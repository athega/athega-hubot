# Getting info about the Athegians
#
# /show athegian <name> - Information about an employee
#
# Author: Peter Hellberg
#

module.exports = (robot) ->
  robot.respond /(show )?athegian (.*)$/i, (msg) ->
    name = msg.match[2]

    msg
      .http("http://athega.se/api/employees/#{name}")
      .get() (err, res, body) ->
        if res.statusCode == 200
          employee = JSON.parse(body)

          msg.send employee.medium_image_url
          msg.send "#{employee.name}, #{employee.position}"

          if employee.github != ''
            msg.send "GitHub: http://github.com/#{employee.github}"

          if employee.twitter != ''
            msg.send "Twitter: http://twitter.com/#{employee.twitter}"
        else
          msg.reply "Sorry, no such employee at Athega"


