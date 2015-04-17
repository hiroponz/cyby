## Cyby

Simple Cybozu REST API wrapper

### Installation

Add this line to your application's Gemfile:

    gem 'cyby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cyby

And then create '.cyby.yml' file in your home dirctory.

    subdomain: <your subdomain>
    login: <your login>
    password: <your password>

### Usage

Get records.

    require 'cyby'
    
    # Create App object.
    app = Cyby::Kintone::App.new(1) # kintone app id
    
    # Filter the records by the various ways.
    record = app.where("id = 1").first
    records = app.all
    app.where("id >= ?", 10).each { |record| puts record.id }
    app.where("name like ?", "Bob").each { |record| puts record.name }
    app.where("create_at < ?", Time.new(2015, 1, 1)).each { |record| puts record.create_at }
    app.where("dropdown in ?", ["a", "b", "c"]).each{ |record| puts record.dropdown }
    app.where("id >= ? and id <= ?", 10, 20).each { |record| puts record.id }
    app.where("id >= ?", 10).and(id <= ?", 20).each { |record| puts record.id }
    app.where("id <= ?", 10).or(id >= ?", 20).each { |record| puts record.id }
    
    # Sort the records.
    app.asc("id").each { |record| record.id }
    app.desc("id").each { |record| record.id }
    app.asc("name").desc("id").each { |record| record.id }
    
    # Select the fields.
    app.select("id", "name", "create_at").map { |record| [record.id, record.name, record.create_at] }
    
    # Using method chain
    app.select("id", "name").where("name like ?, "Bob").asc("id").each 
    
    # Building complex query
    relation = app.relation
    if num > 10
      relation.and("id < ?", num)
    end
    if time < Time.new(2015, 1, 1)
      relation.and("create_at < ?", time)
    end
    if str.length >= 8
      relation.and("name like ?" str)
    end
    unless sort.nil?
     relation.asc(sort)
    end
    records = relation.all

Create a record.

    record = app.new_record
    record.name = "hiroponz"
    record.save

Update a record.

    record = app.where("id = 1").first
    record.age = 30
    record.save

Delete a record.

    record = app.where("id = 1").first
    record.delete

See the [official reference](https://cybozudev.zendesk.com/hc/ja/categories/200147600-kintone-API) to know kintone API details.

### Author

Hiroyuki Sato <hiroyuki_sato@spiber.jp>
