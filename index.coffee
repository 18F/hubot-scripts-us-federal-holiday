# Description:
#   Tells you about US federal holidays
#
# Dependencies:
#   "@18f/us-federal-holidays": "^1.1.0"
#   "moment": "^2.8.4"
#
# Commands:
#   hubot next holiday - tells you when the next holiday is
#   hubot when is next holiday - tells you when the next holiday is
#   hubot when is the next holiday - tells you when the next holiday is

fedHolidays = require('@18f/us-federal-holidays');
moment = require('moment');

module.exports = (robot) ->
  robot.respond /(when is( the)? )?next holiday/i, (msg) ->
    now = new Date
    holidays = fedHolidays.allForYear now.getFullYear()
    i = 0
    while i < holidays.length
      if holidays[i].date >= now
        nextOne = moment(holidays[i].date)
        daysUntil = Math.ceil moment.duration(nextOne.utc().format('x') - Date.now()).asDays()
        msg.reply 'The next federal holiday is ' + holidays[i].name + ' in ' + daysUntil + ' days on ' + nextOne.utc().format('dddd, MMMM Do')
        break
      i++
