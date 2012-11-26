# Description:
#   Metadata lookup for spotify links, with album cover
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   <spotify link> - returns info about the link (track, artist, etc.)
#
# Author:
#   peterhellberg

module.exports = (robot) ->
  robot.hear spotify.link, (msg) ->
    msg.http(spotify.uri msg.match[0]).get() (err, res, body) ->
      if res.statusCode is 200
        data = JSON.parse(body)
        info = spotify[data.info.type](data)
        msg.http(msg.match[0]).get() (err, res, body) ->
          if res.statusCode is 200
            cover_src = /class="album-cover-art">[\s\S]*.+img src="(.+?)"/g
            msg.send "#{cover_src.exec(body)[1]}#.png", info
          else
            msg.send info

spotify =
  link: /// (
    ?: http://open.spotify.com/(track|album|artist)/
     | spotify:(track|album|artist):
    ) \S+ ///

  uri: (link) -> "http://ws.spotify.com/lookup/1/.json?uri=#{link}"

  track: (data) ->
    track = "#{data.track.artists[0].name} - #{data.track.name}"
    album = "(#{data.track.album.name}) (#{data.track.album.released})"
    "Track: #{track} #{album}"

  album: (data) ->
    "Album: #{data.album.artist} - #{data.album.name} (#{data.album.released})"

  artist: (data) ->
    "Artist: #{data.artist.name}"
