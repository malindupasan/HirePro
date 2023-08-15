const db = require('../config/db');


class Service {
  constructor({  description,postedtime,estimation, acceptedtime, location,latitude,longitude,date, customer }) {
    // this.id = id;
    this.description = description;
    this.postedtime = postedtime;
    this.estimation = estimation;
    this.acceptedtime = acceptedtime;
    this.location = location;
    this.latitude=latitude;
    this.longitude=longitude;
    this.date=date;
    this.customer = customer;
  }

  // static async create(customerData) {
  //   const { contact, name, email, password_hash } = customerData;


  //   const salt = await bcrypt.genSalt(10);
  //   const hashed_pw = await bcrypt.hash(password_hash, salt);

  //   const query = 'INSERT INTO customer (contact, name, email, password_hash) VALUES ($1, $2, $3, $4) RETURNING *';
  //   const values = [contact, name, email, hashed_pw];

  //   try {
  //     const result = await db.query(query, values);
  //     return new Customer(result.rows[0]);
  //   } catch (error) {
  //     throw error;
  //   }
  // }






  

  static async findByEmail(email) {
    const query = 'SELECT * FROM customer WHERE email = $1';
    const values = [email];

    try {
      const result = await db.query(query, values);
      //   console.log(result.rows[0]);
      return result.rows[0];

    } catch (error) {
      throw error;
    }
  }


  // Add other static methods for CRUD operations as needed
}

module.exports = Service;
