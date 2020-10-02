'use strict';
const AWS = require('aws-sdk');

console.log('Loading hello world function');

exports.handler = function(event, context, callback)  {
  console.log("request: " + JSON.stringify(event));

// Create an SQS service object
  var sqs = new AWS.SQS({apiVersion: '2012-11-05'});
  
  console.log("body:" + event.body)
  
  var params = {
    MessageBody: event.body,
    QueueUrl: process.env.queue_name
  };
  
  sqs.sendMessage(params, function (err, data) {
    console.log("sending message")
    if (err) {
      console.log("Error", err);
    } else {
      console.log("Success", data.MessageId);
    }
  });
  
  let responseBody = {};
  
  var response = {
    statusCode: 200,
    headers: {},
    body: JSON.stringify(responseBody)
  };
  callback(null, response)
};
