module SpecSupport
  module UploaderHelper
    include CarrierWave::Test::Matchers

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def uploader(fixture_file_path, &block)
        let :uploader, &block

        before do
          subject.class.enable_processing = true
          uploader.store! File.open Rails.root.join('spec', 'fixtures', fixture_file_path)
        end

        after do
          subject.class.enable_processing = false
          FileUtils.rm_r Rails.root.join('public', uploader.store_dir)
        end
      end
    end
  end
end


