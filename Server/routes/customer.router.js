const router=require('express').Router();
const CustomerController=require('../controller/customer.controller')

router.post('/registration',CustomerController.register)

router.post('/login',CustomerController.login)

router.patch('/changename',CustomerController.changeName)


module.exports=router;