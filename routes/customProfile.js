var express = require('express');
var router = express.Router();
const app = express();
var getAccounts = require('../models/accountDetails').getAccounts;
var getMultipleAccDetails = require('../models/accountDetails').getMultipleAccDetails;;

router.get('/',function(req,res,next){
    let username = req.session.username;
    if(req.session.username && req.session.logtype){
        // res.render('customProfile',{msg:null});
        getAccounts(username,function(err,result){
            if(result){
                res.render('customProfile',{details:result,count:result.length,msg:null})
                // console.log(getMultipleAccDetails(result));
                    // console.log(result);
                    // res.send("dff");
                
                // getMultipleAccDetails(result,function(err,result){
                //     // console.log(result);
                //     // res.send("vndpvnfjvnjfnvjnfpjn");   
                // });
            }
        });
    }else{
        res.render('login');
    }
    

});




module.exports = router;