var express = require("express");
var router = express.Router();
const storiesController = require("../controller/stories-controller");
const { validationResult, check } = require("express-validator");
/* GET One pin & stories listing. */
router.get(
  "/getOne/:id",
  
  storiesController.getStory
);

router.get(
  "/getUserStories",
  
  storiesController.getUserStories
);

router.get(
  "/getAddedStories",
 
  storiesController.getAddedStories
);
/* ADD pin & stories listing. */
router.post(
  "/add",

 
  storiesController.addStory
);

/* UPDATE pin & stories listing. */
router.patch("/update/:id", storiesController.updateStory);

/* DELETE pin & stories listing. */
router.delete("/delete/:id", storiesController.deleteStory);

module.exports = router;
