const mysql = require('../mysql');

exports.postPacientes = async (req, res, next) => {
    try {
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);
        
        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }
        
        const paciente = req.body;
        
        query = `SELECT cpf FROM PACIENTE WHERE cpf=? AND codigo_pokemon=?;`;
        const existe_paciente = await mysql.execute(query, [paciente.cpf, paciente.codigo_pokemon]);

        if(existe_paciente.length > 0){
            return res.status(500).send({error: 'Paciente já cadastrado'});
        }

        query = `SELECT cpf FROM PESSOA WHERE cpf=?;`;
        const existe_pessoa = await mysql.execute(query, [paciente.cpf]);

        if(existe_pessoa.length === 0){
            query = `INSERT INTO PESSOA (cpf, nome, email, telefone, cep, logradouro, bairro, cidade, estado)
                            VALUES (?,?,?,?,?,?,?,?,?);`;
            await mysql.execute(query, [paciente.cpf, paciente.nome_dono, paciente.email, paciente.telefone, paciente.cep, paciente.logradouro, paciente.bairro, paciente.cidade, paciente.estado]);    
        }else {
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
            await mysql.execute(query, [paciente.nome_dono, paciente.email, paciente.telefone, paciente.cep, paciente.logradouro, paciente.bairro, paciente.cidade, paciente.estado, paciente.cpf]);
        }


        query = `INSERT INTO PACIENTE (cpf, nome_pokemon, codigo_pokemon, peso, altura, tipo_sanguineo)
                    VALUES (?,?,?,?,?,?);`;
        await mysql.execute(query, [paciente.cpf, paciente.nome_pokemon, paciente.codigo_pokemon, paciente.peso, paciente.altura, paciente.tipo_sanguineo]);

        const response = {
            mensagem: 'Paciente criado com sucesso.',
            pessoa: {
                cpf: paciente.cpf,
                nome: paciente.nome_dono,
                email: paciente.email,
                telefone: paciente.telefone,
                cep: paciente.cep,
                logradouro: paciente.logradouro,
                bairro: paciente.bairro,
                cidade: paciente.cidade,
                estado: paciente.estado
            },
            paciente: {
                cpf: paciente.cpf,
                codigo_pokemon: paciente.codigo_pokemon,
                nome_pokemon: paciente.nome_pokemon,
                peso: paciente.peso,
                altura: paciente.altura,
                tipo_sanguineo: paciente.tipo_sanguineo
            }
        }

        return res.status(201).send(response);
    }catch(error){
        return res.status(500).send({error:error});
    }
}

exports.getPacientes = async (req, res, next) => {
    try {
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        query = `SELECT * FROM PACIENTE INNER JOIN PESSOA ON PACIENTE.cpf=PESSOA.cpf;`;
        const result = await mysql.execute(query);

        if(result.length === 0){
            return res.status(404).send({mensagem: 'Nenhum paciente encontrado'});
        }

        query = `SELECT * FROM AGENDA WHERE email=?;`;
        var pacientes = [];
        for(let i = 0; i < result.length; i++){
            var paciente = result[i];
            var agenda = await mysql.execute(query, [paciente.email]);
            pacientes.push({
                pessoa: {
                    cpf: paciente.cpf,
                    nome: paciente.nome,
                    email: paciente.email,
                    telefone: paciente.telefone,
                    cep: paciente.cep,
                    logradouro: paciente.logradouro,
                    bairro: paciente.bairro,
                    cidade: paciente.cidade,
                    estado: paciente.estado
                },
                paciente: {
                    cpf: paciente.cpf,
                    codigo_pokemon: paciente.codigo_pokemon,
                    nome_pokemon: paciente.nome_pokemon,
                    peso: paciente.peso,
                    altura: paciente.altura,
                    tipo_sanguineo: paciente.tipo_sanguineo
                },
                agendas: agenda
            });
        }

        var response = {
            mensagem: 'Pacientes listado abaixo',
            quantidade: result.length,
            pacientes: pacientes
        }

        return res.status(200).send(response);
    }catch(error){
        return res.status(500).send({error:error});
    }
}