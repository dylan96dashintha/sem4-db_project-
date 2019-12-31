var express = require('express');
var router = express.Router();
var conn = require('./connection');
var depositMoney = require('../models/deposit');
var withdrawtMoney = require('../models/withdraw');
var moneyTransfer = require('../models/moneyTransfer');
var checkAccDetail = require('../models/accountDetails').checkAccDetails;

router.get('/',function(req,res,next){
    if(req.session.username && req.session.logtype == "customer"){
        res.render('addAccountDetails',{msg:null});
    }else{
        res.render('login');
    }

    
});

router.post('/',function(req,res){
    
    var sendToAccNo = req.body.sendToAccNo;
    var accHolderName = req.body.accHolderName;
    var branch = req.body.branch;
    var fromAccNo = req.body.fromAccNo; //meka thawa hadanna tyeno
    var amount = req.body.amount;
    var accNo = req.session.accNo;

    if(req.session.username && req.session.logtype == "customer"){
        if(fromAccNo == accNo){        
            checkAccDetail(sendToAccNo,accHolderName,branch,(err,result)=>{
                if(result){
                    moneyTransfer(fromAccNo,sendToAccNo,amount,(err,result)=>{
                        if(err){
                            res.render('addAccountDetails',{msg:result});
                        }else{
                            res.render('customerAccountOnline',{msg:"Successfully send Rs. "+amount+" from "+fromAccNo+" to "+sendToAccNo,accNo:fromAccNo,customer:req.session.username})
                        }
                    });
                }else{
                    res.render('addAccountDetails',{msg:"You Enterd Details Are Not Correct"})
                }
            });
        }else{
            res.render('addAccountDetails',{msg:"Your Acccount number is wrong"})
        }
    }else{
        res.render('login');
    }
});

module.exports = router;