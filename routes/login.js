var express = require('express');
var router = express.Router();
var conn = require('./connection');

router.get('/',function(req,res,next){
    res.render('login');

});

router.post('/',function(req,res){
    let username = req.body.uname;
    let pswd = req.body.pswd;
    let check = false;
    conn.query('SELECT username,psw,emp_id FROM login left outer join employee_login using(username)',function(err,result){
         if(err) throw err
         for(x=0;x<result.length;x++){
            var uname = result[x].username;
            var psw = result[x].psw;
            var emp_id = result[x].emp_id;
            console.log(uname,psw,emp_id); 
            if ( username == uname && pswd == psw && emp_id != null){
                console.log(uname,psw,emp_id); 
                res.redirect('/empProfile');
                check = true;
                break;
            }else if(username == uname && pswd == psw && emp_id == null){
                res.redirect('/customProfile');
                check = true;
                break;
            }
         }

         if(check == false){
             res.send("login unsuccessful");

         }
         
     });
});



module.exports = router;