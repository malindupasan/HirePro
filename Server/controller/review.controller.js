const RatingModel = require('../model/rating.model')
const CustomerServices = require("../services/customer.services")

exports.addReview = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization; 


        const customerid = await CustomerServices.getIdFromToken(authHeader);

        // const id=data.id
        // const data = await CustomerServices.decodeToken(token, "mal123")
        console.log(customerid);
        const {comment,starRate,serviceproviderid}=req.body;
        
        const successRes=await RatingModel.addRating(comment, starRate, customerid, serviceproviderid);
        // console.log(successRes);
        res.status(200).json(successRes);


    } catch (error) {
        console.log(error + " error inserting the rating")
    }
}