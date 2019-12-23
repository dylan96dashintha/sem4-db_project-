var flakeIdGen = require('flake-idgen');
var intformat = require('biguint-format');

function genarateId(type){
    var genarator = new flakeIdGen();
    var id = genarator.next();
    return type + toString(intformat(id,'dec'));
}

module.exports = genarateId;