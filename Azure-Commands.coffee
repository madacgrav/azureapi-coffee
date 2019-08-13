# Description:
#   Gets the status of a service on the Hubot server
#
# Commands:
#   hubot start server <server name> - Powers on server in Azure 
#   hubot stop server <server name> - Powers off server in Azure 
#   hubot server status <server name> - Shows power status for server
#   hubot list servers - Lists all servers in Azure
#   hubot add ip <ip> to SQL whitelist on <environment> with rulename <rulename to use (no spaces) - Add IP to Azure SQL firewall whitelist
#   hubot show sql whitelist on <environment> - display list of whitelist rules on SQL firewall

#Defining a class

{ Token } = require './Azure-API.coffee'


module.exports = (robot) ->
    robot.respond /start server (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        servername = msg.match[1]
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.profile.email
        RunbookName = 'Azure-Commands'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'start' , 'servername': servername , 'slackRoomID': currentroom, "email": email }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)


    robot.respond /stop server (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        servername = msg.match[1]
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.profile.email
        RunbookName = 'Azure-Commands'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'stop' , 'servername': servername , 'slackRoomID': currentroom, "email": email  }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)


    robot.respond /server status (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        servername = msg.match[1]
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        RunbookName = 'Azure-Commands'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'status' , 'servername': servername , 'slackRoomID': currentroom  }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)

   
    robot.respond /list servers$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        RunbookName = 'Azure-Commands'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'list' , 'slackRoomID': currentroom  }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)


    robot.respond /add ip (.*) to SQL whitelist on (.*) with rulename (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        ip = msg.match[1]
        env = msg.match[2]
        rulename = msg.match[3]
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        RunbookName = 'Update-SQLFirewall'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'add' , 'slackRoomID': currentroom , "email": email , "env": env , "ip": ip , "rulename": rulename }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)


    robot.respond /show sql whitelist on (.*)$/i, (msg) ->
        robot.emit 'slack.reaction', { message: msg.message, name: 'robot_face' }
        env = msg.match[1]
        token = new Token("api")
        token.create()
        currentroom = msg.message.user.room
        email = msg.message.user.email_address
        RunbookName = 'Update-SQLFirewall'
        thebody = {
            'properties': {
                'runbook': { 'name': RunbookName }
                'runon': 'hybridworker'
                'parameters': { 'tasktype': 'list' , 'slackRoomID': currentroom , "email": email , "env": env }
            }
        }
        running = token.Start_RunBook(thebody, token.get(), msg)






