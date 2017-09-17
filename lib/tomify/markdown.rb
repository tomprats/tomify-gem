module Tomify
  module Markdown
    class HTML < Redcarpet::Render::HTML
      def preprocess(text)
        text = find_and_replace(text) if @options[:replace]
        text
      end

      def image(url, title, alt)
        "<img alt=\"#{alt}\" class=\"center-block img-responsive\" src=\"#{url}\" title=\"#{title}\">"
      end

      private
      def find_and_replace(text)
        text.gsub(/!!\w+!!/) { |t| @options[:replace][t[2...-2]] }
      end
    end
  end
end
