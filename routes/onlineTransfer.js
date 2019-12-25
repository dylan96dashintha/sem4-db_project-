var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    res.render('onlineTransfer');
});

router.post('/',function(req,res){
    console.log("hi");
   let account_num=req.body.account_num;
   console.log(account_num);

});
   
    console.log("Database connected successfully!");
    var transaction_query = `SELECT transaction_id,amount,account,date,time_transaction FROM transaction right outer join online_transaction using(transaction_id) `;
    conn.query(transaction_query,function(err,result){
    if (err) throw error;
        
        const response = JSON.parse(JSON.stringify(result));
        for(x=0;x<response.length;x++){
        var transaction_id= response[x].transaction_id;
        var amount=response[x].amount;
        var account=response[x].account;
        var date=response[x].date;
        var time_transaction=response[x].time_transaction;
        console.log(transaction_id,amount,account,date,time_transaction);
        }
  
    });




    module.exports=router
     