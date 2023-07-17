const express=require("express");
const app = express();
const cors=require("cors");

app.use(express.json()); //access req.body
app.use(cors());


//ROuUTES

//Register and Login routes
app.use("/auth",require("./routes/jwtAuth"))



app.listen(5002,()=>{
    console.log("server listening on port 5005");
})