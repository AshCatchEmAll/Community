const {admin} = require("../firestore/firestore")

const checkAuth = (req, res, next)=>  {
    if (req.headers.authtoken) {
       
      admin.auth().verifyIdToken(req.headers.authtoken)
        .then(() => {
            req.uid = req.headers.uid
          next()
        }).catch(() => {
          res.status(403).json ({message:'Something went wrong while authorizing you, Please try again later'})
        });
    } else {
      res.status(403).json({message:'You are unauthorized, please login or signup'})
    }
  }


exports.checkAuth = checkAuth;