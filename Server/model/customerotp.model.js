const db = require('../config/db');




class Customerotp {
    constructor({ id, customerid, otp, timestamp }) {
        this.id = id;
        this.customerid = customerid;
        this.otp = otp;
        this.timestamp = timestamp;

    }

    static async addotp(data) {
        try {
            const { otp,customerid } = data;

            
           
            const query0 = 'SELECT id from customerotp where customerid=$1';
            const values0 = [customerid];
          

            const res1=await db.query(query0, values0);
            console.log(res1.rows);
            if(res1.rows.length > 0) {
                const id = res1.rows[0].id;
                const query1='delete from customerotp  where customerid=$1';
                const values1=[customerid];

                const res2=await db.query(query1, values1);
                
            }
         
                const query2="insert into customerotp (customerid,otp) values($1,$2) returning *";
                const values2=[customerid,otp];
                const res3=await db.query(query2, values2);
                return true;
            


         
          
  
        } catch (error) {
            throw error;
        }
    }

    static async checkotp(data) {
        try {
            const {customerid } = data;

            
           
            const query0 = 'SELECT otp from customerotp where customerid=$1';
            const values0 = [customerid];
          

            const res1=await db.query(query0, values0);
            return res1.rows[0];

            // console.log(res1);
            


         
          
  
        } catch (error) {
            throw error;
        }
    }


    // Add other static methods for CRUD operations as needed
}

module.exports = Customerotp;
