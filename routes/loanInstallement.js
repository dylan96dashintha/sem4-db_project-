var express = require('express');
var router = express.Router();
var conn = require('./connection');
router.get('/' , function(req,res,next){
    res.render('loanInstallement');
});

router.post('/', function(req,res){
    var installementAmount = req.body.installementAmount;
    var actNum = req.body.actNum;
    checkAccountnum();
    function checkAccountnum(){
        conn.query(`SELECT loan_id FROM loan WHERE account_num = '${actNum}'` ,function (err , result){
            if(err){
                res.send("error  in getting loan id");
            }else {
                if(result.length == 0){
                    res.send("you have not apply for a  loan");
                }else{
                    var loan_id = result[0].loan_id;
                    console.log(loan_id);
                }
            }
        });
    }



});

module.exports = router ;