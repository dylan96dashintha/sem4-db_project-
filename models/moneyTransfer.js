var conn = require('../routes/connection');
var mysql = require('mysql');
var depositMoney = require('./deposit');
var withdrawMoney = require('./withdraw');
var flakeIdGen = require('flake-idgen');
var intformat = require('biguint-format');

function genarateId(){
    var genarator = new flakeIdGen();
    var id = genarator.next();
    return intformat(id,'dec');
}


function moneyTransfer(transferingAcc,transferedAcc,amount,callback){
    //TRANSFERD SALLI LABUNU ACCOUNT EKA
    //TRABSFERING SALLI YAWAPU ACCOUNTT EKA
    var transactionID = genarateId();
    var d = new Date();
    var date = d.getFullYear()+"-"+d.getMonth()+"-"+d.getDate();
    var time = d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
   

    withdrawMoney(transferingAcc,amount,"ONLINE-MONEY-TRANSFER",function(err,result){
        if(result == "success"){
            depositMoney(transferedAcc,amount,"ONLINE-MONEY-RECEIVE",function(err,result){
                if(result == "currentSuccess" || result == "savingSuccess"){
                    conn.query(`INSERT INTO transaction (transaction_id, date, time_transaction, transaction_type,account_num) VALUES ('${transactionID}','${date}','${time}',"ONLINE-MONEY-TRANSACTION",'${transferingAcc}')`,function(err,result){
                        if(err){console.error(err)}
                        else{
                            conn.query(`INSERT INTO online_transaction (transaction_id, amount, account) VALUES ('${transactionID}','${amount}','${transferedAcc}')`,function(err,result){
                                if(err){
                                    console.error(err);     
                                    callback(true,"Error in create logs");
        
                                }else{
                                    callback(null,"moneyTransferSuccess");
                                }
                            });
                        }
                    });
                }else{
                    callback(true,"Error in money deposit");
                }
            });
        }else{
            callback(true,"Error in money withdraw");
        }
    });          
}



module.exports = moneyTransfer;