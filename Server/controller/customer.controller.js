
const CustomerServices = require("../services/customer.services")
const CustomerotpModel = require('../model/customerotp.model')
const ServiceModel = require('../model/service.model')

const CustomerModel = require('../model/customer.model')
const LawnmovingModel = require('../model/lawnmoving.model')


exports.register = async (req, res, next) => {
    try {
        const { name, email, contact, password } = req.body;

        const newCustomer = await CustomerServices.registerCustomer(name, email, contact, password);
        if (!newCustomer) {
            throw new Error("Couldn't register");
        }

        console.log(newCustomer.id)


        res.status(200).json({ status: true, id: newCustomer.id })


    } catch (error) {
        console.log(error);
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
        const { name } = req.body;
        const authHeader = req.headers.authorization;


        const id = await CustomerServices.getIdFromToken(authHeader);
        const successRes = await CustomerServices.updateName(id, name);
        console.log(successRes);
        res.status(201).json(successRes);
        // res.json({ status: true, success: "Name updated successfully" })

    } catch (error) {
        console.log(error);
    }
}

exports.addCustomerLawningTask = async (req, res, next) => {
    try {

        const authHeader = req.headers.authorization;


        const id = await CustomerServices.getIdFromToken(authHeader);
        const customer = id;
        console.log("hi");
        const { area, description, postedtime, estmin, estmax, location, latitude, longitude, date } = req.body;
        // console.log(" "+location+" "+latitude+" "+longitude+" "+date);
        // console.log(description);
        const result = await LawnmovingModel.addtask({ area, description, postedtime, estmin, estmax, location, latitude, longitude, date, customer });
        if (!result) {
            throw new Error("cannot add task");
        }
        res.json(result);


    } catch (error) {
        console.log(error);
    }
}


exports.addAddress = async (req, res, next) => {
    try {

        const { address, title, latitude, longitude } = req.body;


        const authHeader = req.headers.authorization;


        const id = await CustomerServices.getIdFromToken(authHeader);

        const successRes = await CustomerModel.addAddress(id, address, title, latitude, longitude);
        // console.log(successRes);
        res.status(201).send("successRes");
        // res.json({ status: true, success: "Name updated successfully" })

    } catch (error) {
        console.log(error);
    }
}

exports.getData = async (req, res, next) => {
    try {


        const authHeader = req.headers.authorization;


        const id = await CustomerServices.getIdFromToken(authHeader);


        const successRes = await CustomerModel.findById(id);
        console.log(successRes);
        res.status(200).json(successRes);
        // res.json({status:true,success:"Data fetched  successfully",data:successRes.data});

    } catch (error) {
        console.log(error);
    }
}



exports.getAddresses = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;


        const id = await CustomerServices.getIdFromToken(authHeader);
        // const id=data.id
        // const data = await CustomerServices.decodeToken(token, "mal123")
        // console.log(data);

        const successRes = await CustomerModel.getAddress(id);
        console.log(successRes);


        res.status(200).json(successRes);
    } catch (error) {
        console.log(error + " bye")
    }
}


exports.changePwd = async (req, res, next) => {
    try {

        const authHeader = req.headers.authorization;


        const id = await CustomerServices.getIdFromToken(authHeader);

        const customer = await CustomerModel.findById(id);

        const { oldPw, password, confirmPw } = req.body;

        const isMatch = await CustomerModel.checkPassword(customer.password_hash, oldPw);

        if (isMatch == false) {
            res.send("old password is wrong")


            throw new Error("Wrong credentials");
        }




        if (password !== confirmPw) {
            res.json({ status: false, Error: "passwords does not match" })
            throw new Error("passwords do not match !");

        }

        const successRes = await CustomerModel.updatePassword({ id, password });
        res.status(201).json(successRes);
        console.log(successRes);
        // res.json({ status: true, success: "password updated successfully" })

    } catch (error) {
        console.log(error);
    }
}

exports.saveotp = async (req, res, next) => {
    try {
        // const authHeader = req.headers.authorization;



        // const customerid = await CustomerServices.getIdFromToken(authHeader);
        // const id=data.id
        // const data = await CustomerServices.decodeToken(token, "mal123")
        // console.log(data);
        const { customerid, otp } = req.body;

        const successRes = await CustomerotpModel.addotp({ customerid, otp });
        console.log(successRes);


        res.status(200).json(successRes);
    } catch (error) {
        console.log(error + " bye")
    }
}
exports.checkotp = async (req, res, next) => {
    try {
        // const authHeader = req.headers.authorization;


        // const customerid = await CustomerServices.getIdFromToken(authHeader);
        // const id=data.id
        // const data = await CustomerServices.decodeToken(token, "mal123")
        // console.log(data);
        const { otp, customerid } = req.body;
        console.log(otp);
        const otpindb = await CustomerotpModel.checkotp({ customerid });
        console.log(otpindb);
        if (otpindb.otp.toString() === otp) {
            res.status(200).json("Success");

        }
        else {
            res.status(404).json("Error");
        }


    } catch (error) {
        console.log(error + " bye")
    }
}

exports.getcompletedtasks = async (req, res, next) => {

    try {
        const authHeader = req.headers.authorization;
        const id = await CustomerServices.getIdFromToken(authHeader);
        if(!id){
            throw new Error("Invalid token !");

        }
        const result=await ServiceModel.completedTasks(id);

       res.send(result);

        








    } catch (error) {
        console.log(error );
    }
}

