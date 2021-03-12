const mysql = require('../mysql');

exports.getEnderecos = async (req, res, next) => {
    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const funcionario = await mysql.execute(query, [req.usuario.cpf]);

        if(funcionario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        query = `SELECT * FROM BASEDEENDERECO;`;
        const result = await mysql.execute(query);

        if(result.length === 0){
            return res.status(404).send({mensagem: 'Nenhum endereço encontrado.'});
        }

        const response = {
            quantidade: result.length,
            enderecos: result.map(endereco => {
                return {
                    endereco
                }
            })
        }
        return res.status(200).send(response);
    }catch(error){
        return res.status(500).send({error:error});
    }
}

exports.postEndereco = async (req, res, next) => {
    try{
        const query = `INSERT INTO BASEDEENDERECO (cep, logradouro, bairro, cidade, estado)
                                VALUES (?, ?, ?, ?, ?);`;
        const endereco = req.body;

        await mysql.execute(query, [endereco.cep, endereco.logradouro, endereco.bairro, endereco.cidade, endereco.estado]);
    
        const response = {
            mensagem: 'Endereço inserido com sucesso.',
            endereco
        }

        return res.status(201).send(response);
    }catch(error){
        return res.status(500).send({error:error});
    }
}

exports.getEnderecoByCep = async (req, res, next) => {
    try{
        var query = `SELECT cpf FROM FUNCIONARIO WHERE cpf=?;`;
        const funcionario = await mysql.execute(query, [req.usuario.cpf]);

        if(funcionario.length === 0){
            return res.status(401).send({mensagem: 'Usuário não autorizado.'});
        }

        query = `SELECT * FROM BASEDEENDERECO WHERE cep=?;`;
        const result = await mysql.execute(query, [req.params.cep]);

        if(result === 0){
            return res.status(404).send({mensagem: 'Nenhum endereço encontrado com o cep '+req.params.cep});
        }

        const response = {
            endereco: result[0]
        }
        
        return res.status(200).send(response);

    }catch(error){
        return res.status(500).send({error:error});
    }
}