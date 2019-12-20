var express = require('express');
var router = express.Router();
var conn = require('./connection');
var depositMoney = require('../models/deposit');
var depositMoney = require('../models/withdraw');
var accDetails = require('../models/accountDetails').getAccdetails;
var checkAccDetails = require('../models/accountDetails').checkAccdetails;

router.get('/',function(req,res,next){
    res.render('moneyTransfer');
    
});

router.post('/',function(req,res){
    // if(req.session.usename){
        
    // }else{
    //     redirect('/login');
    // }
    var accNo = req.body.accNo;
    accDetails(accNo,function(err,result){
        console.log(result);
        res.send(result);
        
    });



});

router.post('/selectAccount',function(req,res){
    var sendToAccNo = req.body.sendToAccNo;
    var accHolderName = req.body.accHolderName;
    var branch = req.body.brach;
    var fromAccNo = req.body.fromAccNo

    checkAccDetails(sendToAccNo,function(err,result){
        if(result){
            
        }
    });



});

module.exports = router;