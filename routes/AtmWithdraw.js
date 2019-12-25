var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    res.render('AtmWithdraw');
});


 //console.log("Database connected successfully!");
 var atmwithdraw_query = `SELECT transaction_id,atm_id,account_num,date,time_transaction FROM transaction right outer join atm_withdraw using(transaction_id) `;

 conn.query(atmwithdraw_query,function(err,result){
 if (err) throw error;
     
     const response = JSON.parse(JSON.stringify(result));
     for(x=0;x<response.length;x++){
     var transaction_id= response[x].transaction_id;
     var atm_id=response[x].atm_id;
     var account_num=response[x].account_num;
     var date=response[x].date;
     var time_transaction=response[x].time_transaction;
     //console.log(transaction_id,atm_id,account_num,date,time_transaction);
     
     }

 });

 

    
   

    module.exports=router
     