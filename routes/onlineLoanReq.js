var express = require('express');
var router = express.Router();
var conn = require('./connection');
var loan_Id = require('./generateLoanId');
var transaction_Id = require('./generateTransactionId');

router.get('/', function (req, res, next) {
    res.render('onlineLoanReq');

});
router.post('/', function (req, res) {
  let account_num = req.body.account_num;
  let repayment = req.body.repayment;
  let amount = req.body.amount;
  //let fd_id = req.body.fd_id;
  console.log
  console.log(account_num);

  function updateDB(){
  conn.beginTransaction(function(err) {
    //checkconnection of db
       if (err) throw err;
      console.log("Database connected successfully!");


//get fd amount from db
      var fd_amount_query=`SELECT amount from fixed_deposit where account_num = ${account_num}`;
      conn.query(fd_amount_query,function(err,result){
     if (err) throw error;

     const response = JSON.parse(JSON.stringify(result));
     const fd_amount = response[0].amount;

  //check correct amount   
     var new_fd_amount=fd_amount*0.6;
     console.log(new_fd_amount);

     function getAmount(){
     if (amount<new_fd_amount){
       amount=amount;
     }
     else{
    
       if(new_fd_amount<500000){
        
         amount=new_fd_amount;
       }
       else{
         amount=500000;
       }
     }
    }
    
      
     getAmount();   //call the function
    console.log(amount)


    //get fd_id from db
      var fd_id_query = `SELECT fd_id from fixed_deposit where account_num = ${account_num}`;
      conn.query(fd_id_query,function(err,result){
        if (err) throw error;

        const response = JSON.parse(JSON.stringify(result));
        const fd_id = response[0].fd_id;


        // update loan table
        var sqlquery = "INSERT INTO loan (loan_id,loan_amount,repayment_period,start_date,state,fd_id,account_num) VALUES ('"+loanId+"','"+amount+"','"+repayment+"',curdate(),'1','"+fd_id+"','"+account_num+"')";
        conn.query(sqlquery, function (err, result) {
          if (err) throw err;
              console.log(result.affectedRows + " record inserted to loan");
        });


        //update online_loan_system table
        var online_query ="INSERT INTO online_loan_system(loan_id,fd_id,maximum_amount)VALUES ('"+loanId+"','"+fd_id+"','"+amount*0.6+"')";
        conn.query(online_query, function (err, result) {
          if (err) throw err;
              console.log(result.affectedRows + " record inserted");
        });


        //update fixed_deposit_has_loan table
        var fixed_deposit_has_loan_query="INSERT INTO fixed_deposit_has_loan(fd_id,maximum_amount,loan_id)VALUES('"+fd_id+"','"+amount*0.6+"','"+loanId+"')";
        conn.query(fixed_deposit_has_loan_query,function(err,result){
          if(err) throw err;
          console.log(result.affectedRows+"record inserted to fixed_deposit_has_loan");
        });
        
//update transaction table
        var transaction_query="INSERT INTO transaction(transaction_id,date,time_transaction,account_num)VALUES('"+transId+"',curdate(),curtime(),'"+account_num+"')";
        conn.query(transaction_query,function(err,result){
          if(err) throw err;
          console.log(result.affectedRows+"record inserted to transaction");
        });

        // update deposite table
        var deposit_query="INSERT INTO deposit(deposit_amount,transaction_id) VALUES ('"+amount+"','"+transId+"')";
        conn.query(deposit_query,function(err,result){
          if(err) throw err;
          console.log(result.affectedRows+"record inserted to deposit");
        });

        //update saving acount
        var saving_query="UPDATE saving_account SET balance =  balance + "+amount+" WHERE account_num = "+account_num+"";
        conn.query(saving_query,function(err,result){
          if(err) throw err;
          console.log(result.affectedRows+"record inserted to saving account");
        });



        conn.commit(function(err) {
          if (err) { 
            conn.rollback(function() {
              throw err;
            });
          }
          res.send("successfully updated");
          console.log('Transaction Complete.');
          conn.end();
        });
    })
  
    
  }); 
   });
  }

  //check account
  function checkAccountNum() {
    console.log("1");
    conn.query(`SELECT account_num FROM account WHERE account_num = '${account_num}'`, function (err, result) {
        if (result.length != 0) {
            checkFixedDeposit();
        } else {
            res.send("error");
        }
    });
}

//check fixed deposit
function checkFixedDeposit(){
    console.log("2");
    conn.query(`SELECT fd_id from fixed_deposit where account_num = ${account_num}`,function(err,result){
      if (result.length !=0){
        checkLoan();
      }
      else{
        res.send("error");
      }
    });
}

//check loan
function checkLoan(){
  
  conn.query(`SELECT loan_id FROM loan WHERE account_num=${account_num}`,function(err,result){
    console.log(result[0]);
    console.log(result.length);
    if (result.length ==0){
      
      updateDB();
    }
    else{
      console.log("3");
      res.send("error");
    }
  })
}

function checkTransactionId() {
    transId = transaction_Id();
    conn.query('SELECT transaction_id FROM transaction WHERE transaction_id = ' + transId, (err, result) => {
        if (result.length != 0) {
            console.log(result.length);
            checkTransactionId();
        } else {
            console.log("check transaction complete...")
            checkAccountNum();
        }

    });

}

function checkLoanId() {
    loanId = loan_Id();
    conn.query('SELECT loan_id FROM loan WHERE loan_id = ' + loanId, (err, result) => {
        console.log(err)
        if (result.length != 0) {
            console.log(result.length);
            checkLoanId();
        } else {
            console.log("check loAN complete...");
            checkTransactionId();
        }
    });

}



checkLoanId();


})

module.exports = router