-- =========================================
-- USERS
-- =========================================
-- user_system
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

-- role
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

-- permission
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

-- role_permission
CREATE OR REPLACE FUNCTION fn_get_all_role_permissions()
RETURNS TABLE (
    id            UUID,
    role_id       UUID,
    permission_id UUID,
    is_deleted    BOOLEAN,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, role_id, permission_id, is_deleted, created_at, updated_at
      FROM role_permission;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_role_permission_by_id(_id UUID)
RETURNS TABLE (
    id            UUID,
    role_id       UUID,
    permission_id UUID,
    is_deleted    BOOLEAN,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, role_id, permission_id, is_deleted, created_at, updated_at
      FROM role_permission
     WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_role_permissions_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id            UUID,
    role_id       UUID,
    permission_id UUID,
    is_deleted    BOOLEAN,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, role_id, permission_id, is_deleted, created_at, updated_at
      FROM role_permission
     WHERE is_deleted = _is_deleted;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_role_permissions_by_role(_role_id UUID)
RETURNS TABLE (
    id            UUID,
    role_id       UUID,
    permission_id UUID,
    is_deleted    BOOLEAN,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, role_id, permission_id, is_deleted, created_at, updated_at
      FROM role_permission
     WHERE role_id = _role_id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_role_permissions_by_permission(_permission_id UUID)
RETURNS TABLE (
    id            UUID,
    role_id       UUID,
    permission_id UUID,
    is_deleted    BOOLEAN,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, role_id, permission_id, is_deleted, created_at, updated_at
      FROM role_permission
     WHERE permission_id = _permission_id;
END;
$$;

-- =========================================
-- BRANCHES
-- =========================================
-- branch
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

-- pos
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

-- shift
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

-- employee_shift
CREATE OR REPLACE FUNCTION fn_get_all_employee_shifts()
RETURNS TABLE (
    id          UUID,
    employee_id UUID,
    shift_id    UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, shift_id, is_deleted, created_at, updated_at
      FROM employee_shift;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_employee_shift_by_id(_id UUID)
RETURNS TABLE (
    id          UUID,
    employee_id UUID,
    shift_id    UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, shift_id, is_deleted, created_at, updated_at
      FROM employee_shift
     WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_employee_shifts_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id          UUID,
    employee_id UUID,
    shift_id    UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, shift_id, is_deleted, created_at, updated_at
      FROM employee_shift
     WHERE is_deleted = _is_deleted;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_employee_shifts_by_employee(_employee_id UUID)
RETURNS TABLE (
    id          UUID,
    employee_id UUID,
    shift_id    UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, shift_id, is_deleted, created_at, updated_at
      FROM employee_shift
     WHERE employee_id = _employee_id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_employee_shifts_by_shift(_shift_id UUID)
RETURNS TABLE (
    id          UUID,
    employee_id UUID,
    shift_id    UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, shift_id, is_deleted, created_at, updated_at
      FROM employee_shift
     WHERE shift_id = _shift_id;
END;
$$;

-- =========================================
-- SALES
-- =========================================
-- sale
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

-- sale_order
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
CREATE OR REPLACE FUNCTION fn_get_sale_orders_by_order_id(_order_id UUID)
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

-- sale_condition
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

-- sales_channel
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

-- discount
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

-- tax
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

-- product_tax
CREATE OR REPLACE FUNCTION fn_get_all_product_taxes()
RETURNS TABLE (
    id          UUID,
    product_id  UUID,
    tax_id      UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, product_id, tax_id, is_deleted, created_at, updated_at
      FROM product_tax;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_product_tax_by_id(_id UUID)
RETURNS TABLE (
    id          UUID,
    product_id  UUID,
    tax_id      UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, product_id, tax_id, is_deleted, created_at, updated_at
      FROM product_tax
     WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_product_taxes_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id          UUID,
    product_id  UUID,
    tax_id      UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, product_id, tax_id, is_deleted, created_at, updated_at
      FROM product_tax
     WHERE is_deleted = _is_deleted;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_product_taxes_by_product(_product_id UUID)
RETURNS TABLE (
    id          UUID,
    product_id  UUID,
    tax_id      UUID,
    is_deleted  BOOLEAN,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, product_id, tax_id, is_deleted, created_at, updated_at
      FROM product_tax
     WHERE product_id = _product_id;
END;
$$;

-- =========================================
-- CASH
-- =========================================
-- cash_register
CREATE OR REPLACE FUNCTION fn_get_all_cash_registers()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, branch_id, is_deleted, created_at, updated_at
    FROM cash_register;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, branch_id, is_deleted, created_at, updated_at
    FROM cash_register
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_registers_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, branch_id, is_deleted, created_at, updated_at
    FROM cash_register
    WHERE is_deleted = _is_deleted;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_registers_by_branch(_branch_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, branch_id, is_deleted, created_at, updated_at
    FROM cash_register
    WHERE branch_id = _branch_id;
END;
$$;

-- cash_register_session
CREATE OR REPLACE FUNCTION fn_get_all_cash_register_sessions()
RETURNS TABLE (
    id UUID,
    cash_register_id UUID,
    employee_id UUID,
    opening_balance DECIMAL,
    closing_balance DECIMAL,
    opened_at TIMESTAMP,
    closed_at TIMESTAMP,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opening_balance, closing_balance, opened_at, closed_at, is_deleted, created_at, updated_at
    FROM cash_register_session;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_session_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    cash_register_id UUID,
    employee_id UUID,
    opening_balance DECIMAL,
    closing_balance DECIMAL,
    opened_at TIMESTAMP,
    closed_at TIMESTAMP,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opening_balance, closing_balance, opened_at, closed_at, is_deleted, created_at, updated_at
    FROM cash_register_session
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_sessions_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    cash_register_id UUID,
    employee_id UUID,
    opening_balance DECIMAL,
    closing_balance DECIMAL,
    opened_at TIMESTAMP,
    closed_at TIMESTAMP,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opening_balance, closing_balance, opened_at, closed_at, is_deleted, created_at, updated_at
    FROM cash_register_session
    WHERE is_deleted = _is_deleted;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_sessions_by_cash_register(_cash_register_id UUID)
RETURNS TABLE (
    id UUID,
    cash_register_id UUID,
    employee_id UUID,
    opening_balance DECIMAL,
    closing_balance DECIMAL,
    opened_at TIMESTAMP,
    closed_at TIMESTAMP,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_id, employee_id, opening_balance, closing_balance, opened_at, closed_at, is_deleted, created_at, updated_at
    FROM cash_register_session
    WHERE cash_register_id = _cash_register_id;
END;
$$;

-- cash_register_movement
CREATE OR REPLACE FUNCTION fn_get_all_cash_register_movements()
RETURNS TABLE (
    id UUID,
    cash_register_session_id UUID,
    movement_type_id UUID,
    amount DECIMAL,
    description VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_session_id, movement_type_id, amount, description, created_at, updated_at, is_deleted
    FROM cash_register_movement;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_movement_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    cash_register_session_id UUID,
    movement_type_id UUID,
    amount DECIMAL,
    description VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_session_id, movement_type_id, amount, description, created_at, updated_at, is_deleted
    FROM cash_register_movement
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_movements_by_session(_session_id UUID)
RETURNS TABLE (
    id UUID,
    cash_register_session_id UUID,
    movement_type_id UUID,
    amount DECIMAL,
    description VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_session_id, movement_type_id, amount, description, created_at, updated_at, is_deleted
    FROM cash_register_movement
    WHERE cash_register_session_id = _session_id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_movements_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    cash_register_session_id UUID,
    movement_type_id UUID,
    amount DECIMAL,
    description VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_session_id, movement_type_id, amount, description, created_at, updated_at, is_deleted
    FROM cash_register_movement
    WHERE is_deleted = _is_deleted;
END;
$$;

-- cash_register_session_approval
CREATE OR REPLACE FUNCTION fn_get_all_cash_register_session_approvals()
RETURNS TABLE (
    id UUID,
    cash_register_session_id UUID,
    approver_id UUID,
    approval_time TIMESTAMP,
    is_approved BOOLEAN,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_session_id, approver_id, approval_time, is_approved, is_deleted, created_at, updated_at
    FROM cash_register_session_approval;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_session_approval_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    cash_register_session_id UUID,
    approver_id UUID,
    approval_time TIMESTAMP,
    is_approved BOOLEAN,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_session_id, approver_id, approval_time, is_approved, is_deleted, created_at, updated_at
    FROM cash_register_session_approval
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_session_approvals_by_session(_session_id UUID)
RETURNS TABLE (
    id UUID,
    cash_register_session_id UUID,
    approver_id UUID,
    approval_time TIMESTAMP,
    is_approved BOOLEAN,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_session_id, approver_id, approval_time, is_approved, is_deleted, created_at, updated_at
    FROM cash_register_session_approval
    WHERE cash_register_session_id = _session_id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_session_approvals_by_approver(_approver_id UUID)
RETURNS TABLE (
    id UUID,
    cash_register_session_id UUID,
    approver_id UUID,
    approval_time TIMESTAMP,
    is_approved BOOLEAN,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_session_id, approver_id, approval_time, is_approved, is_deleted, created_at, updated_at
    FROM cash_register_session_approval
    WHERE approver_id = _approver_id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_cash_register_session_approvals_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    cash_register_session_id UUID,
    approver_id UUID,
    approval_time TIMESTAMP,
    is_approved BOOLEAN,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, cash_register_session_id, approver_id, approval_time, is_approved, is_deleted, created_at, updated_at
    FROM cash_register_session_approval
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- INVOICING
-- =========================================
-- invoice
CREATE OR REPLACE FUNCTION fn_get_all_invoices()
RETURNS TABLE (
    id UUID,
    sale_id UUID,
    invoice_number VARCHAR,
    invoice_date TIMESTAMP,
    total DECIMAL,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_id, invoice_number, invoice_date, total, is_deleted, created_at, updated_at
    FROM invoice;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_invoice_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    sale_id UUID,
    invoice_number VARCHAR,
    invoice_date TIMESTAMP,
    total DECIMAL,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_id, invoice_number, invoice_date, total, is_deleted, created_at, updated_at
    FROM invoice
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_invoices_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    sale_id UUID,
    invoice_number VARCHAR,
    invoice_date TIMESTAMP,
    total DECIMAL,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_id, invoice_number, invoice_date, total, is_deleted, created_at, updated_at
    FROM invoice
    WHERE is_deleted = _is_deleted;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_invoices_by_sale(_sale_id UUID)
RETURNS TABLE (
    id UUID,
    sale_id UUID,
    invoice_number VARCHAR,
    invoice_date TIMESTAMP,
    total DECIMAL,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, sale_id, invoice_number, invoice_date, total, is_deleted, created_at, updated_at
    FROM invoice
    WHERE sale_id = _sale_id;
END;
$$;

-- receipt_type
CREATE OR REPLACE FUNCTION fn_get_all_receipt_types()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM receipt_type;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_receipt_type_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
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
CREATE OR REPLACE FUNCTION fn_get_receipt_types_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
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
-- customer
CREATE OR REPLACE FUNCTION fn_get_all_customers()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    email VARCHAR,
    phone VARCHAR,
    address VARCHAR,
    id_type_id UUID,
    loyalty_program_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, email, phone, address, id_type_id, loyalty_program_id, is_deleted, created_at, updated_at
    FROM customer;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_customer_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    email VARCHAR,
    phone VARCHAR,
    address VARCHAR,
    id_type_id UUID,
    loyalty_program_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, email, phone, address, id_type_id, loyalty_program_id, is_deleted, created_at, updated_at
    FROM customer
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_customers_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    email VARCHAR,
    phone VARCHAR,
    address VARCHAR,
    id_type_id UUID,
    loyalty_program_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, email, phone, address, id_type_id, loyalty_program_id, is_deleted, created_at, updated_at
    FROM customer
    WHERE is_deleted = _is_deleted;
END;
$$;

-- id_type
CREATE OR REPLACE FUNCTION fn_get_all_id_types()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM id_type;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_id_type_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM id_type
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_id_types_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM id_type
    WHERE is_deleted = _is_deleted;
END;
$$;

-- loyalty_program
CREATE OR REPLACE FUNCTION fn_get_all_loyalty_programs()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    points_required INT,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, points_required, is_deleted, created_at, updated_at
    FROM loyalty_program;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_loyalty_program_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    points_required INT,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, points_required, is_deleted, created_at, updated_at
    FROM loyalty_program
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_loyalty_programs_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    points_required INT,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, points_required, is_deleted, created_at, updated_at
    FROM loyalty_program
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- ORDERS
-- =========================================
-- orders
CREATE OR REPLACE FUNCTION fn_get_all_orders()
RETURNS TABLE (
    id UUID,
    customer_id UUID,
    order_type_id UUID,
    reservation_id UUID,
    table_restaurant_id UUID,
    order_date TIMESTAMP,
    status VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, order_type_id, reservation_id, table_restaurant_id, order_date, status, is_deleted, created_at, updated_at
    FROM orders;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_order_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    customer_id UUID,
    order_type_id UUID,
    reservation_id UUID,
    table_restaurant_id UUID,
    order_date TIMESTAMP,
    status VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, order_type_id, reservation_id, table_restaurant_id, order_date, status, is_deleted, created_at, updated_at
    FROM orders
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_orders_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    customer_id UUID,
    order_type_id UUID,
    reservation_id UUID,
    table_restaurant_id UUID,
    order_date TIMESTAMP,
    status VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, order_type_id, reservation_id, table_restaurant_id, order_date, status, is_deleted, created_at, updated_at
    FROM orders
    WHERE is_deleted = _is_deleted;
END;
$$;

-- order_detail
CREATE OR REPLACE FUNCTION fn_get_all_order_details()
RETURNS TABLE (
    id UUID,
    order_id UUID,
    product_id UUID,
    quantity INT,
    price DECIMAL,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, order_id, product_id, quantity, price, is_deleted, created_at, updated_at
    FROM order_detail;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_order_detail_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    order_id UUID,
    product_id UUID,
    quantity INT,
    price DECIMAL,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, order_id, product_id, quantity, price, is_deleted, created_at, updated_at
    FROM order_detail
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_order_details_by_order(_order_id UUID)
RETURNS TABLE (
    id UUID,
    order_id UUID,
    product_id UUID,
    quantity INT,
    price DECIMAL,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, order_id, product_id, quantity, price, is_deleted, created_at, updated_at
    FROM order_detail
    WHERE order_id = _order_id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_order_details_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    order_id UUID,
    product_id UUID,
    quantity INT,
    price DECIMAL,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, order_id, product_id, quantity, price, is_deleted, created_at, updated_at
    FROM order_detail
    WHERE is_deleted = _is_deleted;
END;
$$;

-- order_type
CREATE OR REPLACE FUNCTION fn_get_all_order_types()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM order_type;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_order_type_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM order_type
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_order_types_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM order_type
    WHERE is_deleted = _is_deleted;
END;
$$;

-- reservation
CREATE OR REPLACE FUNCTION fn_get_all_reservations()
RETURNS TABLE (
    id UUID,
    customer_id UUID,
    reservation_date TIMESTAMP,
    table_restaurant_id UUID,
    status VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, reservation_date, table_restaurant_id, status, is_deleted, created_at, updated_at
    FROM reservation;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_reservation_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    customer_id UUID,
    reservation_date TIMESTAMP,
    table_restaurant_id UUID,
    status VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, reservation_date, table_restaurant_id, status, is_deleted, created_at, updated_at
    FROM reservation
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_reservations_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    customer_id UUID,
    reservation_date TIMESTAMP,
    table_restaurant_id UUID,
    status VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, customer_id, reservation_date, table_restaurant_id, status, is_deleted, created_at, updated_at
    FROM reservation
    WHERE is_deleted = _is_deleted;
END;
$$;

-- table_restaurant
CREATE OR REPLACE FUNCTION fn_get_all_table_restaurants()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    capacity INT,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, capacity, branch_id, is_deleted, created_at, updated_at
    FROM table_restaurant;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_table_restaurant_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    capacity INT,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, capacity, branch_id, is_deleted, created_at, updated_at
    FROM table_restaurant
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_table_restaurants_by_branch(_branch_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    capacity INT,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, capacity, branch_id, is_deleted, created_at, updated_at
    FROM table_restaurant
    WHERE branch_id = _branch_id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_table_restaurants_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    capacity INT,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, capacity, branch_id, is_deleted, created_at, updated_at
    FROM table_restaurant
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- AUDIT
-- =========================================
-- audit_log
CREATE OR REPLACE FUNCTION fn_get_all_audit_logs()
RETURNS TABLE (
    id UUID,
    employee_id UUID,
    action VARCHAR,
    entity_name VARCHAR,
    entity_id UUID,
    timestamp TIMESTAMP,
    description VARCHAR,
    is_deleted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, action, entity_name, entity_id, timestamp, description, is_deleted
    FROM audit_log;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_audit_log_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    employee_id UUID,
    action VARCHAR,
    entity_name VARCHAR,
    entity_id UUID,
    timestamp TIMESTAMP,
    description VARCHAR,
    is_deleted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, action, entity_name, entity_id, timestamp, description, is_deleted
    FROM audit_log
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_audit_logs_by_employee(_employee_id UUID)
RETURNS TABLE (
    id UUID,
    employee_id UUID,
    action VARCHAR,
    entity_name VARCHAR,
    entity_id UUID,
    timestamp TIMESTAMP,
    description VARCHAR,
    is_deleted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, action, entity_name, entity_id, timestamp, description, is_deleted
    FROM audit_log
    WHERE employee_id = _employee_id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_audit_logs_by_action(_action VARCHAR)
RETURNS TABLE (
    id UUID,
    employee_id UUID,
    action VARCHAR,
    entity_name VARCHAR,
    entity_id UUID,
    timestamp TIMESTAMP,
    description VARCHAR,
    is_deleted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, action, entity_name, entity_id, timestamp, description, is_deleted
    FROM audit_log
    WHERE action = _action;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_audit_logs_by_entity(_entity_name VARCHAR)
RETURNS TABLE (
    id UUID,
    employee_id UUID,
    action VARCHAR,
    entity_name VARCHAR,
    entity_id UUID,
    timestamp TIMESTAMP,
    description VARCHAR,
    is_deleted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, action, entity_name, entity_id, timestamp, description, is_deleted
    FROM audit_log
    WHERE entity_name = _entity_name;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_audit_logs_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    employee_id UUID,
    action VARCHAR,
    entity_name VARCHAR,
    entity_id UUID,
    timestamp TIMESTAMP,
    description VARCHAR,
    is_deleted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, employee_id, action, entity_name, entity_id, timestamp, description, is_deleted
    FROM audit_log
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- MOVEMENTS
-- =========================================
-- movement_type
CREATE OR REPLACE FUNCTION fn_get_all_movement_types()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM movement_type;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_movement_type_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM movement_type
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_movement_types_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, is_deleted, created_at, updated_at
    FROM movement_type
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- WAREHOUSE
-- =========================================
-- warehouse
CREATE OR REPLACE FUNCTION fn_get_all_warehouses()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    address VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, address, branch_id, is_deleted, created_at, updated_at
    FROM warehouse;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_warehouse_by_id(_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    address VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, address, branch_id, is_deleted, created_at, updated_at
    FROM warehouse
    WHERE id = _id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_warehouses_by_branch(_branch_id UUID)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    address VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, address, branch_id, is_deleted, created_at, updated_at
    FROM warehouse
    WHERE branch_id = _branch_id;
END;
$$;
CREATE OR REPLACE FUNCTION fn_get_warehouses_by_deleted(_is_deleted BOOLEAN)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    address VARCHAR,
    branch_id UUID,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, address, branch_id, is_deleted, created_at, updated_at
    FROM warehouse
    WHERE is_deleted = _is_deleted;
END;
$$;

-- =========================================
-- DASHBOARD
-- =========================================

-- Menu: Obtener menú de hoy
CREATE OR REPLACE FUNCTION fn_get_menu_today()
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    available_date DATE,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, available_date, created_at, updated_at
    FROM menu
    WHERE available_date = CURRENT_DATE;
END;
$$;

-- Menu: Mostrar todos los menús en un rango de fechas
CREATE OR REPLACE FUNCTION fn_get_menus_by_date_range(_start DATE, _end DATE)
RETURNS TABLE (
    id UUID,
    name VARCHAR,
    description VARCHAR,
    available_date DATE,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, description, available_date, created_at, updated_at
    FROM menu
    WHERE available_date BETWEEN _start AND _end;
END;
$$;

-- Kitchen: Órdenes en preparación
CREATE OR REPLACE FUNCTION fn_get_orders_in_preparation()
RETURNS TABLE (
    id UUID,
    table_id UUID,
    status VARCHAR,
    order_time TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, table_id, status, order_time, created_at, updated_at
    FROM orders
    WHERE status = 'in-preparation';
END;
$$;


-- =========================================
-- RESTO DE FUNCIONES (si alguna no encaja en las secciones anteriores)
-- =========================================
