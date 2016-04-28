# Description:
#   A hubot script that send random sentences
#
# Configuration:
#   HUBOT_RANDOM_SENTENCES (default: <some dummy strings>)
#   HUBOT_RANDOM_SENTENCES_ROOM (default: #general)
#   HUBOT_RANDOM_SENTENCES_FREQUENCY (default: 60 * 60 seconds)
#   HUBOT_RANDOM_SENTENCES_OPEN_HOUR (default: 9)
#   HUBOT_RANDOM_SENTENCES_CLOSE_HOUR (default: 19)
#
# Commands:
#   none
#
# Author:
#   vspiewak
#

SENTENCES = process.env.HUBOT_RANDOM_SENTENCES || "Hey !|Yo !|What\'s up !|Bro ?|Wazaaaaaa !"
SENTENCES_ARRAY = SENTENCES.split '|'
SENTENCES_ROOM = process.env.HUBOT_RANDOM_SENTENCES_ROOM || '#general'
SENTENCES_FREQUENCY = process.env.HUBOT_RANDOM_SENTENCES_FREQUENCY || 60 * 60
SENTENCES_OPEN_HOUR = process.env.HUBOT_RANDOM_SENTENCES_OPEN_HOUR || 9
SENTENCES_CLOSE_HOUR = process.env.HUBOT_RANDOM_SENTENCES_CLOSE_HOUR || 19

random = (items) ->
  items[ Math.floor(Math.random() * items.length) ]

module.exports = (robot) ->
  robot.logger.info 'hubot-random-sentences started'

  # Will execute this every SENTENCES_FREQUENCY seconds
  setInterval () ->

    robot.logger.debug 'Executing hubot-random-sentences'

    hour = new Date().getHours()

    # Check if inside office hours
    if hour > SENTENCES_OPEN_HOUR and hour < SENTENCES_CLOSE_HOUR

      robot.logger.debug 'hubot-random-sentences will talk'
      random_message = random SENTENCES_ARRAY
      robot.messageRoom SENTENCES_ROOM, random_message

    else
      robot.logger.debug 'Skip hubot-random-sentences (not in office hours)'

  , 1000 * SENTENCES_FREQUENCY
