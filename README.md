# Omniauth for Sinatra

This is a template for launching Sinatra apps quickly and easily,
using [OmniAuth](https://github.com/intridea/omniauth) as the authentication protocol.
It differs from most of the "use Twitter with Sinatra" code bases, as it incorporates
sessions and a `User` model in the database. This means your user should remain logged
in as long as your server stays live.

The instructions in the "twitter-template.rb" file assume you're using Twitter, but you can use any auth provider handled by OmniAuth. To see how you'd use GitHub, check out the "github-template.rb" file.

Most of the actual code here is simply a port/mashup of Ryan Bates's example from [RailsCasts #241: Simple OmniAuth](http://railscasts.com/episodes/241-simple-omniauth) and the OmniAuth readme.

Once you have your auth codes, getting a new Sinatra app with authentication working is simply a matter of copying the `app.rb` file from here into a new directory, pasting in your auth codes, and then starting in on your app's code. It just works.

## Getting Started Instructions (Twitter version)

### 1. Install Omniauth and the other required gems

    gem install omniauth omniauth-twitter dm-core dm-sqlite-adapter dm-migrations sinatra

(Note that the GitHub template uses the `omniauth-github` gem instead of `omniauth twitter`.)

### 2. Get your Twitter Auth Keys

At Twitter, [register for a new app](https://dev.twitter.com/apps/new).
Note the _Consumer Key_ and _Consumer Secret_ strings it gives you.


### 3. Enter your Auth Keys into the app.rb file

The file `twitter-template.rb` has a place for your `CONSUMER_KEY` and `CONSUMER_SECRET`. Just replace them, and you're set. Fire up your local server via `ruby twitter-template.rb` and you can see your log-in setup. (Again, `github-template.rb` shows how you'd set up a GitHub-auth'd service.)


## A Minor Note

Note that if you want to use shotgun or reloader while testing your app, then you'll need to set
`:session_secret` in your configure block:

    configure :development, :testing do
      set :session_secret, "random string"
    end

## Feedback Is Awesome

I'd really love to hear any suggestions you have on how to improve this. On Twitter,
I'm [@charliepark](https://twitter.com/charliepark/). By e-mail, I'm charlie@charliepark.org.
