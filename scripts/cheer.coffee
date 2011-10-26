# Feeling depressed?
#
# cheer me up - A little pick me up
#
# Author: Carl Lerche
# Gist:   https://gist.github.com/f8fb44e371225e2e97b3
#
module.exports = (robot) ->
  robot.respond /cheer me up/i, (msg) ->
    msg
      .http('http://imgur.com/r/aww.json')
      .get() (err, res, body) ->
        images = JSON.parse(body)
        images = images.gallery
        image  = msg.random images
        msg.send "http://i.imgur.com/#{image.hash}#{image.ext}"
