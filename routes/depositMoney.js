var express = require('express');
var router = express.Router();
var conn = require('./connection');
var depositMoney = require('../functions/deposit');

var accountNumber ;

router.get('/',function(req,res,next){
    res.render('depositMoney');
    
});

router.get('/deposit',function(req,res,next){
    render('accdetails',{type:"deposit"});

});

router.post('/',function(req,res){
    var accNo = req.body.accNo;    
    conn.query("SELECT nic,first_name,last_name FROM person NATURAL JOIN account WHERE account_num ="+accNo,function(err,result){
        if(err) {
            var error = "Incorrect Account Number";
            console.error(error);
            res.render('depositMoney',{error: error});
        }else{  
            req.session.accountNumber = accNo;
            res.render('accdetails',{acc:result[0],accNo:accNo,type:"depositMoney/deposit"});
        }
    });

});

router.post('/deposit',function(req,res){
    var amount = req.body.amount;
    var accNo = req.session.accountNumber;   

    function deposit(err,result){
        if(err){
    
        }
        else if(result == false){
    
        }else if(result){
            console.log(result);
        }
    }

    depositMoney(accNo,amount,deposit);  
    res.send("ok");
    
    
});







module.exports = router;