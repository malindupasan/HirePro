
const CustomerServices = require("../services/customer.services")
const CustomerModel = require('../model/customer.model')


exports.register = async (req, res, next) => {
    try {
        const { name, email, contact, password } = req.body;
        console.log(name);

        const password_hash = password;
        const successRes = await CustomerServices.registerCustomer(name, email, contact, password_hash);
        res.json({ status: true, success: "User registered successfully" })

    } catch (error) {

    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        const customer = await CustomerServices.checkCustomer(email);
        //  console.log(customer)

        if (!customer) {
            throw new Error("User does not exist!");
        }

        const isMatch = await CustomerModel.checkPassword(customer.password_hash, password);
        if (isMatch === false) {
            res.send("wrong Credentials");

            throw new Error("Wrong credentials");



        }
        let tokenData = { id: customer.id, email: customer.email }

        const token = await CustomerServices.genarateToken(tokenData, "mal123", '1h')
        res.status(200).json({ status: true, token: token })


    } catch (error) {
        console.log(error);
    }
}

exports.changeName = async (req, res, next) => {
    try {
        const { id, name } = req.body;

        const successRes = await CustomerServices.updateName(id, name);
        res.json({ status: true, success: "Name updated successfully" })

    } catch (error) {
        console.log(error);
    }
}

exports.getData=async(req,res,next)=>{
    try {
        const {id}=req.body;


        const successRes=await CustomerModel.findById(id);
        res.send(successRes);
        // res.json({status:true,success:"Data fetched  successfully",data:successRes.data});

    } catch (error) {
        console.log(error);
    }
}


exports.changePwd=async(req,res,next)=>{
    try {
        const {id,oldPw,password,confirmPw}=req.body;



        if(password!==confirmPw){
            res.json({status:false,Error:"passwords does not match"})
            throw new Error("passwords do not match !");

        }

        const successRes=await CustomerModel.updatePassword({id,password});
        res.json({status:true,success:"password updated successfully"})

    } catch (error) {
        console.log(error);
    }
}
