var express = require('express');
var router = express.Router();
var conn = require('./connection');
var loan_Id = require('./generateLoanId');
var transaction_Id = require('./generateTransactionId');


router.get('/', function (req, res, next) {
    res.render('normalLoanRequest');

});



router.post('/', function (req, res) {
    let actNum = req.session.accountNumber;
    let repayPeriod = req.body.repayPeriod;
    let loanAmount = req.body.loanAmount;
    let empSector = req.body.empSector;
    let empType = req.body.empType;
    let profession = req.body.profession;
    let annualSalary = req.body.annualSalary;
    let installement_amt = (loanAmount*0.1)/repayPeriod;
    console.log("dsds"+installement_amt);
    //let loanId = loan_Id();
    //let transactionId = transaction_Id();

    function updateDB() {

        conn.beginTransaction(function(err){
            if (err) { throw err; }
            conn.query(`INSERT INTO loan(loan_id,loan_amount,installement_amount,repayment_period,start_date,state,account_num) VALUES ('${loanId}','${loanAmount}','${installement_amt}','${repayPeriod}',curdate(),'1','${actNum}')`, function (err, result) {
                if (err) {
                    conn.rollback(function(err){
                        res.send(err);
                        res.send("unsuccessful in updating loan entity");
                    });
                }
                    
                conn.query(`INSERT INTO normal_loan(loan_id,account_num,emp_sector,emp_type,profession,total_salary) VALUES ('${loanId}','${actNum}','${empSector}','${empType}','${profession}','${annualSalary}')`, function (err, result) {
                    if (err) {
                        conn.rollback(function(err){
                            res.send("unsuccessful in updating normal loan entity");
                        });
                    
                    }

                    conn.query(`INSERT INTO transaction(transaction_id,date,time_transaction,transaction_type,account_num) VALUES ('${transId}',curdate(),curtime(),'loan','${actNum}')`, function (err, result) {
                        if (err) {
                            conn.rollback(function(err){
                                res.send("unsuccessful in updating transaction entity");
                            });
                        }

                        conn.query(`INSERT INTO deposit(deposit_amount,transaction_id) VALUES ('${loanAmount}','${transId}')`, function (err, result) {
                            if (err) {
                                conn.rollback(function(err){
                                    res.send("unsuccessful in updating deposit entity");

                                });
                            }

                            conn.query(`UPDATE account SET balance =  balance + ${loanAmount} WHERE account_num = '${actNum}'`, function (err, result) {
                                if (err) {
                                    conn.rollback(function(err){
                                        res.send("unsuccessful in updating balance column entity");
                                    });
                                }
                                conn.query(`INSERT INTO installement(loan_id,installement_amount,checked_date,net_loan_amount) VALUES('${loanId}' , ${installement_amt} , curdate() , ${loanAmount})` , function(err,result){
                                    if(err) {
                                        conn.rollback(function(err){
                                            res.send("unsuccessfull in installement...");
                                        });
                                    }
                                    conn.commit(function(err) {
                                        if (err) { 
                                          conn.rollback(function() {
                                            throw err;
                                          });
                                        }
                                        res.render('employee',{msg:"Succsessfully added loan to "+req.session.accountNumber,branch:req.session.branch,emp:req.session.username});
                                        // conn.end();
                                      });
    
                                });

                                
                            });

                        });
        
                    });

                });

            });

        });

       // endTransaction();
    }
    
    // function endTransaction(){
    //     conn.end();
    // }

    function checkAccountNum() {
        conn.query(`SELECT account_num FROM account WHERE account_num = '${actNum}'`, function (err, result) {
            if (err){
                console.log(err);
            }else{
                if (result.length == 1) {
                    updateDB();
                    //res.send("correct");
                    // console.log(result);
                } else {
                    
                    res.send("aa");
                }
            }
        });
    }

    function checkTransactionId() {
        transId = transaction_Id();
        conn.query('SELECT transaction_id FROM transaction WHERE transaction_id = ' + transId, (err, result) => {
            if (result.length != 0) {
                console.log(result.length);
                checkTransactionId();
            } else {
                console.log("check transaction complete...")
                checkAccountNum();
            }

        });

    }

    function checkLoanId() {
        loanId = loan_Id();
        conn.query('SELECT loan_id FROM loan WHERE loan_id = ' + loanId, (err, result) => {
            console.log(err)
            if (result.length != 0) {
                console.log(result.length);
                checkLoanId();
            } else {
                console.log("check loAN complete...");
                checkTransactionId();
            }
        });

    }



    checkLoanId();



});

module.exports = router;