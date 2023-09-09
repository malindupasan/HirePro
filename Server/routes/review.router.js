const router = require('express').Router();
const ReviewController = require('../controller/review.controller')


router.post('/addreview',ReviewController.addReview)

module.exports = router;