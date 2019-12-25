var express = require('express');
var router = express.Router();
var conn = require('./connection');
var depositMoney = require('../models/deposit');
var withdrawtMoney = require('../models/withdraw');
var moneyTransfer = require('../models/moneyTransfer');
var checkAccDetail = require('../models/accountDetails').checkAccDetails;

router.get('/',function(req,res,next){
    res.render('addAccountDetails');
    
});

router.post('/',function(req,res){
    
    var sendToAccNo = req.body.sendToAccNo;
    var accHolderName = req.body.accHolderName;
    var branch = req.body.branch;
    var fromAccNo = req.body.fromAccNo; //meka thawa hadanna tyeno
    var amount = req.body.amount;

    checkAccDetail(sendToAccNo,accHolderName,branch,(err,result)=>{
        if(result){
            moneyTransfer(fromAccNo,sendToAccNo,amount,(err,result)=>{
                if(err){
                    res.render('addAccountDetails',{err:result});
                }else{
                    res.send("money transfertd successfully");
                }
            });
        }else{
            res.render('addAccountDetails',{err:"You Enterd Details Are Not Correct"})
        }
    });

});

module.exports = router;