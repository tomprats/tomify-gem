module Tomify::Concerns::Page
  extend ActiveSupport::Concern

  included do
    attr_accessor :admin

    mount_uploader :cover_image, Tomify.uploaders.setting
    mount_uploader :share_image, Tomify.uploaders.setting

    belongs_to :sidebar, class_name: Tomify.models.sidebar.to_s, optional: true
    belongs_to :parent, class_name: self.to_s, optional: true
    has_many :children, class_name: self.to_s, foreign_key: :parent_id

    before_validation :format_path
    before_validation :require_root, if: :root_changed?
    before_save :set_root, if: :root_changed?
    before_destroy { |page| throw :abort unless page.root.blank? }

    validates_presence_of :rank, :path, :name, :template
    validates_uniqueness_of :path
    validate :parent_valid?

    default_scope { order(:rank, :name) }
    scope :active, -> { where(active: true) }

    to_html :text
  end

  class_methods do
    def root
      find_by(root: true) || default
    end

    def default
      feedback = Tomify.setting :feedback
      feedback = feedback.nil? ? true : feedback
      new(name: "Home", path: "", template: "default", feedback: feedback)
    end

    def templates
      return @files if @files
      @files = Dir.glob("#{Tomify.root}/app/views/templates/*")
      @files.concat Dir.glob("#{Rails.root}/app/views/templates/*")
      @files.compact!
      @files.collect! { |file| file.split("/").last.split(".").first }
      @files.sort_by! { |f| f == "default" ? "" : f } # Default First
    end

    def for_env
      all.as_json(env_serializable_options)
    end

    def env_serializable_options
      { only: [
        :active, :feedback, :name, :path,
        :root, :template, :text, :parent_id
      ]}
    end

    def for_navbar
      where(parent_id: nil).as_json(
        only: [:active, :name, :path],
        include: [children: { only: [:active, :name, :path] }]
      )
    end
  end

  def for_env
    as_json(self.class.env_serializable_options)
  end

  def markdown_options
    { replace: as_json(methods: [:cover_image_url, :share_image_url]) }
  end

  private
  def parent_valid?
    errors.add(:parent_id) if parent && parent.id == id
  end

  def format_path
    self.path = path.try(:strip).try(:downcase)
  end

  def require_root
    errors.add(:root, "is required") unless root || self.class.where.not(id: id).root.present?
  end

  def set_root
    self.class.where.not(id: id).where(root: true).update_all(root: false) if root
  end
end
