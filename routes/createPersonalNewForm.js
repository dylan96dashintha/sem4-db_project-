var express = require('express');
var router = express.Router();
var conn = require('./connection');
var customId = require('./generateCustomId');
var accountId = require('./generateAccountId');
router.get('/',function(req,res,next){
    res.render('createPersonalNewForm');

});

router.post('/',function(req,res){
    let nic = req.session.nic;
    console.log(nic);
    let firstName = req.body.firstName;
    let lastName = req.body.lastName;
    let surname = req.body.surname;
    let streetNum = req.body.streetNum;
    let street = req.body.street;
    let city = req.body.city;
    let dob = req.body.dob;
    let contactNum = req.body.contactNum;
    let email = req.body.email;
    //let nic = req.body.nic;
    let uname = req.body.uname;
    let psw = req.body.psw;
    let savingType = req.body.savingType;
    let branchId = req.session.branch_id;
    console.log(branchId);
    let custId = customId();
    let actId = accountId();
    let type = req.body.type;
    let balance = parseFloat(req.body.balance);
    console.log(type);
    console.log(custId); 
    
    function checkNic(){
        conn.query(`SELECT count(nic) as count FROM person WHERE nic = '${nic}'`, (err,result) => {
            console.log(result);
            if (result[0].count == 0){
                checkCustomId();
            }else {
                res.send("error bro");
            }
            
        });
        

    }




    function checkCustomId(){
        custId = customId();
        console.log(custId);
        conn.query('SELECT customer_id FROM customer WHERE customer_id = ' + custId , (err, result) => {
            if(result.length != 0){
                console.log(result.length);   
                checkCustomId()
            }else {
                checkAccountId();
            }
        });
        
    }

    
    function checkAccountId(){
        actId = accountId();
        console.log(custId);
        conn.query('SELECT account_num FROM account WHERE account_num = ' + actId , (err, result) => {
            if(result.length != 0){
                console.log(result.length);   
                checkAccountId()
            }else {
                checkMinimumBalance();
            }
        });
        
    }

    
    function checkMinimumBalance(){
        conn.query(`SELECT minimum_val as min FROM account_type where type_id = ${savingType}` ,function(err,result){
            if(err){
                res.send(err);
            }else{
                if (balance >= result[0].min){
                    updateDb();
                }else{
                    res.redirect('/createPersonalNewForm');
                }
            }
        });


    }




    function updateDb(){
        conn.beginTransaction(function (err) {
            if (err) { throw err; }
            conn.query(`INSERT INTO customer(customer_id,branch_id) VALUES ('${custId}','${branchId}')`,function(err,result){
                if (err) {
                    return conn.rollback(function(err){
                        console.log(`INSERT INTO customer(customer_id,branch_id) VALUES ('${custId}','${branchId}')`);
                        res.send("Error in updating customer table");
                    });
                }
                conn.query(`INSERT INTO login(username,psw) VALUES ('${uname}','${psw}')`,function(err,result){
                    if (err) {
                        console.log(err);
                       
                        return conn.rollback(function(err){
                            res.send("Error in updating login table");
                        });
                    }
                    conn.query(`INSERT INTO  person(nic,first_name,last_name,surname,street_num,street,city,dob,contact_num,email_address,customer_id) VALUES ('${nic}','${firstName}','${lastName}','${surname}','${streetNum}','${street}','${city}','${dob}','${contactNum}','${email}','${custId}')`,function(err,result){
                        if (err) {
                            console.log(err);
                       
                            return conn.rollback(function(err){
                                res.send("err in updatin person table");
                            });
                        }
                        conn.query(`INSERT INTO customer_login(username,customer_id) VALUES ('${uname}','${custId}')`,function(err,result){
                            if(err){
                                console.log(err);
                       
                            return conn.rollback(function(err){
                                res.send("Error in updating customer_login table");
                            });
                        }
                        conn.query(`INSERT INTO account(account_num,branch_id,balance,start_time,state,customer_id) VALUES ('${actId}','${branchId}','${balance}',curdate(),1,'${custId}')`,function(err,result){
                            if (err) {
                                console.log(err);
                       
                                return conn.rollback(function(err){
                                    res.send("unsuccessful in updating account table");
                                });
                            }
                            if(type){
                                conn.query(`INSERT INTO saving_account(account_num,transaction_count,balance,type_id,Date,interest_amount) VALUES ('${actId}',0,'${balance}','${savingType}',curdate(),'0')`,function(err,result){
                                    if (err) {
                                        console.log(err);
                       
                                        return conn.rollback(function(err){
                                            res.send("unable to update saving_account entity");
                                        });
                                        
                                    }else{
                                        conn.commit(function(err) {
                                            if (err) {
                                                return conn.rollback(function(err) {
                                                    throw err
                                                })
                                            }
                                            res.redirect('/customerAccount');
                                             
                                        });
                                    }
                                });
                            }else {
                                conn.query(`INSERT INTO current_account(account_num,balance) VALUES ('${actId}','${balance}')`,function(err,result){
                                    if (err) {
                                        console.log(err);
                       
                                        return conn.rollback(function(err){
                                            res.send("unable to update current_account entity");
                                        });
                                       
                                    }else {
                                        conn.commit(function(err) {
                                            if (err) {
                                                return conn.rollback(function() {
                                                    throw err
                                                });
                                            }
                                            res.redirect('/customerAccount');
                                             
                                        });
                                    }
                                });
                            }
                            });
                        });
                    });
                });
            });
        });
    
                                
                                
        
    
    }
                               
                              
                           
                         
                
                    
        
        
       
            
checkNic();
});

module.exports = router;