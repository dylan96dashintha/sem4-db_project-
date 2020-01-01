var express = require('express');
var router = express.Router();
var accDetails = require('../models/accountDetails').getAccDetails;

router.get('/',function(req,res,next){
    var sessionCheck = false;
    
    if((req.session.logtype == "emp" || req.session.logtype == "manager")){ // check session.Is logged in...
        if(req.session.username){
            sessionCheck = true;
        }
    }

    if(sessionCheck){
        res.render('employee',{msg:null,branch:req.session.branch,emp:req.session.username});
    }else{
        res.render('login');
    }
    
    
});

router.post('/',function(req,res,next){
    
    var sessionCheck = false;
    
    if((req.session.logtype == "emp" || req.session.logtype == "manager")){ // check session.Is logged in...
        if(req.session.username){
            sessionCheck = true;
        }
    }
    if(sessionCheck){
        var accNo = req.body.accNo;
        accDetails(accNo,(err,result)=>{
            if(result.accOwnerType == null || result.accType == null){
                res.render('employee',{msg:"Wrong Account Number",branch:req.session.branch,emp:req.session.username});
            }else{
                req.session.accountNumber = accNo;
                res.render('customerServices',result);
            }
        });
    }else{
        res.render('login');
    }
});

module.exports = router;