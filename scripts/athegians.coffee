# Getting info about the Athegians
#
# /[show ]athegian <name> - Information about an employee
#
# Author:  Peter Hellberg
#

module.exports = (robot) ->
  robot.respond /foobar/, (msg) ->
    msg.send 'foo', 'bar', 'baz'
  
  robot.respond /(show )?athegian (.*)$/i, (msg) ->
    name = escape(msg.match[2])
    msg
      .http("http://athega.se/api/employees/#{name}")
      .get() (err, res, body) ->
        if res.statusCode == 200
          show_employee(JSON.parse(body), msg)
        else
          msg.reply "Sorry, no such employee at Athega"

  show_employee = (employee, msg) ->
    msg.send employee.medium_image_url,
            "#{employee.name}, #{employee.position}"

