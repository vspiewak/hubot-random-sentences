# Description:
#   A hubot script that send random sentences
#
# Configuration:
#   HUBOT_RANDOM_SENTENCES_FREQUENCY
#   HUBOT_RANDOM_SENTENCES_ROOM
#   HUBOT_RANDOM_SENTENCES
#
# Commands:
#   none
#
# Author:
#   vspiewak
#

SENTENCES_FREQUENCY = process.env.HUBOT_RANDOM_SENTENCES_FREQUENCY || 5
SENTENCES_ROOM = process.env.HUBOT_RANDOM_SENTENCES_ROOM || '#general'
SENTENCES = process.env.HUBOT_RANDOM_SENTENCES || ['Wazaaaaaa', 'Hey ! how are you doing ?']

module.exports = (robot) ->
  tryRandomSentence(robot)

  random = (items) ->
    items[ Math.floor(Math.random() * items.length) ]

  tryRandomSentence = (robot) ->
    robot.logger.info 'exec tryRandomSentence'
    robot.messageRoom SENTENCES_ROOM, random SENTENCES

    setTimeout (->
      tryRandomSentence(robot)
    ), 1000 * 60 * SENTENCES_FREQUENCY
