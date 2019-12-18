var express = require('express');
var router = express.Router();
var conn = require('./connection');


router.get('/', function (req, res, next) {
    res.render('AtmWithdraw');
});

    
    
   

    module.exports=router
     