module Tomify
  module Markdown
    class HTML < Redcarpet::Render::HTML
      def preprocess(text)
        text = find_and_replace(text) if @options[:replace]
        text
      end

      def find_and_replace(text)
        text.gsub!(/!!\w+!!/) { |t| @options[:replace][t[2...-2]] }
      end
    end
  end
end
