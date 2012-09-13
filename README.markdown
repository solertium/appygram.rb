# Appygram <http://www.appygram.com>

Appygram is a simple service to manage messages from your web
or mobile app. This gem provides communication with the Appygram
service via a simple API. Useful features higher in the stack
are found in gems that depend on this one, e.g. appygram-rails,
which turns uncaught exceptions in Rails apps into messages.
    
## Installation

1.  Add gem entry to Gemfile
    
    ```ruby
    gem 'appygram'
    ```
    
2.  Run <code>bundle install</code>

3.  Configure your API Key in an initializer, e.g. config/appygram.rb
    
    ```ruby
    Appygram.configure :api_key => 'your_api_key'
    ```
    
    using a valid API key for your app provided by Appygram

## Invocation

   ```ruby
   require 'appygram'

   Appygram.send :topic => 'Test', :message => 'This is a test.'
   ```

## Supported fields in an appygram

* topic
* subject
* message
* name
* email
* phone
* platform ('web' by default for this connector)
* software ('appygram.rb [VERSION]' by default for this connector)

Copyright © 2012 Solertium
