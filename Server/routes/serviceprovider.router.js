const router = require('express').Router();
const ServiceProviderController = require('../controller/serviceProvider.controller')


router.post('/spdetailswithraings',ServiceProviderController.getSpDetails)

module.exports = router;