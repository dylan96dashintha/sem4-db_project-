var express = require('express');
var router = express.Router();
var conn = require('./connection');
router.get('/',function(req,res,next){
    res.render('createPersonalNewAccount');
});



router.post('/',function(req,res){
    let nic = req.body.nic;
    req.session.nic = nic
    conn.query(`SELECT count(nic) as count FROM person WHERE nic = '${nic}'`, (err,result) => {
        if(err){
            console.log(err);
            res.send('sdsd');
        }else{
            if(result[0].count == 0){
                res.redirect('/createPersonalNewForm')
            
            }else{
                res.redirect('createPersonalExistAccount' );
            }
        }

        // if (result.count(nic) = 0){
        //     res.redirect('createPersonalNewForm', {nic : nic});
        // }else{
        //     res.redirect('createPersonalExistForm', {nic : nic} );
        // }
        });
});

module.exports = router;