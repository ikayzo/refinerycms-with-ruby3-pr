shared_context 'grid_view' do
  let(:index_selector) {'#records .images_list'}
  let(:item_selector) { index_selector << ' span.image' }
  let(:link_selector) {item_selector << ' a[href$="/edit"]'}
  let(:thumbnail_selector) {link_selector << ' img'}
  let(:title_selector) {  thumbnail_selector <<  '[tooltip]'}
  let(:alt_selector) { thumbnail_selector << '[alt]'}
  let(:icon_group_selector) {index_selector << '  span.actions'}
end

