var express = require('express');
var router = express.Router();
var fdId = require('./generateFdId');
var conn = require('./connection');

router.get('/',function(req,res,next){
    
    res.render('onlineFD');

});

router.post('/',function(req,res){
    let amount = req.body.amount;
    let plan = req.body.plan;
    let accountNum = req.session.accNo;
//    let username = req.session.username;
    let uname = req.session.username;
    let fd; 
    console.log(plan);
    console.log(accountNum);    
    checkValidity();

    function checkValidity(){
        conn.query(`SELECT username FROM  customer_login WHERE customer_id in (SELECT customer_id FROM account WHERE account_num = '${accountNum}') `,function(err,result){
            if(err){
                res.redirect('/onlineFD');
            }else{
                if (result.length != 0){
                    console.log("success");
                    conn.query(`SELECT balance FROM saving_account WHERE account_num = '${accountNum}' `,function(err,result){
                        if (err) {
                            res.send(err);
                        }else{
                            console.log(result);
                            let balance = parseFloat(result[0].balance);
                            if(balance >= amount){
                                    checkFdId();
                                //res.send("you can have a fd");
                            }else{
                                res.redirect('/onlineFD');
                            }
                        }
                    });
                }
            }
            
            
            
        });
    }



    function checkFdId() {
        fd = fdId();
        console.log(fd);
        conn.query(`SELECT fd_id FROM fixed_deposit WHERE fd_id = '${fd}'`, (err, result) => {
            if (result.length != 0) {
                console.log(result.length);
                checkFdId();
            } else {
                updateDb();
            }
        });

    }

    function updateDb(){
        conn.beginTransaction(function(err){
            if(err){throw err;}
                conn.query(`INSERT INTO fixed_deposit(fd_id,num_months,start_date,amount,net_interest,account_num) VALUES ('${fd}',${plan},curdate(),'${amount}',0,'${accountNum}')`,function(err,result){
                    if(err){
                        conn.rollback(function(err){
                            res.send(err);

                        });
                    }else{
                        conn.query(`UPDATE account SET balance =  balance - ${amount} WHERE account_num = '${accountNum}'`,function(err,result){
                            if(err){
                                conn.rollback(function(err){
                                    res.send(err);
                                });
                            }
                            conn.commit(function(err) {
                                if (err) { 
                                  conn.rollback(function() {
                                    throw err;
                                  });
                                }
                                res.send("successfully updated");
                                console.log('Transaction Complete.');
                                // conn.end();
                              });
                        });
                    }
                });
        });
                
        
        
    }


});


module.exports = router;