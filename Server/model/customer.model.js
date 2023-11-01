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

    //check email exists

    const query1='select * from "Customer" where email=$1';
    const values1=[email];

    const query2='select * from "Customer" where contact=$1';
    const values2=[contact];


    try {
      const res1=await db.query(query1, values1);
      if(res1.rowCount>0){
        console.log(res1.rows[0])
        return "EMAILEXISTS!";
      }

      const res2=await db.query(query2,values2);
      if(res2.rowCount>0){
        return "PHONEEXISTS";
      }

    } catch (error) {
      console.log(error);
    }


    const salt = await bcrypt.genSalt(10);
    const hashed_pw = await bcrypt.hash(password_hash, salt);

    const query = 'INSERT INTO "Customer" (contact, name, email, password_hash) VALUES ($1, $2, $3, $4) RETURNING *';
    const values = [contact, name, email, hashed_pw];

    try {
      const result = await db.query(query, values);
      return new Customer(result.rows[0]);
    } catch (error) {
      throw error;
    }
  }

  static async updateName(customerData) {
    const { id, name } = customerData;



    const query = 'UPDATE "Customer" set name=$1 where id=$2 RETURNING  *';
    const values = [name, id];

    try {
      const result = await db.query(query, values);
      return new Customer(result.rows[0]);
    } catch (error) {
      throw error;
    }
  }


  static async updatePassword(customerData) {
    const { id, password } = customerData;

    const salt = await bcrypt.genSalt(10);
    const hashed_pw = await bcrypt.hash(password, salt);

    const query = 'UPDATE "Customer" set password_hash=$1 where id=$2 RETURNING  *';
    const values = [hashed_pw, id];

    try {
      const result = await db.query(query, values);
      return new Customer(result.rows[0]);
    } catch (error) {
      throw error;
    }
  }

  static async getAddress(id) {
    try {
      const query = 'select * from "CustomerAddress" where id=$1';
      const values = [id];

      const result = await db.query(query, values);
      // console.log(result.rows[0]);
      return result.rows
    } catch (error) {

    }
  }

  static async findByEmail(email) {
    const query = 'SELECT * FROM "Customer" WHERE email = $1';
    const values = [email];

    try {
      const result = await db.query(query, values);
      //   console.log(result.rows[0]);
      return result.rows[0];

    } catch (error) {
      throw error;
    }
  }
  static async findById(id) {
    const query = 'SELECT id,contact,name,email,loyalty_points,password_hash FROM "Customer" WHERE id = $1';
    const values = [id];

    try {
      const result = await db.query(query, values);
      //   console.log(result.rows[0]);
      return result.rows[0];

    } catch (error) {
      throw error;
    }
  }

  static async addAddress(id, address, title ,latitude,longitude){
    try {

        const query = 'SELECT * FROM "CustomerAddress" WHERE id = $1 and address =$2';
        const values = [id,address];
        const result = await db.query(query, values);
        if(result.rows.length>0){
          console.log(result.rows);
          return false;
        }
        const query1 = 'insert into "CustomerAddress" values($1, $2, $3, $4, $5) RETURNING *';
        const values1 = [id, address, title ,latitude,longitude];
        const result1 = await db.query(query1, values1);
        
        if(result1.rows.length>0){
        return true;}


        

        
    } catch (error) {
      console.log(error);
    }
  }


  static async checkPassword(hashed_password, password) {
    try {
      const isMatch = await bcrypt.compare(password, hashed_password);
      return isMatch;
    } catch (error) {
      console.log(error);
    }
  }

  // Add other static methods for CRUD operations as needed
}

module.exports = Customer;
