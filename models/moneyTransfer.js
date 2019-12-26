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
    var transferId = genarateId();
    var d = new Date();
    var date = d.getFullYear()+"-"+d.getMonth()+"-"+d.getDate();
    var time = d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
   

    withdrawMoney(transferingAcc,amount,"ONLINE-MONEY-TRANSFER",function(err,result){
        if(result == "success"){
            depositMoney(transferedAcc,amount,"ONLINE-MONEY-RECEIVE",function(err,result){
                if(result == "currentSuccess" || result == "savingSuccess"){
                    conn.query(`INSERT INTO money_transfer (transfer_id, transfered_acc, transfering_acc, date, time, amount) VALUES ('${transferId}','${transferedAcc}','${transferingAcc}','${date}','${time}','${amount}')`,function(err,result){
                        if(err){
                            console.error(err);
                            callback(true,"Error in create logs");

                        }else{
                            callback(null,"moneyTransferSuccess");
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