#CREAMOS BASE DE DATOS#
CREATE DATABASE pizzeria_Script2;

#CREAMOS TABLAS#
CREATE TABLE IF NOT EXISTS `pizzeria_Script2`.`Categoria` (
  `idCategoria` INT NOT NULL,
  `nombreCategoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `pizzeria_Script2`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `CP` INT NOT NULL,
  `Localidad` VARCHAR(45) NOT NULL,
  `Provincia` VARCHAR(45) NOT NULL,
  `Tel` INT NOT NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `pizzeria_Script2`.`Empleados` (
  `idEmpleados` INT NOT NULL AUTO_INCREMENT,
  `idTiendas` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `NIF` INT NULL,
  `Tel` INT NULL,
  `Puesto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmpleados`, `idTiendas`),
  INDEX `fk_empkeados_tienda_idx` (`idTiendas` ASC) VISIBLE,
  CONSTRAINT `fk_empkeados_tienda`
    FOREIGN KEY (`idTiendas`)
    REFERENCES `pizzeria_Script2`.`Tiendas` (`idTiendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `pizzeria_Script2`.`EntregaPedidos` (
  `idPedidos` INT NOT NULL,
  `idEmpleado` INT NOT NULL,
  `HoraEntrega` DATETIME NOT NULL,
  INDEX `id_empleado_idx` (`idEmpleado` ASC) VISIBLE,
  PRIMARY KEY (`idPedidos`, `idEmpleado`),
  CONSTRAINT `id_empleado`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `pizzeria_Script2`.`Empleados` (`idEmpleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EntregaPedidos_Pedidos1`
    FOREIGN KEY (`idPedidos`)
    REFERENCES `pizzeria_Script2`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `pizzeria_Script2`.`Pedidos` (
  `idPedidos` INT NOT NULL AUTO_INCREMENT,
  `idClientes` INT NOT NULL,
  `idTienda` INT NOT NULL,
  `HoraEntrada` DATETIME NOT NULL,
  `TipoEntrega` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPedidos`, `idClientes`, `idTienda`),
  INDEX `fk_clientes_idx` (`idClientes` ASC) VISIBLE,
  INDEX `fk_tienda_idx` (`idTienda` ASC) VISIBLE,
  CONSTRAINT `fk_clientes`
    FOREIGN KEY (`idClientes`)
    REFERENCES `pizzeria_Script2`.`Clientes` (`idClientes`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_tienda`
    FOREIGN KEY (`idTienda`)
    REFERENCES `pizzeria_Script2`.`Tiendas` (`idTiendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `pizzeria_Script2`.`Productos` (
  `idProductos` INT NOT NULL ,
  `idTipoProducto` INT NOT NULL,
  `idCategoria` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Imagen` TINYINT NULL,
  `Precio` FLOAT NOT NULL,
  PRIMARY KEY (`idProductos`, `idTipoProducto`, `idCategoria`),
  INDEX `fk_categoria_idx` (`idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_categoria`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `pizzeria_Script2`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_TipoProducto1`
    FOREIGN KEY (`idTipoProducto`)
    REFERENCES `pizzeria_Script2`.`TipoProducto` (`idTipoProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `pizzeria_Script2`.`ProductosSeleccionados` (
  `idPedidos` INT NOT NULL,
  `idProducto` INT NOT NULL,
  INDEX `fk_pedidos_idx` (`idPedidos` ASC) VISIBLE,
  INDEX `fk_productos_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos`
    FOREIGN KEY (`idPedidos`)
    REFERENCES `pizzeria_Script2`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos`
    FOREIGN KEY (`idProducto`)
    REFERENCES `pizzeria_Script2`.`Productos` (`idProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `pizzeria_Script2`.`Tiendas` (
  `idTiendas` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NULL,
  `CP` INT NULL,
  `Localidad` VARCHAR(45) NULL,
  `Provincia` VARCHAR(45) NULL,
  PRIMARY KEY (`idTiendas`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `pizzeria_Script2`.`TipoProducto` (
  `idTipoProducto` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoProducto`))
ENGINE = InnoDB;

#CARGAMOS TABLAS#
INSERT INTO `pizzeria_Script2`.`TipoProducto` (`idTipoProducto`, `Tipo`) 
VALUES (1, 'Pizza'),
(2, 'Hmaburguesa'),
(3, 'Bocatas'),
(4, 'Bebidas');

INSERT INTO `pizzeria_Script2`.`Categoria` (`idCategoria`, `nombreCategoria`)
VALUES (1, 'Clasicas'),
(2, 'Gourmet'),
(3, 'Sin TAAC'),
(4, 'Blancas'),
(99, 'Sin categoria');

INSERT INTO `pizzeria_Script2`.`Productos` (`idProductos`, `idTipoProducto`, `idCategoria`, `Nombre`, `Descripcion`, `Imagen`, `Precio`)
VALUES (1, 1, 1, 'Margarita', NULL, NULL, 7),
(2, 1, 2, 'Bufala', NULL, NULL, 10),
(3, 1, 2, 'Noci e funghi', NULL, NULL, 15),
(4, 2, 99, 'Completa', NULL, NULL, 8),
(5, 2, 99, 'Veggie', NULL, NULL, 7),
(6, 3, 99, 'Jamon serrano', NULL, NULL, 4),
(7, 4, 99, 'Cerveza', NULL, NULL, 3.5),
(8, 4, 99, 'Agua', NULL, NULL, 1.5);

INSERT INTO `pizzeria_Script2`.`ProductosSeleccionados` (`idPedidos`, `idProducto`) 
VALUES (1, 2),
(1, 4),
(1, 7),
(1, 7),
(2, 1),
(2, 8),
(3, 6);

INSERT INTO `pizzeria_Script2`.`Tiendas` (`idTiendas`, `Nombre`, `Direccion`, `CP`, `Localidad`, `Provincia`) 
VALUES (DEFAULT, 'Pizzaria Napols', 'Ample 22', 08012, 'Barcelona', 'Barcelona'),
(DEFAULT, 'Pizzaria antica', 'Layetana 52', 08012, 'Barcelona', 'Barcelona'),
(DEFAULT, 'Pizzaria BCN', 'Enric granados 210', 08016, 'Barcelona', 'Barcelona');

INSERT INTO `pizzeria_Script2`.`Empleados` (`idEmpleados`, `idTiendas`, `Nombre`, `Apellido`, `NIF`, `Tel`, `Puesto`) 
VALUES (DEFAULT, 2, 'Francisco', 'Rodriguez', NULL, NULL, 'Cheff'),
(DEFAULT, 2, 'Oscar', 'Gutierrez', NULL, NULL, 'Repartidor'),
(DEFAULT, 2, 'Juan', 'Garcia', NULL, NULL, 'Camarero'),
(DEFAULT, 1, 'Lautaro', 'Rodriguez', NULL, NULL, 'Cheff'),
(DEFAULT, 1, 'Ignacio', 'Gamarra', NULL, NULL, 'Camarero');

INSERT INTO `pizzeria_Script2`.`EntregaPedidos` (`idPedidos`, `idEmpleado`, `HoraEntrega`) 
VALUES (1, 2, '2023-01-01 22:20:00');

INSERT INTO `pizzeria_Script2`.`Pedidos` (`idPedidos`, `idClientes`, `idTienda`, `HoraEntrada`, `TipoEntrega`) 
VALUES (DEFAULT, 1, 2, '2023-01-01 22:00:00', 'Domicilio'),
(DEFAULT, 2, 1, '2023-01-01 22:32:00', 'Tienda'),
(DEFAULT, 3, 1, '2023-01-01 22:46:00', 'Tienda');

INSERT INTO `pizzeria_Script2`.`Clientes` (`idClientes`, `Nombre`, `Apellido`, `Direccion`, `CP`, `Localidad`, `Provincia`, `Tel`) 
VALUES (DEFAULT, 'Mariano', 'Magri', 'Ausias Marc 20 3-1', 08013, 'Barcelona', 'Barcelona', 657569989),
(DEFAULT, 'Alicia', 'Martinez', 'Ausias Marc 33 2-2', 08013, 'Barcelona', 'Barcelona', 657333233),
(DEFAULT, 'Ricardo', 'Mollo', 'Casp 56 1-1', 08013, 'Barcelona', 'Barcelona', 657532219);

#QUERIES#
#Prodcutos por pedido#

SELECT ps.idPedidos, productos.idtipoproducto, productos.nombre, pedidos.idClientes, pedidos.idTienda, pedidos.HoraEntrada, pedidos.TipoEntrega 
FROM pedidos
RIGHT JOIN productosSeleccionados AS ps ON ps.idPedidos = pedidos.idpedidos
JOIN productos ON ps.idProducto = productos.idProductos;

#Precio total por pedido#
SELECT ps.idpedidos, SUM(productos.precio) AS 'PrecioTotalPedido'
FROM productosseleccionados AS ps
JOIN productos ON ps.idProducto = productos.idProductos
GROUP BY ps.idPedidos;

#Entregas de pedidos#
SELECT pedidos.idpedidos, clientes.idClientes, clientes.Direccion AS 'Direccion de entrega', empleados.nombre, empleados.Apellido, empleados.Puesto, pedidos.HoraEntrada, ep.HoraEntrega, pedidos.TipoEntrega
FROM pedidos
JOIN entregapedidos AS ep ON ep.idPedidos = pedidos.idPedidos
JOIN empleados ON empleados.idEmpleados = ep.idEmpleado
JOIN clientes ON pedidos.idClientes = clientes.idClientes;

#MENU#
SELECT p.idProductos, tp.tipo, categoria.nombreCategoria, p.nombre, p.descripcion, p.imagen, p.precio 
FROM productos AS p
JOIN tipoproducto AS tp ON tp.idTipoProducto = p.idTipoProducto
JOIN categoria ON categoria.idcategoria = p.idCategoria;

