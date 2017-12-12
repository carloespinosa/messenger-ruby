require 'messenger/components/attachment'

module Messenger
  module Templates
    class List
      include Components::Attachment

      attr_accessor :template_type, :top_element_style, :elements, :buttons

      ATTRIBUTES = %w(template_type top_element_style elements buttons).freeze

      def initialize(elements: nil, buttons: nil)
        @type          = 'template'
        @template_type = 'list'
        @elements      = build_elements(elements)
        @buttons       = build_buttons(buttons)
      end

      def build_buttons(buttons)
        buttons.map { |button| button.build } if buttons.present?
      end
    end
  end
end