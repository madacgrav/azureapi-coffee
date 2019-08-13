# Description:
#   Gets the status of a service on the Hubot server
#
# Commands:
#   hubot list builds - list all builds in Azure DevOps 
#   hubot list builds <searchterm> - list all builds in Azure DevOps with fuzzy search
#   hubot listprs - list all active prs in Azure DevOps 
#   hubot build <appname> - start build in Azure Devopss

#Defining a class

{ Token } = require './Azure-API.coffee'

module.exports = (robot) ->
    robot.respond /list builds$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        RunbookName = 'ADO-Commands'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'list' , 'slackRoomID': currentroom, "email": email }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)

    robot.respond /list builds (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        search = msg.match[1]
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        RunbookName = 'ADO-Commands'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'list' , 'slackRoomID': currentroom, "email": email, "search": search }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)

    robot.respond /listprs$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        RunbookName = 'ADO-Commands'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'listprs' , 'slackRoomID': currentroom, "email": email }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)

    robot.respond /build (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        appname = msg.match[1]
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        RunbookName = 'ADO-Commands'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'build' , 'slackRoomID': currentroom, "email": email, "appname": appname }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)