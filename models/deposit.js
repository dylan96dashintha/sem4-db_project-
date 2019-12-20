var conn = require('../routes/connection');
var mysql = require('mysql');
// var transId;

function genarateTransactionId(){
    return Math.floor(Math.random() * (999999-100000) + 100000 );
}

function check(){
     var transID = genarateTransactionId();
    console.log(transID);
    conn.query('SELECT COUNT(transaction_id) AS count FROM transaction WHERE transaction_id = '+ transID,function(err,result){
        console.log(result);
        if(result[0].count > 0){
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

//Change the balanvce of account...Shoult input the account type
function changeBalance(accNo,amount,type,callback){
    // var currentBalance ;
    conn.query(`SELECT balance FROM ${type} WHERE account_num =` + accNo,function(err,result){
        if(err){console.log("err in find balance");}
        var currentBalance = result[0].balance;
        var newBalance = parseFloat(currentBalance) + parseFloat(amount);     
        
        conn.query(`UPDATE ${type} SET balance = ${newBalance} WHERE account_num = ${accNo}` , function(err,result){
            if(err){
                callback(err,"err in upadate vale");
            }else{
                callback(null,"success");
            }
        });
        
    });
}

function deposit(accNo, amount, callback){
    // check();
    var d = new Date();
    var date = d.getFullYear()+"-"+d.getMonth()+"-"+d.getDate();
    var time = d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
    var transID = d.getFullYear().toString()
            +(d.getMonth()+1).toString()
            +d.getDate().toString()
            +d.getHours().toString()
            +d.getMinutes().toString()
            +d.getSeconds().toString()
            +d.getMilliseconds().toString();

    // console.log(transID);
    // console.log(date);
    // console.log(time);
    // console.log(d.getFullYear());
    // console.log(d.getMonth());
    // console.log(d.getDate());
    // console.log(d.getHours());
    // console.log(d.getMinutes());
    // console.log(d.getSeconds());
    // console.log(d.getMilliseconds());

    conn.beginTransaction(function(err){
        if(err) console.error(err);
        conn.query(`INSERT INTO transaction (transaction_id,date,time_transaction,account_num) VALUES ('${transID}','${date}','${time}','${accNo}')`,function(err,result) {
            if(err){
                conn.rollback(function(err){
                    callback(err,"Error in update DB");
                });
                console.log("err");
            }
            conn.query(`INSERT INTO deposit (deposit_amount,transaction_id) VALUES ('${amount}','${transID}')`,function(err,result){
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
                        console.log("saving");
                        changeBalance(accNo,amount,"saving_account",function(err,result){

                            if(result == "success"){
                                callback(null,"savingSuccess");
                                conn.commit(function(err) {
                                    if(err){
                                        conn.rollback(function() {
                                            console.error(err);
                                        });
                                    }
                                    // conn.end();
                                    // callback(null,"success"); 
                                });
                            }

                        });
                       
                        
                    }else if(result == "current"){
                        console.log("current");
                        changeBalance(accNo,amount,"current_account",function(err,result){

                            if(result == "success"){
                                callback(null,"currentSuccess");
                                conn.commit(function(err) {
                                    if(err){
                                        conn.rollback(function() {
                                            console.error(err);
                                        });
                                    }
                                    // conn.end();
                                    // callback(null,"success"); 
                                });
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

module.exports = deposit;
