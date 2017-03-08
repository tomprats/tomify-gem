module Tomify
  class Constantly
    def initialize(methods)
      methods.each do |key, value|
        define_singleton_method(key) { value.constantize }
        define_singleton_method("#{key}=") do |new_value|
          define_singleton_method(key) { new_value.constantize }
        end
      end
    end
  end
end
