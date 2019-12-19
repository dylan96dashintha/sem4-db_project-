var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var loginRouter = require('./routes/login');
var empProfileRouter = require('./routes/empProfile');
var customProfileRouter = require('./routes/customProfile');
var createPersonalFormRouter = require('./routes/createPersonalForm');
var createOrganizationalFormRouter = require('./routes/createOrganizationalForm');
var normalLoanRequestRouter = require('./routes/normalLoanRequest');
var onlineLoanRequestRouter = require('./routes/onlineLoanReq');
var accountDetailsRouter = require('./routes/accountDetails');
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/login', loginRouter);
app.use('/empProfile', empProfileRouter);
app.use('/customProfile', customProfileRouter);
app.use('/createPersonalForm', createPersonalFormRouter);
app.use('/createOrganizationalForm', createOrganizationalFormRouter);
app.use('/normalLoanRequest', normalLoanRequestRouter);
app.use('/onlineLoanReq',onlineLoanRequestRouter);
app.use('/accountDetails',accountDetailsRouter);
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
