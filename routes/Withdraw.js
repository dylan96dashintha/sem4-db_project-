var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    
    //res.render('Withdraw');
    var transactionIdList = []  ;
    var dateList = [];
    var timeList = [];
    var accountNumList = [];
    var withdrawAmountList = [];
    

console.log("Database connected successfully!");
 var withdraw_query = `SELECT transaction_id,date,time_transaction,account_num,withdraw_amount FROM transaction right outer join withdraw using(transaction_id) `;
 
 conn.query(withdraw_query,function(err,result){
 if (err) throw error;
     
     
     for(x=0 ; x<result.length ; x++){
        transactionIdList.push(result[x].transaction_id);
        dateList.push(result[x].date);
        timeList.push(result[x].time_transaction);
        accountNumList.push(result[x].account_num,);
        withdrawAmountList.push(result[x].withdraw_amount);

    
    res.render('Withdraw' , {tranc_id : transactionIdList, date :dateList , time :timeList, acc_num : accountNumList ,  with_amm :withdrawAmountList } );
    
     }
    
     console.log(dateList);

 });
});

module.exports=router
