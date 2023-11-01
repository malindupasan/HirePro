const db = require('../config/db');
const bcrypt = require('bcrypt')

class ServiceProvider {
  constructor({ id, contact, name, email, nic,points, password_hash,bank_details,category }) {
    this.id = id;
    this.contact = contact;
    this.name = name;
    this.email = email;
    this.loyalty_points = loyalty_points;
    this.password_hash = password_hash;
    this.category=category;
    this.bank_details = bank_details;
    this.nic = nic;
    this.points = points;
  }

 
  static async findById(id) {
    const query = 'SELECT id,intro,contact,name,email,points,bank_details,category FROM "ServiceProvider" WHERE id = $1';
    const values = [id];

   

    try {
      const result = await db.query(query, values);
      //   console.log(result.rows[0]);
      return result.rows[0];

    } catch (error) {
      throw error;
    }
  }
 
  static async findAvgRaings(id) {

    const query = 'select SUM(starRate) as sumrate ,count(customerid) as custno  from "Rating" where serviceproviderid = $1';
    const values = [id];

    try {
      const result = await db.query(query, values);
      //   console.log(result.rows[0]);
      return result.rows[0];
    } catch (error) {
      console.log(error);
      
    }

  }
  static async getSpLocation(id) {

    const query = 'select * from "providerCurrentLocation" where serviceid=$1 ';
    const values = [id];

    try {
      const result = await db.query(query, values);
      //   console.log(result.rows[0]);
      return result.rows[0];
    } catch (error) {
      console.log(error);
      
    }

  }



 
  // Add other static methods for CRUD operations as needed
}

module.exports = ServiceProvider;
