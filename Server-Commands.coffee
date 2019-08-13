# Description:
#   Gets the status of a service on the Hubot server
#
# Commands:
#   hubot dstask2 <tasktype> <environment> - ex. dstask dataload prod , dstask auditrunner prod
#   hubot <type> appPool <appPool name> on <server> - start/stop/restart an application pool on specific server

#Defining a class

{ Token } = require './Azure-API.coffee'

module.exports = (robot) ->
    robot.respond /(.*) appPool (.*) on (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        action = msg.match[1]
        appPoolName = msg.match[2]
        server = msg.match[3]
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        RunbookName = 'IIS-Commands'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'action': action , 'appPoolName': appPoolName, 'server': server, 'slackRoomID': currentroom, "email": email }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)

    robot.respond /list tasks on (.*)/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        servername = msg.match[1]
        tasktype = "list"
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        RunbookName = 'Server-Commands'
        thebody = {
        'properties': {
            'runbook': { 'name': RunbookName }
            'runon': 'hybridworker'
            'parameters': { 'jobtype': tasktype , 'jobserver': servername,  'slackRoomID': currentroom, "email": email }
        }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)