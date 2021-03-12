const mysql = require('../mysql');

const formatar_data = (data) => {
    const d = data.split('/');
    return d[2]+'-'+d[1]+'-'+d[0];
}

exports.postAgenda = async (req, res, next) => {

    try{
        const agenda = req.body;

        var query = `SELECT horario FROM AGENDA WHERE codigo_medico=? AND data=? AND horario=?;`;
        const existe_agenda = await mysql.execute(query, [agenda.codigo_medico, formatar_data(agenda.data), agenda.horario]);
        if(existe_agenda.length > 0) {
            return res.status(500).send({error: 'Médico ocupado.'});
        }
        
        query = `INSERT INTO AGENDA 
                        (codigo_medico, nome_dono, nome_pokemon, codigo_pokemon, data, email, horario, telefone)
                        VALUES (?,?,?,?,?,?,?,?);`;
        await mysql.execute(query, [agenda.codigo_medico, agenda.nome_dono, agenda.nome_pokemon, agenda.codigo_pokemon, formatar_data(agenda.data), agenda.email, agenda.horario, agenda.telefone]);
        
        const response = {
            mensagem: 'Agenda criada com sucesso',
            agenda: agenda
        }

        return res.status(201).send(response);
    }catch(error){
        return res.status(500).send({error: error});
    }
}

exports.getHorariosAgendadosByMedicoData = async (req, res, next) => {
    try{
        const query = `SELECT horario FROM AGENDA WHERE codigo_medico=? AND data=?`;
        const result = await mysql.execute(query, [req.query.codigo_medico, formatar_data(req.query.data)]);

        if(result.length === 0){
            return res.status(404).send({mensagem: 'Nenhum horário encontrado.'});
        }

        const response = {
            mensagem: `horario do médico ${req.query.codigo_medico} na data ${req.query.data}`,
            horarios: result
        }

        return res.status(200).send(response);
    }catch(error){
        return res.status(500).send({error: error});
    }
}

exports.getAgendas = async (req, res, next) => {
    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const funcionario = await mysql.execute(query, [req.usuario.cpf]);

        if(funcionario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }
        
        query = `SELECT * FROM AGENDA ORDER BY data DESC, horario DESC;`;
        const result = await mysql.execute(query);

        const response = {
            mensagem: `Agendas retornadas com sucesso.`,
            quantidade: result.length,
            agendas: result
        }

        return res.status(200).send(response);
    }catch(error){
        return res.status(500).send({error: error});
    }
}

exports.getAgendaByMedico = async (req, res, next) => {

    try {
        var query = `SELECT crm FROM MEDICO WHERE cpf=?;`;
        
        const medico = await mysql.execute(query, [req.usuario.cpf]);

        if(medico.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        query = `SELECT * FROM AGENDA WHERE codigo_medico=? ORDER BY data DESC, horario DESC;`;

        const result = await mysql.execute(query, [req.usuario.cpf]);

        if(result.length === 0){
            return res.status(404).send({mensagem: 'nenhuma agenda encontrada'});
        }

        const response = {
            mensagem: 'Sua agenda retornada com sucesso.',
            quantidade: result.length,
            agendas: result
        }

        return res.status(200).send(response);
    }catch(error){
        return res.status(500).send({error: error});
    }
}