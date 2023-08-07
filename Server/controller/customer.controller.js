const CustomerServices=require("../services/customer.services")

exports.register=async(req,res,next)=>{
    try {
        const {name,email,contact,password}=req.body;
        const password_hash=password;
        const successRes=await CustomerServices.registerCustomer(name,email,contact,password_hash);
        res.json({status:true,success:"User registered successfully"})

    } catch (error) {
        
    }
}

exports.login=async(req,res,next)=>{
    try {
        const {email,password}=req.body;
       
        const customer =await CustomerServices.checkCustomer(email);
        //  console.log(customer)

        if(!customer){
            throw new Error("User does not exist!");
        }
        const isMatch= await CustomerServices.checkCustomer(customer.password_hash,password);
        if (isMatch===false){
            throw new Error("Wrong credentials");

        }
        let tokenData={id:customer.id,email:customer.email}

        const token=await CustomerServices.genarateToken(tokenData,"mal123",'1h')
        res.status(200).json({status:true,token:token})
       

    } catch (error) {
        console.log(error);
    }
}

exports.changeName=async(req,res,next)=>{
    try {
        const {id,name}=req.body;
        
        const successRes=await CustomerServices.updateName(id,name);
        res.json({status:true,success:"Name updated successfully"})

    } catch (error) {
        console.log(error);
    }
}