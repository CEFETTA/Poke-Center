const express = require('express');
const router = express.Router();

const login = require('../middleware/login');
const EnderecosController = require('../controllers/enderecos-controller');


router.get('/', login, EnderecosController.getEnderecos);

router.post('/', EnderecosController.postEndereco);

router.get('/:cep', login, EnderecosController.getEnderecoByCep);

module.exports = router;