--Subconsultas

-- Obtener los productos cuyo precio unitario sea mayor al precio promedio de la tabla de productos
SELECT * FROM products WHERE unit_price > (SELECT AVG(unit_price) FROM products );
-- Obtener los productos cuya cantidad en stock sea menor al promedio de cantidad en stock de toda la tabla de productos.
SELECT * FROM products WHERE units_in_stock < (SELECT AVG(units_in_stock) FROM products);
-- Obtener los productos cuya cantidad en Inventario (UnitsInStock) sea menor a la cantidad mínima del detalle de ordenes (Order Details)
SELECT * FROM products WHERE units_in_stock < (SELECT min(quantity) FROM order_details);
--OBTENER LOS PRODUCTOS CUYA CATEGORIA SEA IGUAL A LAS CATEGORIAS DE LOS PRODUCTOS CON PROVEEDOR 1.
SELECT * FROM products WHERE category IN (SELECT category FROM products WHERE supplier_id = 1 );

-- Subconsultas correlacionadas 

--Obtener el número de empleado y el apellido para aquellos empleados que tengan menos de 100 ordenes.
SELECT  E.employee_id, E.last_name 
FROM employees E 
WHERE 100 > (SELECT COUNT(O.order_id) FROM orders O WHERE E.employee_id = O.employee_id );
--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes
SELECT C.customer_id, company_name 
FROM customers C 
WHERE 20 < (SELECT COUNT(O.order_id) 
            FROM orders O 
            WHERE C.customer_id = O.customer_id);
--Obtener el productoid, el nombre del producto, el proveedor de la tabla de productos para aquellos productos que se hayan vendido menos de 
--100 unidades (Consultarlo en la tabla de Orders details).
SELECT P.product_id, P.product_name, P.supplier_id FROM products P WHERE 100 > (SELECT SUM(OD.quantity) FROM order_details OD WHERE P.product_id = OD.product_id GROUP BY OD.product_id );
--Obtener los datos del empleado IDEmpleado y nombre completo De aquellos que tengan mas de 100 ordenes
SELECT  E.employee_id,CONCAT( E.first_name,' ',E.last_name) 
FROM employees E 
WHERE 100 < (SELECT COUNT(O.order_id) FROM orders O WHERE E.employee_id = O.employee_id );
--Obtener los datos de Producto ProductId, ProductName, UnitsinStock, UnitPrice (Tabla Products) de los productos que la sumatoria de 
--la cantidad (Quantity) de orders details sea mayor a 450
SELECT P.product_id, P.product_name, P.units_in_stock, P.unit_price 
FROM products P 
WHERE 450< (SELECT SUM(OD.quantity) 
            FROM order_details OD 
            WHERE P.product_id = OD.product_id 
            GROUP BY OD.product_id);
--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes.
SELECT C.customer_id, C.company_name 
FROM customers C 
WHERE  20 < (SELECT COUNT(O.order_id) 
            FROM orders O 
            WHERE C.customer_id = O.customer_id );


--insert

--Insertar un registro en la tabla de Categorias, únicamente se quiere insertar la información del CategoryName y la descripción los
-- Papelería y papelería escolar
INSERT INTO categories (category_id,category_name, description) VALUES (10000,'Papelería', 'Papelería escolar');

--Dar de alta un producto con Productname, SupplierId, CategoryId, UnitPrice, UnitsInStock Como esta tabla tiene dos clave 
--foraneas hay que ver los datos a dar de alta
INSERT INTO products (product_id,product_name, supplier_id, category_id, unit_price, units_in_stock, discontinued) VALUES (10000,'Folios A4', 1, 1, 10, 10,0);

--Dar de alta un empleado con LastName, FistName, Title, BrithDate
INSERT INTO employees (last_name, first_name, title, birth_date) VALUES ('Garcia', 'Juan', 'Jefe de ventas', '1990-01-01');
--Dar de alta una orden, CustomerId, Employeeid, Orderdate, ShipVia Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
INSERT INTO orders (order_id,customer_id, employee_id, order_date, ship_via) VALUES (10000,'ALFKI', 1, '2020-01-01', 1);
--Dar de alta un Order details, con todos los datos
INSERT INTO order_details (order_id,product_id, unit_price, quantity, discount) VALUES (10000,1, 10, 10, 0.1);

--update

-- Cambiar el CategoryName a Verduras de la categoria 10
UPDATE categories SET category_name = 'Verduras' WHERE category_id = 10;
-- Actualizar los precios de la tabla de Productos para incrementarlos un 10%
UPDATE products SET unit_price = unit_price * 1.1;
--ACTUALIZAR EL PRODUCTNAME DEL PRODUCTO 80 A ZANAHORIA ECOLOGICA
UPDATE products SET product_name = 'Zanahoria ecologica' WHERE product_id = 80;
--ACTUALIZAR EL FIRSTNAME DEL EMPLOYEE 10 A ROSARIO 
UPDATE employees SET first_name = 'Rosario' WHERE employee_id = 10;
--ACTUALIZAR EL ORDERS DETAILS DE LA 11079 PARA QUE SU CANTIDAD SEA 10
UPDATE order_details SET quantity = 10 WHERE order_id = 11079;

--Delete

--diferencia entre delete y truncate
--DELETE: Elimina los registros de una tabla, pero no elimina la tabla.
--TRUNCATE: Elimina los registros de una tabla, pero no elimina la tabla. Además, resetea el valor de los identificadores de la tabla.
--BORRAR EL EMPLEADO 10
DELETE FROM employees WHERE employee_id = 10;


