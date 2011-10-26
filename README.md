Whistler
=====

![Whistler avatar](https://github.com/athega/athega-hubot/raw/master/images/whistler.jpg)

[Whistler](http://starwars.wikia.com/wiki/Whistler), also called Xeno, was the astromech droid of Corran Horn.
It was the same R-series model as the legendary R2-D2.

_Whistler is based on GitHub's Campfire bot, [hubot](http://hubot.github.com/). He's pretty cool._

Playing with Whistler
=====================

You'll need to install the necessary dependencies for hubot. Almost all of
those dependencies are provided by [npm](http://npmjs.org)

(You need to install redis on your own, or `brew install redis`).

    % bin/hubot

You'll see some startup output about where your scripts come from.

    Loading deploy-local scripts at /Users/me/nubot/scripts
    Loading hubot core scripts for relative scripts at /Users/me/nubot/src/hubot/scripts
    Hubot: the Shell.
    { id: '1', name: 'Shell' }
    Loading hubot-scripts from /Users/me/nubot/hubot-scripts.json
    Successfully connected to Redis

Then you can interact with Hubot by typing `hubot help`.

    Whistler help

    animate me <query>  - The same thing as `image me`, except adds a few
    convert me <expression> to <units> - Convert expression to given units.
    help - Displays all of the help commands that Hubot knows about.
    ...

Take a look at the scripts in the `./scripts` folder for examples.
Delete any scripts you think are silly.  Add whatever functionality you
want Whistler to have.

Deployment
==========

    % heroku create --stack cedar
    % git push heroku master
    % heroku ps:scale app=1
    % heroku addons:add redistogo:nano

You'll need to edit the `Procfile` to say what the bot's name is.

Hubot also needs three environmental variables set to run and to keep him
running on heroku.

Campfire Variables
------------------

Create a separate user for your bot and get their token from the web UI.

    % heroku config:add HUBOT_CAMPFIRE_TOKEN="..."

Get the numeric ids of the rooms you want the bot to join, comma
delimited. If you want the bot to connect to `https://mysubdomain.campfirenow.com/room/42` 
and `https://mysubdomain.campfirenow.com/room/1024` then you'd add it like this:

    % heroku config:add HUBOT_CAMPFIRE_ROOMS="447885"

Add the subdomain hubot should connect to. If you web URL looks like
`http://mysubdomain.campfirenow.com` then you'd add it like this:

    % heroku config:add HUBOT_CAMPFIRE_ACCOUNT="athega"

Restarting Whistler
-------------------
You may want to get comfortable with `heroku logs` and `heroku restart`
if you're having issues.
