-- =========================================
-- 1. CRUD Usuarios y Upserts Relacionados
-- =========================================

-- 1.1. Función: Upsert User en user_system (retorna fila completa)
--       Si _id IS NULL → hace INSERT y devuelve el registro nuevo.
--       Si _id NO ES NULL → hace UPDATE y devuelve el registro actualizado.
CREATE OR REPLACE FUNCTION fn_upsert_user_system(
    _id       UUID,
    _username VARCHAR,
    _role_id  UUID,
    _status   INT
)
RETURNS TABLE (
    id         UUID,
    username   VARCHAR,
    password   VARCHAR,
    role_id    UUID,
    status     INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF _id IS NOT NULL THEN
        -- Actualizar usuario existente (no cambia password)
        UPDATE user_system
        SET
            username   = _username,
            role_id    = _role_id,
            status     = _status,
            updated_at = NOW()
        WHERE id = _id;
    ELSE
        -- Insertar usuario nuevo (password inicial vacío)
        INSERT INTO user_system(username, password, role_id, status)
        VALUES (_username, '', _role_id, _status)
        RETURNING id, username, password, role_id, status, created_at, updated_at
        INTO id, username, password, role_id, status, created_at, updated_at;
        RETURN NEXT;
        RETURN;
    END IF;

    -- Devolver registro (insertado o actualizado)
    RETURN QUERY
    SELECT id, username, password, role_id, status, created_at, updated_at
    FROM user_system
    WHERE id = COALESCE(_id, id);
END;
$$;


-- 1.2. Procedimiento: Upsert Password en user_system (solo actualiza campo password)
--       No devuelve nada.
CREATE OR REPLACE PROCEDURE sp_upsert_user_password(
    _user_id  UUID,
    _password VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE user_system
    SET
        password   = _password,
        updated_at = NOW()
    WHERE id = _user_id;
END;
$$;


-- 1.3. Función: Upsert Role en role (retorna fila completa)
--       Si _id IS NULL → INSERT + RETURNING.
--       Si _id NO ES NULL → UPDATE + RETURN QUERY.
CREATE OR REPLACE FUNCTION fn_upsert_role(
    _id   UUID,
    _name VARCHAR
)
RETURNS TABLE (
    id         UUID,
    name       VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF _id IS NOT NULL THEN
        UPDATE role
        SET
            name       = _name,
            updated_at = NOW()
        WHERE id = _id;
    ELSE
        INSERT INTO role(name)
        VALUES (_name)
        RETURNING id, name, created_at, updated_at
        INTO id, name, created_at, updated_at;
        RETURN NEXT;
        RETURN;
    END IF;

    RETURN QUERY
    SELECT id, name, created_at, updated_at
    FROM role
    WHERE id = COALESCE(_id, id);
END;
$$;


-- 1.4. Función: Upsert Permission en permission (retorna fila completa)
--       Si _id IS NULL → INSERT + RETURNING.
--       Si _id NO ES NULL → UPDATE + RETURN QUERY.
CREATE OR REPLACE FUNCTION fn_upsert_permission(
    _id          UUID,
    _name        VARCHAR,
    _description VARCHAR
)
RETURNS TABLE (
    id          UUID,
    name        VARCHAR,
    description VARCHAR,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF _id IS NOT NULL THEN
        UPDATE permission
        SET
            name        = _name,
            description = _description,
            updated_at  = NOW()
        WHERE id = _id;
    ELSE
        INSERT INTO permission(name, description)
        VALUES (_name, _description)
        RETURNING id, name, description, created_at, updated_at
        INTO id, name, description, created_at, updated_at;
        RETURN NEXT;
        RETURN;
    END IF;

    RETURN QUERY
    SELECT id, name, description, created_at, updated_at
    FROM permission
    WHERE id = COALESCE(_id, id);
END;
$$;



-- ================================================
-- 2. CRUD Sucursales y Upserts Relacionados (POS, Employees)
-- ================================================

-- 2.1. Función: Upsert Branch en branch (retorna fila completa)
--       Si _id IS NULL → INSERT + RETURNING.
--       Si _id NO ES NULL → UPDATE + RETURN QUERY.
CREATE OR REPLACE FUNCTION fn_upsert_branch(
    _id      UUID,
    _name    VARCHAR,
    _country VARCHAR,
    _city    VARCHAR,
    _address VARCHAR,
    _phone   VARCHAR,
    _status  VARCHAR
)
RETURNS TABLE (
    id         UUID,
    name       VARCHAR,
    country    VARCHAR,
    city       VARCHAR,
    address    VARCHAR,
    phone      VARCHAR,
    status     VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF _id IS NOT NULL THEN
        UPDATE branch
        SET
            name       = _name,
            country    = _country,
            city       = _city,
            address    = _address,
            phone      = _phone,
            status     = _status,
            updated_at = NOW()
        WHERE id = _id;
    ELSE
        INSERT INTO branch(name, country, city, address, phone, status)
        VALUES (_name, _country, _city, _address, _phone, _status)
        RETURNING id, name, country, city, address, phone, status, created_at, updated_at
        INTO id, name, country, city, address, phone, status, created_at, updated_at;
        RETURN NEXT;
        RETURN;
    END IF;

    RETURN QUERY
    SELECT id, name, country, city, address, phone, status, created_at, updated_at
    FROM branch
    WHERE id = COALESCE(_id, id);
END;
$$;


-- 2.2. Función: Upsert POS en pos (retorna fila completa)
--       Si _id IS NULL → INSERT + RETURNING.
--       Si _id NO ES NULL → UPDATE + RETURN QUERY.
CREATE OR REPLACE FUNCTION fn_upsert_pos(
    _id        UUID,
    _name      VARCHAR,
    _branch_id UUID
)
RETURNS TABLE (
    id         UUID,
    name       VARCHAR,
    branch_id  UUID,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF _id IS NOT NULL THEN
        UPDATE pos
        SET
            name       = _name,
            branch_id  = _branch_id,
            updated_at = NOW()
        WHERE id = _id;
    ELSE
        INSERT INTO pos(name, branch_id)
        VALUES (_name, _branch_id)
        RETURNING id, name, branch_id, created_at, updated_at
        INTO id, name, branch_id, created_at, updated_at;
        RETURN NEXT;
        RETURN;
    END IF;

    RETURN QUERY
    SELECT id, name, branch_id, created_at, updated_at
    FROM pos
    WHERE id = COALESCE(_id, id);
END;
$$;


-- 2.3. Función: Upsert Employee en employee (retorna fila completa)
--       Si _id IS NULL → INSERT + RETURNING.
--       Si _id NO ES NULL → UPDATE + RETURN QUERY.
CREATE OR REPLACE FUNCTION fn_upsert_employee(
    _id         UUID,
    _first_name VARCHAR,
    _last_name  VARCHAR,
    _role       VARCHAR
)
RETURNS TABLE (
    id         UUID,
    first_name VARCHAR,
    last_name  VARCHAR,
    role       VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF _id IS NOT NULL THEN
        UPDATE employee
        SET
            first_name = _first_name,
            last_name  = _last_name,
            role       = _role,
            updated_at = NOW()
        WHERE id = _id;
    ELSE
        INSERT INTO employee(first_name, last_name, role)
        VALUES (_first_name, _last_name, _role)
        RETURNING id, first_name, last_name, role, created_at, updated_at
        INTO id, first_name, last_name, role, created_at, updated_at;
        RETURN NEXT;
        RETURN;
    END IF;

    RETURN QUERY
    SELECT id, first_name, last_name, role, created_at, updated_at
    FROM employee
    WHERE id = COALESCE(_id, id);
END;
$$;
