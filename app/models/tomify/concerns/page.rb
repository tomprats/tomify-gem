module Tomify::Concerns::Page
  extend ActiveSupport::Concern

  included do
    mount_uploader :cover_image, CoverImageUploader
    mount_uploader :share_image, ShareImageUploader

    belongs_to :sidebar
    belongs_to :parent_page, class_name: "Page"
    has_many :children, class_name: "Page", foreign_key: :parent_page_id

    before_validation :format_path
    before_validation :require_root, if: :root_changed?
    before_save :set_root, if: :root_changed?
    before_destroy { |page| page.root.blank? }

    validates_presence_of :rank, :path, :name, :template
    validates_uniqueness_of :path
    validate :parent_page_valid?

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
      @files = Dir.glob("#{Rails.root}/app/views/templates/*")
      @files.collect! { |file| file.split("/").last.split(".").first }
      @files.sort_by! { |f| f == "default" ? "" : f } # Default First
    end

    def import_json(file)
      records = JSON.parse(file.read, symbolize_names: true)
      records.each { |record| import_find_or_create(record) }
    end

    def import_find_or_create(record)
      record.delete(:id)
      parent = record.delete(:parent_page)
      record[:parent_page_id] = import_find_or_create(parent).id if parent
      sidebar = record.delete(:sidebar)
      record[:sidebar_id] = Sidebar.find_or_create_by(sidebar[:name]).id if sidebar

      find_or_create_by(path: record[:path]) do |page|
        page.assign_attributes(record)
      end
    end

    def admin_params
      [
        :parent_page_id, :sidebar_id,
        :active, :root, :rank,
        :path, :name, :template,
        :title, :description,
        :cover_image, :share_image,
        :text
      ]
    end
  end

  def serializable_hash(options = nil)
    options ||= {}
    super({ include: [:parent_page, :sidebar] }.update(options))
  end

  private
  def parent_page_valid?
    errors.add(:parent_page_id) if parent_page && parent_page.id == id
  end

  def format_path
    self.path = path.try(:strip).try(:downcase)
  end

  def require_root
    errors.add(:root, "is required") unless root || Page.where.not(id: id).root.present?
  end

  def set_root
    Page.where.not(id: id).where(root: true).update_all(root: false) if root
  end
end
