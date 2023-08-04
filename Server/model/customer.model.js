const db = require('../config/db');
const bcrypt = require('bcrypt')

class Customer {
  constructor({ id, contact, name, email, loyalty_points, password_hash }) {
    this.id = id;
    this.contact = contact;
    this.name = name;
    this.email = email;
    this.loyalty_points = loyalty_points;
    this.password_hash = password_hash;
  }

  static async create(customerData) {
    const { contact, name, email, password_hash } = customerData;
    console.log(password_hash);
    const salt = await bcrypt.genSalt(10);
    const hased_pw = await bcrypt.hash(password_hash, salt);

    const query = 'INSERT INTO customer (contact, name, email, password_hash) VALUES ($1, $2, $3, $4) RETURNING *';
    const values = [contact, name, email, hased_pw];

    try {
      const result = await db.query(query, values);
      return new Customer(result.rows[0]);
    } catch (error) {
      throw error;
    }
  }

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

  static async checkPassword(hased_password, password) {
    try {
      const isMatch = await bcrypt.compare(hased_password, password);
      return isMatch;
    } catch (error) {
      console.log(error);
    }
  }

  // Add other static methods for CRUD operations as needed
}

module.exports = Customer;
