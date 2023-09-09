const app = require("./app");

const port = 3000;



app.get('/', (req, res) => {



  try {
    // createCustomer();
    res.send("hello");

  } catch (error) {
    console.log(error);
    res.send("error");
    console.log("fail");


  }

  
})

app.listen(port, () => {
  console.log(`Server Listening on Port http://localhost:${port}`);
})