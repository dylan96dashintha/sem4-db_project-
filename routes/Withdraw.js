var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    res.render('Withdraw');
});

console.log("Database connected successfully!");
 var withdraw_query = `SELECT transaction_id,withdraw_amount,account_num,date,time_transaction FROM transaction right outer join withdraw using(transaction_id) `;
 
 conn.query(withdraw_query,function(err,result){
 if (err) throw error;
     
     const response = JSON.parse(JSON.stringify(result));
     for(x=0;x<response.length;x++){
     var transaction_id= response[x].transaction_id;
     var withdraw_amount=response[x].withdraw_amount;
     var account_num=response[x].account_num;
     var date=response[x].date;
     var time_transaction=response[x].time_transaction;
     console.log(transaction_id,withdraw_amount,account_num,date,time_transaction);
     
     }

 });


module.exports=router
     