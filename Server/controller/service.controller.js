const ServiceModel = require('../model/service.model')
const CustomerServices = require("../services/customer.services")
const ServiceProviderModel = require('../model/serviceprovider.model')
const RatingModel = require('../model/rating.model')

exports.getBids = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        const {serviceid}=req.body;


        const customerid = await CustomerServices.getIdFromToken(authHeader);

        if(!customerid) {
            res.status(404).json({message:"Unauthenticated"})
        }
        else{
        
        
        const successRes=await ServiceModel.getbids(serviceid)
      
        const serviceProviderId=successRes.serviceProviderId;


        res.status(200).json(successRes);
        }


    } catch (error) {
        console.log(error + "error inserting the rating")
    }
}

exports.acceptBid=async (req, res, next) => {

    try {
        const authHeader = req.headers.authorization;
        const {serviceid}=req.body;

        const customerid = await CustomerServices.getIdFromToken(authHeader);

     
    } catch (error) {
        
    }


}

exports.getAllTasks = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        // const {serviceid}=req.body;

        const customerid = await CustomerServices.getIdFromToken(authHeader);

        if(!customerid) {
            throw new Error;
        }
     
        
        
        const successRes=await ServiceModel.alltasks(customerid)
        
        res.status(200).json(successRes);


    } catch (error) {
        console.log(error + " error inserting the rating")
    }
}

exports.getTaskbyId= async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        const customerid=await CustomerServices.getIdFromToken(authHeader);

        if(!customerid) {
            throw new Error;
        }

        const successRes=await ServiceModel.alltasks(customerid);
        
        
    } catch (error) {
        
    }
}

exports.getServiceProviderDetails=async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        const customerid=await CustomerServices.getIdFromToken(authHeader);
         console.log("getspdetails");
        if(!customerid) {
            throw new Error;
        }
        const{ serviceProviderId}=req.body;
        const spDetails=await ServiceProviderModel.findById(serviceProviderId);

       
        const reviews= await RatingModel.getReviews(serviceProviderId);
        // console.log(spDetails);
        // console.log("reviews");
        // console.log(reviews);

        spDetails.reviews=reviews;

        res.status(200).json(spDetails);


    } catch (error) {
        console.log(error);
    }
}

exports.getPendingTasks= async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        const customerid=await CustomerServices.getIdFromToken(authHeader);
        if(!customerid) {
            throw new Error;
        }

        const successRes=await ServiceModel.pendingTasks(customerid);
        console.log("hello");

        res.status(200).json(successRes);
        
        
    } catch (error) {
        console.log(error);
    }
}