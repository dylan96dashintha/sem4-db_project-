var express = require('express');
var router = express.Router();
var conn = require('./connection');
var getEmpBranch = require('../models/employee').getEmpBranchName;
//const session = require('express-session');

router.get('/',function(req,res,next){
    req.session.destroy();
    res.render('login');

});


router.post('/',function(req,res){

});

module.exports = router;