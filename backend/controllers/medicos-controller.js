const mysql = require('../mysql');
const bcrypt = require('bcrypt');

const formata_data = (data) => {
    const d = data.split('/');
    return d[2]+'-'+d[1]+'-'+d[0];
}

exports.getMedicos = async (req, res, next) => {
    try {
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        query = `SELECT * FROM MEDICO
                        INNER JOIN FUNCIONARIO ON MEDICO.cpf = FUNCIONARIO.cpf
                        INNER JOIN PESSOA ON PESSOA.cpf = MEDICO.cpf;`;
        
        const result = await mysql.execute(query);

        if(result.length === 0){
            return res.status(404).send({mensagem: 'Nenhum médico encontrado'});
        }

        query = `SELECT * FROM AGENDA WHERE codigo_medico=?;`;

        var medicos = [];
        for(let i = 0; i < result.length; i++){
            let medico = result[i];
            const {cpf, data_contrato, salario, nome, email, telefone, cep, logradouro, bairro, cidade, estado, especialidade, crm} = medico;
            var agendas = await mysql.execute(query, [cpf]);

            medicos.push({
                medico: {
                    cpf: cpf,
                    especialidade: especialidade,
                    crm: crm
                },
                funcionario: {
                    cpf: cpf,
                    data_contrato: data_contrato,
                    salario: salario,
                },
                pessoa: {
                    cpf: cpf,
                    nome: nome,
                    email: email,
                    telefone: telefone,
                    cep: cep,
                    logradouro: logradouro,
                    bairro: bairro,
                    cidade: cidade,
                    estado: estado
                },
                agendas: agendas
            });
        }

        const response = {
            quantidade: result.length,
            medicos: medicos
        }
        return res.status(200).send(response);
    }catch(error){
        return res.status(500).send({error:error});
    }
}

exports.postMedico = async (req, res, next) => {
    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        const medico = req.body;

        query = `SELECT cpf FROM MEDICO WHERE cpf=?;`;
        const existe_medico = await mysql.execute(query, [medico.cpf]);

        if(existe_medico.length > 0){
            return res.status(500).send({error: 'Médico já cadastrado!'});
        }

        query = `SELECT cpf FROM PESSOA WHERE cpf=?;`;
        const existe_pessoa = await mysql.execute(query, [medico.cpf]);

        if(existe_pessoa.length === 0){
            query = `INSERT INTO PESSOA (cpf, nome, email, telefone, cep, logradouro, bairro, cidade, estado) 
                            VALUES (?,?,?,?,?,?,?,?,?);`;
            await mysql.execute(query, [medico.cpf, medico.nome, medico.email, medico.telefone, medico.cep, medico.logradouro, medico.bairro, medico.cidade, medico.estado]);
        }else{
            query = `UPDATE PESSOA 
                        SET nome=?,
                            email=?,
                            telefone=?,
                            cep=?,
                            logradouro=?,
                            bairro=?,
                            cidade=?,
                            estado=?
                    WHERE cpf=?;`;
            await mysql.execute(query, [medico.nome, medico.email, medico.telefone, medico.cep, medico.logradouro, medico.bairro, medico.cidade, medico.estado, medico.cpf]);
        }

        query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const existe_funcionario = await mysql.execute(query, [medico.cpf]);

        const hash = await bcrypt.hashSync(medico.senha, 10);

        if(existe_funcionario.length === 0){
            query = `INSERT INTO FUNCIONARIO (cpf, data_contrato, salario, senha_hash)
                        VALUES (?,?,?,?);`;
            await mysql.execute(query, [medico.cpf, formata_data(medico.data_contrato), medico.salario, hash]);
        }else{
            query = `UPDATE FUNCIONARIO
                        SET data_contrato = ?, 
                            salario = ?, 
                            senha_hash = ?
                    WHERE cpf = ?;`;
            await mysql.execute(query, [medico.data_contrato, medico.salario, hash, medico.cpf]);
        }


        query = `INSERT INTO MEDICO (cpf, especialidade, crm)
                    VALUES (?,?,?);`;
        await mysql.execute(query, [medico.cpf, medico.especialidade, medico.crm]);

        const {cpf, data_contrato, salario, nome, email, telefone, cep, logradouro, bairro, cidade, estado, especialidade, crm} = medico;
    
        const response = {
            mensagem: 'Médico criado com sucesso.',
            medico: {
                cpf: cpf,
                especialidade: especialidade,
                crm: crm
            },
            funcionario: {
                cpf: cpf,
                data_contrato: data_contrato,
                salario: salario,
            },
            pessoa: {
                cpf: cpf,
                nome: nome,
                email: email,
                telefone: telefone,
                cep: cep,
                logradouro: logradouro,
                bairro: bairro,
                cidade: cidade,
                estado: estado
            }
        };

        return res.status(201).send(response);

    }catch(error){
        return res.status(500).send({error:error});
    }
}

exports.getMedicoByCpf = async (req, res, next) => {
    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        query = `SELECT * FROM MEDICO 
                        INNER JOIN FUNCIONARIO ON MEDICO.cpf=FUNCIONARIO.cpf AND MEDICO.cpf=?
                        INNER JOIN PESSOA ON MEDICO.cpf=PESSOA.cpf AND MEDICO.cpf=?;`;
        const result = await mysql.execute(query, [req.params.cpf, req.params.cpf]);

        if(result.length === 0){
            return res.status(404).send({
                mensagem: `Não foi encontrado nenhum médico com o cpf ${req.params.cpf}`
            });
        }

        const {cpf, data_contrato, salario, nome, email, telefone, cep, logradouro, bairro, cidade, estado, especialidade, crm} = result[0];

        const response = {
            mensagem: 'Médico retornado com sucesso.',
            medico: {
                cpf: cpf,
                especialidade: especialidade,
                crm: crm
            },
            funcionario: {
                cpf: cpf,
                data_contrato: data_contrato,
                salario: salario,
            },
            pessoa: {
                cpf: cpf,
                nome: nome,
                email: email,
                telefone: telefone,
                cep: cep,
                logradouro: logradouro,
                bairro: bairro,
                cidade: cidade,
                estado: estado
            }
        }

        return res.status(200).send(response);

    }catch(error){
        return res.status(500).send({error:error});
    }
}

exports.patchMedico = async (req, res, next) => {
    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        const medico = req.body;

        query = `SELECT cpf FROM MEDICO WHERE cpf=?;`;
        const existe_medico = await mysql.execute(query, [medico.cpf]);

        if(existe_medico.length === 0){
            return res.status(500).send({error: 'Médico não cadastrado.'});
        }

        const hash = await bcrypt.hashSync(medico.senha, 10);

        query = `UPDATE PESSOA
                        SET nome = ?, 
                            email = ?, 
                            telefone = ?, 
                            cep = ?, 
                            logradouro = ?, 
                            bairro = ?, 
                            cidade = ?, 
                            estado = ? 
                    WHERE cpf = ?;`;
        await mysql.execute(query, [medico.nome, medico.email, medico.telefone, medico.cep, medico.logradouro, medico.bairro, medico.cidade, medico.estado, medico.cpf]);

        query = `UPDATE FUNCIONARIO
                    SET data_contrato = ?, 
                        salario = ?, 
                        senha_hash = ?
                WHERE cpf = ?;`;
        await mysql.execute(query, [formata_data(medico.data_contrato), medico.salario, hash, medico.cpf]);

        query = `UPDATE MEDICO
                    SET especialidade = ?,
                        crm = ?
                WHERE cpf = ?;`;
        await mysql.execute(query, [medico.especialidade, medico.crm, medico.cpf]);

        const {cpf, data_contrato, salario, nome, email, telefone, cep, logradouro, bairro, cidade, estado, especialidade, crm} = medico;
    
        const response = {
            mensagem: 'Médico alterado com sucesso',
            medico: {
                cpf: cpf,
                especialidade: especialidade,
                crm: crm
            },
            funcionario: {
                cpf: cpf,
                data_contrato: data_contrato,
                salario: salario,
            },
            pessoa: {
                cpf: cpf,
                nome: nome,
                email: email,
                telefone: telefone,
                cep: cep,
                logradouro: logradouro,
                bairro: bairro,
                cidade: cidade,
                estado: estado
            }
        };

        return res.status(201).send(response);

    }catch(error){
        return res.status(500).send({error:error});
    }
}

exports.deleteMedico = async (req, res, next) => {
    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        query = `DELETE FROM MEDICO WHERE cpf=?;`;
        await mysql.execute(query, [req.body.cpf]);
        
        query = `DELETE FROM FUNCIONARIO WHERE cpf=?;`;
        await mysql.execute(query, [req.body.cpf]);

        query = `DELETE FROM PESSOA WHERE cpf=?;`;
        await mysql.execute(query, [req.body.cpf]);

        const response = {
            mensagem: 'Médico deletado com sucesso.'
        };

        return res.status(201).send(response);
    }catch(error){
        return res.status(500).send({error:error});
    }
}