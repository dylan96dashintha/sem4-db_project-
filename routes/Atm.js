var express = require('express');
var router = express.Router();
var conn = require('./connection');
var transaction_Id = require('./generateTransactionId');

router.get('/',function(req,res,next){
    res.render('Atm')
});

router.post('/', function (req, res) {
    let account_num = req.body.account_num;
    let amount=req.body.amount;
    console.log(account_num);
    console.log(amount);

function updateDB(){
    conn.beginTransaction(function(err){
        if (err) throw err;
      console.log("Database connected successfully!");
    
         
//update transaction table
transId=transaction_Id();
var transaction_query="INSERT INTO transaction(transaction_id,date,time_transaction,transaction_type,account_num)VALUES('"+transId+"',curdate(),curtime(),'atm withdraw','"+account_num+"')";
conn.query(transaction_query,function(err,result){
  if(err) throw err;
  console.log(result.affectedRows+"record inserted to transaction");
});

//update atm_withdraw table 
var atm_withdraw_query="INSERT INTO atm_withdraw(atm_id,amount,transaction_id) VALUES('25526','"+amount+"','"+transId+"')";
conn.query(atm_withdraw_query,function(err,result){
    if(err) throw err;
    console.log(result.affectedRows+"record inserted to atm_withdraw");
  });


   //update saving acount
   var saving_query="UPDATE saving_account SET balance =  balance - "+amount+" WHERE account_num = "+account_num+"";
   conn.query(saving_query,function(err,result){
     if(err) throw err;
     console.log(result.affectedRows+"record inserted to saving account");
   });
  var transaction_count_query="UPDATE saving_account SET transaction_count=transaction_count+1 WHERE account_num = "+account_num+"";
  conn.query(transaction_count_query,function(err,result){
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

    });


}
//check balance
function checkbalance(){
    conn.query( `SELECT balance FROM saving_account WHERE account_num = '${account_num}'`,function(err,result){
        if(result[0].balance>=amount){
            console.log("ok")
        }
        else{
            res.send("Can not withdraw money")
        }
    })
}
   //check transaction count
   function checkTransactionCount(){
       conn.query(`SELECT transaction_count FROM saving_account WHERE account_num = '${account_num}'`,function(err,result){
           if(result[0].transaction_count<=4){

               updateDB()
           }
           else{
               res.send("You already did five transactions withing month")
           }
       })
   } 
    //check account 
    function checkAccountNum() {

        conn.query(`SELECT account_num FROM account WHERE account_num = '${account_num}' AND state !=0`, function (err, result) {
            if (result.length != 0) {
                checkTransactionCount();
            } else {
                console.log("error");
                //res.send("Account not exsists");
            }
        });
    }
    checkAccountNum();
});


module.exports=router