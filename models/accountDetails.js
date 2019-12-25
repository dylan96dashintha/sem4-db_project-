var conn = require('../routes/connection');
var mysql = require('mysql');


function getAccDetails(accNo,callback){
    // console.log("sddddd");
    conn.query(`SELECT COUNT(account_num) AS count FROM current_account WHERE account_num = `+ accNo, function(err,result){
        // console.log(result[0].count);
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

function getAccDetails2(accNo){
    // console.log("sddddd");
    conn.query(`SELECT COUNT(account_num) AS count FROM current_account WHERE account_num = `+ accNo, function(err,result){
        // console.log(result[0].count);
        if(result[0].count == 1){
            isPersonalOrOrganization(accNo,function(err,result){
                result.accType = "currentAccount";
                // console.log("aaaaaaaaaa");
                return result;
            });
        }
        else{
            conn.query(`SELECT COUNT(account_num) AS count , transaction_count FROM saving_account WHERE account_num = `+ accNo, function(err,result){
                if(result[0].count == 1){ 
                    var tCount = result[0].transaction_count;
                    isPersonalOrOrganization(accNo,function(err,result){
                        result.transactionCount = tCount;
                        result.accType = "savingAccount";
                        return result;
                    });
                }
                else{
                    return {accOwnerType: null , accType: null};
                }
            });
        }
    });
}

function isPersonalOrOrganization(accNo,callback){   
     var details ={};
    conn.query(`SELECT * FROM person_details WHERE account_num = ${accNo}`,function(err,result){
        if(result.length == 1){
            details = {msg:null,accOwnerType: "personal" , nic: result[0].nic, firstName: result[0].first_name, lastName: result[0].last_name, accNo: result[0].account_num, branchName:result[0].branch_name, balance: result[0].balance};
            callback(null,details);
        }else{
            conn.query(`SELECT * FROM organization_details WHERE account_num = ${accNo}`,function(err,result){
                if(result.length == 1){
                    details = {msg:null,accOwnerType: "organization" , regNo: result[0].reg_num, name: result[0].name, accNo: result[0].account_num, branchName:result[0].branch_name, balance: result[0].balance};
                    callback(null,details);
                }else{
                    callback(null, {accOwnerType: null , accType: null})
                }
            });
        }
    });
}

function isSavingOrCurrent(accNo,callback){

    conn.query(`SELECT COUNT(account_num) as count , transaction_count FROM saving_account WHERE account_num ='${accNo}'`,function(err,result){
        if(err){console.error(err);}
        else if(result[0].count == 1){
            callback(null,result[0].transaction_count);
        }else{
            conn.query(`SELECT COUNT(account_num) as count FROM current_account WHERE account_num ='${accNo}'`,function(err,result){
                if(err){console.error(err);}
                else if(result[0].count == 1){
                    callback(null,"current");
                }else{callback(true,null);}
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
        // console.log(result);
        if(result.accOwnerType == "personal"){
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

function getAccounts(username,callback){
    //this function returns the all the accounts thah customer has
    //should input the username 
    var details = [];
    conn.query(`SELECT * FROM customer_login NATURAL JOIN person_details WHERE username = '${username}'`,async function(err,result){
        if(err){console.error(err)}
        else if(result.length > 0){            
            result.forEach(element => {
                details.push({accNo:element.account_num,balance:element.balance,branch:element.branch_name,state:element.state});
            });
            callback(null,details);
            
        }else{
            conn.query(`SELECT * FROM customer_login NATURAL JOIN organization_details WHERE username = '${username}'`,function(err,result){
                if(err){console.error(err)}
                else if(result.length > 0){
                    result.forEach(element => {
                        details.push({accNo:element.account_num,balance:element.balance,branch:element.branch_name,state:element.state});
                    });
                    callback(null,details);
                }else{
                    callback(null,false);
                }

            });
        }
    });

}

async function getMultipleAccDetails(accNumbers){
    // console.log(accNumbers);
    let accNums = accNumbers;
    const balances = [];
    const branches = [];
    const accTypes = [];
    const transactionCounts = [];
    // add().then(console.log(transactionCounts));
    // async function add(){
        //  for(let i=0;i<accNums.length;i++){
         for(const item of accNums){
            console.log(item);

            await add(item).then(console.log("sd"));
            
        }
        console.log(balances);

        async function add(accNo){
            await getAccDetails(accNo,function(err,result){
                console.log("djdedjewoejijwfindn");
                balances.push(result.balance);
            });
        }
        // console.log(balances);
    
    // add().then(console.log(transactionCounts));
    // callback(null,{accNo:accNums,balance:balances,branch:branches,accType:accTypes,transactionCount:transactionCounts})
    // return {accNo:accNums,balance:balances,branch:branches,accType:accTypes,transactionCount:transactionCounts};


}

module.exports = {getAccDetails,checkAccDetails,getAccounts,getMultipleAccDetails};