var express = require('express');
var router = express.Router();
var conn = require('./connection');

router.get('/', function(req,res,next){
    res.render('closeAccount');
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
       console.log('Update');
        conn.end();
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
            console.log("Account number is incorrect or already closed account")
        }
    })
}


// check loans
function checkLoan(){
    conn.query(`SELECT loan_id FROM loan WHERE account_num = '${account_num}'`, function (err,result) {
        if (result.length != 0) {
           
            console.log("cannot close account");
        } else {
            
            UpdateDB();
        }
    });
}

checkaccount();
});

module.exports = router;