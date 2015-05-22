node-messagesender
================

[![Join the chat at https://gitter.im/andreskir/node-messagesender](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/andreskir/node-messagesender?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Sends messages to Azure Queue

## Prerrequisitos

* [Git](http://git-scm.com/)
* [NodeJS](http://nodejs.org/)

### Quick start

```
npm install

npm start # Start application
```

### To Send Messages
**pricechange message**
```
GET http://localhost:4000/priceupdate/
```
**stockupdate message**
```
GET http://localhost:4000/stockupdate/
```

### To Read Messages
```
GET http://localhost:4000/
```
