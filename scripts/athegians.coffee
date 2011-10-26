# Getting info about the Athegians
#
# /[show ]athegian <name> - Information about an employee
#
# Author:  Peter Hellberg
#

Flow = require 'gowiththeflow'

module.exports = (robot) ->
  robot.respond /(show )?athegian (.*)$/i, (msg) ->
    name = msg.match[2]

    msg
      .http("http://athega.se/api/employees/#{name}")
      .get() (err, res, body) ->
        if res.statusCode == 200
          employee = JSON.parse(body)
          show_employee(employee, msg)
          #
        else
          msg.reply "Sorry, no such employee at Athega"

    show_employee = (employee, msg) ->
      Flow()
        # Image
        .seq (next) ->
          msg.send employee.medium_image_url
          next()

        # Name and position
        .seq (next) ->
          msg.send "#{employee.name}, #{employee.position}"
          next()

        # GitHub profile (if available)
        .seq (next) ->
          if employee.github != ''
            msg.send "GitHub: http://github.com/#{employee.github}"
          next()

        # Twitter profile (if available)
        .seq (next) ->
          if employee.twitter != ''
            msg.send "Twitter: http://twitter.com/#{employee.twitter}"
          msg.send
