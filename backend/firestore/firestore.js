const admin = require('firebase-admin');
const serviceAccount = require('../firestore/key.json');
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });


  const db = admin.firestore();

module.exports.db = db;
module.exports.admin = admin;