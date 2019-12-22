var express = require('express');
var router = express.Router();
const app = express();

router.get('/',function(req,res,next){
    
    res.render('addEmp');

});




module.exports = router;