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

static async acceptTask(taskid){

  const query = 'update "Service" set status=\'accepted\' where id=$1';
  const values = [taskid];
  try {
    const result = await db.query(query, values);

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

static async getOngoingAndAcceptedTasks(){

  // const query = 'select * from "Service" where status=\'ongoing\' or status=\'accepted\'';
  // const values = [taskid];
  const query = `
  SELECT "Service".*, bid.amount, sp.name AS "providerName"
  FROM "Service"
  LEFT JOIN "Bid" AS bid ON "Service"."id" = bid."serviceId"
  LEFT JOIN "ServiceProvider" AS sp ON bid."serviceProviderId" = sp."id"
  WHERE ("Service".status='ongoing' OR "Service".status='accepted') AND "Service"."customerid"=$1;
`;
  try {
    const result = await db.query(query);
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










  // Add other static methods for CRUD operations as needed
}

module.exports = Service;
