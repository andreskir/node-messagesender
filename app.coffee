express = require 'express'
bodyParser = require 'body-parser'
azure = require 'azure-storage'

app = express()

exports.app = app

app.set 'port', 4000
app.use bodyParser()

priceupdate =
  method: 'PUT'
  companyId: 1
  resource: 'products/55'
  body:
    prices: [
      priceList: "Default"
      amount: 649.99
    ]

stocksupdate =
  method: 'PUT'
  companyId: 1
  resource: 'products/55/stocks'
  body: [
    variation: 230
    stocks: [
      warehouse: "Default"
      quantity: 5
    ]
  ]

queueSvc = azure.createQueueService 'producteca', 'sharedKey'

messageCtrl = (message) ->
  (req, res) ->
    queueSvc.createMessage 'requests', JSON.stringify(message), (err) ->
      if err
        return res.send err
      res.send message

app.get '/priceupdate', messageCtrl priceupdate
app.get '/stocksupdate', messageCtrl stocksupdate
app.get '/', (req, res) ->
  queueSvc.getMessages 'requests', (err, result, response) ->
    if err
      return res.send err
    message = result[0]
    if message == undefined
      return res.send 'no new messages'
    queueSvc.deleteMessage 'requests', message.messageid, message.popreceipt, (err) ->
      if err
        return res.send err
      res.send message

app.listen app.get('port'), () ->
  console.log "listening on port #{app.get('port')}"
