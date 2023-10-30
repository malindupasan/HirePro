const CustomerServices = require("../services/customer.services")

const LawnmovingModel = require('../model/lawnmoving.model')


exports.addCustomerLawningTask = async (req, res, next) => {
    try {

        const authHeader = req.headers.authorization;



        const customerid = await CustomerServices.getIdFromToken(authHeader);
        console.log(customerid)

        if(!customerid){
            console.log(customerid)
            res.send(404).json({message:"No access"});
        }

        
        // console.log("hi");
        const { area, description, postedtime, estmin, estmax, location, latitude, longitude, date } = req.body;
        // console.log(" "+location+" "+latitude+" "+longitude+" "+date);
        // console.log(description);
        const result = await LawnmovingModel.addtask({ area, description, postedtime, estmin, estmax, location, latitude, longitude, date, customerid });
        if (!result) {
            throw new Error("cannot add task");
        }
        // res.json(result);
        res.status(200).json({ status: true, serviceid:result.id })



    } catch (error) {
        console.log(error);
    }
}