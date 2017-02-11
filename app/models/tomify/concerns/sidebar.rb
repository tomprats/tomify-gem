module Tomify::Concerns::Sidebar
  extend ActiveSupport::Concern

  included do
    has_many :pages
    validates_presence_of :name

    scope :active, -> { where(active: true) }

    to_html :text
  end

  class_methods do
    def admin_params
      [:active, :name, :heading, :text]
    end
  end
end
