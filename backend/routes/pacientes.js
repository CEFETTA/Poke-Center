const express = require('express');
const router = express.Router();

const PacientesController = require('../controllers/pacientes-controller');
const login = require('../middleware/login');

router.post('/', login, PacientesController.postPacientes);
router.get('/', login, PacientesController.getPacientes);

module.exports = router;