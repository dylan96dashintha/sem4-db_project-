var express = require('express');
var router = express.Router();
var conn = require('./connection');
var withdrawMoney = require('../functions/withdraw');

var accountNumber ; 

router.get('/',function(req,res,next){
    res.render('withdrawMoney');
    
});

router.get('/withdraw',function(req,res,next){
    render('accdetails',{type:"withdraw"});

});

router.post('/',function(req,res){
    var accNo = req.body.accNo;    
    conn.query("SELECT nic,first_name,last_name FROM person NATURAL JOIN account WHERE account_num ="+accNo,function(err,result){
        if(err) {
            var error = "Incorrect Account Number";
            console.error(err);
            res.render('depositMoney',{error: error});
        }else{  
            req.session.accountNumber = accNo;
            res.render('accdetails',{acc:result[0],accNo:accNo,type:"withdrawMoney/withdraw"});
        }
    });

});

router.post('/withdraw',function(req,res){
    var amount = req.body.amount;
    var accNo = req.session.accountNumber;   

    function withdraw(err,result){
        if(err){
    
        }else if (result == "NoBalance"){
            console.log("No Balance in Account");
        }else if (result == "success"){
            console.log("Finally its ");
        }else if(result == "limit"){
            console.log("No money");
        }else{
            console.log(result);    
        }
    }

    withdrawMoney(accNo,amount,withdraw);  
   
    res.send("s");
    
    
});







module.exports = router;