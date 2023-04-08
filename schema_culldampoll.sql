#CREA BASE DE DATOS Y DISEÑO#
CREATE DATABASE CULLDEAMPOLL;

CREATE TABLE IF NOT EXISTS `CULLDEAMPOLL`.`Proveedores` (
  `idProveedores` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` INT NULL,
  `Fax` INT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProveedores`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `CULLDEAMPOLL`.`Direccion` (
  `idProveedores` INT NOT NULL,
  `Calle` VARCHAR(45) NOT NULL,
  `Numero` VARCHAR(45) NOT NULL,
  `Piso` INT NOT NULL,
  `Puerta` INT NOT NULL,
  `Ciudad` VARCHAR(45) NOT NULL DEFAULT 'Barcelona',
  `CP` INT NOT NULL,
  `Pais` VARCHAR(45) NULL DEFAULT 'Spain',
  UNIQUE INDEX `Pais_UNIQUE` (`Pais` ASC) VISIBLE,
  UNIQUE INDEX `Ciudad_UNIQUE` (`Ciudad` ASC) VISIBLE,
  INDEX `fk_direccion_idx` (`idProveedores` ASC) VISIBLE,
  PRIMARY KEY (`idProveedores`),
  CONSTRAINT `fk_direccion`
    FOREIGN KEY (`idProveedores`)
    REFERENCES `CULLDEAMPOLL`.`Proveedores` (`idProveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `CULLDEAMPOLL`.`Marca` (
  `Marca` VARCHAR(45) NOT NULL,
  `idProveedores` INT NOT NULL,
  PRIMARY KEY (`Marca`),
  INDEX `fk_Marca_Proveedores1_idx` (`idProveedores` ASC) VISIBLE,
  CONSTRAINT `fk_Marca_Proveedores1`
    FOREIGN KEY (`idProveedores`)
    REFERENCES `CULLDEAMPOLL`.`Proveedores` (`idProveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `CULLDEAMPOLL`.`Empleados` (
  `idEmpleados` INT NOT NULL,
  `NombreEmpleado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmpleados`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `CULLDEAMPOLL`.`Gafas` (
  `idGafas` INT NOT NULL AUTO_INCREMENT,
  `Marca` VARCHAR(45) NOT NULL,
  `Graduacion` FLOAT NULL,
  `TipoMontura` VARCHAR(45) NULL,
  `ColorMontura` VARCHAR(45) NULL,
  `ColorVidrio` VARCHAR(45) NULL,
  `Precio` FLOAT NOT NULL,
  `idEmpleado` INT NULL,
  PRIMARY KEY (`idGafas`),
  INDEX `fk_Marca_idx` (`Marca` ASC) VISIBLE,
  INDEX `fk_Empleado_idx` (`idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Marca`
    FOREIGN KEY (`Marca`)
    REFERENCES `CULLDEAMPOLL`.`Marca` (`Marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `CULLDEAMPOLL`.`Empleados` (`idEmpleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `CULLDEAMPOLL`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `CP` INT NULL,
  `Telefono` INT NULL,
  `CorreoElectronico` VARCHAR(45) NULL,
  `FechaRegistro` DATE NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `CULLDEAMPOLL`.`Referidos` (
  `Recomendador` INT NOT NULL,
  `Recomendado` INT NOT NULL,
  PRIMARY KEY (`Recomendador`, `Recomendado`),
  INDEX `fk_Recomendado_idx` (`Recomendado` ASC) VISIBLE,
  CONSTRAINT `fk_Recomendador`
    FOREIGN KEY (`Recomendador`)
    REFERENCES `CULLDEAMPOLL`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recomendado`
    FOREIGN KEY (`Recomendado`)
    REFERENCES `CULLDEAMPOLL`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

#CARGA DE DATOS#
INSERT INTO `CULLDEAMPOLL`.`Proveedores` (`idProveedores`, `Nombre`, `Telefono`, `Fax`, `NIF`) 
VALUES (DEFAULT, 'Mariano', NULL, NULL, 'Y833423R'), 
(DEFAULT, 'Pilar', NULL, NULL, 'F1234563E'), 
(DEFAULT, 'Victoria', NULL, NULL, 'V564758W'), 
(DEFAULT, 'Ignacio', NULL, NULL, 'I9898973J');

INSERT INTO `CULLDEAMPOLL`.`Direccion` (`idProveedores`, `Calle`, `Numero`, `Piso`, `Puerta`, `Ciudad`, `CP`, `Pais`) 
VALUES (2, 'Ausias Marc', 12, 1, 2, 'Barcelona', 08013, 'Espana'),
(1, 'Mallorca', 45, 4, 2, 'Barcelona', 08012, 'Espana'),
(3, 'Casp', 22, 3, 5, 'Barcelona', 0801, 'Espana'),
(4, 'Ausias Marc', 88, 1, 2, 'Barcelona', 08013, 'Espana');

INSERT INTO `CULLDEAMPOLL`.`Marca` (`Marca`, `idProveedores`) 
VALUES ('Oneil', 1),
('Rayban', 2),
('Reef', 1);

INSERT INTO `CULLDEAMPOLL`.`Gafas` (`idGafas`, `Marca`, `Graduacion`, `TipoMontura`, `ColorMontura`, `ColorVidrio`, `Precio`, `idEmpleado`) 
VALUES (DEFAULT, 'Oneil', NULL, NULL, NULL, 'Negro', 120, 1),
(DEFAULT, 'Oneil', NULL, NULL, NULL, 'Transparente', 145.5, 2),
(DEFAULT, 'Reef', NULL, NULL, NULL, 'Amarillo', 80, 1),
(DEFAULT, 'Rayban', NULL, NULL, NULL, 'Negro', 220, NULL);

INSERT INTO `CULLDEAMPOLL`.`Empleados` (`idEmpleados`, `NombreEmpleado`)
VALUES (1, 'Ferran'),
(2, 'Mateo');

INSERT INTO `CULLDEAMPOLL`.`Clientes` (`idClientes`, `Nombre`, `CP`, `Telefono`, `CorreoElectronico`, `FechaRegistro`)
VALUES (DEFAULT, 'Pol', NULL, NULL, NULL, NULL),
(DEFAULT, 'Juan', NULL, NULL, NULL, NULL),
(DEFAULT, 'Lluisa', NULL, NULL, NULL, NULL),
(DEFAULT, 'Merce', NULL, NULL, NULL, NULL);

INSERT INTO `CULLDEAMPOLL`.`Referidos` (`Recomendador`, `Recomendado`) 
VALUES (1, 2),
(1, 3),
(4, 1);

#MOSTRAMOS REGISTROS DE UNA FORMA LOGICA Y ORDENADA#

SELECT proveedores.idProveedores, proveedores.Nombre, proveedores.Telefono,
proveedores.Fax, proveedores.NIF, direccion.Calle, direccion.Numero, 
direccion.Piso, direccion.Puerta, direccion.Ciudad, direccion.CP, direccion.Pais 
FROM proveedores
JOIN direccion ON proveedores.idProveedores=direccion.idProveedores;

SELECT gafas.idGafas, marca.Marca, gafas.Graduacion, gafas.TipoMontura, 
gafas.ColorMontura, gafas.ColorVidrio, gafas.precio, empleados.NombreEmpleado AS 'Nombre vendedor', 
marca.idProveedores, proveedores.Nombre AS 'Nombre proveedor'
FROM gafas
LEFT JOIN empleados ON gafas.idEmpleado=empleados.idEmpleados
LEFT JOIN marca ON gafas.marca = marca.Marca
LEFT JOIN proveedores ON proveedores.idProveedores=marca.idProveedores;

SELECT clientes.idClientes, clientes.nombre, referidos.recomendador AS 'Recomendado por:' FROM clientes
LEFT JOIN referidos ON clientes.idClientes = referidos.Recomendado;
