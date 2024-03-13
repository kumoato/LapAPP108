const db = require('../models');
const { sequelize } = require('../models');
require('dotenv').config();

module.exports = {
  getproducts: async (req, res) => {
    try {
      const schema = process.env.SCHEMA;

      var query = ` select  * from products`;

      var data = await sequelize
        .query(query, { replacements: {}, type: sequelize.QueryTypes.SELECT })
        .then((data) => {
          console.log(data);
          return data;
        })
        .catch((error) => {
          console.log(error);
          return res.status(500).json({ message: error });
        });
      return res.status(200).json({ data: data });
    } catch (error) {
      console.log(error);
      return res.status(500).json({ message: error });
    }
  },

  createproductswithmodel: async (req, res) => {
    try {
      const schema = process.env.SCHEMA;
      const usermodel = db.products.schema(schema);
      const data = req.body;
      const papra = await usermodel
        .create(data)
        .then((payload) => {
          return payload;
        })
        .catch((error) => {
          console.log(error);
          return res.status(500).json({ message: 'Bad request.' });
        });
      return res.status(200).json({ data: papra });
    } catch (error) {
      console.log(error);
      return res
        .status(500)
        .json({ message: 'Cannot insert data into database.' });
    }
  },

  update: async (req, res) => {
    try {
      const schema = process.env.SCHEMA;
      const usermodel = db.products.schema(schema);
      const id = req.params.id;
      const data = req.body;
      const papra = await usermodel
        .update(data, { where: { id: id } })
        .then((payload) => {
          return payload;
        })
        .catch((error) => {
          console.log(error);
          return res.status(500).json({ message: 'Bad request.' });
        });
      return res.status(200).json({ data: papra });
    } catch (error) {
      console.log(error);
      return res
        .status(500)
        .json({ message: 'Cannot update data in database.' });
    }
  },
  delete: async (req, res) => {
    const schema = process.env.SCHEMA;
    console.log(schema);
    const officermodel = db.products.schema(schema);
    const id = req.params.id;
    if (id) {
      try {
        await officermodel.destroy({ where: { id: id } });
        return res.status(200).send();
      } catch (e) {
        return res
          .status(500)
          .json({ message: 'Cannot remove data from database.' });
      }
    } else {
      return res.status(400).json({ message: 'Bad request.' });
    }
  },
};
