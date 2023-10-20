const router = require('express').Router();
const ServiceProviderController = require('../controller/serviceProvider.controller')


router.post('/spdetailswithraings',ServiceProviderController.getSpDetails)

router.post('/getSpdetailsext',ServiceProviderController.getSpDetails)


module.exports = router;