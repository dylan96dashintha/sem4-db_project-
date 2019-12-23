var express = require('express');
var router = express.Router();
var conn = require('./connection');

router.get('/',function(req,res,next){
    let branchId;
    let emp_id = req.session.emp_id;
    conn.query(`SELECT branch_id FROM employee where emp_id = '${emp_id}'` , function(err,result){
        if(err){
            console.log(err);
        }else{
            branchId = result[0].branch_id;
            console.log(branchId);
            var nameList = []  ;
    var lastNameList = [];
    var nicList = [];
    var customerIdList = [];
    var contactNumList = [];
    var mailList = [];
    var accountList = [];
    conn.query(`CALL lateloanreport()` , function(err,result){
        if(err) {
            console.log(err);

        } else {
            console.log('success');
            conn.query(`SELECT account_num,email_address,contact_num,person.customer_id,nic,first_name,last_name FROM lateloanreport,person WHERE lateloanreport.customer_id = person.customer_id AND lateloanreport.branch_id = '${branchId}'` , function(err,result){
                if(err){
                    console.log(err);
                }else {
                    
                    for(x=0 ; x<result.length ; x++){
                        nameList.push(result[x].first_name);
                        lastNameList.push(result[x].last_name);
                        nicList.push(result[x].nic);
                        customerIdList.push(result[x].customer_id);
                        contactNumList.push(result[x].contact_num);
                        mailList.push(result[x].email_address);
                        accountList.push(result[x].account_num);

                    }
                    JSON.stringify(nameList);
                    JSON.stringify(lastNameList);
                    JSON.stringify(nicList);
                    JSON.stringify(customerIdList);
                    JSON.stringify(contactNumList);
                    JSON.stringify(mailList);
                    JSON.stringify(accountList);

                    res.render('latePersonalLoanInstallementReport' , {email :mailList , account :accountList, name1 : nameList , nameLast : lastNameList , nic :nicList, customNum :customerIdList , tel : contactNumList   } );

                    //res.send(name);
                }
            });

            
        }
    });
            
        }
    });

    
});




module.exports = router;