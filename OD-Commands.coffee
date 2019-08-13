# Description:
#   Gets the status of a service on the Hubot server
#
# Commands:
#   hubot deploy <appname> to <environment> version <version> - Deploys application to specfic envr and version
#   hubot deploy <appname> to <environment>- Deploys application to specfic envr and latest version
#   hubot show deployments <search term> - Shows deployments within search term
#   hubot show deployments - Shows all deployments


#Defining a class

{ Token } = require './Azure-API.coffee'


module.exports = (robot) ->
    robot.respond /show deployments (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        searchterm = msg.match[1]
        token = new Token("api")
        token.create()
        RunbookName = 'OD-Commands'
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'list' , 'searchterm': searchterm , 'slackchannel': 'devops' , 'slackRoomID': currentroom, "email": email }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)


    robot.respond /show deployments$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        token = new Token("api")
        token.create()
        RunbookName = 'OD-Commands'
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'list' , 'slackchannel': 'devops' , 'slackRoomID': currentroom, "email": email }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)


    robot.respond /deploy (.*) to (.*) version (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        app = msg.match[1]
        env = msg.match[2]
        version = msg.match[3]
        token = new Token("api")
        token.create()
        RunbookName = 'OD-Commands'
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { "tasktype": "deploy" , "project": app , "env": env , "version": version , 'slackRoomID': currentroom, "email": email }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)


    robot.respond /deploy (.*) to (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        app = msg.match[1]
        env = msg.match[2]
        token = new Token("api")
        token.create()
        RunbookName = 'OD-Commands'
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { "tasktype": "deploy" , "project": app , "env": env , "version": "latest" , 'slackRoomID': currentroom, "email": email }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)




