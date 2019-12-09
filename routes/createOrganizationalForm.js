var express = require('express');
var router = express.Router();
var conn = require('./connection');
var customId = require('./generateCustomId');
router.get('/',function(req,res,next){
    res.render('createOrganizationalForm');

});


router.post('/',function(req,res){
    let regNum = req.body.regNum;
    let name = req.body.name;
    let dos = req.body.dos;
    let uname = req.body.uname;
    let psw = req.body.psw;
    let branchId = req.body.branchId;
    let streetNum = req.body.streetNum;
    let street = req.body.street;
    let city = req.body.city;
    let contactNum = req.body.contactNum;
    let email = req.body.email;
    let custId = customId();



    function check(){
        custId = customId();
        console.log(custId);
        conn.query('SELECT customer_id FROM customer WHERE customer_id = ' + custId , (err, result) => {
            if(result.length != 0){
                console.log(result.length);   
                check()
            }
        });
        
    }
    check();


    conn.query(`INSERT INTO customer(customer_id,branch_id) VALUES ('${custId}','${branchId}')`,function(err,result){
        if (err) {
            res.send("Error in updating customer table");
        }else{
            conn.query(`INSERT INTO login(username,psw) VALUES ('${uname}','${psw}')`,function(err,result){
                if (err) {
                    console.log(err);
                    res.send("Error in updating login table");
                }else{
                    conn.query(`INSERT INTO  organization(reg_num,name,start_date,street_num,street,city,contact_num,email_address,customer_id) VALUES ('${regNum}','${name}','${dos}','${streetNum}','${street}','${city}','${contactNum}','${email}','${custId}')`,function(err,result){
                        if (err) {
                            res.send("err in updating Organization table");
                        }else{
                            conn.query(`INSERT INTO customer_login(username,customer_id) VALUES ('${uname}','${custId}')`,function(err,result){
                                if(err){
                                    res.send("Error in updating customer_login table");
                                }else{
                                    res.send("successfully updated...");                
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