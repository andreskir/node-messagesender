express = require 'express'
bodyParser = require 'body-parser'
azure = require 'azure-storage'

app = express()

exports.app = app

app.set 'port', 4000
app.use bodyParser()

queueSvc = azure.createQueueService 'storageName', 'accessKey'

messageCtrl = (message) ->
  (req, res) ->
    queueSvc.createMessage 'requests', JSON.stringify(message), (err) ->
      if err
        return res.send err
      res.send message

app.get '/', (req, res) ->
  queueSvc.getQueueMetadata 'requests', (err, result, response) ->
    res.send result.approximatemessagecount

app.listen app.get('port'), () ->
  console.log "listening on port #{app.get('port')}"
