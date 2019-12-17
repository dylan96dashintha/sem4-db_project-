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
  
  console.log(account_num);

  conn.connect(function(err) {
      if (err) throw err;
      console.log("Database connected successfully!");
      // console.log(fd_id);
      var fd_id_query = `SELECT fd_id from fixed_deposit where account_num = ${account_num}`;
      conn.query(fd_id_query,function(err,result){
        if (err) throw error;

        const response = JSON.parse(JSON.stringify(result));
        const fd_id = response[0].fd_id;
  
        var sqlquery = "INSERT INTO loan (loan_id,loan_amount,repayment_period,start_date,state,fd_id,account_num) VALUES ('5','"+amount+"','"+repayment+"',curdate(),'1','"+fd_id+"','"+account_num+"')";
        conn.query(sqlquery, function (err, result) {
          if (err) throw err;
              console.log(result.affectedRows + " record inserted to loan");
        });
        var online_query ="INSERT INTO online_loan_system(loan_id,fd_id,maximum_amount)VALUES ('5','"+fd_id+"','5')";
        conn.query(online_query, function (err, result) {
          if (err) throw err;
              console.log(result.affectedRows + " record inserted");
        });
      })

    
    
  });
})

module.exports = router