const Sequelize = require('sequelize');
require('dotenv').config();
const sequelize = new Sequelize(
  process.env.DB,
  process.env.USERSNAME,
  process.env.PASSWORD,

  {
    host: process.env.HOST,
    port: parseInt(process.env.PGPORT),
    dialect: process.env.DIALECT,
    operatorsAliases: false,

    pool: {
      max: parseInt(process.env.POOLMAX),
      min: parseInt(process.env.POOLMIN),
      acquire: parseInt(process.env.POOLACQUIRE),
      idle: parseInt(process.env.POOLIDLE),
    },
  }
);

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.user = require('./officer.model')(sequelize, Sequelize);
db.products = require('./product.model')(sequelize, Sequelize);

module.exports = db;
