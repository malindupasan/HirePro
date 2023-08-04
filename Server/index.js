const app = require("./app");
const Customer = require('./model/customer.model');

// const db = require('./config/db')
const port = 3000;

async function createCustomer() {
    try {
      // Define the data for the new customer
      const newCustomerData = {
        contact: '1234567890',
        name: 'John Doe',
        email: 'john.doe16@example.com',
        loyaltyPoints: 100,
        passwordHash: 'somehashvalue',
      };
  
      // Call the create method with the new customer data
      const newCustomer = await Customer.create(newCustomerData);
  
      // The new customer object will be returned after the insert operation
      console.log('New customer created:', newCustomer);
    } catch (error) {
      console.error('Error creating customer:', error);
    }
  }

app.get('/',(req,res)=>{
   
 

    try {
        // createCustomer();

    } catch (error) {
        console.log(error);
        res.send("error");
        console.log("fail");

        
    }

    // Customer.create(newCustomerData);
    // res.send("hwllo world! ")
})

app.listen(port,()=>{
    console.log(`Server Listening on Port http://localhost:${port}`);
})