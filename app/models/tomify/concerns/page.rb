module Tomify::Concerns::Page
  extend ActiveSupport::Concern

  included do
    belongs_to :sidebar
    belongs_to :parent, class_name: self
    has_many :children, class_name: self, foreign_key: :parent_id

    before_validation :format_path
    before_validation :require_root, if: :root_changed?
    before_save :set_root, if: :root_changed?
    before_destroy { |page| page.root.blank? }

    validates_presence_of :rank, :path, :name, :template
    validates_uniqueness_of :path
    validate :parent_valid?

    default_scope { order(:rank, :name) }
    scope :active, -> { where(active: true) }

    to_html :text
  end

  class_methods do
    def root
      find_by(root: true) || new(root: true, name: "Home", path: "", template: "default")
    end

    def templates
      return @files if @files
      @files = Dir.glob("#{Tomify.root}/app/views/templates/*")
      @files.concat Dir.glob("#{Rails.root}/app/views/templates/*")
      @files.compact!
      @files.collect! { |file| file.split("/").last.split(".").first }
      @files.sort_by! { |f| f == "default" ? "" : f } # Default First
    end

    def admin_params
      [
        :parent_id, :sidebar_id,
        :active, :root, :rank,
        :path, :name, :template,
        :title, :description,
        :cover_image, :share_image,
        :text
      ]
    end
  end

  def serializable_hash(options = nil)
    options = { include: [:parent, :sidebar] } if options.blank?
    super(options)
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
