var express = require('express');
var router = express.Router();
var conn = require('./connection');
var depositMoney = require('../models/deposit');
var accDetails = require('../models/accountDetails').getAccDetails;


var accountNumber ;

router.get('/',function(req,res,next){
    
});

router.post('/',function(req,res){
    var accNo = req.body.accNo;   
    var amount = req.body.amount; 

    depositMoney(accNo,amount,"MONEY-DEPOSIT",function(err,result){
        if(err){
            res.send("dd");
        }else if(result == "savingSuccess" || result == "currentSuccess"){ //if success return to the custrmer servise page
            accDetails(accNo,(err,result)=>{
                if(result.accOwnerType == null || result.accType == null){
                    res.render('employee');
                }else{
                    result.msg = "Deposit Rs."+amount+" successfully into "+accNo;    
                    res.render('customerServices',result);
                }
            });   
        }
    });
    

});








module.exports = router;