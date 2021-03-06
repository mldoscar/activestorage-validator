# ActiveStorage Validator

ActiveStorage blob validator.

## Installation

Add this line to your application's Gemfile:

```ruby
# From this fork
gem 'activestorage-validator', git: 'https://github.com/mldoscar/activestorage-validator', branch: 'master'

# Original repository version (it may not have some enhancements from this forked repository):
gem 'activestorage-validator', '~> 0.1.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ # Original repository version (it may not have some enhancements from this forked repository):
    $ gem install activestorage-validator -v '~> 0.1.1'

## Internationalization (I18n)

There's no need to make any additional configuration into your Rails application to make the translations work. It's enough to configure `I18n.default_locale` or `I18n.available_locales` in your application. The following translation files are available at this moment:

```
en, es, es-NI, ja
```

**If your desired locale is not included yet**, you can temporally create a translation file `*.yml` inside your application's locales folder `app/config/locales/`. The locale structure goes like this:

```ruby
en:
  activerecord:
    errors:
      messages:
        content_type: "is not a valid file format"
        min_size_error: "File size should be greater than %{min_size}"
        max_size_error: "File size should be less than %{max_size}"
        # ...and so on...
```

## Usage

```ruby
class User < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :photos

  validates :avatar, presence: true, blob: {
    ## Content-Type validation
    # Supported options: :image, :audio, :video, :text
    content_type: :image,
    # Supported options: Any supported mime type (list: https://www.freeformatter.com/mime-types-list.html#mime-types-list)
    content_type: ['image/png', 'image/jpg', 'image/jpeg'],

    ## File size validation (Range)
    size_range: 1.byte..5.megabytes,

    ## Purge file validation if file is not valid
    purge: true
  }
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aki77/activestorage-validator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

**CONTRIBUTORS:** Please feel free to make your pull request in order to add additional translation files into `app/config/locales` gem folder

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
