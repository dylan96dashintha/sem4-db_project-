var express = require('express');
var router = express.Router();
var conn = require('./connection');
var customId = require('./generateCustomId');
var accountId = require('./generateAccountId');
router.get('/',function(req,res,next){
    res.render('createPersonalForm');

});

router.post('/',function(req,res){
    let firstName = req.body.firstName;
    let lastName = req.body.lastName;
    let surname = req.body.surname;
    let streetNum = req.body.streetNum;
    let street = req.body.street;
    let city = req.body.city;
    let dob = req.body.dob;
    let contactNum = req.body.contactNum;
    let email = req.body.email;
    let nic = req.body.nic;
    let uname = req.body.uname;
    let psw = req.body.psw;
    let branchId = req.body.branchId;
    let custId = customId();
    let actId = accountId();
    let type = req.body.type;
    let balance = parseFloat(req.body.balance);
    console.log(type);
    console.log(custId); 
    
    
    function checkCustomId(){
        custId = customId();
        console.log(custId);
        conn.query('SELECT customer_id FROM customer WHERE customer_id = ' + custId , (err, result) => {
            if(result.length != 0){
                console.log(result.length);   
                checkCustomId()
            }
        });
        
    }

    
    function checkAccountId(){
        actId = accountId();
        console.log(custId);
        conn.query('SELECT account FROM customer WHERE account_id = ' + actId , (err, result) => {
            if(result.length != 0){
                console.log(result.length);   
                checkAccountId()
            }
        });
        
    }


   
    checkCustomId();
    checkAccountId();
    console.log(custId);
   // console.log(`INSERT INTO customer(customer_id,branch_id) VALUES (${custId},${branchId})`);
    conn.query(`INSERT INTO customer(customer_id,branch_id) VALUES ('${custId}','${branchId}')`,function(err,result){
        if (err) {
            res.send("Error in updating customer table");
        }else{
            conn.query(`INSERT INTO login(username,psw) VALUES ('${uname}','${psw}')`,function(err,result){
                if (err) {
                    console.log(err);
                    res.send("Error in updating login table");
                }else{
                    conn.query(`INSERT INTO  person(nic,first_name,last_name,surname,street_num,street,city,dob,contact_num,email_address,customer_id) VALUES ('${nic}','${firstName}','${lastName}','${surname}','${streetNum}','${street}','${city}','${dob}','${contactNum}','${email}','${custId}')`,function(err,result){
                        if (err) {
                            res.send("err in updatin person table");
                        }else{
                            conn.query(`INSERT INTO customer_login(username,customer_id) VALUES ('${uname}','${custId}')`,function(err,result){
                                if(err){
                                    res.send("Error in updating customer_login table");
                                }else{
                                    conn.query(`INSERT INTO account(account_num,branch_id,balance,start_time,state,customer_id) VALUES ('${actId}','${branchId}','${balance}',curdate(),1,'${custId}')`,function(err,result){
                                        if (err) {
                                            res.send("unsuccessful in updating account table");
                                        }else {
                                            if(type){
                                                conn.query(`INSERT INTO saving_account(account_num,transaction_count,balance) VALUES ('${actId}',0,'${balance}')`,function(err,result){
                                                    if (err) {
                                                        res.send("unable to update saving_account entity");
                                                    }else{
                                                        res.send("successfully updated the db...");   
                                                    }
                                                });
                                            }else {
                                                conn.query(`INSERT INTO current_account(account_num,balance) VALUES ('${actId}','${balance}')`,function(err,result){
                                                    if (err) {
                                                        res.send("unable to update current_account entity");
                                                    }else {
                                                        res.send("successfully updated the db...");
                                                    }
                                                
                                                });
                                  
                                            }
                                  
                                        }
                                   
                                    });                
                                
                                }
                            
                            });
                        
                        }
                
                    });
    
                }
    
            });
    
        }
    
    });

});

module.exports = router;