var express = require('express');
var router = express.Router();
var accountId = require('./generateAccountId');
var conn = require('./connection');

router.get('/', function (req, res, next) {
    res.render('createPersonalExistAccount');
});

router.post('/', function (req, res) {
    console.log('sffdfdf');
    let type = req.body.type;
    let branchId = req.body.branchId;
    let balance = req.body.balance;
    let nic = req.session.nic;
    //let nic = "212121";
    // console.log(nic);
    let custId;
    let actId;
    getCustomId();
    function getCustomId() {
        conn.query(`SELECT customer_id  FROM person WHERE nic = '${nic}'`, function (err, result) {
            if (err) {
                res.send("error in getting customer id");
            } else {
                console.log("aaaaaaaaaaaaaaaaaaaaaaa");
                custId = result[0].customer_id;
                //console.log(custId);
                checkAccountId();
            }
        });
        //console.log("sssssssssssssssssssssssssss");
        // checkAccountId();
        //console.log(custId);


    }

    function checkAccountId() {
        actId = accountId();
        console.log(custId);
        conn.query(`SELECT account_num FROM account WHERE account_num = '${actId}'`, (err, result) => {
            if (result.length != 0) {
                console.log(result.length);
                checkAccountId()
            } else {
                updateDb();
            }
        });

    }

    function updateDb(){
        conn.beginTransaction(function (err) {
            if (err) { throw err; }
            console.log(`INSERT INTO account(account_num,branch_id,balance,start_time,state,customer_id) VALUES ('${actId}','${branchId}','${balance}',curdate(),1,'${custId}')`);
            conn.query(`INSERT INTO account(account_num,branch_id,balance,start_time,state,customer_id) VALUES ('${actId}','${branchId}','${balance}',curdate(),1,'${custId}')`, function (err, result) {
                if (err) {
                    return conn.rollback(function (err) {
                        res.send("unsuccessful in updating account table");
                        throw err
                    });
                }

                if (type) {
                    console.log(`INSERT INTO saving_account(account_num,transaction_count,balance) VALUES ('${actId}',0,${balance})`);
                    conn.query(`INSERT INTO saving_account(account_num,transaction_count,balance) VALUES ('${actId}',0,${balance})`, function (err, result) {
                        if (err) {
                            return conn.rollback(function (err) {
                                res.send("unable to update saving_account entity");
                                throw err 
                           });
                        }else {
                            conn.commit(function(err) {
                                if (err) {
                                    return conn.rollback(function() {
                                        throw err
                                    })
                                }
                                res.send("successfully updated the db...");
                                conn.end();  
                            })
                        }
                    });
                }else{
                    console.log("5");
                    console.log(`INSERT INTO current_account(account_num,balance) VALUES ('${actId}','${balance}')`);
                    conn.query(`INSERT INTO current_account(account_num,balance) VALUES ('${actId}','${balance}')`, function (err, result) {
                        if (err) {
                            console.log("6");
                            conn.rollback(function (err) {
                            res.send("unable to update current_account entity");
                            });

                        } else {
                            console.log("7");
                            res.send("Account Created...");
                            conn.end();
                        }
                    });

                }
        
            });
        });
    }



});


module.exports = router;