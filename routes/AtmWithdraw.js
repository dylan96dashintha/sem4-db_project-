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

    var count_query=`SELECT COUNT(*) AS num FROM transaction right outer join atm_withdraw using(transaction_id)`;
    conn.query(count_query,function(err,result){
    
        if (err) throw error;
    
        const count1 = JSON.parse(JSON.stringify(result));
    
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

     res.render('AtmWithdraw',{count:count1[0].num,tranc_id : transactionIdList,date :dateList , time :timeList,atm:atmIdList, acc_num:accountNumList ,  amm :amountList });

 });

});
});
    
   

    module.exports=router
     