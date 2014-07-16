module Refinery
  module Pages
    module Admin
      module PageEditing

        def page_tabs_and_editors(page, form)
          tabs = page.parts.each_with_index.map do
            |part, index| {
              title: part.title.titleize,
              id: part.to_param(index, !page.persisted?),
              template: part.edit_page_template,
              content: part.body}
          end
          tabs += ::Refinery::Pages.tabs_for_template(page.view_template).each_with_index.map do
               |tab, index| {
                 title: tab.name.titleize,
                 id: "#custom_tab_#{tab_index}",
                 template: tab.partial,
                 content: '' }
           end
           content_tag(:div, id: 'page-tabs', class: 'clearfix') do
             tab_index(tabs) << tab_editors(tabs, form)
           end
        end

        def tab_index(tabs)
          content_tag(:ul, id: 'page_parts') do
            tabs.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (tab, ix)|
              buffer << content_tag(:li, link_to(tab[:title], anchor: tab[:id]), data: {index: ix})
            end
          end
        end

        def page_part_attributes_fields(id, title, index, new_part=false)
          hidden_field_tag( "page[parts_attributes][#{index}][position]", index) +
          hidden_field_tag( "page[parts_attributes][#{index}][id]", id) +
          new_part ? hidden_field_tag( "page[parts_attributes][#{index}][title]", title) : ''
        end

        def new_page_part(title, body, index)
          part = ::Refinery::PagePart.new(title: title, body: body, plugin: 'refinery_pages')
          tab = {
            title: title.titleize,
            id: part.to_param(index, true),
            template: part.edit_page_template,
            content: body}
          tab_field(form, tab, index, true)
        end

        def tab_field(form, tab, index, new_part=false)
          content_tag(:div, class: 'page_part', id: tab[:id]) do
            page_part_attributes_fields(tab[:id], tab[:title], tab[:index]) +
            render( tab[:template], f: form, body: tab[:content], index: index)
          end
        end

        def tab_editors(tabs, form)
          content_tag(:div, id: 'page_part_editors') do
            tabs.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer,( tab, ix)|
              buffer << tab_field(form, tab, ix)
            end
          end
        end

      end
    end
  end
end

