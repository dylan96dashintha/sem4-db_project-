var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    res.render('transaction',{msg:null,branch:req.session.branch,emp:req.session.username});
});

    
    
    
     


module.exports = router