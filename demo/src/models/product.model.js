module.exports = (sequelize, Sequelize) => {
  const products = sequelize.define(
    'products',
    {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      productname: { type: Sequelize.STRING },
      price: { type: Sequelize.STRING },
      count: { type: Sequelize.STRING },
      files: { type: Sequelize.STRING },
    },
    {
      timestamps: false,
      freezeTableName: true,
    }
  );
  return products;
};
