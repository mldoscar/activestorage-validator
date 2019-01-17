RSpec.describe ActiveRecord::Validations::BlobValidator do
  after { User.clear_validators! }

  describe 'with size_range option' do
    let(:example_range) { 700.kilobytes..1.megabyte }
    before do
      User.validates :file,  blob: { size_range: example_range }
      User.validates :files, blob: { size_range: example_range }
    end

    it "should translate the validation error according to it's locale" do
      # Iterate every available locale in app/config/locales
      available_locales.each do |locale|
        I18n.with_locale locale.to_sym do
          # Create new resource and validate it
          user = User.new(file: create_file_blob(filename: '600KB.jpg'), files: [create_file_blob(filename: '1_4MB.jpg')])
          user.validate

          # Run expectation
          # Translation: min_size_error
          expect(
            user.errors.messages[:file]
          ).to include I18n.t('activerecord.errors.messages.min_size_error', min_size: ActiveSupport::NumberHelper.number_to_human_size(example_range.min))

          # Translation: max_size_error 
          expect(
            user.errors.messages[:files]
          ).to include I18n.t('activerecord.errors.messages.max_size_error', max_size: ActiveSupport::NumberHelper.number_to_human_size(example_range.max))

        end
      end
    end
  end

  describe 'with content_type option' do
    before do
      User.validates :file,  blob: { content_type: :image }
      User.validates :files, blob: { content_type: :image }
    end

    it "should translate the validation error according to it's locale" do
      # Iterate every available locale in app/config/locales
      available_locales.each do |locale|
        I18n.with_locale locale.to_sym do
          # Create new resource and validate it
          user = User.new(file: create_file_blob(filename: 'dummy.txt', content_type: 'text/plain'), files: [create_file_blob(filename: 'dummy.txt', content_type: 'text/plain')])
          user.validate

          # Run expectation
          expect(user.errors.messages[:file]).to  include(I18n.t('activerecord.errors.messages.content_type'))
          expect(user.errors.messages[:files]).to include(I18n.t('activerecord.errors.messages.content_type'))
        end
      end
    end
  end

end

