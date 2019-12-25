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
    


 var withdraw_query = `SELECT transaction_id,date,time_transaction,account_num,withdraw_amount FROM transaction right outer join withdraw using(transaction_id) `;
 
 conn.query(withdraw_query,function(err,result){
 if (err) throw error;
     
    const response = JSON.parse(JSON.stringify(result));
     for(x=0 ; x<response.length ; x++){
        transactionIdList.push(response[x].transaction_id);
        dateList.push(response[x].date);
        timeList.push(response[x].time_transaction);
        accountNumList.push(response[x].account_num,);
        withdrawAmountList.push(response[x].withdraw_amount);

     }
    res.render('Withdraw' , {tranc_id : transactionIdList, date :dateList , time :timeList, acc_num : accountNumList ,  with_amm :withdrawAmountList } );
    
     
    
     

 });
});

module.exports=router
