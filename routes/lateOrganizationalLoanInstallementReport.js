var express = require('express');
var router = express.Router();
var conn = require('./connection');

router.get('/',function(req,res,next){
    let emp_id = req.session.emp_id;
    let branchId; 
        conn.query(`SELECT branch_id FROM employee where emp_id = '${emp_id}'` , function(err,result){
        if(err){
            console.log(err);
        }else{
            branchId = result[0].branch_id;
            console.log(branchId);
    var nameList = []  ;
    var regNumList = [];
    var customerIdList = [];
    var contactNumList = [];
    var mailList = [];
    var accountList = [];
    

    conn.query(`CALL lateloanreport()` , function(err,result){
        if(err) {
            console.log(err);

        } else {
            conn.query(`SELECT reg_num,name,contact_num,organization.customer_id,email_address,account_num FROM lateloanreport,organization WHERE lateloanreport.customer_id = organization.customer_id AND lateloanreport.branch_id = '${branchId}'` , function(err,result){
                if(err){
                    console.log(err);
                }else {
                    
                    for(x=0 ; x<result.length ; x++){
                        nameList.push(result[x].name);
                        regNumList.push(result[x].reg_num);
                        customerIdList.push(result[x].customer_id);
                        contactNumList.push(result[x].contact_num);
                        mailList.push(result[x].email_address);
                        accountList.push(result[x].account_num);

                    }
                    JSON.stringify(nameList);
                    JSON.stringify(regNumList);
                    JSON.stringify(customerIdList);
                    JSON.stringify(contactNumList);
                    JSON.stringify(mailList);
                    JSON.stringify(accountList);

                    res.render('lateOrganizationalLoanInstallementReport' , {regNum : regNumList, email :mailList , account :accountList, name : nameList ,  customNum :customerIdList , tel : contactNumList   } );

                    //res.send(name);
                }
            });

            
        }
    });
            
        }
    });
    
});




module.exports = router;