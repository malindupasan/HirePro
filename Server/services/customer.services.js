const CustomerModel=require('../model/customer.model')
const jwt=require('jsonwebtoken')

class CustomerServices{

    static async registerCustomer(name,email,contact,password_hash){
        try {
            
            const newCustomer = await CustomerModel.create({name,email,contact,password_hash});
            console.log('New customer created:', newCustomer);

        } catch (error) {
            console.error('Error creating customer:', error);

            throw error;
        }
    }

    static async checkCustomer(email){
        try {
            return await CustomerModel.findByEmail(email);
        } catch (error) {
            throw error;
        }
    }
    static async updateName(id,name){
        try {
            return await CustomerModel.updateName({id,name});
        } catch (error) {
            throw error;
        }
    }

    static async genarateToken(tokenData,secretKey,jwt_expire){
        return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expire})
    }


}
module.exports = CustomerServices