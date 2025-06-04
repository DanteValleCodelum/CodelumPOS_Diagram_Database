-- =========================================
-- 1. CRUD Usuarios y Upserts Relacionados
-- =========================================

-- 1.1. Procedure: Upsert User en user_system 
--       Si _id IS NULL → hace INSERT y devuelve el registro nuevo.
--       Si _id NO ES NULL → hace UPDATE y devuelve el registro actualizado.
CREATE OR REPLACE PROCEDURE sp_upsert_user_system(
    IN _id       UUID,
    IN _username VARCHAR,
    IN _password VARCHAR,
    IN _role_id  UUID,
    IN _status   INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        IF _id IS NOT NULL THEN
            -- Actualizar usuario existente
            UPDATE user_system
            SET
                username   = _username,
                role_id    = _role_id,
                password   = _password,
                status     = _status,
                updated_at = NOW()
            WHERE id = _id;
        ELSE
            -- Insertar nuevo usuario
            INSERT INTO user_system(username, password, role_id, status, created_at, updated_at)
            VALUES (_username, _password, _role_id, _status, NOW(), NOW());
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_upsert_user_system: %', SQLERRM;
    END;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_all_user_system()
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
    RETURN QUERY
    SELECT 
        id, username, password, role_id, status, created_at, updated_at
    FROM 
        user_system;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_user_system_by_id(
    _id UUID
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
    RETURN QUERY
    SELECT 
        id, username, password, role_id, status, created_at, updated_at
    FROM 
        user_system
    WHERE 
        id = _id;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_user_system(
    IN _id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        UPDATE user_system
        SET 
            status = 0,         -- Estado inactivo o dado de baja
            updated_at = NOW()
        WHERE id = _id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'No existe un usuario del sistema con id %', _id;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_delete_user_system: %', SQLERRM;
    END;
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


-- 1.3. SP: Upsert Role en role
CREATE OR REPLACE PROCEDURE sp_upsert_role(
    IN _id   UUID,
    IN _name VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        IF _id IS NOT NULL AND EXISTS (
            SELECT 1 FROM role WHERE id = _id
        ) THEN
            -- Actualizar rol existente
            UPDATE role
            SET
                name       = _name,
                updated_at = NOW()
            WHERE id = _id;
        ELSE
            -- Insertar nuevo rol (id se genera automáticamente)
            INSERT INTO role(name, created_at, updated_at)
            VALUES (_name, NOW(), NOW());
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_upsert_role: %', SQLERRM;
    END;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_all_roles()
RETURNS TABLE (
    id         UUID,
    name       VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, created_at, updated_at
    FROM role;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_role_by_id(
    _id UUID
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
    RETURN QUERY
    SELECT id, name, created_at, updated_at
    FROM role
    WHERE id = _id;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_role(
    IN _id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        DELETE FROM role
        WHERE id = _id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'No existe un rol con id %', _id;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_delete_role: %', SQLERRM;
    END;
END;
$$;


-- 1.4. SP: Upsert Permission en permission
--       Si _id IS NULL → INSERT + RETURNING.
--       Si _id NO ES NULL → UPDATE + RETURN QUERY.
CREATE OR REPLACE PROCEDURE sp_upsert_permission(
    IN _id          UUID,
    IN _name        VARCHAR,
    IN _description VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        IF _id IS NOT NULL THEN
            -- Actualizar permiso existente
            UPDATE permission
            SET
                name        = _name,
                description = _description,
                updated_at  = NOW()
            WHERE id = _id;

            IF NOT FOUND THEN
                RAISE EXCEPTION 'No existe un permiso con id %', _id;
            END IF;

        ELSE
            -- Insertar nuevo permiso
            INSERT INTO permission(name, description,updated_at, created_at)
            VALUES (_name, _description, NOW(), NOW());
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_upsert_permission: %', SQLERRM;
    END;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_all_permissions()
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
    RETURN QUERY
    SELECT id, name, description, created_at, updated_at
    FROM permission;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_permission_by_id(
    _id UUID
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
    RETURN QUERY
    SELECT id, name, description, created_at, updated_at
    FROM permission
    WHERE id = _id;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_permission(
    IN _id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        DELETE FROM permission
        WHERE id = _id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'No existe un permiso con id %', _id;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_delete_permission: %', SQLERRM;
    END;
END;
$$;

-- ================================================
-- 2. CRUD Sucursales y Upserts Relacionados (POS, Employees)
-- ================================================

-- 2.1. SP: Upsert Branch en branch
CREATE OR REPLACE PROCEDURE sp_upsert_branch(
    IN _id      UUID,
    IN _name    VARCHAR,
    IN _country VARCHAR,
    IN _city    VARCHAR,
    IN _address VARCHAR,
    IN _phone   VARCHAR,
    IN _status  int
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        IF _id IS NOT NULL THEN
            -- Actualizar sucursal
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

            IF NOT FOUND THEN
                RAISE EXCEPTION 'No existe una sucursal con id %', _id;
            END IF;
        ELSE
            -- Insertar nueva sucursal
            INSERT INTO branch(name, country, city, address, phone, status, created_at,updated_at)
            VALUES (_name, _country, _city, _address, _phone, _status, NOW(),NOW());
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_upsert_branch: %', SQLERRM;
    END;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_all_branches()
RETURNS TABLE (
    id         UUID,
    name       VARCHAR,
    country    VARCHAR,
    city       VARCHAR,
    address    VARCHAR,
    phone      VARCHAR,
    status     int,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, country, city, address, phone, status, created_at, updated_at
    FROM branch;
END;
$$;

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
    status     int,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, country, city, address, phone, status, created_at, updated_at
    FROM branch
    WHERE id = _id;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_branch(
    IN _id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        UPDATE branch
        SET status = 0,
        updated_at = NOW()
        WHERE id = _id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'No existe una sucursal con id %', _id;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_delete_branch: %', SQLERRM;
    END;
END;
$$;



-- 2.2. SP: Upsert POS en pos 
CREATE OR REPLACE PROCEDURE sp_upsert_pos(
    IN _id        UUID,
    IN _name      VARCHAR,
    IN _branch_id UUID,
    IN _status    INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        IF _id IS NOT NULL THEN
            -- Actualizar POS existente
            UPDATE pos
            SET
                name       = _name,
                branch_id  = _branch_id,
                status     = _status,
                updated_at = NOW()
            WHERE id = _id;

            IF NOT FOUND THEN
                RAISE EXCEPTION 'No existe un POS con id %', _id;
            END IF;
        ELSE
            -- Insertar nuevo POS
            INSERT INTO pos(name, branch_id, status, created_at, updated_at)
            VALUES (_name, _branch_id, _status, NOW(), NOW());
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_upsert_pos: %', SQLERRM;
    END;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_all_pos()
RETURNS TABLE (
    id         UUID,
    name       VARCHAR,
    branch_id  UUID,
    status     INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, branch_id, status, created_at, updated_at
    FROM pos;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_pos_by_id(
    _id UUID
)
RETURNS TABLE (
    id         UUID,
    name       VARCHAR,
    branch_id  UUID,
    status     INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, branch_id, status, created_at, updated_at
    FROM pos
    WHERE id = _id;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_pos(
    IN _id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        UPDATE pos
        SET status = 0, updated_at = NOW()
        WHERE id = _id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'No existe un POS con id %', _id;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_delete_pos: %', SQLERRM;
    END;
END;
$$;


-- 3. SP: CRUD Warehouse
CREATE OR REPLACE PROCEDURE sp_upsert_warehouse(
    IN _id                  UUID,
    IN _name                VARCHAR,
    IN _shortname           VARCHAR,
    IN _parent_warehouse_id UUID,
    IN _branch_id           UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        IF _id IS NOT NULL THEN
            -- Actualización de almacén existente
            UPDATE warehouse
            SET
                name                = _name,
                shortname           = _shortname,
                parent_warehouse_id = _parent_warehouse_id,
                branch_id           = _branch_id,
                updated_at          = NOW()
            WHERE id = _id;

            IF NOT FOUND THEN
                RAISE EXCEPTION 'No existe un warehouse con id %', _id;
            END IF;
        ELSE
            -- Inserción de nuevo almacén
            INSERT INTO warehouse(name, shortname, parent_warehouse_id, branch_id, created_at)
            VALUES (_name, _shortname, _parent_warehouse_id, _branch_id, NOW());
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_upsert_warehouse: %', SQLERRM;
    END;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_all_warehouse()
RETURNS TABLE (
    id                  UUID,
    name                VARCHAR,
    shortname           VARCHAR,
    parent_warehouse_id UUID,
    branch_id           UUID,
    created_at          TIMESTAMP,
    updated_at          TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, shortname, parent_warehouse_id, branch_id, created_at, updated_at
    FROM warehouse;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_warehouse_by_id(
    _id UUID
)
RETURNS TABLE (
    id                  UUID,
    name                VARCHAR,
    shortname           VARCHAR,
    parent_warehouse_id UUID,
    branch_id           UUID,
    created_at          TIMESTAMP,
    updated_at          TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, shortname, parent_warehouse_id, branch_id, created_at, updated_at
    FROM warehouse
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE PROCEDURE sp_delete_warehouse(
    IN _id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        UPDATE warehouse
        SET status = 0, updated_at = NOW()
        WHERE id = _id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'No existe un warehouse con id %', _id;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_delete_warehouse: %', SQLERRM;
    END;
END;
$$;

-- 3.1 SP: CRUD storage_type
CREATE OR REPLACE PROCEDURE sp_upsert_storage_type(
    IN _id                UUID,
    IN _name              VARCHAR,
    IN _maximum_weight    VARCHAR,
    IN _allow_new_product BOOLEAN,
    IN _status            INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        IF _id IS NOT NULL THEN
            -- Actualizar tipo de almacenamiento
            UPDATE storage_type
            SET
                name               = _name,
                maximum_weight     = _maximum_weight,
                allow_new_product  = _allow_new_product,
                status             = _status,
                updated_at         = NOW()
            WHERE id = _id;

            IF NOT FOUND THEN
                RAISE EXCEPTION 'No existe un storage_type con id %', _id;
            END IF;
        ELSE
            -- Insertar nuevo tipo de almacenamiento
            INSERT INTO storage_type(name, maximum_weight, allow_new_product, status, created_at, updated_at)
            VALUES (_name, _maximum_weight, _allow_new_product, _status, NOW(), NOW());
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_upsert_storage_type: %', SQLERRM;
    END;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_all_storage_type()
RETURNS TABLE (
    id                UUID,
    name              VARCHAR,
    maximum_weight    VARCHAR,
    allow_new_product BOOLEAN,
    status            INT,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, maximum_weight, allow_new_product, status, created_at, updated_at
    FROM storage_type;
END;
$$;

CREATE OR REPLACE FUNCTION fn_get_storage_type_by_id(
    _id UUID
)
RETURNS TABLE (
    id                UUID,
    name              VARCHAR,
    maximum_weight    VARCHAR,
    allow_new_product BOOLEAN,
    status            INT,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, maximum_weight, allow_new_product, status, created_at, updated_at
    FROM storage_type
    WHERE id = _id;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_storage_type(
    IN _id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        UPDATE storage_type
        SET
            status = 0,
            updated_at = NOW()
        WHERE id = _id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'No existe un storage_type con id %', _id;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error en sp_delete_storage_type: %', SQLERRM;
    END;
END;
$$;


