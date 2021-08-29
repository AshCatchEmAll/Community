var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const cors = require('cors')
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var storiesRouter = require('./routes/stories');
const { checkAuth } = require('./authentication/checkAuth');

var app = express();
//Cors
app.use(cors())
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));


app.use(checkAuth);

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/stories', storiesRouter);

app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
 
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};


  res.status(err.status || 500);
  res.render('error');
});

app.listen("5000",(err)=>{
  if(err){
    console.log("Error listening : ", err)
  }else{
    console.log("Listening on port 5000")
  }
})

module.exports = app;
