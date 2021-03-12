const mysql = require('mysql');

var pool = mysql.createPool({
    "connectionLimit": 20,
    "user": process.env.MYSQL_USER,
    "password": process.env.MYSQL_PASSWORD,
    "database": process.env.MYSQL_DATABASE,
    "host": process.env.MYSQL_HOST,
    "port": process.env.MYSQL_PORT
});

exports.execute = (query, params=[]) => {
    return new Promise((resolve, reject) => {
        pool.query(
            query,
            params,
            (error, results, fields) => {
                error ? reject(error) : resolve(results);
            }
        )
    })
}

exports.pool = pool;