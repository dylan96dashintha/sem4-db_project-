var conn = require('../routes/connection');
var mysql = require('mysql');
var transId;

//genarate transaction ID
function genarateTransactionId(){
    return Math.floor(Math.random() * (999999-100000) + 100000 );
}

//to genarate unique transaction ID
function check(){
    transID = genarateTransactionId();
    conn.query('SELECT transaction_id FROM transaction WHERE transaction_id = '+ transID,function(err,result){
        if(result.length != 0){
            check();
        }
    });
}

//check wether saving account or current account
function isSavingOrCurrentAcc(accNo,callback){
    conn.query(`SELECT COUNT(account_num) AS count FROM current_account WHERE account_num = `+ accNo, function(err,result){
        if(result[0].count == 1){
            callback(null,"current");
        }
        else{
            conn.query(`SELECT COUNT(account_num) AS count FROM saving_account WHERE account_num = `+ accNo, function(err,result){
                if(result[0].count == 1){ 
                    callback(null,"saving");
                }
                else{
                    callback(null,"notAcc");
                }
            });
        }
    });
}

//get the count of withdrawal of saving account
function getWithdrawCount(accNo,callback){
    conn.query(`SELECT transaction_count  FROM saving_account WHERE account_num = ` + accNo, function(err,result){
        if(err){
            callback(err,null);
        }else{
            callback(null, result[0].transaction_count);
        }
    });
}

//Change the balanvce of account...Shoult input the account type
function changeBalance(accNo,amount,type,count,callback){
    // var currentBalance ;
    conn.query(`SELECT balance FROM ${type} WHERE account_num =` + accNo,function(err,result){
        if(err){console.log("err in find balance");}
        var currentBalance = result[0].balance;
        var newBalance = parseFloat(currentBalance)-parseFloat(amount);     
        if(newBalance < 0){
            callback(null, "nobalance");
        }else if (type == "saving_account"){
            conn.query(`UPDATE ${type} SET balance = ${newBalance} , transaction_count = ${count} WHERE account_num = ${accNo}` , function(err,result){
                if(err){
                    callback(err,"err in upadate vale");
                }
                callback(null,"success");
            });
        }else if(type == "current_account"){
            conn.query(`UPDATE ${type} SET balance = ${newBalance} WHERE account_num = ${accNo}`, function(err,result){
                if(err){
                    callback(err,"err in upadate vale");
                }
                callback(null,"success");
            });
        }
    });
}

//withdraw money from any type of account
function withdraw(accNo, amount, callback){

    check();
    var d = new Date();
    var date = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
    var time = d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
    let accType ;
  
    conn.beginTransaction(function(err){
        if(err) throw err;
        conn.query(`INSERT INTO transaction (transaction_id,date,time_transaction,account_num) VALUES ('${transID}','${date}','${time}','${accNo}')`,function(err,result) {
            if(err){
                conn.rollback(function(err){
                    callback(err,"Error in update DB");
                });
            }
            conn.query(`INSERT INTO withdraw (withdraw_amount,transaction_id) VALUES ('${amount}','${transID}')`,function(err,result){
                if(err){
                    conn.rollback(function(err){
                        callback(err,"Error in update DB");
                    });
                }
                isSavingOrCurrentAcc(accNo,function(err,result){

                    if(err){

                        conn.rollback(function(err){
                            callback(err,"Error in select account type");
                        });

                    }else if(result == "saving"){

                        // console.log("saving");
                        getWithdrawCount(accNo,function(err, result){
                            // console.log(result);
                            if(parseInt(result) >= 5){
                                conn.rollback(function(err){
                                    callback(null,"limit");
                                });
                            }else{ 
                                changeBalance(accNo,amount,'saving_account',parseInt(result)+1,function(err,result){

                                    if(result == "success"){
                                        console.log("update saving acc successfully");
                                        conn.commit(function(err) {
                                            if(err){
                                                conn.rollback(function() {
                                                    console.error(err);
                                                });
                                            }
                                            conn.end();
                                            callback(null,"success"); 
                                        });

                                    }else if(result == "nobalance"){
                                        conn.rollback(function(err) {
                                            // console.error(err);
                                            callback(null,"NoBalance");
                                        });
                                        conn.commit(function(err) {
                                            if(err){
                                                conn.rollback(function() {
                                                    console.error(err);
                                                }); 
                                            }
                                            conn.end();
                                            // callback(null,"success"); 
                                        });

                                    }else{
                                        conn.commit(function(err) {
                                            if(err){
                                                conn.rollback(function() {
                                                    console.error(err);
                                                });
                                            }
                                            conn.end();
                                            // callback(null,"success"); 
                                        });
                                    }                                     
                                });
                            }
                        });
                        
                    }else if(result == "current"){
                        
                        console.log("current"); 
                        changeBalance(accNo,amount,'current_account',result,function(err,result){
                            if(result == "success"){
                                console.log("update current acc successfully");
                            }                            
                        });                       

                    }else if(result == "notAcc"){
                        console.log("Not account");
                    }
                });
            });
        });
    });         
}

module.exports = withdraw;
