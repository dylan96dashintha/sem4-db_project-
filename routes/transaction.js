var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    res.render('transaction');
});

    
    
    conn.connect(function(err){
    if (err) throw err;
    console.log("Database connected successfully!");
    var transaction_query = `SELECT date from transaction where account_num ="4789"`;
    conn.query(transaction_query,function(err,result){
    if (err) throw error;
        
        const response = JSON.parse(JSON.stringify(result));
        const date = response[0].date;
        console.log("df");
        console.log(date);

  
    });

    });
     


module.exports = router