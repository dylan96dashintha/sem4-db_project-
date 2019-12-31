var express = require('express');
var router = express.Router();
var conn = require('./connection');

router.get('/', function(req,res,next){
    var sessionCheck = false;
    
    if((req.session.logtype == "emp" || req.session.logtype == "manager")){ // check session.Is logged in...
        if(req.session.username){
            sessionCheck = true;
        }
    }
    if(sessionCheck){
        res.render('closeAccount');
    }else{
        res.render('login')
    }
});


router.post('/', function (req, res) {
    let account_num = req.body.account_num;
    
    

//delete entity from database

function UpdateDB(){
 conn.beginTransaction(function(err){
     if (err)throw err;
     
  conn.query(`UPDATE account SET state=0 WHERE account_num=${account_num}`,function(err,result){
        if (err) throw err;
            
      });
      conn.commit(function(err) {
        if (err) { 
          conn.rollback(function() {
            throw err;
          });
        }
    //    console.log('Update');
    //     conn.end();
    res.render('employee',{msg:null,branch:req.session.branch,emp:req.session.username});
      });


 })   
}





//check account
function checkaccount(){
    conn.query(`SELECT account_num FROM account WHERE account_num=${account_num} AND state !=0`,function(err,result){
        if (result.length !=0){
            checkLoan();
        }
        else{
            res.render('employee',{msg:"No account exsists or account is allready closed",branch:req.session.branch,emp:req.session.username});
        }
    })
}


// check loans
function checkLoan(){
    conn.query(`SELECT loan_id FROM loan WHERE account_num = '${account_num}'`, function (err,result) {
        if (result.length != 0) {
           
            res.render('employee',{msg:"Cannot close account",branch:req.session.branch,emp:req.session.username});
        } else {
            
            UpdateDB();
        }
    });
}

checkaccount();
});

module.exports = router;