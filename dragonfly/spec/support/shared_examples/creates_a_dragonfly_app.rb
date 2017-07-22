shared_examples_for 'Creates a dragonfly App:' do

  describe 'app creation' do
    ::Refinery::Dragonfly.configure!(described_class)
    it 'succeeds' do
      expect(::Dragonfly.app(described_class.dragonfly_name).name).to eq(described_class.dragonfly_name.to_sym)
    end
  end

  describe 'app configuration' do
    ::Refinery::Dragonfly.configure!(described_class)

    # These are just some of the configuration parameters which can be passed to Dragonfly
    it 'sets the datastore_root_path' do
      expect(Dragonfly.app(described_class.dragonfly_name).datastore.root_path).to eq(described_class.dragonfly_datastore_root_path)
    end

    it 'sets the url host' do
      expect(Dragonfly.app(described_class.dragonfly_name).server.url_host).to eq(described_class.dragonfly_url_host)
    end

    it 'sets the url format' do
      expect(Dragonfly.app(described_class.dragonfly_name).server.url_format).to eq(described_class.dragonfly_url_format)
    end

    it 'sets verify_urls' do
      expect(Dragonfly.app(described_class.dragonfly_name).server.verify_urls).to eq(described_class.dragonfly_verify_urls)
    end

  end

  describe 'configuring Amazon S3' do
    context "using custom settings" do
      it "uses the custom values" do
        Refinery::Dragonfly.s3_bucket_name = "kfc"
        described_class.s3_bucket_name = "buckethead"

        expect(described_class.s3_bucket_name).to eq("buckethead")
      end
    end

    describe "without custom settings" do
      it "uses the defaults" do
        described_class.s3_bucket_name = nil
        Refinery::Dragonfly.s3_bucket_name = "kfc"

        expect(described_class.s3_bucket_name).to eq("kfc")
      end
    end
  end

  describe "defining a custom datastore" do
    before(:all) do
      CustomDatastore1 = Class.new
      CustomDatastore2 = Class.new
    end

    before(:each) do
      allow(Refinery::Dragonfly).to receive_messages(:custom_datastore_class => CustomDatastore1)
    end

    after(:each) do
      described_class.dragonfly_custom_datastore_class = nil
    end

    context "with the default configuration" do
      it "uses the default values" do
        expect(described_class.dragonfly_custom_datastore_class).to eq(CustomDatastore1)
      end
    end

    context "with a custom configuration" do
      it "uses custom values" do
        described_class.dragonfly_custom_datastore_class = 'CustomDatastore2'
        expect(described_class.dragonfly_custom_datastore_class).to eq(CustomDatastore2)
      end
    end

  end
end


