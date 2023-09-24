const ServiceModel = require('../model/service.model')
const CustomerServices = require("../services/customer.services")
const ServiceProviderModel = require('../model/serviceprovider.model')

exports.getBids = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        const {serviceid}=req.body;

        const customerid = await CustomerServices.getIdFromToken(authHeader);

     
        
        
        const successRes=await ServiceModel.getbids(serviceid)
      
        const serviceProviderId=successRes.serviceProviderId;


        res.status(200).json(successRes);


    } catch (error) {
        console.log(error + "error inserting the rating")
    }
}

exports.getAllTasks = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        // const {serviceid}=req.body;

        const customerid = await CustomerServices.getIdFromToken(authHeader);

     
        
        
        const successRes=await ServiceModel.alltasks(customerid)
        
        res.status(200).json(successRes);


    } catch (error) {
        console.log(error + " error inserting the rating")
    }
}