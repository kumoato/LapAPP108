const express = require('express');
const router = express.Router();
const controller = require('../controllers/product.controller');

router.get('/products', controller.getproducts);
router.post('/modelproducts', controller.createproductswithmodel);
router.put('/updatptoduct/:id', controller.update);
router.delete('/productdel/:id', controller.delete);
module.exports = router;
