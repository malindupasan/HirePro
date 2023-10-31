const router = require('express').Router();
const LawnMovingController = require('../controller/lawnmoving.controller')
const ServiceController = require('../controller/service.controller')
const ServiceProviderController = require('../controller/serviceProvider.controller')

router.post('/addlawnmovingtask',LawnMovingController.addCustomerLawningTask);

router.post('/getbids',ServiceController.getBids);

router.post('/getspdetails',ServiceController.getServiceProviderDetails);

router.get('/getpendingtasks',ServiceController.getPendingTasks)

router.post('/acceptbid',ServiceController.acceptBid)


router.post('/getservicestatus',ServiceController.getServiceStatus)

router.get('/getOngoingandAcceptedTasks',ServiceController.getAcceptedandOngoingtaks)

router.get('/getCompletedTasks',ServiceController.getCompletedTasks)

router.get('/getscheduledtasks',ServiceController.getSheduledTasks)

router.post('/getsingletaskdetails',ServiceController.getSingleTaskDetails)


module.exports = router;