var express = require('express');
var router = express.Router();
var conn = require('./connection');
router.get('/',function(req,res,next){
    res.render('createOrganizationalNewAccount');
});



router.post('/',function(req,res){
    let reg_num = req.body.reg_num;
    req.session.reg_num = reg_num
    conn.query(`SELECT count(reg_num) as count FROM organization WHERE reg_num = '${reg_num}'`, (err,result) => {
        if(err){
            console.log(err);
            //res.send('ddd');
        }else{
            if(result[0].count == 0){
                res.redirect('/createOrganizationalNewForm')
            
            }else{
                res.redirect('/createOrganizationalExistAccount' );
            }
        }

       
        });
});

module.exports = router;