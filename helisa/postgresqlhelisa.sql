CREATE TABLE PRODUCTOS(
   ID INT PRIMARY KEY     NOT NULL,
   DESCRIPCION           TEXT    NOT NULL
);

CREATE TABLE PRODUCTO_DETALLE(
    ID INT PRIMARY KEY     NOT NULL,
    PRODUCTO INT,
    VENTA numeric(18, 2),
    COSTO numeric(18, 2),
    constraint fk_producto_detalle
     foreign key (PRODUCTO) 
     REFERENCES PRODUCTOS (id)
);

CREATE TABLE PRODUCTO_OPERACION(
    ID INT PRIMARY KEY     NOT NULL,
    PRODUCTO INT,
    TIPO INT,
    CANTIDAD INT,
    FECHA    DATE,
    constraint fk_producto_operacion
     foreign key (PRODUCTO) 
     REFERENCES PRODUCTOS (id)
);
--registrando datos basicos de productos
insert into PRODUCTOS(id,DESCRIPCION) values(1,'arroz');
insert into PRODUCTOS(id,DESCRIPCION) values(2,'azucar');
insert into PRODUCTOS(id,DESCRIPCION) values(3,'cafe');
insert into PRODUCTOS(id,DESCRIPCION) values(4,'panela');
select * from productos;
--ingresando valores de venta y costos del producto
insert into PRODUCTO_DETALLE(id, producto,venta, costo) values(1,1,15800,7900);
insert into PRODUCTO_DETALLE(id, producto,venta, costo) values(2,2,5400,3800);
insert into PRODUCTO_DETALLE(id, producto,venta, costo) values(3,3,9580,7650);
insert into PRODUCTO_DETALLE(id, producto,venta, costo) values(4,4,950,350);
select * from producto_detalle;
--Ingresando compras a los productos
insert into PRODUCTO_OPERACION(id, producto,tipo, cantidad,FECHA) values(1,1,1,80,'2018-09-12');
insert into PRODUCTO_OPERACION(id, producto,tipo, cantidad,FECHA) values(2,1,2,35,'2018-09-12');
insert into PRODUCTO_OPERACION(id, producto,tipo, cantidad,FECHA) values(3,2,1,92,'2018-09-12');
insert into PRODUCTO_OPERACION(id, producto,tipo, cantidad,FECHA) values(4,2,2,43,'2018-09-12');
insert into PRODUCTO_OPERACION(id, producto,tipo, cantidad,FECHA) values(5,3,1,62,'2018-09-12');
insert into PRODUCTO_OPERACION(id, producto,tipo, cantidad,FECHA) values(6,3,2,15,'2018-09-12');
insert into PRODUCTO_OPERACION(id, producto,tipo, cantidad) values(7,4,1,125,'2018-09-12');
insert into PRODUCTO_OPERACION(id, producto,tipo, cantidad,FECHA) values(8,4,2,87,'2018-09-12');
select * from producto_operacion;
--Reporte consulta
select p.id, p.descripcion, ( select sum(po.cantidad) 
  from PRODUCTO_DETALLE pd,
       PRODUCTO_OPERACION po
where  pd.producto = p.id
  and  po.producto = p.id
  and  po.fecha    = '2018-09-12'
  and  po.tipo     = 1
  
  ) - 
  
  ( select sum(po.cantidad) 
  from PRODUCTO_DETALLE pd,
       PRODUCTO_OPERACION po
where  pd.producto = p.id
  and  po.producto = p.id
  and  po.fecha    = '2018-09-12'
  and  po.tipo     = 2
  
  ) stock
  ,
  
  ( select sum(po.cantidad*pd.venta) 
  from PRODUCTO_DETALLE pd,
       PRODUCTO_OPERACION po
where  pd.producto = p.id
  and  po.producto = p.id
  and  po.fecha    = '2018-09-12'
  and  po.tipo     = 2
  
  ) ingresos
  ,
  ( select sum(po.cantidad*pd.costo) 
  from PRODUCTO_DETALLE pd,
       PRODUCTO_OPERACION po
where  pd.producto = p.id
  and  po.producto = p.id
  and  po.fecha    = '2018-09-12'
  and  po.tipo     = 1
  
  ) egresos
  ,
  ( select sum(po.cantidad*pd.venta) 
  from PRODUCTO_DETALLE pd,
       PRODUCTO_OPERACION po
where  pd.producto = p.id
  and  po.producto = p.id
  and  po.fecha    = '2018-09-12'
  and  po.tipo     = 2
  
  ) 
  -
  ( select sum(po.cantidad*pd.costo) 
  from PRODUCTO_DETALLE pd,
       PRODUCTO_OPERACION po
where  pd.producto = p.id
  and  po.producto = p.id
  and  po.fecha    = '2018-09-12'
  and  po.tipo     = 1
  
  ) ganancia
from PRODUCTOS p;  
  
    




