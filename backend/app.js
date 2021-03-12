const express = require('express');
const app = express();
const morgan = require('morgan');
const bodyParser = require('body-parser');

const rotaFuncionarios = require('./routes/funcionarios');
const rotaEnderecos = require('./routes/enderecos');
const rotaLogin = require('./routes/login');
const rotaMedico = require('./routes/medicos');
const rotaEspecialidades = require('./routes/especialidades');
const rotaAgendas = require('./routes/agendas');
const rotaPacientes = require('./routes/pacientes');

app.use(morgan('dev'));
app.use(bodyParser.urlencoded({ extended: false })); // apenas dados simples
app.use(bodyParser.json()); // json de entrada no body

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*'); // colocar aqui o caminho do servidor no futuro. Ex.: https://google.com
    res.header('Access-Control-Allow-Header',
    'Origin, X-Requested-With, Content-Type, Accept, Authorization');

    if(req.method === 'OPTIONS'){
        res.header('Access-Control-Allow-Methods', 'PUT, POST, PATCH, DELETE, GET');
        return res.status(200).send({});
    }

    next();
});

app.use('/funcionarios', rotaFuncionarios);
app.use('/enderecos', rotaEnderecos);
app.use('/login', rotaLogin);
app.use('/medicos', rotaMedico);
app.use('/especialidades', rotaEspecialidades);
app.use('/agendas', rotaAgendas);
app.use('/pacientes', rotaPacientes);

// caso não encontre nenhuma rota
app.use((req, res, next) => {
    const erro = new Error('Rota não encontrada!');
    erro.status = 404;
    next(erro);
});

app.use((error, req, res, next) => {
    res.status(error.status || 500);
    return res.send({
        erro: {
            mensagem: error.message
        }
    });
});

module.exports = app;