include ActionView::Helpers::TagHelper

module Tomify::Concerns::Default::ReactHelper
  def react_component(name, props = {})
    content_tag :div, "", class: "react-component", data: { react: { component: name, props: props.to_json }}
  end
end
