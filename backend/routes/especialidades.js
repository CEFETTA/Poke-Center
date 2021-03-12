const express = require('express');
const router = express.Router();

const EspecialidadesController = require('../controllers/especialidades-controller');

router.get('/', EspecialidadesController.getEspecialidade);
router.get('/:especialidade', EspecialidadesController.getMedicoByEspecialidade);

module.exports = router;