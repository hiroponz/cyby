Simple Cybozu API wrapper
----------------

### Author

Hiroyuki Sato <hiroyuki_sato@spiber.jp>

## Ruby Gem

TODO: Write a gem description

### Installation

Add this line to your application's Gemfile:

    gem 'cyby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cyby

### Usage

TODO: Write usage instructions here

Create '.cyby.yml' file in your home dirctory.

    subdomain: <your subdomain>
    login: <your login>
    password: <your password>

And then require in ruby script.

    require 'cyby'

    kintone_rest_api = Cyby::KintoneRestApi.new(1) # kintone app id
    records = kintone_rest_api.get('/records.json')

