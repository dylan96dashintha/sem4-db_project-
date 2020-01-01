var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    
    var transactionIdList = []  ;
    var dateList = [];
    var timeList = [];
    var accountNumList = [];
    var depositAmountList = [];

    var count_query=`SELECT COUNT(*) AS num FROM transaction right outer join deposit using(transaction_id)`;
    conn.query(count_query,function(err,result){
    
        if (err) throw error;
    
        const count1 = JSON.parse(JSON.stringify(result));
    

 var deposit_query = `SELECT transaction_id,date,time_transaction,account_num,deposit_amount FROM transaction right outer join deposit using(transaction_id) `;
 
 conn.query(deposit_query,function(err,result){
 if (err) throw error;

 const response = JSON.parse(JSON.stringify(result));  
 
    for(x=0 ; x<response.length ; x++){
        transactionIdList.push(response[x].transaction_id);
        dateList.push(response[x].date);
        timeList.push(response[x].time_transaction);
        accountNumList.push(response[x].account_num,);
        depositAmountList.push(response[x].deposit_amount);
     
     
     }

     res.render('Deposit',{count:count1[0].num,tranc_id : transactionIdList, date :dateList , time :timeList, acc_num:accountNumList ,  depo_amm :depositAmountList });

 }); 
});   
});    
module.exports = router