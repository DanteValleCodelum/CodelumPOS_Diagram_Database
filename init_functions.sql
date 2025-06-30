-- =========================================
-- 1. CRUD Usuarios 
-- =========================================
-- 1.1. User en user_system 
CREATE OR REPLACE FUNCTION fn_get_all_user_system_by_status(_status INT)
RETURNS TABLE (
    id           UUID,
    username     VARCHAR,
    password     VARCHAR,
    role_id      UUID,
    employee_id  UUID,
    status       INT,
    created_at   TIMESTAMP,
    updated_at   TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM user_system
    WHERE status = _status;
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
