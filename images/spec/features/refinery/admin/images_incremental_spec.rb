require "spec_helper"

module Refinery

  describe "Admin Images Tab", type: :feature do
    refinery_login_with :refinery_user

    context 'when there are no images' do
      it 'says there are no images'do
        visit refinery.admin_images_path
        expect(page).to have_content(::I18n.t('no_images_yet', scope: 'refinery.admin.images.records'))
      end
    end

    context 'when there is one image' do
      let!(:image) { FactoryGirl.create(:image) }

        it_behaves_like 'an image index' do
          before {visit refinery.admin_images_path}
        end

        it_behaves_like 'an image deleter' do  #deletes an image
          before {visit refinery.admin_images_path}
        end
    end

    context 'when there are many images' do
      let!(:image) { FactoryGirl.create(:image) }
      let!(:alt_image) { FactoryGirl.create(:alternate_image) }
      let!(:another_image) { FactoryGirl.create(:another_image) }

      it_behaves_like 'an image index' do
        before {visit refinery.admin_images_path}
      end

      it_behaves_like 'an image deleter' do
        before {visit refinery.admin_images_path}
      end

    end

  end  # Admin Images Tab
end  # Module Refinery



    # it_behaves_like 'an image uploader' do
      # click_target ='#add_icon'
      # dialog_element = page.within_frame('dialog_iframe')
    # end
#    uploads one image, uploads multiple images, doesn't upload other formats
    # it behaves_like 'an image editor'
#     replace image, change title and alt

    # it behaves_like 'an image previewer'
#     shows image

  # describe "Page Editor Images Tab", type: feature do
    # refinery_login_with :refinery_user
    # before :each do
      # visit refinery.insert_admin_images_path(modal: true)
    # end
#
    # it_behaves_like 'an image index'
    # it_behaves_like 'an image uploader' do
      # click_target = 'a#add_image_link'
      # dialog_element = 'page#iframe_dialog'
    # end
    # it behaves_like 'an image inserter'
    # it behaves_like 'an image editor'
    # it behaves_like 'an image deleter'
    # it behaves_like 'an image previewer'
  # end

