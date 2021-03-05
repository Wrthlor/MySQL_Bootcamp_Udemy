require("dotenv").config();     // Retrieving data (password) from .env file
let faker = require('faker');   // Generates fake data: emails, dates, locations
let mysql = require('mysql');   // Node.js driver for MySQL

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: process.env.mySQL_Password,
    database: 'join_us'
})

// Declare empty array
// Add 500 random emails/dates into data array
let data = [];
for (let i = 0; i < 500; i++) {
    data.push([
        faker.internet.email(), 
        faker.date.past()
    ]);
}

// Inserts data into MySQL database
q = 'INSERT INTO users (email, created_at) VALUES ?';
connection.query(q, [data], function(error, results) {
    if (error) throw error;
    //console.log(results);
});

connection.end();