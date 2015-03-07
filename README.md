# ItunesConnect::Autoingestion

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itunes_connect-autoingestion', github: 'mizoR/itunes_connect-autoingestion'
```

## Usage

### in Application

```rb
# example.rb
ingester = ItunesConnect::Autoingestion.new(
    username:  '<your username>',
    password:  '<your pass>',
    vendor_id: '<your vendor_id>',
    date:      (Date.today - 2)
  )

apps = ingester.run
#=> #<ItunesConnect::Autoingestion::Result>

apps.each do |app|
  app.provider   #=> "APPLE"
  app.title      #=> "YourSuperCoolAppTitle"
  app.developer  #=> "Your Developer Name"
  app.units      #=> 13
end
```

## Contributing

1. Fork it ( https://github.com/mizoR/itunes_connect-autoingestion/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
