var conn = require('../routes/connection');
var mysql = require('mysql');


function getAccDetails(accNo,callback){
    console.log("sddddd");
    conn.query(`SELECT COUNT(account_num) AS count FROM current_account WHERE account_num = `+ accNo, function(err,result){
        console.log(result[0].count);
        if(result[0].count == 1){
            isPersonalOrOrganization(accNo,function(err,result){
                result.accType = "currentAccount";
                // console.log("aaaaaaaaaa");
                callback(null,result);
            });
        }
        else{
            conn.query(`SELECT COUNT(account_num) AS count , transaction_count FROM saving_account WHERE account_num = `+ accNo, function(err,result){
                if(result[0].count == 1){ 
                    var tCount = result[0].transaction_count;
                    isPersonalOrOrganization(accNo,function(err,result){
                        result.transactionCount = tCount;
                        result.accType = "savingAccount";
                        callback(null,result);
                    });
                }
                else{
                    callback(null,{accOwnerType: null , accType: null});
                }
            });
        }
    });
}

function isPersonalOrOrganization(accNo,callback){   
     var details ={};
    conn.query(`SELECT * FROM person_details WHERE account_num = ${accNo}`,function(err,result){
        if(result.length == 1){
            details = {accOwnerType: "personal" , nic: result[0].nic, firstName: result[0].first_name, lastName: result[0].last_name, accNo: result[0].account_num, branchName:result[0].branch_name, balance: result[0].balance};
            callback(null,details);
        }else{
            conn.query(`SELECT * FROM organization_details WHERE account_num = ${accNo}`,function(err,result){
                if(result.length == 1){
                    details = {accOwnerType: "organization" , regNo: result[0].reg_num, name: result[0].name, accNo: result[0].account_num, branchName:result[0].branch_name, balance: result[0].balance};
                    callback(null,details);
                }else{
                    callback(null, {accOwnerType: null , accType: null})
                }
            });
        }
    });
}

/** input accNo, accHoldersName, and branch
 * dan brach id ekata hada tyenne
 * branch name ekat hdanna oone
 * 
*/

function checkAccDetails(accNo, accHoldername, branchName,callback){

    getAccDetails(accNo,function(err,result){
        console.log(result);
        if(result.accOwnerType == "person"){
            if((accHoldername == result.firstName || accHoldername == result.lastName) && branchName == result.branchName  ){ //brach id sholld be branch
                callback(null, true);
            }else{
                callback(null, false);
            }
        }else if(result.accOwnerType == "organization"){
            if(accHoldername == result.name && branchName ==result.branchName){
                callback(null,true);
            }else{
                callback(null,false); 
            }
        }else{callback(null,false);}
    });

}

module.exports = {getAccDetails,checkAccDetails};