def visit_admin_images_page
  refinery_login_with :refinery_user
  visit refinery.admin_images_path
end

def trigger_add_image_dialog
  refinery_login_with :refinery_user
  visit refinery.admin_images_path
  click_link ::I18n.t('create_new_image', scope: 'refinery.admin.images.actions')
end

def upload_an_image(context, image, title, alt)
   context do
    attach_file "image_image", Refinery.roots('refinery/images').join('spec/fixtures').join(image)
    fill_in place_holder: ::I18n.t('.image_title'), with: title
    fill_in placeholder: ::I18n.t('.image_alt'), with: alt
    click_button ::I18n.t('save', scope: 'refinery.admin.form_actions')
  end
end
