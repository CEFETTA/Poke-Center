const express = require('express');
const router = express.Router();
const login = require('../middleware/login');

const FuncionariosController = require('../controllers/funcionarios-controller');

//senha: teste123
// req.usuario = {cpf, iat, exp}

// retorna todos os funcionários
router.get('/', login, FuncionariosController.getFuncionarios);

// insere um funcionário
router.post('/', login, FuncionariosController.postFuncionario);

// retorna um funcionário específico
router.get('/:cpf', login, FuncionariosController.getFuncionarioByCpf);

// altera um funcionário
router.patch('/', login, FuncionariosController.patchFuncionario);

// deleta um funcionario
router.delete('/', login, FuncionariosController.deleteFuncionario);

module.exports = router;