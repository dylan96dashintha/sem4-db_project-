var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    
    var transactionIdList = []  ;
    var accountNumList = [];
    var dateList = [];
    var timeList = [];
    var accountList = [];
    var amountList = [];

    var count_query=`SELECT COUNT(*) AS num FROM transaction right outer join online_transaction using(transaction_id)`;
    conn.query(count_query,function(err,result){
    
        if (err) throw error;
    
        const count1 = JSON.parse(JSON.stringify(result));
    
    
    
    var transaction_query = `SELECT transaction_id,account_num,date,time_transaction,account,amount FROM transaction right outer join online_transaction using(transaction_id) `;
    conn.query(transaction_query,function(err,result){
    
    if (err) throw error;

    const response = JSON.parse(JSON.stringify(result));  
 
    for(x=0 ; x<response.length ; x++){
        transactionIdList.push(response[x].transaction_id);
        accountNumList.push(response[x].account_num,);
        dateList.push(response[x].date);
        timeList.push(response[x].time_transaction);
        accountList.push(response[x].account,);
        amountList.push(response[x].amount);

        
    }
        res.render('onlineTransfer',{count:count1[0].num,tranc_id : transactionIdList,acc_num:accountNumList, date :dateList , time :timeList, acc : accountList ,  amm :amountList });
    
    });
});

});


    module.exports=router
     