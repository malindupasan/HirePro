const Pool = require("pg").Pool;

const pool = new Pool({
  host: "localhost",
  user: "postgres",
  password: "Mal12345",
  port: 5432,
  database: "jwttut"
});

module.exports = pool;