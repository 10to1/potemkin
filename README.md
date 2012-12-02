# Potemkin

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/10to1/potemkin) [![Build Status](https://secure.travis-ci.org/10to1/potemkin.png?branch=master)](https://travis-ci.org/10to1/potemkin)

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

[![Build Status](https://secure.travis-ci.org/10to1/potemkin.png?branch=master)](https://travis-ci.org/10to1/potemkin)