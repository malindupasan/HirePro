const router = require("express").Router();
const pool = require("../db")
const validinfo=require("../middleware/validinfo")

const bcrypt = require("bcrypt");
const jwtGenarator = require("../utils/jwtGenarator")



router.post("/register", validinfo,async (req, res) => {
    try {
        //destructure(get email,pw,name)
        const { name, email, password } = req.body;

        //if user exist -> error
        const user = await pool.query("SELECT * FROM users where user_email=$1", [email])
        // res.json(user.rows)

        if (user.rows.length !== 0) {
            return res.status(401).send("user already exists")
        }
        //bcrypt users pw

        const saltRound = 10;
        const salt = await bcrypt.genSalt(saltRound);

        const bcryptPassword = await bcrypt.hash(password, salt);

        //enter the new user inside the db

        const newUser = await pool.query("INSERT INTO users (user_name, user_email, user_password) VALUES ($1,$2,$3) RETURNING *", [name, email, bcryptPassword])

        // res.json(newUser.rows[0]);

        //genarating jwt token
        const token = jwtGenarator(newUser.rows[0].user_id);
        res.send(token);

    } catch (err) {
        console.log(err);
        res.status(500).send("Server Error")
    }


})


//login

router.post('/login', validinfo,async (req, res) => {
    try {
        //destructure req body
        const { email, password } = req.body;

        //check if user exists and then throw an error if not exists
        const user = await pool.query("SELECT * FROM users WHERE user_email = $1", [
            email
        ]);

        if (user.rows.length === 0) {
            return res.status(401).json("Invalid Credential");
        }

        const validPassword= await bcrypt.compare(password,user.rows[0].user_password);
        console.log(validPassword);

        if(!validPassword) {
            return res.status(401).json("invalid credentials");
        }

        const token=jwtGenarator(user.rows[0].user_id);
        
        res.json({token})

    } catch (err) {
        console.log(err);
        res.status(500).send("Server Error")
    }
})


module.exports = router;