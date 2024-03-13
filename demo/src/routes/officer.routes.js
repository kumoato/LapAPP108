const express = require('express');
const router = express.Router();
const controller = require('../controllers/officer.controller');

router.get('/user', controller.getuser);
router.post('/modeluser', controller.createofficerwithmodel);
router.put('/updateuser/:id', controller.update);
router.delete('/userdel/:id', controller.delete);
module.exports = router;
