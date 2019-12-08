function transactionId(){
    return Math.floor(Math.random() * (999999-100000) + 100000 );
}

//console.log(customId());

module.exports = transactionId;