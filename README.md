# Potemkin

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/10to1/potemkin) [![Build Status](https://secure.travis-ci.org/10to1/potemkin.png?branch=master)](https://travis-ci.org/10to1/potemkin)
[![Coverage Status](https://coveralls.io/repos/10to1/potemkin/badge.png?branch=master)](https://coveralls.io/r/10to1/potemkin)


`Potemkin` («Потёмкин») is rebelling against the Xcode and Eclipse of the Tsarist regime. It will try to bring the build and deploy commands needed for iOS and Android app back to simple oneliners you can enter in your shell. (Which also makes it very easy for CI builds).

## Goals

- `potemkin build`

Issues the build command, useful to check if the app still builds (CI builds etc.)

- `potemkin version:bump:(major|minor|patch)`

A universal interface to make versioning your app a bit more sane. We try to use [semver](http://semver.org/) as the guidelines, and this will make it easier (begone editing plists by hand) to do so. **TODO: Android**

- `potemkin deploy`

Should support different deploy endpoints (Testflight, Dropbox, Hockeyapp,...) but should make it possible to deploy an app with one command. **TODO: iOS/Android**

- `potemkin release`

Much like `bundler`s `rake release` for gem development, this would tag the commit with the current version number and deploy it. **TODO: iOS/Android**


## Installation

Add this line to your application's Gemfile:

    gem 'potemkin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install potemkin

## Usage

Run `potemkinize .` in the root folder of your project. This will create a file at `config/potemkin.rb` which contains some example configs for iOS and Android.

After having filled in the necessary config settings, you can run a build command with:

    $ potemkin build

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[![Build Status](https://secure.travis-ci.org/10to1/potemkin.png?branch=master)](https://travis-ci.org/10to1/potemkin)
[![Coverage Status](https://coveralls.io/repos/10to1/potemkin/badge.png?branch=master)](https://coveralls.io/r/10to1/potemkin)
