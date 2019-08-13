# Description:
#   Gets the status of a service on the Hubot server
#
# Commands:
#   hubot reset cacheid <id> on <env> -  resets cachce by id and environment for hcbbweb


#Defining a class

{ Token } = require './Azure-API.coffee'

module.exports = (robot) ->
    robot.respond /reset cacheid (.*) on (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        cacheid = msg.match[1]
        env = msg.match[2]
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        RunbookName = 'Web-Commands'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'cacheid': cacheid , 'env': env,  'slackRoomID': currentroom, "email": email }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)