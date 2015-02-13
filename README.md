# Traceability

Traceability is request/response trace tool for rack application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'traceability'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install traceability

## Usage

Use Traceability Web UI as Rails Engine,

config/routes.rb

```
require 'traceability/web'

MyApp::Application.routes.draw do
  mount Traceability::Web, at: "/traceability"
end
```

or rack up stand alone

config.ru

```
require 'traceability/web'
run Traceability::Web
```

and `rackup `

## Config

In Rails,

config/initializer/traceability.rb

```
if defined?(Traceability)
  Traceability.configure do |config|
    config.store_file_path "tmp/traceability"
    config.max_history_size = 30
    config.request_filter = lambda { |uri, resposne_header| resposne_header["content-type"] == "application/json" }
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/traceability/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
