# Description:
#   A hubot script that send random sentences
#
# Configuration:
#   HUBOT_RANDOM_SENTENCES_FILE
#
# Commands:
#   none
#
# Author:
#   vspiewak
#

fs   = require 'fs'

file = process.env.HUBOT_RANDOM_SENTENCES_FILE


random = (items) ->
  items[ Math.floor(Math.random() * items.length) ]

module.exports = (robot) ->
  robot.logger.info 'hubot-random-sentences started'
  unless file?
    msg.send 'You need to set HUBOT_RANDOM_SENTENCES_FILE'
  if file
    try
      data = fs.readFileSync file, 'utf-8'
      if data
        json = JSON.parse(data)
        targets = json.targets
        sentences = json.sentences
        room = json.room
        frequency = json.frequency
        openHour = json.openHour
        closeHour = json.closeHour
        robot.logger.info 'loaded file'
    catch error
      robot.logger.info('Unable to read file', error) unless error.code is 'ENOENT'

  # Will execute this every SENTENCES_FREQUENCY seconds
  setInterval () ->

    robot.logger.debug 'Executing hubot-random-sentences'

    hour = new Date().getHours()
    isWeekDay = (new Date().getDay() % 6) != 0

    # Check if inside office hours and not weekend
    if isWeekDay and hour > openHour and hour < closeHour

      robot.logger.debug 'hubot-random-sentences will talk'

      random_target = random targets
      random_message = random sentences
      final_message = random_message.replace("<user>", random_target)

      robot.logger.info 'sentence: ' + final_message
      robot.messageRoom room, final_message

    else
      robot.logger.debug 'Skip hubot-random-sentences (not in office hours)'

  , 1000 * frequency
