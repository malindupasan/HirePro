const router = require('express').Router();
const ServiceProviderController = require('../controller/serviceProvider.controller')


router.post('/spdetailswithraings',ServiceProviderController.getSpDetails)

router.post('/getSpdetailsext',ServiceProviderController.getSpDetails)
router.post('/getsplocation',ServiceProviderController.getSpLoc)


module.exports = router;