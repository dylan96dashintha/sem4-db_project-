var express = require('express');
var router = express.Router();
var conn = require('./connection');

router.get('/', function(req,res,next){
    res.render('closeAccount');
});

var account_num=6081;






//check account
function checkaccount(){
    conn.query(`SELECT account_num FROM account WHERE account_num=${account_num}`,function(err,result){
        if (result.length !=0){
            checkLoan();
        }
        else{
            console.log("Account number is incorrect")
        }
    })
}
// check loans
function checkLoan(){
    conn.query(`SELECT loan_id FROM loan WHERE account_num = '${account_num}'`, function (err,result) {
        if (result.length != 0) {
           
            console.log("cannot close account");
        } else {
            console.log("Dulaj");
           // DeleteDB();
        }
    });
}
checkaccount();


module.exports = router;