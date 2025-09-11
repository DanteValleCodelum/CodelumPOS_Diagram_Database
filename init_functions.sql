-- =========================================
-- USER SYSTEM
-- =========================================
--Obtener todos los usuarios (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_user_system()
RETURNS TABLE (
    id           UUID,
    username     VARCHAR,
    password     VARCHAR,
    role_id      UUID,
    employee_id  UUID,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, username, password, role_id, employee_id, is_deleted, created_at, updated_at
    FROM user_system;
END;
$$;
-- Obtener un usuario por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_user_system_by_id(
    _id UUID
)
RETURNS TABLE (
    id           UUID,
    username     VARCHAR,
    password     VARCHAR,
    role_id      UUID,
    employee_id  UUID,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, username, password, role_id, employee_id, is_deleted, created_at, updated_at
    FROM user_system
    WHERE id = _id;
END;
$$;
-- Obtener usuarios según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_user_systems_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id           UUID,
    username     VARCHAR,
    password     VARCHAR,
    role_id      UUID,
    employee_id  UUID,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, username, password, role_id, employee_id, is_deleted, created_at, updated_at
    FROM user_system
    WHERE is_deleted = _is_deleted;
END;
$$;

-- ========================================
-- FUNCIONES: ROLE
-- ========================================
-- Obtener todos los roles (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_roles()
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, is_deleted, created_at, updated_at
    FROM role;
END;
$$;
-- Obtener un rol por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_role_by_id(
    _id UUID
)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, is_deleted, created_at, updated_at
    FROM role
    WHERE id = _id;
END;
$$;
-- Obtener roles según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_roles_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, is_deleted, created_at, updated_at
    FROM role
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- PERMISSION
-- =========================================
-- Obtener todos los permisos (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_permissions()
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    description VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM permission;
END;
$$;
-- Obtener un permiso por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_permission_by_id(
    _id UUID
)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    description VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM permission
    WHERE id = _id;
END;
$$;
-- Obtener permisos según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_permissions_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    description VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM permission
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- SHIFT
-- =========================================
-- Obtener todos los turnos (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_shifts()
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    start_time   TIMESTAMP,
    end_time     TIMESTAMP,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, start_time, end_time, is_deleted, created_at, updated_at
    FROM shift;
END;
$$;
-- Obtener un turno por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_shift_by_id(
    _id UUID
)
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    start_time   TIMESTAMP,
    end_time     TIMESTAMP,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, start_time, end_time, is_deleted, created_at, updated_at
    FROM shift
    WHERE id = _id;
END;
$$;
-- Obtener turnos según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_shifts_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    start_time   TIMESTAMP,
    end_time     TIMESTAMP,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, start_time, end_time, is_deleted, created_at, updated_at
    FROM shift
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- EMPLOYEE
-- =========================================
-- Obtener todos los empleados (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_employees()
RETURNS TABLE (
    id           UUID,
    first_name   VARCHAR,
    last_name    VARCHAR,
    phone        VARCHAR,
    start_date   TIMESTAMP,
    end_date     TIMESTAMP,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, first_name, last_name, phone, start_date, end_date, is_deleted, created_at, updated_at
    FROM employee;
END;
$$;
-- Obtener un empleado por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_employee_by_id(
    _id UUID
)
RETURNS TABLE (
    id           UUID,
    first_name   VARCHAR,
    last_name    VARCHAR,
    phone        VARCHAR,
    start_date   TIMESTAMP,
    end_date     TIMESTAMP,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, first_name, last_name, phone, start_date, end_date, is_deleted, created_at, updated_at
    FROM employee
    WHERE id = _id;
END;
$$;
-- Obtener empleados según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_employees_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id           UUID,
    first_name   VARCHAR,
    last_name    VARCHAR,
    phone        VARCHAR,
    start_date   TIMESTAMP,
    end_date     TIMESTAMP,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, first_name, last_name, phone, start_date, end_date, is_deleted, created_at, updated_at
    FROM employee
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- BRANCH
-- =========================================
-- Obtener todas las sucursales (tanto eliminadas como no eliminadas)
CREATE OR REPLACE FUNCTION fn_get_all_branches()
RETURNS TABLE (
    id         UUID,
    name       VARCHAR,
    country    VARCHAR,
    city       VARCHAR,
    address    VARCHAR,
    phone      VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, country, city, address, phone, is_deleted, created_at, updated_at
    FROM branch;
END;
$$;
-- Obtener una sucursal por su ID (sin importar si está eliminada o no)
CREATE OR REPLACE FUNCTION fn_get_branch_by_id(
    _id UUID
)
RETURNS TABLE (
    id         UUID,
    name       VARCHAR,
    country    VARCHAR,
    city       VARCHAR,
    address    VARCHAR,
    phone      VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, country, city, address, phone, is_deleted, created_at, updated_at
    FROM branch
    WHERE id = _id;
END;
$$;
-- Obtener sucursales según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_branches_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id         UUID,
    name       VARCHAR,
    country    VARCHAR,
    city       VARCHAR,
    address    VARCHAR,
    phone      VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, country, city, address, phone, is_deleted, created_at, updated_at
    FROM branch
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- POS
-- =========================================
-- Obtener todos los puntos de venta (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_pos()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$BEGIN
    RETURN QUERY
    SELECT id, name, branch_id, is_deleted, created_at, updated_at
    FROM pos;
END;$$;
-- Obtener un punto de venta por su ID
CREATE OR REPLACE FUNCTION fn_get_pos_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$BEGIN
    RETURN QUERY
    SELECT id, name, branch_id, is_deleted, created_at, updated_at
    FROM pos
    WHERE id = _id;
END;$$;
-- Obtener puntos de venta según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_pos_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$BEGIN
    RETURN QUERY
    SELECT id, name, branch_id, is_deleted, created_at, updated_at
    FROM pos
    WHERE is_deleted = _is_deleted;
END;$$;
-- Obtener puntos de venta por ID de sucursal
CREATE OR REPLACE FUNCTION fn_get_pos_by_branch_id(_branch_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$BEGIN
    RETURN QUERY
    SELECT id, name, branch_id, is_deleted, created_at, updated_at
    FROM pos
    WHERE branch_id = _branch_id;
END;$$;

-- =========================================
-- TABLE_RESTAURANT
-- =========================================
-- Obtener todas las mesas (tanto eliminadas como no eliminadas)
CREATE OR REPLACE FUNCTION fn_get_all_table_restaurant()
RETURNS TABLE (
    id UUID,
    number INT,
    capacity INT,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, number, capacity, is_deleted, created_at, updated_at
    FROM table_restaurant;
END;
$$;
-- Obtener una mesa por ID (sin importar si está eliminada o no)
CREATE OR REPLACE FUNCTION fn_get_table_restaurant_by_id(
    _id UUID
)
RETURNS TABLE (
    id UUID,
    number INT,
    capacity INT,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, number, capacity, is_deleted, created_at, updated_at
    FROM table_restaurant
    WHERE id = _id;
END;
$$;
-- Obtener mesas según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_table_restaurants_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id UUID,
    number INT,
    capacity INT,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, number, capacity, is_deleted, created_at, updated_at
    FROM table_restaurant
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- RESERVATION
-- =========================================
-- Obtener todas las reservaciones (tanto eliminadas como no eliminadas)
CREATE OR REPLACE FUNCTION fn_get_all_reservations()
RETURNS TABLE (
    id                 UUID,
    customer_id        UUID,
    table_id           UUID,
    reservation_date   TIMESTAMP,
    number_of_people   INT,
    note               VARCHAR,
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, table_id, reservation_date, number_of_people, note, status, is_deleted, created_at, updated_at
      FROM reservation;
END;
$$;
-- Obtener una reservación por su ID (sin importar si está eliminada o no)
CREATE OR REPLACE FUNCTION fn_get_reservation_by_id(_id UUID)
RETURNS TABLE (
    id                 UUID,
    customer_id        UUID,
    table_id           UUID,
    reservation_date   TIMESTAMP,
    number_of_people   INT,
    note               VARCHAR,
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, table_id, reservation_date, number_of_people, note, status, is_deleted, created_at, updated_at
      FROM reservation
     WHERE id = _id;
END;
$$;
-- Obtener reservaciones según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_reservations_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id                 UUID,
    customer_id        UUID,
    table_id           UUID,
    reservation_date   TIMESTAMP,
    number_of_people   INT,
    note               VARCHAR,
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, table_id, reservation_date, number_of_people, note, status, is_deleted, created_at, updated_at
      FROM reservation
     WHERE is_deleted = _is_deleted;
END;
$$;
-- Obtener reservaciones en un rango de fecha de reserva
CREATE OR REPLACE FUNCTION fn_get_reservations_by_date_range(_start TIMESTAMP, _end TIMESTAMP)
RETURNS TABLE (
    id                 UUID,
    customer_id        UUID,
    table_id           UUID,
    reservation_date   TIMESTAMP,
    number_of_people   INT,
    note               VARCHAR,
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, table_id, reservation_date, number_of_people, note, status, is_deleted, created_at, updated_at
      FROM reservation
     WHERE reservation_date BETWEEN _start AND _end
     ORDER BY reservation_date;
END;
$$;
-- Obtener reservaciones por ID de mesa
CREATE OR REPLACE FUNCTION fn_get_reservations_by_table_id(_table_id UUID)
RETURNS TABLE (
    id                 UUID,
    customer_id        UUID,
    table_id           UUID,
    reservation_date   TIMESTAMP,
    number_of_people   INT,
    note               VARCHAR,
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, table_id, reservation_date, number_of_people, note, status, is_deleted, created_at, updated_at
      FROM reservation
     WHERE table_id = _table_id
     ORDER BY reservation_date;
END;
$$;
-- Obtener reservaciones por ID de cliente
CREATE OR REPLACE FUNCTION fn_get_reservations_by_customer_id(_customer_id UUID)
RETURNS TABLE (
    id                 UUID,
    customer_id        UUID,
    table_id           UUID,
    reservation_date   TIMESTAMP,
    number_of_people   INT,
    note               VARCHAR,
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, table_id, reservation_date, number_of_people, note, status, is_deleted, created_at, updated_at
      FROM reservation
     WHERE customer_id = _customer_id
     ORDER BY reservation_date;
END;
$$;

-- =========================================
-- SALE
-- =========================================
-- Obtener todas las ventas (tanto eliminadas como no eliminadas)
CREATE OR REPLACE FUNCTION fn_get_all_sales()
RETURNS TABLE (
    id                UUID,
    sale_date         TIMESTAMP,
    employee_id       UUID,
    total             DECIMAL,
    customer_id       UUID,
    receipt_type_id   UUID,
    payment_method_id UUID,
    sales_channel_id  UUID,
    pos_id            UUID,
    sale_condition_id UUID,
    discount_id       UUID,
    credit_term       VARCHAR,
    tax_id            UUID,
    is_deleted        BOOLEAN,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_date, employee_id, total, customer_id,
           receipt_type_id, payment_method_id, sales_channel_id,
           pos_id, sale_condition_id, discount_id, credit_term,
           tax_id, is_deleted, created_at, updated_at
    FROM sale;
END;
$$;
-- Obtener una venta por su ID (sin importar si está eliminada o no)
CREATE OR REPLACE FUNCTION fn_get_sale_by_id(_id UUID)
RETURNS TABLE (
    id                UUID,
    sale_date         TIMESTAMP,
    employee_id       UUID,
    total             DECIMAL,
    customer_id       UUID,
    receipt_type_id   UUID,
    payment_method_id UUID,
    sales_channel_id  UUID,
    pos_id            UUID,
    sale_condition_id UUID,
    discount_id       UUID,
    credit_term       VARCHAR,
    tax_id            UUID,
    is_deleted        BOOLEAN,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_date, employee_id, total, customer_id,
           receipt_type_id, payment_method_id, sales_channel_id,
           pos_id, sale_condition_id, discount_id, credit_term,
           tax_id, is_deleted, created_at, updated_at
    FROM sale
    WHERE id = _id;
END;
$$;
-- Obtener ventas según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_sales_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id                UUID,
    sale_date         TIMESTAMP,
    employee_id       UUID,
    total             DECIMAL,
    customer_id       UUID,
    receipt_type_id   UUID,
    payment_method_id UUID,
    sales_channel_id  UUID,
    pos_id            UUID,
    sale_condition_id UUID,
    discount_id       UUID,
    credit_term       VARCHAR,
    tax_id            UUID,
    is_deleted        BOOLEAN,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_date, employee_id, total, customer_id,
           receipt_type_id, payment_method_id, sales_channel_id,
           pos_id, sale_condition_id, discount_id, credit_term,
           tax_id, is_deleted, created_at, updated_at
    FROM sale
    WHERE is_deleted = _is_deleted;
END;
$$;
-- Obtener ventas en un rango de fechas
CREATE OR REPLACE FUNCTION fn_get_sales_by_date_range(_start TIMESTAMP, _end TIMESTAMP)
RETURNS TABLE (
    id                UUID,
    sale_date         TIMESTAMP,
    employee_id       UUID,
    total             DECIMAL,
    customer_id       UUID,
    receipt_type_id   UUID,
    payment_method_id UUID,
    sales_channel_id  UUID,
    pos_id            UUID,
    sale_condition_id UUID,
    discount_id       UUID,
    credit_term       VARCHAR,
    tax_id            UUID,
    is_deleted        BOOLEAN,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_date, employee_id, total, customer_id,
           receipt_type_id, payment_method_id, sales_channel_id,
           pos_id, sale_condition_id, discount_id, credit_term,
           tax_id, is_deleted, created_at, updated_at
    FROM sale
    WHERE sale_date BETWEEN _start AND _end
    ORDER BY sale_date;
END;
$$;
-- Obtener ventas por empleado
CREATE OR REPLACE FUNCTION fn_get_sales_by_employee(_employee_id UUID)
RETURNS TABLE (
    id                UUID,
    sale_date         TIMESTAMP,
    employee_id       UUID,
    total             DECIMAL,
    customer_id       UUID,
    receipt_type_id   UUID,
    payment_method_id UUID,
    sales_channel_id  UUID,
    pos_id            UUID,
    sale_condition_id UUID,
    discount_id       UUID,
    credit_term       VARCHAR,
    tax_id            UUID,
    is_deleted        BOOLEAN,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_date, employee_id, total, customer_id,
           receipt_type_id, payment_method_id, sales_channel_id,
           pos_id, sale_condition_id, discount_id, credit_term,
           tax_id, is_deleted, created_at, updated_at
    FROM sale
    WHERE employee_id = _employee_id
    ORDER BY sale_date;
END;
$$;
-- Obtener ventas por cliente
CREATE OR REPLACE FUNCTION fn_get_sales_by_customer(_customer_id UUID)
RETURNS TABLE (
    id                UUID,
    sale_date         TIMESTAMP,
    employee_id       UUID,
    total             DECIMAL,
    customer_id       UUID,
    receipt_type_id   UUID,
    payment_method_id UUID,
    sales_channel_id  UUID,
    pos_id            UUID,
    sale_condition_id UUID,
    discount_id       UUID,
    credit_term       VARCHAR,
    tax_id            UUID,
    is_deleted        BOOLEAN,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_date, employee_id, total, customer_id,
           receipt_type_id, payment_method_id, sales_channel_id,
           pos_id, sale_condition_id, discount_id, credit_term,
           tax_id, is_deleted, created_at, updated_at
    FROM sale
    WHERE customer_id = _customer_id
    ORDER BY sale_date;
END;
$$;
-- Obtener ventas por punto de venta (POS)
CREATE OR REPLACE FUNCTION fn_get_sales_by_pos(_pos_id UUID)
RETURNS TABLE (
    id                UUID,
    sale_date         TIMESTAMP,
    employee_id       UUID,
    total             DECIMAL,
    customer_id       UUID,
    receipt_type_id   UUID,
    payment_method_id UUID,
    sales_channel_id  UUID,
    pos_id            UUID,
    sale_condition_id UUID,
    discount_id       UUID,
    credit_term       VARCHAR,
    tax_id            UUID,
    is_deleted        BOOLEAN,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_date, employee_id, total, customer_id,
           receipt_type_id, payment_method_id, sales_channel_id,
           pos_id, sale_condition_id, discount_id, credit_term,
           tax_id, is_deleted, created_at, updated_at
    FROM sale
    WHERE pos_id = _pos_id
    ORDER BY sale_date;
END;
$$;

-- =========================================
-- SALE_CONDITION
-- =========================================
-- Obtener todas las condiciones de venta (tanto eliminadas como no eliminadas)
CREATE OR REPLACE FUNCTION fn_get_all_sale_conditions()
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, is_deleted, created_at, updated_at
    FROM sale_condition;
END;
$$;
-- Obtener una condición de venta por su ID (sin importar si está eliminada o no)
CREATE OR REPLACE FUNCTION fn_get_sale_condition_by_id(
    _id UUID
)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, is_deleted, created_at, updated_at
    FROM sale_condition
    WHERE id = _id;
END;
$$;
-- Obtener condiciones de venta según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_sale_conditions_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, is_deleted, created_at, updated_at
    FROM sale_condition
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- SALES_CHANNEL
-- =========================================
-- Obtener todos los canales de venta (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_sales_channels()
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    description VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
      FROM sales_channel;
END;
$$;
-- Obtener un canal de venta por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_sales_channel_by_id(
    _id UUID
)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    description VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
      FROM sales_channel
     WHERE id = _id;
END;
$$;
-- Obtener canales de venta según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_sales_channels_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    description VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
      FROM sales_channel
     WHERE is_deleted = _is_deleted;
END;
$$;
-- =========================================
-- DISCOUNT
-- =========================================
-- Obtener todos los descuentos (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_discounts()
RETURNS TABLE (
    id            UUID,
    name          VARCHAR,
    description   VARCHAR,
    discount_type VARCHAR,
    value         DECIMAL,
    start_date    TIMESTAMP,
    end_date      TIMESTAMP,
    is_deleted    BOOLEAN,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, discount_type, value, start_date, end_date,
           is_deleted, created_at, updated_at
      FROM discount;
END;
$$;
-- Obtener un descuento por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_discount_by_id(_id UUID)
RETURNS TABLE (
    id            UUID,
    name          VARCHAR,
    description   VARCHAR,
    discount_type VARCHAR,
    value         DECIMAL,
    start_date    TIMESTAMP,
    end_date      TIMESTAMP,
    is_deleted    BOOLEAN,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, discount_type, value, start_date, end_date,
           is_deleted, created_at, updated_at
      FROM discount
     WHERE id = _id;
END;
$$;
-- Obtener descuentos según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_discounts_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id            UUID,
    name          VARCHAR,
    description   VARCHAR,
    discount_type VARCHAR,
    value         DECIMAL,
    start_date    TIMESTAMP,
    end_date      TIMESTAMP,
    is_deleted    BOOLEAN,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, discount_type, value, start_date, end_date,
           is_deleted, created_at, updated_at
      FROM discount
     WHERE is_deleted = _is_deleted;
END;
$$;
-- Obtener descuentos vigentes en un rango de fechas
CREATE OR REPLACE FUNCTION fn_get_discounts_by_date_range(_start TIMESTAMP, _end TIMESTAMP)
RETURNS TABLE (
    id            UUID,
    name          VARCHAR,
    description   VARCHAR,
    discount_type VARCHAR,
    value         DECIMAL,
    start_date    TIMESTAMP,
    end_date      TIMESTAMP,
    is_deleted    BOOLEAN,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, discount_type, value, start_date, end_date,
           is_deleted, created_at, updated_at
      FROM discount
     WHERE start_date <= _end
       AND end_date   >= _start
     ORDER BY start_date;
END;
$$;
-- Obtener descuentos por tipo
CREATE OR REPLACE FUNCTION fn_get_discounts_by_type(_type VARCHAR)
RETURNS TABLE (
    id            UUID,
    name          VARCHAR,
    description   VARCHAR,
    discount_type VARCHAR,
    value         DECIMAL,
    start_date    TIMESTAMP,
    end_date      TIMESTAMP,
    is_deleted    BOOLEAN,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, discount_type, value, start_date, end_date,
           is_deleted, created_at, updated_at
      FROM discount
     WHERE discount_type = _type
     ORDER BY name;
END;
$$;

-- =========================================
-- TAX
-- =========================================
-- Obtener todos los impuestos (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_taxes()
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    rate         DECIMAL,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, rate, is_deleted, created_at, updated_at
      FROM tax;
END;
$$;
-- Obtener un impuesto por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_tax_by_id(
    _id UUID
)
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    rate         DECIMAL,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, rate, is_deleted, created_at, updated_at
      FROM tax
     WHERE id = _id;
END;
$$;
-- Obtener impuestos según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_taxes_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    rate         DECIMAL,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, rate, is_deleted, created_at, updated_at
      FROM tax
     WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- SALE_ORDER
-- =========================================

-- Obtener todas las relaciones venta-orden (tanto eliminadas como no eliminadas)
CREATE OR REPLACE FUNCTION fn_get_all_sale_orders()
RETURNS TABLE (
    id          UUID,
    sale_id     UUID,
    order_id    UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_id, order_id, is_deleted, created_at, updated_at
      FROM sale_order;
END;
$$;

-- Obtener una relación venta-orden por su ID
CREATE OR REPLACE FUNCTION fn_get_sale_order_by_id(_id UUID)
RETURNS TABLE (
    id          UUID,
    sale_id     UUID,
    order_id    UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_id, order_id, is_deleted, created_at, updated_at
      FROM sale_order
     WHERE id = _id;
END;
$$;

-- Obtener relaciones según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_sale_orders_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id          UUID,
    sale_id     UUID,
    order_id    UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_id, order_id, is_deleted, created_at, updated_at
      FROM sale_order
     WHERE is_deleted = _is_deleted;
END;
$$;

-- Obtener relaciones por ID de venta
CREATE OR REPLACE FUNCTION fn_get_sale_orders_by_sale_id(_sale_id UUID)
RETURNS TABLE (
    id          UUID,
    sale_id     UUID,
    order_id    UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_id, order_id, is_deleted, created_at, updated_at
      FROM sale_order
     WHERE sale_id = _sale_id;
END;
$$;

-- Obtener relaciones por ID de orden
CREATE OR REPLACE_FUNCTION fn_get_sale_orders_by_order_id(_order_id UUID)
RETURNS TABLE (
    id          UUID,
    sale_id     UUID,
    order_id    UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_id, order_id, is_deleted, created_at, updated_at
      FROM sale_order
     WHERE order_id = _order_id;
END;
$$;

-- =========================================
-- CASH_REGISTER
-- =========================================
-- Obtener todos los registros de caja (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_cash_registers()
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    pos_id       UUID,
    description  VARCHAR,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, pos_id, description, is_deleted, created_at, updated_at
      FROM cash_register;
END;
$$;
-- Obtener un registro de caja por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_cash_register_by_id(
    _id UUID
)
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    pos_id       UUID,
    description  VARCHAR,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, pos_id, description, is_deleted, created_at, updated_at
      FROM cash_register
     WHERE id = _id;
END;
$$;
-- Obtener registros de caja según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_cash_registers_by_deleted(
    _is_deleted BOOLEAN
)
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    pos_id       UUID,
    description  VARCHAR,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, pos_id, description, is_deleted, created_at, updated_at
      FROM cash_register
     WHERE is_deleted = _is_deleted;
END;
$$;
-- Obtener registros de caja por ID de POS
CREATE OR REPLACE FUNCTION fn_get_cash_registers_by_pos_id(
    _pos_id UUID
)
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    pos_id       UUID,
    description  VARCHAR,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, pos_id, description, is_deleted, created_at, updated_at
      FROM cash_register
     WHERE pos_id = _pos_id;
END;
$$;

-- =========================================
-- CASH_REGISTER_SESSION
-- =========================================
-- Obtener todas las sesiones de caja (tanto eliminadas como no eliminadas)
CREATE OR REPLACE FUNCTION fn_get_all_cash_register_sessions()
RETURNS TABLE (
    id                 UUID,
    cash_register_id   UUID,
    employee_id        UUID,
    opened_at          TIMESTAMP,
    closed_at          TIMESTAMP,
    opening_amount     NUMERIC(10,2),
    closing_amount     NUMERIC(10,2),
    expected_balance   NUMERIC(10,2),
    discrepancy        NUMERIC(10,2),
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opened_at, closed_at,
           opening_amount, closing_amount, expected_balance,
           discrepancy, status, is_deleted, created_at, updated_at
      FROM cash_register_session;
END;
$$;
-- Obtener una sesión de caja por su ID
CREATE OR REPLACE FUNCTION fn_get_cash_register_session_by_id(_id UUID)
RETURNS TABLE (
    id                 UUID,
    cash_register_id   UUID,
    employee_id        UUID,
    opened_at          TIMESTAMP,
    closed_at          TIMESTAMP,
    opening_amount     NUMERIC(10,2),
    closing_amount     NUMERIC(10,2),
    expected_balance   NUMERIC(10,2),
    discrepancy        NUMERIC(10,2),
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opened_at, closed_at,
           opening_amount, closing_amount, expected_balance,
           discrepancy, status, is_deleted, created_at, updated_at
      FROM cash_register_session
     WHERE id = _id;
END;
$$;
-- Obtener sesiones según estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_cash_register_sessions_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id                 UUID,
    cash_register_id   UUID,
    employee_id        UUID,
    opened_at          TIMESTAMP,
    closed_at          TIMESTAMP,
    opening_amount     NUMERIC(10,2),
    closing_amount     NUMERIC(10,2),
    expected_balance   NUMERIC(10,2),
    discrepancy        NUMERIC(10,2),
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opened_at, closed_at,
           opening_amount, closing_amount, expected_balance,
           discrepancy, status, is_deleted, created_at, updated_at
      FROM cash_register_session
     WHERE is_deleted = _is_deleted;
END;
$$;
-- Obtener sesiones por ID de caja
CREATE OR REPLACE FUNCTION fn_get_cash_register_sessions_by_cash_register(_cash_register_id UUID)
RETURNS TABLE (
    id                 UUID,
    cash_register_id   UUID,
    employee_id        UUID,
    opened_at          TIMESTAMP,
    closed_at          TIMESTAMP,
    opening_amount     NUMERIC(10,2),
    closing_amount     NUMERIC(10,2),
    expected_balance   NUMERIC(10,2),
    discrepancy        NUMERIC(10,2),
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opened_at, closed_at,
           opening_amount, closing_amount, expected_balance,
           discrepancy, status, is_deleted, created_at, updated_at
      FROM cash_register_session
     WHERE cash_register_id = _cash_register_id
     ORDER BY opened_at;
END;
$$;
-- Obtener sesiones por empleado
CREATE OR REPLACE FUNCTION fn_get_cash_register_sessions_by_employee(_employee_id UUID)
RETURNS TABLE (
    id                 UUID,
    cash_register_id   UUID,
    employee_id        UUID,
    opened_at          TIMESTAMP,
    closed_at          TIMESTAMP,
    opening_amount     NUMERIC(10,2),
    closing_amount     NUMERIC(10,2),
    expected_balance   NUMERIC(10,2),
    discrepancy        NUMERIC(10,2),
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opened_at, closed_at,
           opening_amount, closing_amount, expected_balance,
           discrepancy, status, is_deleted, created_at, updated_at
      FROM cash_register_session
     WHERE employee_id = _employee_id
     ORDER BY opened_at;
END;
$$;
-- Obtener sesiones por estado (OPEN | CLOSED | CANCELLED)
CREATE OR REPLACE FUNCTION fn_get_cash_register_sessions_by_status(_status VARCHAR)
RETURNS TABLE (
    id                 UUID,
    cash_register_id   UUID,
    employee_id        UUID,
    opened_at          TIMESTAMP,
    closed_at          TIMESTAMP,
    opening_amount     NUMERIC(10,2),
    closing_amount     NUMERIC(10,2),
    expected_balance   NUMERIC(10,2),
    discrepancy        NUMERIC(10,2),
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opened_at, closed_at,
           opening_amount, closing_amount, expected_balance,
           discrepancy, status, is_deleted, created_at, updated_at
      FROM cash_register_session
     WHERE status = _status
     ORDER BY opened_at;
END;
$$;
-- Obtener sesiones abiertas en rango de fecha de apertura
CREATE OR REPLACE FUNCTION fn_get_cash_register_sessions_by_opened_range(_start TIMESTAMP, _end TIMESTAMP)
RETURNS TABLE (
    id                 UUID,
    cash_register_id   UUID,
    employee_id        UUID,
    opened_at          TIMESTAMP,
    closed_at          TIMESTAMP,
    opening_amount     NUMERIC(10,2),
    closing_amount     NUMERIC(10,2),
    expected_balance   NUMERIC(10,2),
    discrepancy        NUMERIC(10,2),
    status             VARCHAR,
    is_deleted         BOOLEAN,
    created_at         TIMESTAMP,
    updated_at         TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opened_at, closed_at,
           opening_amount, closing_amount, expected_balance,
           discrepancy, status, is_deleted, created_at, updated_at
      FROM cash_register_session
     WHERE opened_at BETWEEN _start AND _end
     ORDER BY opened_at;
END;
$$;

-- =========================================
-- CASH_REGISTER_MOVEMENT
-- =========================================
-- Obtener todos los movimientos de caja (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_cash_register_movements()
RETURNS TABLE (
    id            UUID,
    session_id    UUID,
    movement_type VARCHAR,
    description   TEXT,
    amount        NUMERIC(10,2),
    performed_at  TIMESTAMP,
    is_deleted    BOOLEAN,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, session_id, movement_type, description, amount, performed_at, is_deleted, updated_at
      FROM cash_register_movement;
END;
$$;
-- Obtener un movimiento por su ID
CREATE OR REPLACE FUNCTION fn_get_cash_register_movement_by_id(_id UUID)
RETURNS TABLE (
    id            UUID,
    session_id    UUID,
    movement_type VARCHAR,
    description   TEXT,
    amount        NUMERIC(10,2),
    performed_at  TIMESTAMP,
    is_deleted    BOOLEAN,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, session_id, movement_type, description, amount, performed_at, is_deleted, updated_at
      FROM cash_register_movement
     WHERE id = _id;
END;
$$;
-- Obtener movimientos según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_cash_register_movements_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id            UUID,
    session_id    UUID,
    movement_type VARCHAR,
    description   TEXT,
    amount        NUMERIC(10,2),
    performed_at  TIMESTAMP,
    is_deleted    BOOLEAN,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, session_id, movement_type, description, amount, performed_at, is_deleted, updated_at
      FROM cash_register_movement
     WHERE is_deleted = _is_deleted;
END;
$$;
-- Obtener movimientos por ID de sesión de caja
CREATE OR REPLACE FUNCTION fn_get_cash_register_movements_by_session(_session_id UUID)
RETURNS TABLE (
    id            UUID,
    session_id    UUID,
    movement_type VARCHAR,
    description   TEXT,
    amount        NUMERIC(10,2),
    performed_at  TIMESTAMP,
    is_deleted    BOOLEAN,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, session_id, movement_type, description, amount, performed_at, is_deleted, updated_at
      FROM cash_register_movement
     WHERE session_id = _session_id
     ORDER BY performed_at;
END;
$$;
-- Obtener movimientos por tipo (SALE, INCOME, EXPENSE, REFUND)
CREATE OR REPLACE FUNCTION fn_get_cash_register_movements_by_type(_type VARCHAR)
RETURNS TABLE (
    id            UUID,
    session_id    UUID,
    movement_type VARCHAR,
    description   TEXT,
    amount        NUMERIC(10,2),
    performed_at  TIMESTAMP,
    is_deleted    BOOLEAN,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, session_id, movement_type, description, amount, performed_at, is_deleted, updated_at
      FROM cash_register_movement
     WHERE movement_type = _type
     ORDER BY performed_at;
END;
$$;
-- Obtener movimientos en un rango de fechas
CREATE OR REPLACE FUNCTION fn_get_cash_register_movements_by_date_range(_start TIMESTAMP, _end TIMESTAMP)
RETURNS TABLE (
    id            UUID,
    session_id    UUID,
    movement_type VARCHAR,
    description   TEXT,
    amount        NUMERIC(10,2),
    performed_at  TIMESTAMP,
    is_deleted    BOOLEAN,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, session_id, movement_type, description, amount, performed_at, is_deleted, updated_at
      FROM cash_register_movement
     WHERE performed_at BETWEEN _start AND _end
     ORDER BY performed_at;
END;
$$;

-- =========================================
-- INVOICE
-- =========================================
-- Obtener todas las facturas (tanto eliminadas como no eliminadas)
CREATE OR REPLACE FUNCTION fn_get_all_invoices()
RETURNS TABLE (
    id                      UUID,
    batch_id                INT,
    sale_id                 UUID,
    cash_register_movement_id UUID,
    key_code                VARCHAR,
    consecutive_number      VARCHAR,
    issue_date              TIMESTAMP,
    currency_code           VARCHAR,
    exchange_rate           DECIMAL,
    invoice_comment         VARCHAR,
    document                VARCHAR,
    email_copy              VARCHAR,
    other_content           VARCHAR,
    other_text              VARCHAR,
    is_deleted              BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        id, batch_id, sale_id, cash_register_movement_id,
        key_code, consecutive_number, issue_date,
        currency_code, exchange_rate, invoice_comment,
        document, email_copy, other_content, other_text,
        is_deleted, created_at, updated_at
    FROM invoice;
END;
$$;
-- Obtener una factura por su ID
CREATE OR REPLACE FUNCTION fn_get_invoice_by_id(_id UUID)
RETURNS TABLE (
    id                      UUID,
    batch_id                INT,
    sale_id                 UUID,
    cash_register_movement_id UUID,
    key_code                VARCHAR,
    consecutive_number      VARCHAR,
    issue_date              TIMESTAMP,
    currency_code           VARCHAR,
    exchange_rate           DECIMAL,
    invoice_comment         VARCHAR,
    document                VARCHAR,
    email_copy              VARCHAR,
    other_content           VARCHAR,
    other_text              VARCHAR,
    is_deleted              BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        id, batch_id, sale_id, cash_register_movement_id,
        key_code, consecutive_number, issue_date,
        currency_code, exchange_rate, invoice_comment,
        document, email_copy, other_content, other_text,
        is_deleted, created_at, updated_at
    FROM invoice
    WHERE id = _id;
END;
$$;
-- Obtener facturas según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_invoices_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id                      UUID,
    batch_id                INT,
    sale_id                 UUID,
    cash_register_movement_id UUID,
    key_code                VARCHAR,
    consecutive_number      VARCHAR,
    issue_date              TIMESTAMP,
    currency_code           VARCHAR,
    exchange_rate           DECIMAL,
    invoice_comment         VARCHAR,
    document                VARCHAR,
    email_copy              VARCHAR,
    other_content           VARCHAR,
    other_text              VARCHAR,
    is_deleted              BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        id, batch_id, sale_id, cash_register_movement_id,
        key_code, consecutive_number, issue_date,
        currency_code, exchange_rate, invoice_comment,
        document, email_copy, other_content, other_text,
        is_deleted, created_at, updated_at
    FROM invoice
    WHERE is_deleted = _is_deleted;
END;
$$;
-- Obtener facturas por ID de venta
CREATE OR REPLACE FUNCTION fn_get_invoices_by_sale_id(_sale_id UUID)
RETURNS TABLE (
    id                      UUID,
    batch_id                INT,
    sale_id                 UUID,
    cash_register_movement_id UUID,
    key_code                VARCHAR,
    consecutive_number      VARCHAR,
    issue_date              TIMESTAMP,
    currency_code           VARCHAR,
    exchange_rate           DECIMAL,
    invoice_comment         VARCHAR,
    document                VARCHAR,
    email_copy              VARCHAR,
    other_content           VARCHAR,
    other_text              VARCHAR,
    is_deleted              BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        id, batch_id, sale_id, cash_register_movement_id,
        key_code, consecutive_number, issue_date,
        currency_code, exchange_rate, invoice_comment,
        document, email_copy, other_content, other_text,
        is_deleted, created_at, updated_at
    FROM invoice
    WHERE sale_id = _sale_id
    ORDER BY issue_date;
END;
$$;
-- Obtener facturas por batch_id
CREATE OR REPLACE FUNCTION fn_get_invoices_by_batch_id(_batch_id INT)
RETURNS TABLE (
    id                      UUID,
    batch_id                INT,
    sale_id                 UUID,
    cash_register_movement_id UUID,
    key_code                VARCHAR,
    consecutive_number      VARCHAR,
    issue_date              TIMESTAMP,
    currency_code           VARCHAR,
    exchange_rate           DECIMAL,
    invoice_comment         VARCHAR,
    document                VARCHAR,
    email_copy              VARCHAR,
    other_content           VARCHAR,
    other_text              VARCHAR,
    is_deleted              BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        id, batch_id, sale_id, cash_register_movement_id,
        key_code, consecutive_number, issue_date,
        currency_code, exchange_rate, invoice_comment,
        document, email_copy, other_content, other_text,
        is_deleted, created_at, updated_at
    FROM invoice
    WHERE batch_id = _batch_id
    ORDER BY issue_date;
END;
$$;
-- Obtener facturas por rango de fechas de emisión
CREATE OR REPLACE FUNCTION fn_get_invoices_by_issue_date_range(_start TIMESTAMP, _end TIMESTAMP)
RETURNS TABLE (
    id                      UUID,
    batch_id                INT,
    sale_id                 UUID,
    cash_register_movement_id UUID,
    key_code                VARCHAR,
    consecutive_number      VARCHAR,
    issue_date              TIMESTAMP,
    currency_code           VARCHAR,
    exchange_rate           DECIMAL,
    invoice_comment         VARCHAR,
    document                VARCHAR,
    email_copy              VARCHAR,
    other_content           VARCHAR,
    other_text              VARCHAR,
    is_deleted              BOOLEAN,
    created_at              TIMESTAMP,
    updated_at              TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        id, batch_id, sale_id, cash_register_movement_id,
        key_code, consecutive_number, issue_date,
        currency_code, exchange_rate, invoice_comment,
        document, email_copy, other_content, other_text,
        is_deleted, created_at, updated_at
    FROM invoice
    WHERE issue_date BETWEEN _start AND _end
    ORDER BY issue_date;
END;
$$;

-- =========================================
-- RECEIPT_TYPE
-- =========================================
-- Obtener todos los tipos de recibo (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_receipt_types()
RETURNS TABLE (
    id          INT,
    name        VARCHAR,
    description VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
      FROM receipt_type;
END;
$$;
-- Obtener un tipo de recibo por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_receipt_type_by_id(_id INT)
RETURNS TABLE (
    id          INT,
    name        VARCHAR,
    description VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
      FROM receipt_type
     WHERE id = _id;
END;
$$;
-- Obtener tipos de recibo según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_receipt_types_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id          INT,
    name        VARCHAR,
    description VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
      FROM receipt_type
     WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- CUSTOMER
-- =========================================
-- Obtener todos los clientes (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_customers()
RETURNS TABLE (
    id          UUID,
    id_type_id  UUID,
    id_number   VARCHAR,
    name        VARCHAR,
    lastname    VARCHAR,
    phone       VARCHAR,
    email       VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, id_type_id, id_number, name, lastname, phone, email, is_deleted, created_at, updated_at
      FROM customer;
END;
$$;
-- Obtener un cliente por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_customer_by_id(_id UUID)
RETURNS TABLE (
    id          UUID,
    id_type_id  UUID,
    id_number   VARCHAR,
    name        VARCHAR,
    lastname    VARCHAR,
    phone       VARCHAR,
    email       VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, id_type_id, id_number, name, lastname, phone, email, is_deleted, created_at, updated_at
      FROM customer
     WHERE id = _id;
END;
$$;
-- Obtener clientes según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_customers_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id          UUID,
    id_type_id  UUID,
    id_number   VARCHAR,
    name        VARCHAR,
    lastname    VARCHAR,
    phone       VARCHAR,
    email       VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, id_type_id, id_number, name, lastname, phone, email, is_deleted, created_at, updated_at
      FROM customer
     WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- ID_TYPE
-- =========================================

-- Obtener todos los tipos de documento (tanto eliminados como no eliminados)
CREATE OR REPLACE FUNCTION fn_get_all_id_types()
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, is_deleted, created_at, updated_at
      FROM id_type;
END;
$$;

-- Obtener un tipo de documento por su ID (sin importar si está eliminado o no)
CREATE OR REPLACE FUNCTION fn_get_id_type_by_id(_id UUID)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, is_deleted, created_at, updated_at
      FROM id_type
     WHERE id = _id;
END;
$$;

-- Obtener tipos de documento según su estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_id_types_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, is_deleted, created_at, updated_at
      FROM id_type
     WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- LOYALTY_PROGRAM
-- =========================================
-- Obtener todos los programas de lealtad
CREATE OR REPLACE FUNCTION fn_get_all_loyalty_programs()
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    points       INT,
    customer_id  UUID,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, points, customer_id, created_at, updated_at
      FROM loyalty_program;
END;
$$;

-- Obtener un programa de lealtad por ID
CREATE OR REPLACE FUNCTION fn_get_loyalty_program_by_id(_id UUID)
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    points       INT,
    customer_id  UUID,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, points, customer_id, created_at, updated_at
      FROM loyalty_program
     WHERE id = _id;
END;
$$;
-- Obtener programas de lealtad según estado de eliminación
CREATE OR REPLACE FUNCTION fn_get_loyalty_programs_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    points       INT,
    customer_id  UUID,
    is_deleted   BOOLEAN,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, points, customer_id, is_deleted, created_at, updated_at
      FROM loyalty_program
     WHERE is_deleted = _is_deleted;
END;
$$;
-- Obtener programas de lealtad por ID de cliente
CREATE OR REPLACE FUNCTION fn_get_loyalty_programs_by_customer(_customer_id UUID)
RETURNS TABLE (
    id           UUID,
    name         VARCHAR,
    points       INT,
    customer_id  UUID,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, points, customer_id, created_at, updated_at
      FROM loyalty_program
     WHERE customer_id = _customer_id;
END;
$$;




