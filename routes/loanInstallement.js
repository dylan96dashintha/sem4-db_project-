var express = require('express');
var router = express.Router();
var conn = require('./connection');
var installement_id = require('./generateInstallementId');
router.get('/' , function(req,res,next){
    res.render('loanInstallement');
});

router.post('/', function(req,res){
    let installementAmount = req.body.installementAmount;
    // let actNum = req.body.actNum;
    let actNum = req.session.accountNumber;
    console.log(actNum);
    let loan_id;
    let installementId;
    console.log("installement amount"+installementAmount);
    checkInstallementId();
    function checkAccountnum(){
        conn.query(`SELECT loan_id FROM loan WHERE account_num = '${actNum}'` ,function (err , result){
            if(err){
                res.send("error  in getting loan id");
            }else {
                if(result.length == 0){
                    res.send("you have not apply for a  loan");
                }else{
                    updatedb();
                    loan_id = result[0].loan_id;
                    console.log(loan_id);
                }
            }
        });
    }

    // function interval(){
    //     conn.query(`SELECT start_date FROM loan where loan_id = '${loan_id}'` , function(err,result){
    //         if (err) {

    //         }else{
    //             console.log(result[0].start_date - );
    //         }
    //     });
    // }

    function updatedb() {
        conn.beginTransaction(function (err){
            if (err) { throw err;}
            
            conn.query(`UPDATE installement SET paied_amount = paied_amount + ${installementAmount} , monthly_pavement = ${installementAmount} , date_pavement = curdate() , net_loan_amount = net_loan_amount - ${installementAmount} WHERE loan_id = '${loan_id}'` , function(err,result){
                if (err){
                    conn.rollback(function(err){
                        res.send('unsuccessfull...');
                    });
                }
                console.log(`UPDATE installement SET paied_amount = paied_amount + ${installementAmount} , monthly_pavement = ${installementAmount} date_pavement = curdate() , net_loan_amount = net_loan_amount - ${installementAmount} WHERE loan_id = '${loan_id}'`);

                conn.query(`UPDATE installement SET  late_not_late_state = 'nlate' WHERE date_pavement - checked_date >= 0 AND paied_amount - installement_amount >= 0 ` , function(err){
                    if(err) {
                        conn.rollback(function(err){
                            res.send("unsuccessfull in late or not...")
                        });
                    }

                    conn.query(`INSERT INTO installement_history(installement_id , paied_amount , paied_date , loan_id) VALUES('${installementId}',${installementAmount},curdate(),'${loan_id}')` , function(err){
                        if(err) {
                            conn.rollback(function(err){
                                console.log(`INSERT INTO installement_history(installement_id , paied_amount , paied_date , loan_id) VALUES('${installementId}',${installementAmount},curdate(),'${loan_id}')`);
                                res.send("unable to update installement_history");
                            });
                        }
                        conn.commit(function(err) {
                            if (err) { 
                              conn.rollback(function() {
                                throw err;
                              });
                            }
                            res.redirect('/empProfile');
                            console.log('Transaction Complete.');
                            // conn.end();
                          });
        
                    });
                });
                
                

                
            });


    });
}

function checkInstallementId() {
    installementId = installement_id();
    conn.query('SELECT count(installement_id) AS counter FROM installement_history WHERE installement_id = ' + installementId, (err, result) => {
        console.log(result);
        if (result[0].counter != 0) {
            console.log(result.length);
            checkInstallementId();
        } else {
            console.log("check installement complete...")
            checkAccountnum();
        }

    });

}


});

module.exports = router ;