module Refinery
  module Pages
    class CollectionPresenter < Refinery::Pages::SectionPresenter
      include ActiveSupport::Configurable
      # presents a collection of items in a section
      # TODO do a better fallback_html

      attr_accessor :output_buffer
      config_accessor :content_wrapper_tag,
        :collection_tag, :collection_class, :collection_id,
        :item_wrapper_tag, :item_tag, :item_class

      self.collection_tag = :ul
      self.item_wrapper_tag = :li
      self.content_wrapper_tag = :section
      self.item_tag = ''

      def initialize(page_part)
        super(page_part[:options]) unless page_part[:options].blank?
        @collection = page_part[:data]
        self.collection_class = page_part[:id]
        self.collection_id = page_part[:id]
      end

      def has_content?(can_use_fallback = true)
        !@collection.blank?
      end

      def wrap_content_in_tag(content)
        content_tag(content_wrapper_tag.to_sym, content,  id: collection_id)
      end


      private

      def collection_markup()
        unless @collection.blank?
          content_tag(collection_tag.to_sym, class: collection_class ) do
            @collection.each.inject(ActiveSupport::SafeBuffer.new) do |buffer, item|
              buffer << content_tag(item_wrapper_tag.to_sym, item_markup(item))
            end
          end
        end
      end

      def item_markup(item)
      # minimal markup for a generic item (none!)
        content_tag(item_tag.sym, item.to_s, class: item_class)
      end

    end
  end
end
