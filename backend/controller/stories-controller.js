const { db } = require("../firestore/firestore");
const { validationResult, check } = require("express-validator");
const addStory = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    console.log("Error");
    const errorArray = errors.array();
    return res.status(400).json({ message: errorArray });
  }
  if (req.uid) {
    try {
      const story = req.body.story;
      const xcord = req.body.xcord;
      const ycord = req.body.ycord;
      const subject = req.body.subject;
      const docRef = db.collection("stories");
      const createdAt = new Date().getTime();

      const response = await docRef.add({
        story: story,
        xcord: xcord,
        ycord: ycord,
        subject: subject,
        public: false,
        createdAt: createdAt,
        ownerID: req.uid,
      });
      return res
        .status(200)
        .json({ message: "Insertion succesfull", id: response.id });
    } catch (err) {
      return next(new Error("Error adding story : " + err));
    }
  } else {
    return res.status(401).send({ message: "You need to be validated" });
  }
};

const deleteStory = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    console.log("Error");
    const errorArray = errors.array();
    return res.status(400).json({ message: errorArray });
  }
  if (req.uid) {
    try {
      const id = req.params.id;
      const response = await db.collection("stories").doc(id).delete();

      return res.status(200).json({ message: "Deletion succesfull" });
    } catch (err) {
      return next(new Error("Error deleting story : " + err));
    }
  } else {
    return res.status(401).send({ message: "You need to be validated" });
  }
};

const updateStory = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    console.log("Error");
    const errorArray = errors.array();
    return res.status(400).json({ message: errorArray });
  }
  if (req.uid) {
    try {
      const id = req.params.id;
      const story = req.body.story;
      const createdAt = new Date().getTime();
      const docRef = db.collection("stories").doc(id);
      const response = await docRef.update({
        story: story,
        createdAt: createdAt,
      });

      return res.status(200).json({ message: "Updation succesfull" });
    } catch (err) {
      return next(new Error("Error updating story : " + err));
    }
  } else {
    return res.status(401).send({ message: "You need to be validated" });
  }
};

const getUserStories = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    console.log("Error");
    const errorArray = errors.array();
    return res.status(400).json({ message: errorArray });
  }
  if (req.uid) {
    try {
      const id = req.params.id;
      const docRef = db.collection("stories");

      const snapshot = await docRef.where("ownerID", "==", req.uid).get();
      if (snapshot.empty) {
        return res.status(200).json({ message: "No such story found",doc:[] });
      } else {
        const returnedDocs = [];
        snapshot.forEach((doc) => {
          returnedDocs.push({
            story: doc.data()["story"],
            subject: doc.data()["subject"],
            xcord: doc.data()["xcord"],
            ycord: doc.data()["ycord"],
            id: doc.id,
            public: doc.data()["public"],
          });

     
        });

        return res
          .status(200)
          .json({ message: "Documents found", doc: returnedDocs });
      }
    } catch (err) {
      return next(new Error("Error updating story : " + err));
    }
  } else {
    return res.status(401).send({ message: "You need to be validated" });
  }
};

const getAddedStories = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    console.log("Error");
    const errorArray = errors.array();
    return res.status(400).json({ message: errorArray });
  }
  if (req.uid) {
    try {
      const docRef = db.collection("stories");

      const snapshot = await docRef.where("public", "==", true).get();
      if (snapshot.empty) {
        return res.status(404).json({ message: "No such story found" });
      } else {
        const returnedDocs = [];
        snapshot.forEach((doc) => {
          returnedDocs.push({
            story: doc.data()["story"],
            subject: doc.data()["subject"],
            xcord: doc.data()["xcord"],
            ycord: doc.data()["ycord"],
            id: doc.id,
          });

      
        });

        return res
          .status(200)
          .json({ message: "Documents found", doc: returnedDocs });
      }
    } catch (err) {
      return next(new Error("Error updating story : " + err));
    }
  } else {
    return res.status(401).send({ message: "You need to be validated" });
  }
};
const getStory = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    console.log("Error");
    const errorArray = errors.array();
    return res.status(400).json({ message: errorArray });
  }
  if (req.uid) {
    try {
      const id = req.params.id;
      const docRef = db.collection("stories").doc(id);
      const doc = await docRef.get();
      if (!doc.exists) {
        return res.status(200).json({ message: "No such story found" });
      } else {
        const returnDoc = {
          story:
            doc["_fieldsProto"]["story"][
              doc["_fieldsProto"]["story"]["valueType"]
            ],
          xcord:
            doc["_fieldsProto"]["xcord"][
              doc["_fieldsProto"]["xcord"]["valueType"]
            ],
          ycord:
            doc["_fieldsProto"]["ycord"][
              doc["_fieldsProto"]["ycord"]["valueType"]
            ],
        };
        return res
          .status(200)
          .json({ message: "Document found", doc: returnDoc });
      }
    } catch (err) {
      return next(new Error("Error updating story : " + err));
    }
  } else {
    return res.status(401).send({ message: "You need to be validated" });
  }
};
exports.addStory = addStory;
exports.deleteStory = deleteStory;
exports.updateStory = updateStory;
exports.getStory = getStory;
exports.getUserStories = getUserStories;
exports.getAddedStories = getAddedStories;
