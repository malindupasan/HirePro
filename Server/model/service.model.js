const db = require('../config/db');


class Service {
  constructor({ description, postedtime, estimation, acceptedtime, location, latitude, longitude, date, customer }) {
    // this.id = id;
    this.description = description;
    this.postedtime = postedtime;
    this.estimation = estimation;
    this.acceptedtime = acceptedtime;
    this.location = location;
    this.latitude = latitude;
    this.longitude = longitude;
    this.date = date;
    this.customer = customer;
  }




  static async getbids(serviceid) {
    // const query = 'SELECT * FROM "Bid" where "serviceId" = $1';
    const query = 'SELECT b.* ,s.contact,s.intro,s.name,s.id as spid  FROM "Bid" AS b inner join "ServiceProvider" AS s on s.id=b."serviceProviderId" where "serviceId" = $1';

    const values = [serviceid];

    try {
      const result = await db.query(query, values);
      if (result.length == 0) {
        return "No bids found for service";

      }
      else {


        return result.rows;
      }


    }
    catch (error) {
      throw error;
    }

  }

  static async pendingTasks(customerid) {

    const query = 'SELECT * FROM "Service" s  where status=$1 AND s.customerid=$2  ';
    const values = ["pending",customerid];

    try {
      const result = await db.query(query, values);
      
      if (!result.rows) {
        return "No pending taks";

      }
      else {
        console.log("hey");
        return result.rows;
      }

    }
    catch (error) {
      throw error;
    }

  }


  static async alltasks(customerid) {
    const query = 'SELECT * FROM "Service" where "customerid" = $1 and';
    const values = [customerid];

    try {
      const result = await db.query(query, values);
      if (result.rows[0].count <= 0) {
        return "No bids found for service";

      }
      else {
        return result.rows[0];
      }


    }
    catch (error) {
      throw error;
    }

  }

  static async completedTasks(customerid) {
    // console.log(customerid);
    const query = 'SELECT * FROM "Service" s  where status=$1 AND s.customerid=$2  ';
    const values = ["completed",customerid];

    try {
      const result = await db.query(query, values);
      
      if (!result.rows) {
        return "No pending taks";

      }
      else {
        console.log("hey");
        return result.rows;
      }

    }
    catch (error) {
      throw error;
    }


  }




static async acceptTask(serviceid,bidid,customerid) {

  const query = 'update "Service" set status=\'accepted\' where id=$1';
  const query2='update "Bid" set accept_customerid=$1,accept_timestamp=$2 where id=$3'

  const currentTimestamp = new Date();
  currentTimestamp.setHours(currentTimestamp.getHours() + 5); // Add 5 hours
  currentTimestamp.setMinutes(currentTimestamp.getMinutes() + 30); // Add 30 minutes
  
  const formattedTimestamp = currentTimestamp.toISOString().slice(0, 19).replace('T', ' ');
    const values2=[customerid,formattedTimestamp,bidid];
  const values = [serviceid];


  const date=new Date();
console.log(date);

  try {

    const result2 = await db.query(query2, values2);


    const result = await db.query(query, values);
    console.log("second query didnt work");


    // if(result2.rowCount==0){
    //   console.log("second query didnt work");
    // }


    if (result.rowCount === 0) {
      console.log("No rows were updated.");
      return false;  // No rows were updated
    } else {
      console.log("Update was successful.");
      return true;   // Update was successful
    }
  } catch (error) {
    // throw error;
    console.log(error)
  }

}

// static async acceptTask(taskid){

//   const query = 'update "Service" set status=\'accepted\' where id=$1';
//   const values = [taskid];
//   try {
//     const result = await db.query(query, values);

//     if (result.rowCount === 0) {
//       console.log("No rows were updated.");
//       return false;  // No rows were updated
//     } else {
//       console.log("Update was successful.");
//       return true;   // Update was successful
//     }
//   } catch (error) {
//     // throw error;
//     console.log(error)
//   }

// }

static async getStatus(taskid){

  const query = 'select status from "Service" where id=$1';
  const values = [taskid];

  try {
    const result = await db.query(query, values);
    if (result.rowCount === 0) {
      console.log("No rows were updated.");
      return false;  // No rows were updated
    } else {
      console.log("Update was successful.");
      return result.rows[0];   // Update was successful
    }

  } catch (error) {
    console.log(error)
  }



}

static async getOngoingAndAcceptedTasks(customerid){

  const query = 'select * from "Service" where (status=\'ongoing\' or status=\'accepted\') AND "customerid"=$1 ';
  // const query = `SELECT * FROM "Service" WHERE (status='ongoing' OR status='accepted') AND "customerid"=$1`;

  // const query1 = 'SELECT "Service".*, bid.amount FROM "Service" LEFT JOIN "Bid" ON "Service"."id" = bid."serviceid" WHERE ("Service".status=\'ongoing\' OR "Service".status=\'accepted\') AND "Service"."customerid"=$1';

  const query3 = `
    SELECT "Service".*, bid.amount 
    FROM "Service"
    LEFT JOIN "Bid" AS bid ON "Service"."id" = bid."serviceId"
    WHERE ("Service".status='ongoing' OR "Service".status='accepted') AND "Service"."customerid"=$1;
`;

const query1 = `
    SELECT "Service".*, bid.amount, sp.name AS "providerName"
    FROM "Service"
    LEFT JOIN "Bid" AS bid ON "Service"."id" = bid."serviceId"
    LEFT JOIN "ServiceProvider" AS sp ON bid."serviceProviderId" = sp."id"
    WHERE ("Service".status='ongoing' OR "Service".status='accepted') AND "Service"."customerid"=$1;
`;

  const values = [customerid];

  try {
    const result = await db.query(query1,values);
    if (result.rowCount === 0) {
      console.log("No rows were updated.");
      return false;  // No rows were updated
    } else {
      console.log("Update was successful.");
      return result.rows;   // Update was successful
    }

  } catch (error) {
    console.log(error)
  }



}
static async getCategory(serviceid){

  const query1 = 'select * from "HouseCleaningTasks" where id=$1';
  const query2 = 'select * from "HairDressing" where id=$1';
  const query3 = 'select * from "LawnMoving" where id=$1';

  const values = [taskid];

  try {
    const result = await db.query(query1,values);
    if (result.rowCount > 0) {
      return "House Cleaning";  
    } 
    const result1 = await db.query(query2,values);
    if (result1.rowCount > 0) {
      return "Hair Dressing";  
    } 

    const result2 = await db.query(query3,values);
    if (result2.rowCount > 0) {
      return "Lawn Moving";  
    } 


  return "Genaral";




  } catch (error) {
    console.log(error)
  }



}










  // Add other static methods for CRUD operations as needed
}

module.exports = Service;
