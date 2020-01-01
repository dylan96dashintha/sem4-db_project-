var express = require('express');
var router = express.Router();
var conn = require('./connection');
var getEmpBranch = require('../models/employee').getEmpBranchName;
//const session = require('express-session');

router.get('/',function(req,res,next){

    res.render('login');

});


router.post('/',function(req,res){
    let username = req.body.uname;
    let pswd = req.body.pswd;
    let check = false;
    ssn = req.session;
    conn.query('SELECT username,psw,emp_id FROM login left outer join employee_login using(username)',function(err,result){
         if(err) throw err
         for(x=0;x<result.length;x++){
            var uname = result[x].username;
            var psw = result[x].psw;
            var emp_id = result[x].emp_id;
            //console.log(uname,psw,emp_id); 
            if ( username == uname && pswd == psw && emp_id != null){
                check = true;

                conn.query(`SELECT count(branch_manager.emp_id) AS counter FROM branch_manager,employee_login where branch_manager.emp_id = '${emp_id}' ` , function(err,result){
                    if (err) {
                        console.log(err);
                    }else{
                        if(result[0].counter == 0){
                            req.session.logtype = "emp";
                            req.session.username = uname;
                            conn.query(`SELECT branch_name,branch_id FROM emp_branch WHERE username = '${uname}'`,function(err,result){
                                if(err){console.error(err);}
                                else{
                                    req.session.branch = result[0].branch_name;
                                    req.session.branch_id = result[0].branch_id;

                                    res.redirect('/customerAccount');
                                }
                            });
                        }else{
                            conn.query(`SELECT branch_name FROM emp_branch WHERE username = '${uname}'`,function(err,result){
                                if(err){console.error(err);}
                                else{
                                    req.session.branch = result[0].branch_name;
                                    req.session.emp_id = emp_id;
                                    req.session.username = uname;
                                    req.session.logtype = "manager";
                                    res.redirect('/branchManagerProfile');
                                }
                            });

                        }

                    }
                });
                break;

            }else if(username == uname && pswd == psw && emp_id == null){
                check = true;
                req.session.username = username
                req.session.logtype = "customer";
                res.redirect('customProfile');
                
                break;
            }
         }

         if(check == false){

             res.render('login');

         }
         
     });
    
});
module.exports = router;
//module.exports = lol;