const CustomerModel = require('../model/customer.model')
const jwt = require('jsonwebtoken')

class CustomerServices {

    static async registerCustomer(name, email, contact, password_hash) {
        try {

            const newCustomer = await CustomerModel.create({ name, email, contact, password_hash });
            console.log('New customer created:', newCustomer);
            return newCustomer;

        } catch (error) {
            console.error('Error creating customer:', error);

            throw error;
        }
    }

    static async checkCustomer(email) {
        try {
            return await CustomerModel.findByEmail(email);
        } catch (error) {
            throw error;
        }
    }
    static async updateName(id, name) {
        try {
            return await CustomerModel.updateName({ id, name });
        } catch (error) {
            throw error;
        }
    }




    static async genarateToken(tokenData, secretKey, jwt_expire) {
        return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire })
    }

    static async decodeToken(token, secretKey) {
        return jwt.verify(token, secretKey)

    }
    static async getIdFromToken(authHeader) {

        if(!authHeader){
           return false;}

        

        const token = authHeader.split(' ')[1]; // Extract the token part

        if (!token) {
            // res.send(404);
            console.log("no  token")
        }


        const data = await CustomerServices.decodeToken(token, "mal123")
        // console.log(data);
        return data.id;

    }


}
module.exports = CustomerServices