const router = require('express').Router();
const CustomerController = require('../controller/customer.controller')

router.post('/register', CustomerController.register)

router.post('/login', CustomerController.login)

router.post('/changename', CustomerController.changeName)

router.post('/changepassword', CustomerController.changePwd)


router.get('/getdata',CustomerController.getData)


router.post('/addlawnmovingtask',CustomerController.addCustomerLawningTask)



router.get('/getaddress',CustomerController.getAddresses)

router.post('/addaddress',CustomerController.addAddress)



module.exports = router;