const ServiceModel = require('../model/service.model')
const CustomerServices = require("../services/customer.services")

exports.getBids = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        const {serviceid}=req.body;

        // const customerid = await CustomerServices.getIdFromToken(authHeader);

     
        
        
        const successRes=await ServiceModel.getbids(serviceid)
        
        res.status(200).json(successRes);


    } catch (error) {
        console.log(error + " error inserting the rating")
    }
}