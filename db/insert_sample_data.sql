USE bioinventory_db;

-- Insertar proveedores solo si no existen
INSERT INTO proveedores (nombre, contacto, telefono, email)
SELECT * FROM (
    SELECT 'Proveedor A', 'Juan Pérez', '1234567890', 'a@example.com'
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM proveedores WHERE nombre = 'Proveedor A'
);

INSERT INTO proveedores (nombre, contacto, telefono, email)
SELECT * FROM (
    SELECT 'Proveedor B', 'Laura Gómez', '0987654321', 'b@example.com'
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM proveedores WHERE nombre = 'Proveedor B'
);

-- Insertar insumos solo si no existen (sin categoría por ahora)
INSERT INTO insumos (nombre, descripcion, cantidad, unidad_medida, proveedor_id)
SELECT * FROM (
    SELECT 'Guantes de látex', 'Guantes desechables', 100, 'cajas',
           (SELECT id FROM proveedores WHERE nombre = 'Proveedor A')
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM insumos WHERE nombre = 'Guantes de látex'
);

INSERT INTO insumos (nombre, descripcion, cantidad, unidad_medida, proveedor_id)
SELECT * FROM (
    SELECT 'Alcohol en gel', 'Botellas de alcohol al 70%', 50, 'botellas',
           (SELECT id FROM proveedores WHERE nombre = 'Proveedor B')
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM insumos WHERE nombre = 'Alcohol en gel'
);

-- Insertar movimientos si no existen
INSERT INTO movimientos (id_insumo, tipo, cantidad, fecha, descripcion)
SELECT * FROM (
    SELECT 
        (SELECT id FROM insumos WHERE nombre = 'Guantes de látex'),
        'ingreso',
        50,
        CURDATE(),
        'Ingreso inicial de guantes'
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM movimientos 
    WHERE id_insumo = (SELECT id FROM insumos WHERE nombre = 'Guantes de látex')
      AND tipo = 'ingreso'
      AND fecha = CURDATE()
);

INSERT INTO movimientos (id_insumo, tipo, cantidad, fecha, descripcion)
SELECT * FROM (
    SELECT 
        (SELECT id FROM insumos WHERE nombre = 'Alcohol en gel'),
        'salida',
        10,
        CURDATE(),
        'Salida por consumo interno de alcohol'
) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM movimientos 
    WHERE id_insumo = (SELECT id FROM insumos WHERE nombre = 'Alcohol en gel')
      AND tipo = 'salida'
      AND fecha = CURDATE()
);
