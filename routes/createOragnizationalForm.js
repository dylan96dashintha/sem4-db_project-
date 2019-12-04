var express = require('express');
var router = express.Router();
var conn = require('./connection');
var customId = require('./generateCustomId');
router.get('/',function(req,res,next){
    res.render('createOrganizationalForm');

});





module.exports = router;