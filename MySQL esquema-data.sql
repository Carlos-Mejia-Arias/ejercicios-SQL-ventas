DROP DATABASE IF EXISTS Ejercicio_ventas;
CREATE DATABASE Ejercicio_ventas CHARACTER SET utf8mb4;
USE Ejercicio_ventas;

DROP TABLE IF EXISTS `ventas`;
DROP TABLE IF EXISTS `vendedores`;
DROP TABLE IF EXISTS `clientes`;
DROP TABLE IF EXISTS `oficina`;
DROP TABLE IF EXISTS `productos`;

SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `NOMBRE` varchar(50) DEFAULT NULL,
  `APELLIDO` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `oficina` (
  `id_oficina` int(11) NOT NULL,
  `descripcion` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`id_oficina`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `descripcion` varchar(225) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `vendedores` (
  `id_vendedor` int(11) NOT NULL,
  `nombre` varchar(225) DEFAULT NULL,
  `apellido` varchar(225) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `id_oficina` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_vendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `ventas` (
  `id_cliente` int(11) DEFAULT NULL,
  `id_vendedor` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `ID_VENTA` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_VENTA`),
  KEY `ID_CLIENTE` (`ID_CLIENTE`),
  KEY `ID_VENDEDOR` (`ID_VENDEDOR`),
  KEY `ID_PRODUCTO` (`ID_PRODUCTO`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedores` (`id_vendedor`),
  CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


insert  into `clientes`(`id_cliente`,`nombre`,`apellido`) values 
(1,'CRISTIAN','VILA'),
(2,'CARLA','HERRERA'),
(3,'SANDRA','LOPEZ');

insert  into `productos`(`id_producto`,`descripcion`,`precio`) values 
(1,'SAMSUNG S40',800.49),
(2,'IPHONE 13',949.59),
(3,'ONEPLUS 8T',750.15),
(4,'PIXEL 10 XL',800.49),
(5,'HUAWEI P50',650);

insert  into `vendedores`(`id_vendedor`,`nombre`,`apellido`,`fecha_nac`,`id_oficina`) values 
(1,'Carlos','Perez','1995-08-29',1),
(2,'Ana','Suarez','1980-02-10',1),
(3,'Juan','Salazar','1990-05-08',1),
(4,'Pedro','Gutierrez','1980-01-07',2),
(5,'Maria','Soliz','2000-11-04',2),
(6,'Mario','Mos','2001-12-04',1),
(7,'Matias','Ramon','1999-09-01',2);

insert  into `oficina`(`id_oficina`,`descripcion`) values 
(1,'BARCELONA'),
(2,'MADRID'),
(3,'VALENCIA');

insert  into `ventas`(`id_cliente`,`id_vendedor`,`id_producto`,`fecha`,`id_venta`) values 
(1,1,1,'2020-01-17',1),
(3,1,2,'2020-01-19',2),
(2,1,3,'2020-01-09',3),
(3,3,4,'2020-01-07',4),
(2,3,5,'2020-01-20',5),
(2,2,5,'2020-01-08',6),
(2,2,5,'2020-01-04',7),
(2,2,5,'2020-01-14',8),
(1,5,5,'2020-01-25',9),
(1,6,4,'2020-01-14',10),
(1,6,3,'2020-01-14',11),
(1,6,3,'2020-01-21',12),
(1,6,3,'2020-01-22',13),
(2,5,2,'2020-01-13',14),
(3,5,2,'2020-01-10',15),
(3,5,2,'2020-01-25',16),
(3,5,2,'2020-01-25',17),
(3,5,2,'2020-01-04',18),
(3,3,1,'2020-01-18',19),
(2,2,3,'2020-01-06',20),
(2,2,1,'2020-01-05',21),
(2,2,2,'2020-01-19',22),
(2,2,4,'2020-01-11',23),
(3,3,4,'2020-01-22',24),
(3,3,4,'2020-01-11',25),
(2,3,3,'2020-01-04',26),
(2,3,3,'2020-01-02',27),
(2,3,3,'2020-01-05',28),
(1,3,3,'2020-01-13',29),
(3,2,5,'2020-02-06',30),
(3,3,3,'2020-02-14',31),
(2,2,5,'2020-02-20',32),
(3,2,4,'2020-02-15',33),
(2,2,3,'2020-02-08',34),
(3,5,5,'2020-02-05',35),
(2,6,1,'2020-02-05',36),
(3,2,4,'2020-02-13',37),
(1,6,1,'2020-02-19',38),
(1,1,4,'2020-02-17',39),
(1,3,4,'2020-02-03',40),
(1,2,1,'2020-02-18',41),
(2,3,5,'2020-02-20',42),
(1,2,1,'2020-02-19',43),
(1,2,4,'2020-02-13',44),
(1,6,2,'2020-02-18',45),
(3,6,4,'2020-02-17',46),
(3,1,5,'2020-02-09',47),
(2,5,4,'2020-02-20',48),
(1,2,4,'2020-02-08',49),
(3,2,3,'2020-02-21',50),
(3,6,1,'2020-02-13',51),
(3,2,1,'2020-02-06',52),
(3,6,5,'2020-02-06',53),
(3,3,3,'2020-02-20',54),
(3,2,4,'2020-02-17',55),
(2,1,2,'2020-02-18',56),
(3,3,3,'2020-02-12',57),
(2,2,5,'2020-02-17',58);