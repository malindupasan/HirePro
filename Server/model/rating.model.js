const db = require('../config/db');


class Rating {
  constructor({  comment,starRate,customerid, serviceproviderid}) {
    // this.id = id;
    this.comment = comment;
    this.starRate = starRate;
    this.customerid = customerid;
    this.serviceproviderid = serviceproviderid;
   
  }


  static async addRating(comment, starRate, customerid, serviceproviderid) {


    
    const query = 'INSERT INTO "Rating" (comment, "starRate", customerid, serviceproviderid) VALUES ($1, $2, $3, $4) RETURNING *';
    const values = [comment, starRate, customerid, serviceproviderid];

    try {
      const result = await db.query(query, values);
      return new Rating(result.rows[0]);
    } catch (error) {
      throw error;
    }
   
  
  }

  static async getRating(serviceproviderid){ 
    const query = 'SELECT * FROM "Rating where serviceproviderid=$1';
    const values = [serviceproviderid];

    try {
        const result = await db.query(query, values);
        return result.rows[0];
    } catch (error) {
      throw error;
    }
  }





  

  static async getReviews(serviceProviderId) {
    const query = 'SELECT r.*, c.name FROM  "Rating" r inner join customer c on r.customerid =c.id where r.serviceproviderid=$1';
    const values = [serviceProviderId];

    try {
      const result = await db.query(query, values);
      //   console.log(result.rows[0]);
      // console.log(result.rows[0]);
      return result.rows;

    } catch (error) {
      throw error;
    }
  }


  // Add other static methods for CRUD operations as needed
}

module.exports = Rating;
