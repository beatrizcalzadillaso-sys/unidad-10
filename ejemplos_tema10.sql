use mysql;
desc user;

SELECT host, user, authentication_string FROM user;

select * 
from user
where user in ('anita', 'santi', 'jose');

CREATE USER santi@localhost IDENTIFIED BY '4321'
WITH MAX_QUERIES_PER_HOUR 100          /*no se separan por coma los privilegios*/
MAX_USER_CONNECTIONS 10;

CREATE USER jose IDENTIFIED BY '1234',
ana@localhost IDENTIFIED BY '5678';

ALTER USER santi@localhost
WITH MAX_USER_CONNECTIONS 15;

RENAME USER ana@localhost TO anita@localhost;

select *
from db;

select *
from Tables_priv;

CREATE USER dba IDENTIFIED BY 'aaaa';
GRANT ALL PRIVILEGES ON *.* TO dba
WITH GRANT OPTION;

GRANT SELECT ON pedidos_dam.* TO jose;

GRANT insert, update, delete ON pedidos_dam.pedido TO jose;

REVOKE insert ON pedidos_dam.pedido FROM jose;

SHOW GRANTS FOR jose;

CREATE ROLE RolVentas;
GRANT select, insert, update, delete ON pedidos_dam.pedido TO RolVentas;
GRANT select, insert, update, delete ON pedidos_dam.LineaPedido TO RolVentas;
GRANT select ON pedidos_dam.Articulo TO RolVentas;

SHOW GRANTS FOR RolVentas;

select @@activate_all_roles_on_login;
set global activate_all_roles_on_login = 1;

DROP ROLE RolVentas;