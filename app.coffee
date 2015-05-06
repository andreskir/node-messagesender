express = require 'express'
bodyParser = require 'body-parser'
azure = require 'azure-storage'

app = express()

exports.app = app

app.set 'port', 4000
app.use bodyParser()

queueSvc = azure.createQueueService 'storageAccount', 'accessKey'

app.get '/', (req, res) ->
  queueSvc.getQueueMetadata 'queueName', (err, result, response) ->
    res.send result.approximatemessagecount

app.listen app.get('port'), () ->
  console.log "listening on port #{app.get('port')}"
