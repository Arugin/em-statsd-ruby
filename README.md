# EventMachine Statsd
[![Build Status](https://travis-ci.org/Arugin/em-statsd-ruby.svg?branch=master)](https://travis-ci.org/Arugin/em-statsd-ruby)
[![Coverage Status](https://coveralls.io/repos/github/Arugin/em-statsd-ruby/badge.svg?branch=master)](https://coveralls.io/github/Arugin/em-statsd-ruby?branch=master)

EM::Statsd is a simple async wrapper around the ruby Statsd client.
It uses EventMachine Connection class to push data around.

It is written for `statsd-ruby` v1.3.0 

For older versions of `statsd-ruby` use [old wrapper](https://rubygems.org/gems/em-statsd/versions/1.0.0)

Getting started
---------------

1. Add `em-statsd-ruby` to your `Gemfile` and `bundle install`:

    ```ruby
    gem 'em-statsd-ruby'
    ```
    
2. Require it in code and use:    

    ```ruby
    require 'eventmachine'
    require 'em-statsd-ruby'
        
    EM.run do
      statsd = EM::Statsd.new('127.0.0.1', 8125)
      statsd.increment 'daddy'
    end
    ```    
3. If you prefer tcp:

    ```ruby
    statsd = EM::Statsd.new('127.0.0.1', 8125, :tcp)
    ``` 

4. It supports batch too:

    ```ruby 
    EM.run do
      statsd = EM::Statsd.new('127.0.0.1', 8125)
      statsd.batch do |s|
        s.increment 'daddy'
        s.count 'kitty', 5
      end
    end
    ``` 
or
    
    ```ruby 
    EM.run do
      statsd = EM::Batch(EM::Statsd.new('127.0.0.1', 8125))
      statsd.increment 'daddy'
      statsd.count 'kitty', 5
    end
    ``` 
    
## Copyright

Copyright (c) Valery Mayatsky. See LICENSE for details.    