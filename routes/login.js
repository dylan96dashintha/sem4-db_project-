var express = require('express');
var router = express.Router();
//var conn = require('./connection');

router.get('/',function(req,res,next){
    res.render('login');

});

router.post('/',function(req,res){
    let username = req.body.uname;
    let pswd = req.body.pswd;

   // conn.query('SELECT username,psw FROM login',function(err,result){
    //     if(err) throw err
    //     for(x=0;x<result.length;x++){
    //           var uname = result[x].username;
    //         var psw = result[x].psw;
    //         if ( username == uname && pswd == psw){
                 res.redirect('/profile');
    //         }else{
    //             res.send('login unsuccessful...');
    //         }
    //     }
    // });
});



module.exports = router;