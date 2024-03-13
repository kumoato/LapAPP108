module.exports = (sequelize, Sequelize) => {
  const user = sequelize.define(
    'user',
    {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      username: { type: Sequelize.STRING },
      password: { type: Sequelize.STRING },
    },
    {
      timestamps: false,
      freezeTableName: true,
    }
  );
  return user;
};
