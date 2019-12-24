var express = require('express');
var router = express.Router();
var conn = require('./connection');
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
                            res.redirect('/customerAccount');
                        }else{
                            req.session.emp_id = emp_id
                            res.redirect('/branchManagerProfile');

                        }

                    }
                });
                break;

            }else if(username == uname && pswd == psw && emp_id == null){
                check = true;
                req.session.username = username
                res.redirect('/customProfile');
                break;
            }
         }

         if(check == false){
             res.send("login unsuccessful");

         }
         
     });
    
});
module.exports = router;
//module.exports = lol;