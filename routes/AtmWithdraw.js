var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    
    var transactionIdList = []  ;
    var dateList = [];
    var timeList = [];
    var atmIdList=[];
    var accountNumList = [];
    var amountList = [];


 //console.log("Database connected successfully!");
 var atmwithdraw_query = `SELECT transaction_id,date,time_transaction,atm_id,account_num,amount FROM transaction right outer join atm_withdraw using(transaction_id) `;

 conn.query(atmwithdraw_query,function(err,result){
 if (err) throw error;

 const response = JSON.parse(JSON.stringify(result));  
 
    for(x=0 ; x<response.length ; x++){
        transactionIdList.push(response[x].transaction_id);
        dateList.push(response[x].date);
        timeList.push(response[x].time_transaction);
        atmIdList.push(response[x].atm_id,);
        accountNumList.push(response[x].account_num,);
        amountList.push(response[x].amount);


     }

     res.render('AtmWithdraw',{tranc_id : transactionIdList,date :dateList , time :timeList,atm:atmIdList, acc_num:accountNumList ,  amm :amountList });

 });

});

    
   

    module.exports=router
     