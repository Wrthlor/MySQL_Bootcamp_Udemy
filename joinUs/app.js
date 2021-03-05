require("dotenv").config();     // Retrieving data (password) from .env file
const mysql = require('mysql');   // Node.js driver for MySQL
const express = require('express');
const bodyParser = require('body-parser');
const app = express();

// Set the view engine to ejs
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended : true }));

// Connect to "join_us" database 
let connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: process.env.mySQL_Password,
    database: 'join_us'
})

// HTTP GET request to find count of users in DB and respond with that count
app.get('/', (req, res) => {
    let q = 'SELECT COUNT(*) AS userCount FROM users';
    connection.query(q, (error, results) => {
        if (error) throw error;
        let count = results[0].userCount;
        res.render('home', { count: count });
    });
})

// HTTP POST request to send email to DB
app.post('/register', (req, res) => {
    let email = { email : req.body.email };
    let q = 'INSERT INTO users SET ?';
    connection.query(q, email, (error, results) => {
        if (error) throw error;

        // Redirects to root page after successfully adding to DB
        res.redirect('/');
    })    
})

// "Joke page" with poor HTML usage
app.get('/joke', (req, res) => {
    const joke = '<strong>What do you call a dog that does magic tricks?</strong> <br/> <em>A labracadabrador.</em>';
    res.send(joke);
})

app.get('/randomNumber', (req, res) => {
    let rng = Math.random() * 100;
    res.send(rng.toString());
})

const port = 8080;
app.listen(8080, () => {
    console.log(`Server running on ${port}`);
})