shared_examples 'updates an image' do
  before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  def update_image(path, new_title='', new_alt_text='')

    find('img', text: 'Beach').click_on('edit')
    page.within_frame(dialog_frame_id) do
      attach_file 'image_image', path
      if new_title.present?    fill_in  'image_image_title', with: new_title
        if new_alt_text.present? fill_in  'image_image_alt', with: new_alt_text
          click_button ::I18n.t('save', scope: 'refinery.admin.form_actions')
        end
      end
    end
  end

  it 'has an update link for each image' do
    expect(page).to have_selector(index_item_selector << edit_dialog_selector, count: image_count)
  end


  context 'the new image has the same filename' do

    it 'replaces the old image with the new image' do
      update_image(same_name_image_path)
      expect(image_size).to have_changed
    end

    it 'updates image attributes if supplied', :js => true do
      update_image(image_path, 'New title for image', 'New alt text for image')
      expect(image).to have_title('New title for image')
      expect(image).to have_title('New alt text for image')
    end

    it 'image attributes remain the same if not supplied', :js => true do
      original_title = Refinery::Images.first.title
      original_alt_text = Refinery::Images.first.alt
      update_image(image_path)
      expect(image).to have_title(original_title)
      expect(image).to have_alt_text(original_alt_text)
    end

  end

  context 'the new image has a different filename' do
    it 'rejects the image' do
      update_image(different_name_image_path)
      expect(page).to have_content(::I18n.t("different_file_name", :scope => "activerecord.errors.models.refinery/image"))
    end
  end

end
