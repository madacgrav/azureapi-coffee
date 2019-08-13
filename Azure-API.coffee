

class Token
    constructor: (@name)->
    create: ->
        fs = require "fs"
        request = require 'request'
        host = 'login.windows.net'
        uri = '**subsccriptionid**/oauth2/token'
        fullurl = "https://login.windows.net/**tenatid**/oauth2/token"
        ARMResource = 'https://management.core.windows.net/'
        ClientID       = '*****azure client/app ID'
        ClientSecret   = 'SPN secret for API'
        tennantid      = '**tenant id***'
        apibody = {
            'grant_type': 'client_credentials' ,
            'resource': ARMResource ,
            'client_id': ClientID ,
            'client_secret': ClientSecret
        }
        apiheaders = {
            'accept': 'application/json'
        }
        request.post ({url: fullurl , form: apibody , headers: apiheaders , json: true }) , (error, response, body) ->
            @token = response.body.access_token
            #console.log response.body.access_token
            fs.writeFile "E:\\Hubot\\config\\token.txt" , @token , (e) ->
                if e
                    throw e
    get: () ->
        this.create()
        fs = require "fs"
        foo = ->
            fs.readFileSync "E:\\Hubot\\config\\token.txt" , 'utf8'
        return foo()
    
    clearfile: () ->
        fs = require "fs"

    Start_RunBook: (rbbody, authtoken, msg) ->
        request = require 'request'
        tennantid      = "**tenant id***"
        SubscriptionId = '**subsccriptionid**'
        rg = '** resource group name***'
        aaname = '**Automation Account Name***'
        APIVersion = '2017-05-15-preview'
        ContentType = 'application/x-www-form-urlencoded'
       # console.log authtoken
        uuidv1 = require('uuid/v1')
        guid =  uuidv1()
        rbheader = {
            'authorization': "Bearer #{authtoken}"
        }
        fullUri = "https://management.azure.com/subscriptions/#{SubscriptionId}/resourceGroups/#{rg}/providers/Microsoft.Automation/automationAccounts/#{aaname}/jobs/#{guid}?api-version=#{APIVersion}"
        
        try
            request.put { uri: fullUri , body: rbbody , headers: rbheader , json: true } , (error, response, body) ->
                msg.reply (body.error.code + " : Error with command, retry and if persists notify #sre")
        catch
            msg.send e

exports.Token = Token