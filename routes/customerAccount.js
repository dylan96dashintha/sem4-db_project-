var express = require('express');
var router = express.Router();
var accDetails = require('../models/accountDetails').getAccDetails;


router.get('/',function(req,res,next){

    res.render('employee',{msg:null,branch:req.session.branch});

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
                res.render('employee');
            }else{
                console.log(result);
                res.render('customerServices',result);
            }
        });
    }else{
        res.render('login');
    }
});

module.exports = router;