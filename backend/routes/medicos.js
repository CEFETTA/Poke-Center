const express = require('express');
const router = express.Router();

const login = require('../middleware/login');
const MedicosController = require('../controllers/medicos-controller');

router.get('/', login, MedicosController.getMedicos);
router.post('/', login, MedicosController.postMedico);
router.get('/:cpf', login, MedicosController.getMedicoByCpf);
router.patch('/', login, MedicosController.patchMedico);
router.delete('/', login, MedicosController.deleteMedico);

module.exports = router;