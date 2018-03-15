const express = require('express');
const app = express();
const server = require('http').Server(app);

const mongo = require('mongodb').MongoClient;
const ObjectID = require('mongodb').ObjectID;
const mongo_url = "mongodb://localhost:27017/";
const db_name = "bubbleio";
const port = 80;
let dbo;


app.use(express.static('build'));







// On browser load
app.get('/', function (req, res) {
  res.sendFile(__dirname + '/build/index.html');
});






// Create a DB connection
mongo.connect(mongo_url, function(err, db) {
  if (err) throw err;
  dbo = db.db(db_name);
  server.listen(port, function() {
   console.log('Server listening on http://localhost:' + port);
  });
});
