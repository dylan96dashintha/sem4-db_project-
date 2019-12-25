var express = require('express');
var router = express.Router();
const app = express();
var conn = require('./connection');
var emp_Id = require('./generateEmpId');
router.get('/',function(req,res,next){
    
    res.render('addEmp');

});

router.post('/' , function(req,res){
    let firstName = req.body.firstName;
    let lastName = req.body.lastName;
    let surname = req.body.surname;
    let uname = req.body.uname;
    let psw =req.body.psw;
    let streetNum = req.body.streetNum;
    let street = req.body.street;
    let city = req.body.city;
    let province = req.body.province;
    let dob = req.body.dob;
    let contactNum = req.body.contactNum;
    let nic = req.body.nic;
    let empId;
    let emp_id = req.session.emp_id;
    let branchId;
    let post = req.body.post;
    checkBranchId();
    function checkBranchId(){
        conn.query(`SELECT branch_id FROM employee where emp_id = '${emp_id}'` , function(err,result){
            if(err){
                console.log(err);
            }else{
                branchId = result[0].branch_id;                
        

                checkEmpId();

            }
        });
        function checkEmpId() {
            empId = emp_Id();
            console.log(empId);
            conn.query(`SELECT count(emp_id) AS counter FROM employee WHERE emp_id = '${empId}'`, (err, result) => {
                // console.log(`SELECT emp_id FROM employee WHERE account_num = '${empId}'`);
                
                console.log(result);
                if (result[0].counter != 0) {
                    console.log(result.counter);
                    checkEmpId()
                } else {
                    updateDb();
                }
            });
    
        }
    
    

    function updateDb(){
        conn.beginTransaction(function(err){
            if (err){ throw err;}
            conn.query(`INSERT INTO employee(emp_id,first_name,last_name,surname,street_num,city,province,date_of_birth,contact_num,nic,state,branch_id) VALUES('${empId}','${firstName}','${lastName}','${surname}','${streetNum}','${city}','${province}','${dob}','${contactNum}','${nic}',1,'${branchId}')` , function(err,result){
                if (err) {
                    console.log(err);
                    conn.rollback(function(err){
                        console.log("unable to update emp entity");
                    });
                }

                conn.query(`INSERT INTO history(start_day,post,branch_id,emp_id) VALUES(curdate(),'${post}','${branchId}','${empId}')` , function(err,result){
                    if (err) {
                        console.log(err);
                        conn.rollback(function(err){
                            console.log("unable to update history entity");
                        });
                    }

                    conn.query(`INSERT INTO login(username,psw) VALUES('${uname}','${psw}')` , function(err,result){
                        if(err) {
                            console.log(err);
                            conn.rollback(function(err){
                                console.log("unable to update login");
                            });
                        }
                        conn.query(`INSERT INTO employee_login(username,emp_id) VALUES('${uname}','${empId}')` , function(err,result){
                            if (err) {
                                console.log(err);
                                conn.rollback(function(err){
                                    console.log("unable to update employee entity");
                                });
                            }
                            conn.commit(function(err){
                                if(err) {
                                    console.log(err);
                                    console.rollback(function(err){
                                        res.redirect('/addEmp');
                                    });
                                }
                                console.log("employee successfully added to branch");
                                res.redirect('/branchManagerProfile');
                                conn.end();
                                    //alert("employee successfully added to branch");
                            });
                        });
                    });   
                });
            });
        });
    }

    
    
    }
    

});



module.exports = router;