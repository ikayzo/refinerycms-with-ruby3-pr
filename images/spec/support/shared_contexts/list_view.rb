shared_context 'list_view' do
  let(:index_selector) {'#records .images_list'}
  let(:item_selector) {index_selector << ' span.title'}
  let(:link_selector) {item_selector << ' a[href$="/edit"]'}
  let(:preview_selector) {index_selector << ' span.preview'}
  let(:icon_group_selector) {index_selector << ' span.actions'}
end


