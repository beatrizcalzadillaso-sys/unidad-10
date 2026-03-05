/*a) Crea un usuario llamado adminpedidos con la contraseña que desees y que tenga todos los
privilegios sobre todas las tablas de la base de datos Pedidos. Permite que este usuario pueda
pasar sus privilegios a otros usuarios. */ 
use pedidos_dam;

select user, host
from mysql.user;

create user if not exists adminpedidos 
identified by '1234';

grant all privileges on pedidos_dam.* to adminpedidos
with grant option;


/*b) Crea un segundo usuario llamado consulpedidos con la contraseña que desees, que pueda
consultar el contenido de cualquiera de las tablas de la base de datos Pedidos y que además
pueda:
 crear tablas, 
 eliminar tablas, 
 modificar el diseño de las tablas creadas, 
 crear vistas y
crear y borrar índices
						, todo ello en la base de datos Pedidos. 
Comprueba que efectivamente
puede en dicha base de datos consultar tablas, pero que no puede añadir filas a las mismas.*/

create user consulpedidos 
identified by '1234';

grant select on pedidos_dam.* to consulpedidos;
grant create, drop, alter, create view, index on pedidos_dam.* to consulpedidos;

select * from pedido;

insert into pedido 
values ('P0007', current_date());

/*c) Crea un tercer usuario procpedidos que solo se pueda conectar desde el equipo local con la
contraseña que desees y que tenga las siguientes limitaciones: 
el número máximo de consultas y 
actualizaciones que puede hacer por hora son 30 
y el número máximo de conexiones simultáneas de ese usuario son 4. 

Este usuario debe poder crear y modificar rutinas
almacenadas en la base de datos Pedidos. Comprueba las restricciones asignadas en la tabla
User de la base de datos MySQL.*/

create user procpedidos@localhost 
identified by '1234'
with max_queries_per_hour 30
	 max_updates_per_hour 30
     max_user_connections 4;
     
grant create routine,
alter routine on pedidos_dam.*
to procpedidos@localhost;    

show grants for procpedidos@localhost;

select * 
from mysql.db
where user ='procpedidos@localhost';

/*d) Crea un cuarto usuario llamado modifpedidos con la contraseña que desees, que pueda

consultar la tabla Articulo, 
insertar nuevas filas en dicha tabla, 
borrar artículos, 
modificar los atributos DesArt y PVPArt de los artículos y 
crear claves ajenas a la clave primaria de esta tabla. 

Una vez asignados estos privilegios, visualiza los permisos de este usuario. Comprueba
que este usuario puede añadir un nuevo artículo y luego modificar el precio de dicho artículo,
pero no modificar su código.*/

create user modifpedidos
identified by '1234';

grant select, insert, delete , update , references on pedidos_dam.articulo 
to modifpedidos;

show grants for modifpedidos;

/*e) Retira los privilegios otorgados al usuario procpedidos y después elimina el usuario.*/
revoke all privileges on pedidos_dam.* 
from procpedidos@localhost;

drop user procpedidos;

/*f) Visualiza los privilegios del usuario consulpedidos. Retira a este usuario la posibilidad de
crear, eliminar tablas y modificar su diseño en la base de datos Pedidos. Visualiza a
continuación sus privilegios.*/