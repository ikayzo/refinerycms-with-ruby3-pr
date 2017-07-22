shared_examples 'edits an image' do
  let(:image_count) {[Refinery::Image.count, Refinery::Images.pages_per_admin_index].min}
  before do
    ensure_on(initial_path)
  end

end
