# Appygram <http://www.appygram.com>

Appygram is a simple service to handle messages from your web
or mobile app. This gem provides communication with the Appygram
service via a simple API. Useful features higher in the stack
are found in gems that depend on this one, e.g. appygram-rails,
which automatically turns uncaught Rails exceptions into traces.

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

# Sending an appygram
Appygram.send :topic => 'Test', :message => 'This is a test.'

# Sending a trace
Appygram.trace some_exception

# Sending a trace with accompanying appygram fields
Appygram.trace some_exception, :email => 'some_user@domain'
```

## Supported fields in an appygram

*   topic - of principal importance in message routing
*   subject
*   message
*   name
*   email
*   phone
*   platform ('web' by default for this connector)
*   software ('appygram.rb [VERSION]' by default for this connector)
*   app_json - Any object assigned to this field will be serialized
    into JSON. If it is a hash, top level keys will be addressable
    in the message routing and formatting.

## Traces

*   Traces send the current stack trace from your application.
*   Appygram deduplicates traces and treats them statistically;
    traces are converted to notifications based on rules agreed by
    the system and the user.
*   If you send fields (like "name" and "email") along with the
    trace, Appygram can put that information into notifications.
    For example, if you generate a trace because of an unexpected
    exception, and you include the contact information for the
    logged-in user who experienced the exception, responders can
    more easily identify and communicate with the affected user
    about what might have led to the exception.

## Additional configuration options

You can call Appygram.configure multiple times safely, or pack
all the options you need into one call.

To minimize network bandwidth in the event that your app generates
a LOT of traces, you can throttle the trace sender when you configure
Appygram. You can throttle all traces on a per-second basis, or
duplicate traces per day.

```ruby
Appygram.configure :max_traces_per_second => 3
# and/or
Appygram.configure :max_duplicate_traces_per_day => 1
```

You can set defaults for the platform or software at configuration time.

```ruby
Appygram.configure :platform => 'Ruboto'
# and/or
Appygram.configure :software => 'awesomesauce'
```

The standard endpoints for Appygram are built in. If you need to change
them, you can configure <code>:appygram_endpoint</code> and
<code>:trace_endpoint</code> to the full URL destination where data is
to be sent.

If you send traces, you can provide a map of uri stubs to paths
within your application. Appygram will use these to hyperlink
the traces to the appropriate repository online. This map may
be also populated by higher level gems, like appygram_rails;
anything you supply here will be additively merged.

```ruby
Appygram.add_trace_uris 'lib' => 'http://github.com/anythinglabs/appygram.rb'
```

## Rules for improvement

*   This gem must not have other dependencies.
*   This gem may take advantage of other gems (e.g. async i/o,
    background queueing, http pooling) if detected, and the advantage
    is related directly to communication with the service
*   Effort should be made to retain parity with other fully supported
    connectors

Copyright © 2012 Solertium
