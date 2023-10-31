const db = require('../config/db');
const moment = require('moment-timezone');


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
    const query1 = `
    SELECT b.*, s.contact, s.intro, s.name, s.id as spid, serv.category
    FROM "Bid" AS b
    INNER JOIN "ServiceProvider" AS s ON s.id = b."serviceProviderId"
    INNER JOIN "Service" AS serv ON serv.id = b."serviceId"
    WHERE serv.id = $1;
`;


    const values = [serviceid];

    try {
      const result = await db.query(query1, values);
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

        const adjustedServices = result.rows.map(service => {
          if (service.date) { // assuming 'date' is the column name in your table
              service.date = moment.tz(service.date, "Asia/Colombo").tz(moment.tz.guess()).format();
          }
          return service;
      });


      const finaldata = adjustedServices.map(service => {
        if (service.posted_timestamp) { // assuming 'date' is the column name in your table
            service.posted_timestamp = moment.tz(service.date, "Asia/Colombo").tz(moment.tz.guess()).format();
        }
        return service;
    });

        console.log("hey");
        return finaldata;
      }

    }
    catch (error) {
      throw error;
    }

  }


  static async alltasks(customerid) {
    const query = 'SELECT * FROM "Service" where "customerid" = $1 ';
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

  static async getSingleTaskDetails(customerid,taskid) {
    const query = 'SELECT s.* FROM "Service" s where "customerid" = $1 and id=$2  ';

    const qry='SELECT "ServiceProvider"."name" , "Service".*  FROM  "Service" INNER JOIN  "Bid" ON "Service"."id" = "Bid"."serviceId" INNER JOIN  "ServiceProvider" ON "Bid"."serviceProviderId" = "ServiceProvider"."id" WHERE "Service"."id" = $1 and "Service".customerid=$2';


    const values = [taskid,customerid];

    try {
      
      const result = await db.query(qry, values);
      // console.log(result)
      if (!result.rows) {
        return "No task found";

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




static async acceptTask(taskid,bidid,customerid) {

  const query = 'update "Service" set status=\'accepted\' where id=$1';
  const query2='update "Bid" set accept_customerid=s1,accept_timestamp=$2 where id=$3'
  const currentTimestamp = new Date().toISOString().slice(0, 19).replace('T', ' ');
  const values2=[customerid,currentTimestamp,bidid];
  const values = [taskid];
  try {
    const result = await db.query(query, values);
    const result2 = await db.query(query2, values2);
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

  // const query = 'select * from "Service" where status=\'ongoing\' or status=\'accepted\'';
  // const values = [taskid];
  const query = `
  SELECT "Service".*, bid.amount, sp.name AS "providerName" ,sp.id as "spid"
  FROM "Service"
  LEFT JOIN "Bid" AS bid ON "Service"."id" = bid."serviceId"
  LEFT JOIN "ServiceProvider" AS sp ON bid."serviceProviderId" = sp."id"
  WHERE ("Service".status='arrived' OR "Service".status='started' OR "Service".status='accepted') AND "Service"."customerid"=$1;
`;

const values=[customerid]
  try {
    const result = await db.query(query,values);
    if (result.rowCount === 0) {
      console.log("No rows were updated.");
      return false;  // No rows were updated
    } else {
      console.log("Update was successful.");
      return result.rows;   // Update was successful
    }

  } catch (error) {
    console.log(error)
  }//dd



}
static async getCompletedTasks(customerid){

  // const query = 'select * from "Service" where status=\'ongoing\' or status=\'accepted\'';
  // const values = [taskid];
  const query = `
  SELECT "Service".*, bid.amount, sp.name AS "providerName"
  FROM "Service"
  LEFT JOIN "Bid" AS bid ON "Service"."id" = bid."serviceId"
  LEFT JOIN "ServiceProvider" AS sp ON bid."serviceProviderId" = sp."id"
  WHERE ("Service".status='completed' ) AND "Service"."customerid"=$1;
`;
const values=[customerid]
  try {
    const result = await db.query(query,values);
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



static async getSheduledTasks(customerid){

  // const query = 'select * from "Service" where status=\'ongoing\' or status=\'accepted\'';
  // const values = [taskid];
  const query = `
  SELECT "Service".*,"Service".date + INTERVAL '5 hours 30 minutes' AS "date2",bid.amount, sp.name AS "providerName"
  FROM "Service"
  LEFT JOIN "Bid" AS bid ON "Service"."id" = bid."serviceId"
  LEFT JOIN "ServiceProvider" AS sp ON bid."serviceProviderId" = sp."id"
  WHERE  "Service"."customerid"=$1 AND posted_timestamp  > NOW() + INTERVAL '1 hour';
`;

const values=[customerid]
  try {
    const result = await db.query(query,values);
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








  // Add other static methods for CRUD operations as needed
}

module.exports = Service;
