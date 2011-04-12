# Omniauth for Sinatra

This is a template for launching Sinatra apps quickly and easily, using [OmniAuth](https://github.com/intridea/omniauth) as the authentication protocol. It differs from most of the "use Twitter with Sinatra" code bases, as it incorporates sessions and a User model in the database. This means your user should remain logged in as long as your server stays live.

The instructions here assume you're using Twitter, but you can use any auth provider handled by OmniAuth.

Most of the actual code here is simply a port/mashup of Ryan Bates's example from [RailsCasts #241: Simple OmniAuth](http://railscasts.com/episodes/241-simple-omniauth) and the OmniAuth readme.

Once you have your auth codes, getting a new Sinatra app with authentication working is simply a matter of copying the app.rb file from here into a new directory, pasting in your auth codes, and then starting in on your app's code. It just works.


## Getting Started Instructions

### 1. Install Omniauth and the other required gems

    gem install omniauth

You'll also need to install data_mapper and dm-sqlite-adapter if you don't have them in your system.


### 2. Get your Twitter Auth Keys

At Twitter, [register for a new app](https://dev.twitter.com/apps/new). Note the Consumer Key and Consumer Secret strings it gives you.


### 3. Enter your Auth Keys into the app.rb file

The file app.rb has a place for your CONSUMER_KEY and CONSUMER_SECRET. Just replace them, and you're set. Fire up your local server ('ruby app.rb') and you can see your log-in setup.


## A Minor Note

Note that **you cannot use shotgun to test your app**, as you'll need sessions to persist in order to stay logged in, and shotgun restarts the server on every request. Starting your app with 'ruby app.rb' should work with no problems.


## Feedback Is Awesome

I'd really love to hear any suggestions you have on how to improve this. On Twitter, I'm [@charliepark](https://twitter.com/charliepark/). By e-mail, I'm charlie@monotask.com.