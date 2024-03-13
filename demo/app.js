const express = require('express');
const cors = require('cors');
const expressValidator = require('express-validator');
const dotenv = require('dotenv');
const app = express();
dotenv.config();

// import routes

const officer = require('./src/routes/officer.routes');
const products = require('./src/routes/product.routes');

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(expressValidator());
app.use(function (req, res, next) {
  // 5 Min
  req.socket.setTimeout(300000);
  next();
});

app.use('/api/nahra', officer, products);
app.listen(process.env.APP_PORT, () => {
  console.log(
    `Server is running on port : ${process.env.APP_PORT} for ${process.env.APP_ENV}`
  );
});
