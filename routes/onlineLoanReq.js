var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    res.render('onlineLoanReq');

});
 router.post('/', function (req, res) {
    let account_num = req.body.account_num;
    let repayment = req.body.repayment;
    let amount = req.body.amount;
    //let fd_id = req.body.fd_id;
    

conn.connect(function(err) {
    if (err) throw err;
    console.log("Database connected successfully!");
    console.log(fd_id);
    var fd_id = "SELECT fd_id from fixed_deposit where account_num = '"+account_num+"'";
    console.log(fd_id);
    var sqlquery = "INSERT INTO loan (loan_id,loan_amount,repayment_period,start_date,state,fd_id,account_num) VALUES ('1','"+amount+"','"+repayment+"','45','1','"+fd_id+"','"+account_num+"')";
  conn.query(sqlquery, function (err, result) {
    if (err) throw err;
        console.log(result.affectedRows + " record inserted");
  });
});
 })
//});

module.exports = router;