# Description:
#   Gets the status of a service on the Hubot server
#
# Commands:
#   hubot list roomid shows current channel id

#import Token from './Azure-API.coffee'
{ Token } = require './Azure-API.coffee'

module.exports = (robot) ->
  # Capture the user message using a regex capture to find the name of the service

  robot.respond /list roomid/i, (msg) ->
    currentroom = msg.message.user.room
    email = msg.message.user.email_address
    msg.reply currentroom
    #msg.reply email
    #msg.reply msg.message.rawMessage.ts
    robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
    token = new Token("api")
    token.create()
    RunbookName = 'ADO-Commands'
    thebody = {
      'properties': {
        'runbook': { 'name': RunbookName }
        'runon': 'hybridworker'
        'parameters': { 'tasktype': 'listprs' , 'slackRoomID': currentroom, "email": email }
      }
    }
    running = token.Start_RunBook(thebody, token.get(), msg)
