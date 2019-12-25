var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    res.render('Deposit');
});

console.log("Database connected successfully!");
 var deposit_query = `SELECT transaction_id,deposit_amount,account_num,date,time_transaction FROM transaction right outer join deposit using(transaction_id) `;
 
 conn.query(deposit_query,function(err,result){
 if (err) throw error;
     
     const response = JSON.parse(JSON.stringify(result));
     for(x=0;x<response.length;x++){
     var transaction_id= response[x].transaction_id;
     var deposit_amount=response[x].deposit_amount;
     var account_num=response[x].account_num;
     var date=response[x].date;
     var time_transaction=response[x].time_transaction;
     console.log(transaction_id,deposit_amount,account_num,date,time_transaction);
     
     }

 });    
    
module.exports = router