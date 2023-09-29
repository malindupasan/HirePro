const ServiceModel = require('../model/service.model')
const CustomerServices = require("../services/customer.services")
const ServiceProviderModel = require('../model/serviceprovider.model')
const RatingModel = require('../model/rating.model')


exports.getSpDetails=async (req, res, next) => {

    try {
        const authHeader = req.headers.authorization;
        const {serviceproviderid}=req.body;

        const customerid = await CustomerServices.getIdFromToken(authHeader);
        if(!customerid){
            res.send(404).json({message:"No access"});
        }
       const result1= await ServiceProviderModel.findAvgRaings(serviceproviderid);
        const avgRatings={"avg": parseFloat(parseFloat(result1.sumrate)/parseFloat(result1.custno))};
       

       const spDetails = await ServiceProviderModel.findById(serviceproviderid);

        const mergedRes={
            ...avgRatings,
            ...spDetails
        }
        console.log(mergedRes);
        res.send(200).json(mergedRes);

     
    } catch (error) {
        console.error(error);
    }


}