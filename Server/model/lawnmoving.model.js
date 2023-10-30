const db = require('../config/db');
const Service = require('../model/service.model')



class Lawnmoving extends Service {
  constructor({ id, area ,description,postedtime,estmin,estmax, location,latitude,longitude,date, customer}) {
    super({ id ,description,postedtime,estmin,estmax, location,latitude,longitude,date, customer});
  this.area = area;

  }

  static async addtask(taskData) {
   try { 
    const { area ,description,postedtime,estmin,estmax,location,latitude,longitude,date, customerid} = taskData;

    // console.log("des"+description);
    const status="pending";
    const query0='INSERT INTO "Service" ( description,location,estmin,estmax,date,status,customerid,posted_timestamp,latitude,longitude) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING *';
    const values0=[description,location,estmin,estmax,date,status,customerid,postedtime,latitude,longitude]

    const query1 = 'INSERT INTO "LawnMoving" (id, "areaInSquareMeter") VALUES ($1, $2) RETURNING *';
    // const values1 = [id,area];

    
      const result1 = await db.query(query0, values0);
      // console.log(result1.rows[0].id)
      const id=result1.rows[0].id;
       const values1 = [id,area];
       const result2=await db.query(query1, values1);
       const tmp={

        ...result1.rows[0],
        ...result2.rows[0], 
       }
       console.log(tmp);
      return tmp;
    } catch (error) {
      throw error;
    }
  }


  static async addSheduleTask(taskData) {
    try { 
     const { area ,description,postedtime,estmin,estmax,location,latitude,longitude,date, customer} = taskData;
 
     // console.log("des"+description);
     const status="accepted";
     const query0='INSERT INTO "Service" ( description,location,estmin,estmax,date,status,customerid,posted_timestamp,latitude,longitude) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING *';
     const values0=[description,location,estmin,estmax,date,status,customer,postedtime,latitude,longitude]
 
     const query1 = 'INSERT INTO "LawnMoving" (id, "areaInSquareMeter") VALUES ($1, $2) RETURNING *';
     // const values1 = [id,area];
 
     
       const result1 = await db.query(query0, values0);
       // console.log(result1.rows[0].id)
       const id=result1.rows[0].id;
        const values1 = [id,area];
        const result2=await db.query(query1, values1);
        const tmp={
 
         ...result1.rows[0],
         ...result2.rows[0], 
        }
        console.log(tmp);
       return tmp;
     } catch (error) {
       throw error;
     }
   }



  

  


  // Add other static methods for CRUD operations as needed
}

module.exports = Lawnmoving;
