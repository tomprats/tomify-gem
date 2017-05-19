module Tomify::Concerns::Default::NavbarHelper
  extend ActiveSupport::Concern

  included do
    class_attribute :_navbar, instance_accessor: false
    self._navbar = {}

    add_to_navbar :public, Proc.new { Tomify.models.page.for_navbar }
    add_to_navbar :admin, [
      { name: "App", path: "admin/settings" },
      { name: "Pages", path: "admin/pages" },
      { name: "Sidebars", path: "admin/sidebars" },
      { name: "Uploads", path: "admin/uploads" },
      { name: "Users", path: "admin/users" }
    ]
  end

  class_methods do
    def add_to_navbar(type, *pages)
      self._navbar[type] ||= []
      pages.each do |item|
        self._navbar[type] << item
      end
    end

    def prepend_to_navbar(type, *pages)
      self._navbar[type] ||= []
      pages.each do |item|
        self._navbar[type].unshift item
      end
    end
  end

  def navbar
    types = {}

    self.class._navbar.each do |type, pages|
      types[type] = []
      pages.each do |item|
        types[type].concat navbar_pages_from(item)
      end
      types[type].flatten!
    end

    types
  end

  private
  def navbar_pages_from(item)
    case item
    when Proc
      navbar_pages_from item.call
    when Hash
      navbar_pages_from_hash item
    when Array
      navbar_pages_from_array item
    else
      []
    end
  end

  def navbar_pages_from_hash(hash)
    hash.symbolize_keys!
    return [] if hash[:active] == false
    page = hash.slice(:children, :external, :name, :url)
    page[:children] = navbar_pages_from page[:children]
    page[:url] ||= "/#{hash[:path]}" if page[:children].empty?
    [page]
  end

  def navbar_pages_from_array(array)
    pages = []
    array.each { |item| pages.concat navbar_pages_from(item) }
    pages
  end
end
