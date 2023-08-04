const express = require("express");
const bodyParser = require("body-parser")
const app=  express();
const CustomerRouter =require('./routes/customer.router')
// const UserRoute = require("./routes/user.routes");
// const ToDoRoute = require('./routes/todo.router');
// const app = express();
app.use(bodyParser.json())
app.use("/",CustomerRouter);
// app.use("/",ToDoRoute);
module.exports = app;