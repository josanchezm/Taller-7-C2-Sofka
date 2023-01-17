use mydb;
-- 1- Consulta SQL donde pueda obtener los productos vendidos digitando tipo de documento y número de documento
select p.Nombre, p.Precio, f.Cantidad as Unidades_Compradas, f.Cliente_Tipo_Documento, f.Cliente_Numero_Documento from producto p 
right join factura f on p.idProducto = f.Producto_idProducto
where f.Cliente_Tipo_Documento = 'Tarjeta de identidad' and f.Cliente_Numero_Documento = 1032 
or f.Cliente_Tipo_Documento = 'Cedula' and f.Cliente_Numero_Documento = 1020;

-- 2- Consultar productos por medio del nombre, el cual debe mostrar quien o quienes han sido sus proveedores.
select p.Nombre as Nombre_Producto, p.Precio as Precio_Producto, pr.Nombre as Nombre_Proveedor, pr.Telefono as Telefono_Proveedor from producto p 
right join proveedor pr on p.Proveedor_idProveedor = pr.idProveedor
where p.Nombre = 'Cereal' or p.Nombre = 'Helado';

-- 3- PLUS: Crear una consulta que me permita ver qué producto ha sido el más vendido (por factura) y en qué cantidades de mayor a menor.
select p.Nombre as Nombre_Producto, p.Precio as Precio_Producto, f.Cantidad as Unidades_Vendidas, f.Total as Total_Vendido from producto p
right join factura f on p.idProducto = f.Producto_idProducto order by f.Cantidad desc;

