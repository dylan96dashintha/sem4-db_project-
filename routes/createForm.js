var express = require('express');
var router = express.Router();
var conn = require('connection');

router.get('/',function(req,res,next){
    res.render('createForm');

});

router.post('/',function(req,res){
    let firstName = req.body.firstName;
    let lastName = req.body.lastName;
    let surname = req.body.surname;
    let streetNum = req.body.streetNum;
    let city = req.body.city;
    let dob = req.body.dob;
    let contactNum = req.body.contactNum;
    let email = req.body.email;
    let nic = req.body.nic;
    let uname = req.body.uname;
    let psw = req.body.psw;
    let branchId = req.body.branchId;

    conn.query('INSERT VALUES INTO ()');
});



module.exports = router;