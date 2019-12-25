var express = require('express');
var router = express.Router();
var conn = require('./connection');
var actNum = require('./generateAccountId');
router.get('/' , function(req,res,next){
    res.render('accountDetails');
});

router.post('/',function(req,res){
    let nic = req.body.nic;
    req.session.nic = nic
    conn.query(`SELECT count(nic) as count FROM person WHERE nic = '${nic}'`, (err,result) => {
        if(err){
            console.log(err);
            res.send('pppp');
        }else{
            if(result[0].count == 0){
                res.send('There is not exist such that account')
            
            }else{
                res.send('correct');
                //updateDb();
            }
        }

    });
});


module.exports = router;