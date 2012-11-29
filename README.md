# Potemkin

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'potemkin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install potemkin

## Usage

Place a configuration file in config/potemkin. This could look something like:

    Potemkin.configure do |config|
      config.platform = :android
      config.android_project_dir = "Carsharing"
    end

Run a build command

    $ potemkin build

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
