var express = require('express');
var router = express.Router();
var conn = require('./connection');
var customId = require('./generateCustomId');
var accountId = require('./generateAccountId');
router.get('/',function(req,res,next){
    res.render('createOrganizationalNewForm');

});

router.post('/',function(req,res){
    let reg_num = req.session.reg_num;
    console.log(reg_num);
    let name = req.body.name;
    let dos = req.body.dos;
    let accType = req.body.accType;
    console.log(accType);
    let accPlan = req.body.accPlan;
    console.log(accPlan);
    let uname = req.body.username;
    let psw = req.body.password;

    //to be continued
    // let branchId = req.body.branchId;
    // let streetNum = req.body.streetNum;
    // let street = req.body.street;
    // let city = req.body.city;
    // let contactNum = req.body.contactNum;
    // let email = req.body.email;
    // let custId = customId();    
    // let actId = accountId();
    // let type = req.body.type;
    // let balance = parseFloat(req.body.balance);
    // console.log(type);
    // console.log(custId);

    function checkRegNum(){
        conn.query('SELECT count(reg_num) as count FROM organization WHERE reg_num = ' + reg_num, (err,result) => {
            if (result[0].count == 0){
                checkCustomId();
            }else {
                res.send("error");
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
                updateDb();
            }
        });
        
    }

    function updateDb(){    
    
        conn.query(`INSERT INTO customer(customer_id,branch_id) VALUES ('${custId}','${branchId}')`,function(err,result){
            if (err) {
                res.send("Error in updating customer table");
            }else{
                conn.query(`INSERT INTO login(username,psw) VALUES ('${uname}','${psw}')`,function(err,result){
                    if (err) {
                        console.log(err);
                        res.send("Error in updating login table");
                    }else{
                        conn.query(`INSERT INTO organization(reg_num,name,start_date,street_num,street,city,contact_num,email_address,customer_id) VALUES ('${regNum}','${name}','${dos}','${streetNum}','${street}','${city}','${contactNum}','${email}','${custId}')`,function(err,result){
                            if (err) {
                                res.send("Error in updating Organization table");
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
                                                    conn.query(`INSERT INTO saving_account(account_num,transaction_count,Date,balance) VALUES ('${actId}',0,curdate(),'${balance}')`,function(err,result){
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

    }
       res.send("Account Created");     
checkRegNum();
});

module.exports = router;