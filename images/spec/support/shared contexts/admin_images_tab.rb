shared_context 'admin images tab' do

  let(:initial_path) { refinery.admin_images_path(view: %w(grid list).sample) }
  let(:select_upload) {}

  let(:open_image_dialog) { click_on(::I18n.t('create_new_image', scope: 'refinery.admin.images.actions')) }
  let(:open_edit_dialog)  {
    find('img', text: 'Beach')
    click_on(::I18n.t('edit', scope: 'refinery.admin.images.actions'))}
  let(:edit_dialog_selector) {::I18n.t('edit', scope: 'refinery.admin.images.actions')}

  let(:dialog_frame_id) {'dialog_iframe'}

  let(:index_item_selector) {'#records li'}

  let(:gridview_img_selector) {' > img'}
  let(:gridview_title_selector) {'[tooltip]'}
  let(:gridview_alt_selector) {'[alt]'}

  let(:listview_title_selector) {' > span.title'}
  let(:listview_alt_selector) {' > span.alt'}

  let(:image_path)                {Refinery.roots('refinery/images').join("spec/fixtures/beach.jpeg")}
  let(:same_name_image_path)      {Refinery.roots('refinery/images').join("spec/fixtures/replacement/beach.jpeg")}
  let(:different_name_image_path) {Refinery.roots('refinery/images').join("spec/fixtures/fathead.jpeg")}

end
