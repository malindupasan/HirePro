const router = require('express').Router();
const LawnMovingController = require('../controller/lawnmoving.controller')
const ServiceController = require('../controller/service.controller')

router.post('/addlawnmovingtask',LawnMovingController.addCustomerLawningTask)

router.post('/getbids',ServiceController.getBids)

module.exports = router;