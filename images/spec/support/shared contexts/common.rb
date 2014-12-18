shared_context 'always' do
  let(:image_count) {[Refinery::Image.count, Refinery::Images.pages_per_admin_index].min}
end
