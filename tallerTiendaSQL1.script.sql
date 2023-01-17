-- MySQL Script generated by MySQL Workbench
-- Thu Oct 27 12:08:21 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- 1- Creacion de las tablas y sus relaciones

-- -----------------------------------------------------
-- Table `mydb`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proveedor` (
  `idProveedor` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` INT NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Marca` (
  `idMarca` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMarca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Precio` DOUBLE NOT NULL,
  `Proveedor_idProveedor` INT NOT NULL,
  `Marca_idMarca` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) VISIBLE,
  INDEX `fk_Producto_Proveedor1_idx` (`Proveedor_idProveedor` ASC) VISIBLE,
  INDEX `fk_Producto_Marca1_idx` (`Marca_idMarca` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Proveedor1`
    FOREIGN KEY (`Proveedor_idProveedor`)
    REFERENCES `mydb`.`Proveedor` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Marca1`
    FOREIGN KEY (`Marca_idMarca`)
    REFERENCES `mydb`.`Marca` (`idMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vendedor` (
  `idVendedor` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Telefono` INT NOT NULL,
  `Numero_Documento` INT NOT NULL,
  PRIMARY KEY (`idVendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Tipo_Documento` VARCHAR(45) NOT NULL,
  `Numero_Documento` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `Tipo_Documento`, `Numero_Documento`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `mydb`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `Producto_idProducto` INT NOT NULL,
  `Venta_idVenta` INT NOT NULL,
  `Cantidad` INT NULL,
  `Total` DOUBLE NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Cliente_Tipo_Documento` VARCHAR(45) NOT NULL,
  `Cliente_Numero_Documento` INT NOT NULL,
  PRIMARY KEY (`idFactura`, `Producto_idProducto`, `Venta_idVenta`),
  INDEX `fk_Producto_has_Venta_Venta1_idx` (`Venta_idVenta` ASC) VISIBLE,
  INDEX `fk_Producto_has_Venta_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  INDEX `fk_Factura_Cliente1_idx` (`Cliente_idCliente` ASC, `Cliente_Tipo_Documento` ASC, `Cliente_Numero_Documento` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_has_Venta_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_has_Venta_Venta1`
    FOREIGN KEY (`Venta_idVenta`)
    REFERENCES `mydb`.`Venta` (`idVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_Cliente1`
    FOREIGN KEY (`Cliente_idCliente` , `Cliente_Tipo_Documento` , `Cliente_Numero_Documento`)
    REFERENCES `mydb`.`Cliente` (`idCliente` , `Tipo_Documento` , `Numero_Documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Venta` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `Fecha` DATE NOT NULL,
  `Vendedor_idVendedor` INT NOT NULL,
  `Estado` TINYINT NOT NULL,
  PRIMARY KEY (`idVenta`, `idCliente`),
  INDEX `fk_Venta_Vendedor1_idx` (`Vendedor_idVendedor` ASC) VISIBLE,
  INDEX `fk_Factura_Cliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Venta_Vendedor1`
    FOREIGN KEY (`Vendedor_idVendedor`)
    REFERENCES `mydb`.`Vendedor` (`idVendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `mydb`.`Factura` (`Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- 2- Llenado de las tablas con datos

insert into cliente (Nombre, Apellido, Tipo_Documento, Numero_Documento) 
values 
	('Andrea', 'Gutierrez', 'Cedula', 1234),
	('Jaime', 'Sanchez', 'Cedula', 1020),
	('Jesus', 'Sanchez', 'Cedula', 1090),
	('Sofia', 'Sanchez', 'Tarjeta de identidad', 1032),
	('Karen', 'Molano', 'Cedula', 1345);
    

insert into factura (Producto_idProducto, Cantidad, Total, Cliente_idCliente, Cliente_Tipo_Documento, Cliente_Numero_Documento, Venta_idVenta)
values
	(1,3,3500*3,1,'Cedula',1234,1),
	(1,2,3500*2,5,'Cedula',1345,2),
	(3,1,2000,2,'Cedula',1020,3),
	(4,5,1750.3*5,2,'Cedula',1020,4),
	(5,1,1000,5,'Cedula',1345,5),
	(6,3,800*3,4,'Tarjeta de identidad',1032,6),
	(9,1,985.3,3,'Cedula',1090,7);
    
select * from venta;

insert into marca (Nombre)
values
	('Cuervo'),
    ('Frescampo'),
    ('Alqueria'),
    ('Colanta');

insert into producto (Nombre, Precio, Proveedor_idProveedor, Marca_idMarca) 
values 
	('Shampoo', 3500, 3, 3),
	('Cereal', 2320.3, 1, 2),
	('Manzana', 2000, 2, 1),
	('Chocolatina', 1750.3, 1, 3),
	('Atun', 1000, 2, 2),
	('Fosforo', 800, 1, 1),
	('Vino', 3500, 3, '3'),
	('Frijoles', 2351.9, 2, 1),
	('Sardinas', 3000, 4, 4),
	('Jabon', 985.3, 1, 4);

insert into proveedor (Nombre, Telefono, Direccion) 
values 
	('Nestle', 12354, 'Cl 149 19 79'),
	('Alpina', 12456, 'Cl 71 45 79'),
	('Ramo', 15478, 'Cl 78 12 50'),
	('Bavaria', 24578, 'KR 74 102 59');

insert into vendedor (Nombre, Apellido, Telefono, Numero_Documento) 
values 
	('Alfredo', 'Bermudez', 23541, 123564);
    
insert into venta (idCliente, Fecha, Vendedor_idVendedor, Estado)
values
	(1,'2000-10-07',1,1),
	(5,'1999-09-07',1,1),
	(2,'2007-10-07',1,1),
	(2,'2009-01-01',1,1),
	(5,'2000-01-01',1,1),
	(4,'2010-07-09',1,1),
	(3,'2019-05-07',1,1);

-- 3- Dos borrados logicos y fisicos de ventas 

set foreign_key_checks = 0;
-- Borrado fisico:
delete from venta where idVenta = 1 or idVenta = 2;
select * from venta;
-- Borrado logico:
update venta set estado = 0 where idVenta = 3 or idVenta = 4;
select * from venta where estado <> 0;
set foreign_key_checks = 1;

-- 4- Modificar tres productos en su nombre y proveedor

update producto set nombre = 'Helado', Proveedor_idProveedor = 2 where idProducto = 1;
update producto set nombre = 'Aceite', Proveedor_idProveedor = 3 where idProducto = 5;
update producto set nombre = 'Leche', Proveedor_idProveedor = 1 where idProducto = 7;
select * from producto;    

    
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;