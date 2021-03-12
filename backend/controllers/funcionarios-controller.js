const mysql = require('../mysql');
const bcrypt = require('bcrypt');

const formata_data = (data) => {
    const d = data.split('/');
    return d[2]+'-'+d[1]+'-'+d[0];
}

exports.getFuncionarios = async (req, res, next) => {
    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        query = `SELECT * from FUNCIONARIO f JOIN PESSOA p ON f.cpf=p.cpf;`;
        const result = await mysql.execute(query);
        const response = {
            quantidade: result.length,
            funcionarios: result.map(funcionario => {
    
                const {cpf, data_contrato, salario, nome, email, telefone, cep, logradouro, bairro, cidade, estado} = funcionario;
    
                return {
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
            })
        }
        return res.status(200).send(response);
    }catch(error){
        return res.status(500).send({error: error});
    }
}

exports.postFuncionario = async (req, res, next) => {
    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        const funcionario = req.body;
        query = `SELECT * FROM FUNCIONARIO INNER JOIN PESSOA ON FUNCIONARIO.cpf=PESSOA.cpf AND PESSOA.email=?`;
        var result = await mysql.execute(query, funcionario.email);

        if(result.length > 0){
            return res.status(409).send({mensagem: 'Funcionário já cadastrado'});
        }

        const hash = await bcrypt.hashSync(funcionario.senha, 10);

        query = `SELECT cpf FROM PESSOA WHERE cpf=?;`;
        const pessoa = await mysql.execute(query, [funcionario.cpf]);

        if(pessoa.length === 0){
            query = `INSERT INTO PESSOA (cpf, nome, email, telefone, cep, logradouro, bairro, cidade, estado) 
            VALUES (?,?,?,?,?,?,?,?,?);`
            
            await mysql.execute(query, [funcionario.cpf, funcionario.nome, funcionario.email, funcionario.telefone, funcionario.cep, funcionario.logradouro, funcionario.bairro, funcionario.cidade, funcionario.estado]);
        }
        else {
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
            await mysql.execute(query, [funcionario.nome, funcionario.email, funcionario.telefone, funcionario.cep, funcionario.logradouro, funcionario.bairro, funcionario.cidade, funcionario.estado, funcionario.cpf]);
        }


        query = `INSERT INTO FUNCIONARIO (cpf, data_contrato, salario, senha_hash)
                    VALUES (?,?,?,?);`

        await mysql.execute(query, [funcionario.cpf, formata_data(funcionario.data_contrato), funcionario.salario, hash]);

        const {cpf, data_contrato, salario, nome, email, telefone, cep, logradouro, bairro, cidade, estado} = funcionario;
    
        const response = {
            mensagem: 'Funcionario criado com sucesso.',
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
        return res.status(500).send({error: error});
    }
}

exports.getFuncionarioByCpf = async (req, res, next) => {
    try{

        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        query = `SELECT * FROM FUNCIONARIO f JOIN PESSOA p ON f.cpf=p.cpf AND f.cpf=?;`;

        const result = await mysql.execute(query, [req.params.cpf]);

        if(result.length === 0){
            return res.status(404).send({
                mensagem: `Não foi encontrado nenhum funcionário com o cpf ${req.params.cpf}.`
            });
        }

        const {cpf, data_contrato, salario, nome, email, telefone, cep, logradouro, bairro, cidade, estado} = result[0];

        const response = {
            mensagem: 'Funcionário retornado com sucesso.',
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
    }
    catch(error){
        return res.status(500).send({error:error});
    }
}

exports.patchFuncionario = async (req, res, next) => {
    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        const funcionario = req.body;

        query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const existe_funcionario = await mysql.execute(query, [funcionario.cpf]);

        if(existe_funcionario.length === 0){
            return res.status(500).send({error: 'Funcionário não cadastrado.'});
        }

        const hash = await bcrypt.hashSync(funcionario.senha, 10);

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
        
        await mysql.execute(query, [funcionario.nome, funcionario.email, funcionario.telefone, funcionario.cep, funcionario.logradouro, funcionario.bairro, funcionario.cidade, funcionario.estado, funcionario.cpf]);

        query = `UPDATE FUNCIONARIO
                    SET data_contrato = ?, 
                        salario = ?, 
                        senha_hash = ?
                WHERE cpf = ?;`;

        await mysql.execute(query, [formata_data(funcionario.data_contrato), funcionario.salario, hash, funcionario.cpf]);

        const {cpf, data_contrato, salario, nome, email, telefone, cep, logradouro, bairro, cidade, estado} = funcionario;
    
        const response = {
            mensagem: 'Funcionário alterado com sucesso',
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

exports.deleteFuncionario = async (req, res, next) => {

    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const usuario = await mysql.execute(query, [req.usuario.cpf]);

        if(usuario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        query = `DELETE FROM FUNCIONARIO WHERE cpf=?;`;

        await mysql.execute(query, [req.body.cpf]);

        query = `DELETE FROM PESSOA WHERE cpf=?;`;

        await mysql.execute(query, [req.body.cpf]);

        const response = {
            mensagem: 'Funcionário deletado com sucesso.'
        };

        return res.status(201).send(response);

    }catch(error){
        return res.status(500).send({error:error});
    }
}