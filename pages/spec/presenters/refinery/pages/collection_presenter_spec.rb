require "spec_helper"

module Refinery
  module Pages

    describe CollectionPresenter do
      let(:items) {['a', 'b', 'c']}
      let(:collection1)  { {id: 'items', data: items } }
#, options: { :collection_tag => :ul, :item_tag => :p }
      it 'creates a collection instance variable from the data' do
        presenter = Refinery::Pages::CollectionPresenter.new(collection1)
        expect(presenter.instance_variable_get('@collection')).to eq(items)
        expect(presenter.collection_class).to eq('items')
        end

      it 'returns the collection inside collection_tag' do
        presenter = Refinery::Pages::CollectionPresenter.new(collection1)
        # expect(presenter.content_html).to  have_tag(:ul).with_content(:li).count(3)
      end
    end
  end
end