const express = require('express');
const router = express.Router();

const login = require('../middleware/login');
const AgendasController = require('../controllers/agendas-controller');

router.post('/', AgendasController.postAgenda);
router.get('/', login, AgendasController.getAgendas);
router.get('/especifica', AgendasController.getHorariosAgendadosByMedicoData);
router.get('/medico', login, AgendasController.getAgendaByMedico);

module.exports = router;