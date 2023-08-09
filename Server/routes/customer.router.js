const router=require('express').Router();
const CustomerController=require('../controller/customer.controller')

router.post('/register',CustomerController.register)

router.post('/login',CustomerController.login)

router.patch('/changename',CustomerController.changeName)

router.patch('/changepassword',CustomerController.changePwd)

router.get('/getdata',CustomerController.getData)

router.post('/decodetoken',CustomerController.getIdFromToken)



module.exports=router;