var express = require('express');
var router = express.Router();
const app = express();
var conn = require('./connection');

router.get('/',function(req,res,next){

    var sessionCheck = false;
    
    if((req.session.logtype == "manager")){ // check session.Is logged in...
        if(req.session.username){
            sessionCheck = true;
        }
    }

    if(sessionCheck){
        let emp_id = req.session.emp_id;
    conn.query(`SELECT branch_id FROM employee where emp_id = '${emp_id}'` , function(err,result){
        if(err){
            console.log(err);
        }else{
            req.session.branchId = result[0].branch_id;
            
            
        }
    });
    res.render('branchManagerProfile',{msg:null,branch:req.session.branch,emp:req.session.username});

    }
    else{
        res.render('login');
    }
});




module.exports = router;