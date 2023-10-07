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

  static async alltasks(serviceid) {
    const query = 'SELECT * FROM "service" where "customerid" = $1 and';
    const values = [serviceid];

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


  static async alltasks(serviceid) {
    const query = 'SELECT * FROM "service" where "customerid" = $1 and';
    const values = [serviceid];

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







  // Add other static methods for CRUD operations as needed
}

module.exports = Service;
