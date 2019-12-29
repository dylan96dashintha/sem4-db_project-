var conn = require('../routes/connection');
var mysql = require('mysql');

async function getEmpBranchName(username,callback){
    await conn.query(`SELECT branch_name FROM emp_branch WHERE username = '${username}'`,function(err,result){
        if(err){
            callback(err,false);
        }else{
            callback(null,result[0].branch_name);
        }
    });
}

module.exports = getEmpBranchName;