var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var session = require('express-session');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var loginRouter = require('./routes/login');
var empProfileRouter = require('./routes/empProfile');
var customProfileRouter = require('./routes/customProfile');
var createPersonalNewFormRouter = require('./routes/createPersonalNewForm');
var createPersonalNewAccountRouter = require('./routes/createPersonalNewAccount');
var createPersonalExistAccountRouter = require('./routes/createPersonalExistAccount');
var createOrganizationalNewFormRouter = require('./routes/createOrganizationalNewForm');
var createOrganizationalNewAccountRouter = require('./routes/createOrganizationalNewAccount');
var createOrganizationalExistAccountRouter = require('./routes/createOrganizationalExistAccount');
var normalLoanRequestRouter = require('./routes/normalLoanRequest');
var onlineFDRouter = require('./routes/onlineFD');
var loanInstallementRouter = require('./routes/loanInstallement');
var branchManagerProfileRouter = require('./routes/branchManagerProfile');
var onlineLoanRequestRouter = require('./routes/onlineLoanReq');
//<<<<<<< HEAD
var transactionRouter=require('./routes/transaction');
var onlineTransferRouter=require('./routes/onlineTransfer');
var atmWithdrawRouter=require('./routes/AtmWithdraw');
var depositRouter=require('./routes/Deposit');
var withdrawRouter=require('./routes/Withdraw');
//=======
var accountDetailsRouter = require('./routes/accountDetails');
var depositMoneyRouter = require('./routes/depositMoney');
var withdrawMoneyRouter = require('./routes/withdrawMoney');
var moneyTransferRouter = require('./routes/moneyTransfer');
var latePersonalLoanInstallementReportRouter = require('./routes/latePersonalLoanInstallementReport');
var lateOrganizationalLoanInstallementReportRouter = require('./routes/lateOrganizationalLoanInstallementReport');
var addEmpRouter = require('./routes/addEmp');
var customerAccountRouter = require('./routes/customerAccount');
//<<<<<<< HEAD
var closeAccountRouter= require('./routes/closeAccount');
//=======
var customerAccountOnlineRouter = require('./routes/customerAccountOnline');
var logoutRouter = require('./routes/logout');
var atmRouter =require('./routes/Atm');
//>>>>>>> 42b4b5eaaa99283873975fcea4dbe69ed617f02e
//>>>>>>> bf1d718e7f9250267f1910a017c05ac281eccb40
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(session({
  secret :'ssshhhhh',
  resave : false,
  saveUninitialized : true,
  }));
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// app.use('/', indexRouter);
app.use('/', loginRouter);
app.use('/users', usersRouter);
app.use('/login', loginRouter);
app.use('/empProfile', empProfileRouter);
app.use('/customProfile', customProfileRouter);
app.use('/createPersonalNewForm', createPersonalNewFormRouter);
app.use('/createPersonalNewAccount', createPersonalNewAccountRouter);
app.use('/createPersonalExistAccount', createPersonalExistAccountRouter);
app.use('/createOrganizationalNewForm', createOrganizationalNewFormRouter);
app.use('/createOrganizationalNewAccount', createOrganizationalNewAccountRouter);
app.use('/createOrganizationalExistAccount', createOrganizationalExistAccountRouter);
app.use('/normalLoanRequest', normalLoanRequestRouter);
app.use('/onlineLoanReq',onlineLoanRequestRouter);
//<<<<<<< HEAD
app.use('/transaction',transactionRouter);
app.use('/onlinetransfer',onlineTransferRouter);
app.use('/atmwithdraw',atmWithdrawRouter);
app.use('/deposit',depositRouter);
app.use('/withdraw',withdrawRouter);
//=======
app.use('/accountDetails',accountDetailsRouter);
app.use('/depositMoney',depositMoneyRouter);
app.use('/withdrawMoney',withdrawMoneyRouter);
app.use('/onlineFD' , onlineFDRouter);
app.use('/onlineLoanReq' , onlineLoanRequestRouter);
app.use('/loanInstallement' , loanInstallementRouter);
app.use('/moneyTransfer',moneyTransferRouter);
app.use('/branchManagerProfile' , branchManagerProfileRouter);
app.use('/latePersonalLoanInstallementReport' , latePersonalLoanInstallementReportRouter);
app.use('/lateOrganizationalLoanInstallementReport' , lateOrganizationalLoanInstallementReportRouter);
app.use('/addEmp' , addEmpRouter);
app.use('/customerAccount',customerAccountRouter);
//<<<<<<< HEAD
app.use('/closeAccount',closeAccountRouter);
//=======
app.use('/customerAccountOnline',customerAccountOnlineRouter);
app.use('/logout',logoutRouter);
app.use('/Atm',atmRouter);
//>>>>>>> 42b4b5eaaa99283873975fcea4dbe69ed617f02e
//>>>>>>> bf1d718e7f9250267f1910a017c05ac281eccb40
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
