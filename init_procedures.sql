-- =========================================
-- USERS
-- =========================================
-- SELECT para user_system
CREATE PROCEDURE sp_select_user_system
AS
BEGIN
    SELECT * FROM user_system;
END;
GO
-- SELECT por ID para user_system
CREATE PROCEDURE sp_select_user_system_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM user_system WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de user_system
CREATE PROCEDURE sp_upsert_user_system
    @id UNIQUEIDENTIFIER = NULL,
    @username VARCHAR(50),
    @password VARCHAR(50),
    @role_id UNIQUEIDENTIFIER,
    @employee_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM user_system WHERE id = @id)
    BEGIN
        UPDATE user_system
        SET username = @username, role_id = @role_id, password = @password, employee_id = @employee_id, updated_at = SYSDATETIME()
        WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO user_system(username, password, role_id, employee_id, created_at, updated_at)
        VALUES (@username, @password, @role_id, @employee_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- Adaptación a T-SQL del cambio de password
CREATE PROCEDURE sp_upsert_user_password
    @user_id UNIQUEIDENTIFIER,
    @password VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE user_system SET password = @password, updated_at = SYSDATETIME() WHERE id = @user_id;
END;
GO
-- Roles
-- SELECT para role
CREATE PROCEDURE sp_select_role
AS
BEGIN
    SELECT * FROM role;
END;
GO
-- SELECT por ID para role
CREATE PROCEDURE sp_select_role_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM role WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de role
CREATE PROCEDURE sp_upsert_role
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM role WHERE id = @id)
    BEGIN
        UPDATE role SET name = @name, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO role(name, created_at, updated_at) VALUES (@name, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- Permissions
-- SELECT para permission
CREATE PROCEDURE sp_select_permission
AS
BEGIN
    SELECT * FROM permission;
END;
GO
-- SELECT por ID para permission
CREATE PROCEDURE sp_select_permission_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM permission WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de permission
CREATE PROCEDURE sp_upsert_permission
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @description VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM permission WHERE id = @id)
    BEGIN
        UPDATE permission SET name = @name, description = @description, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO permission(name, description, created_at, updated_at) VALUES (@name, @description, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- shift
-- SELECT para shift
CREATE PROCEDURE sp_select_shift
AS
BEGIN
    SELECT * FROM shift;
END;
GO
-- SELECT por ID para shift
CREATE PROCEDURE sp_select_shift_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM shift WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de shift
CREATE PROCEDURE sp_upsert_shift
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @start_time DATETIME,
    @end_time DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM shift WHERE id = @id)
    BEGIN
        UPDATE shift SET name = @name, start_time = @start_time, end_time = @end_time, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO shift(name, start_time, end_time, created_at, updated_at) VALUES (@name, @start_time, @end_time, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- Employee
-- SELECT para employee
CREATE PROCEDURE sp_select_employee
AS
BEGIN
    SELECT * FROM employee;
END;
GO
-- SELECT por ID para employee
CREATE PROCEDURE sp_select_employee_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM employee WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de employee
CREATE PROCEDURE sp_upsert_employee
    @id UNIQUEIDENTIFIER = NULL,
    @first_name VARCHAR(50),
    @last_name VARCHAR(50),
    @phone VARCHAR(50),
    @start_date DATETIME,
    @end_date DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM employee WHERE id = @id)
    BEGIN
        UPDATE employee SET first_name = @first_name, last_name = @last_name, phone = @phone, start_date = @start_date, end_date = @end_date, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO employee(first_name, last_name, phone, start_date, end_date, created_at, updated_at) VALUES (@first_name, @last_name, @phone, @start_date, @end_date, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_employee(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employee SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- employee_shift
-- SELECT para employee_shift
CREATE PROCEDURE sp_select_employee_shift
AS
BEGIN
    SELECT * FROM employee_shift;
END;
GO
-- SELECT por ID para employee_shift
CREATE PROCEDURE sp_select_employee_shift_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM employee_shift WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de employee_shift
CREATE PROCEDURE sp_upsert_employee_shift
    @id UNIQUEIDENTIFIER = NULL,
    @employee_id UNIQUEIDENTIFIER,
    @shift_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM employee_shift WHERE id = @id)
    BEGIN
        UPDATE employee_shift SET employee_id = @employee_id, shift_id = @shift_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO employee_shift(employee_id, shift_id, created_at, updated_at) VALUES (@employee_id, @shift_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_employee_shift(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employee_shift SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- =========================================
-- BRANCHES
-- =========================================
-- SELECT para branch
CREATE PROCEDURE sp_select_branch
AS
BEGIN
    SELECT * FROM branch;
END;
GO
-- SELECT por ID para branch
CREATE PROCEDURE sp_select_branch_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM branch WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de branch
CREATE PROCEDURE sp_upsert_branch
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @country VARCHAR(50),
    @city VARCHAR(50),
    @address VARCHAR(50),
    @phone VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM branch WHERE id = @id)
    BEGIN
        UPDATE branch SET name = @name, country = @country, city = @city, address = @address, phone = @phone, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO branch(name, country, city, address, phone, created_at, updated_at) VALUES (@name, @country, @city, @address, @phone, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_branch(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE branch SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- SELECT para pos
CREATE PROCEDURE sp_select_pos
AS
BEGIN
    SELECT * FROM pos;
END;
GO
-- SELECT por ID para pos
CREATE PROCEDURE sp_select_pos_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM pos WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de pos
CREATE PROCEDURE sp_upsert_pos
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @branch_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM pos WHERE id = @id)
    BEGIN
        UPDATE pos SET name = @name, branch_id = @branch_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO pos(name, branch_id, created_at, updated_at) VALUES (@name, @branch_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_pos(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE pos SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- SELECT para table_restaurant
CREATE PROCEDURE sp_select_table_restaurant
AS
BEGIN
    SELECT * FROM table_restaurant;
END;
GO
-- SELECT por ID para table_restaurant
CREATE PROCEDURE sp_select_table_restaurant_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM table_restaurant WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de table_restaurant
CREATE PROCEDURE sp_upsert_table_restaurant
    @id UNIQUEIDENTIFIER = NULL,
    @number INT,
    @capacity INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM table_restaurant WHERE id = @id)
    BEGIN
        UPDATE table_restaurant SET number = @number, capacity = @capacity, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO table_restaurant(number, capacity, created_at, updated_at) VALUES (@number, @capacity, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_table_restaurant(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE table_restaurant SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- SELECT para reservation
CREATE PROCEDURE sp_select_reservation
AS
BEGIN
    SELECT * FROM reservation;
END;
GO
-- SELECT por ID para reservation
CREATE PROCEDURE sp_select_reservation_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM reservation WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de reservation
CREATE PROCEDURE sp_upsert_reservation
    @id UNIQUEIDENTIFIER = NULL,
    @customer_id UNIQUEIDENTIFIER,
    @table_id UNIQUEIDENTIFIER,
    @reservation_date DATETIME,
    @number_of_people INT,
    @note VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM reservation WHERE id = @id)
    BEGIN
        UPDATE reservation SET customer_id = @customer_id, table_id = @table_id, reservation_date = @reservation_date, number_of_people = @number_of_people, note = @note, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO reservation(customer_id, table_id, reservation_date, number_of_people, note, created_at, updated_at) VALUES (@customer_id, @table_id, @reservation_date, @number_of_people, @note, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_reservation(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE reservation SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- =========================================
-- SALES
-- =========================================
-- SELECT para sale
CREATE PROCEDURE sp_select_sale
AS
BEGIN
    SELECT * FROM sale;
END;
GO
-- SELECT por ID para sale
CREATE PROCEDURE sp_select_sale_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM sale WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de sale
CREATE PROCEDURE sp_upsert_sale
    @id UNIQUEIDENTIFIER = NULL,
    @sale_date DATETIME,
    @employee_id UNIQUEIDENTIFIER,
    @total DECIMAL(10,2),
    @customer_id UNIQUEIDENTIFIER = NULL,
    @receipt_type_id UNIQUEIDENTIFIER = NULL,
    @payment_method_id UNIQUEIDENTIFIER = NULL,
    @sales_channel_id UNIQUEIDENTIFIER = NULL,
    @pos_id UNIQUEIDENTIFIER = NULL,
    @sale_condition_id UNIQUEIDENTIFIER = NULL,
    @discount_id UNIQUEIDENTIFIER = NULL,
    @credit_term VARCHAR(10) = NULL,
    @tax_id UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM sale WHERE id = @id)
    BEGIN
        UPDATE sale SET sale_date = @sale_date, employee_id = @employee_id, total = @total, customer_id = @customer_id, receipt_type_id = @receipt_type_id, payment_method_id = @payment_method_id, sales_channel_id = @sales_channel_id, pos_id = @pos_id, sale_condition_id = @sale_condition_id, discount_id = @discount_id, credit_term = @credit_term, tax_id = @tax_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO sale(sale_date, employee_id, total, customer_id, receipt_type_id, payment_method_id, sales_channel_id, pos_id, sale_condition_id, discount_id, credit_term, tax_id, created_at, updated_at) VALUES (@sale_date, @employee_id, @total, @customer_id, @receipt_type_id, @payment_method_id, @sales_channel_id, @pos_id, @sale_condition_id, @discount_id, @credit_term, @tax_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- Adaptación a T-SQL del UPSERT de sale_condition
CREATE PROCEDURE sp_upsert_sale_condition
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM sale_condition WHERE id = @id)
    BEGIN
        UPDATE sale_condition SET name = @name, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO sale_condition(name, created_at, updated_at) VALUES (@name, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- Adaptación a T-SQL del UPSERT de discount
CREATE PROCEDURE sp_upsert_discount
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @description VARCHAR(50),
    @discount_type VARCHAR(50),
    @value DECIMAL(10,2),
    @start_date DATETIME,
    @end_date DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM discount WHERE id = @id)
    BEGIN
        UPDATE discount SET name = @name, description = @description, discount_type = @discount_type, value = @value, start_date = @start_date, end_date = @end_date, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO discount(name, description, discount_type, value, start_date, end_date, created_at, updated_at) VALUES (@name, @description, @discount_type, @value, @start_date, @end_date, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- Roles
-- SELECT para role
CREATE PROCEDURE sp_select_role
AS
BEGIN
    SELECT * FROM role;
END;
GO
-- SELECT por ID para role
CREATE PROCEDURE sp_select_role_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM role WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de role
CREATE PROCEDURE sp_upsert_role
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM role WHERE id = @id)
    BEGIN
        UPDATE role SET name = @name, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO role(name, created_at, updated_at) VALUES (@name, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- Permissions
-- SELECT para permission
CREATE PROCEDURE sp_select_permission
AS
BEGIN
    SELECT * FROM permission;
END;
GO
-- SELECT por ID para permission
CREATE PROCEDURE sp_select_permission_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM permission WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de permission
CREATE PROCEDURE sp_upsert_permission
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @description VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM permission WHERE id = @id)
    BEGIN
        UPDATE permission SET name = @name, description = @description, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO permission(name, description, created_at, updated_at) VALUES (@name, @description, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- shift
-- SELECT para shift
CREATE PROCEDURE sp_select_shift
AS
BEGIN
    SELECT * FROM shift;
END;
GO
-- SELECT por ID para shift
CREATE PROCEDURE sp_select_shift_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM shift WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de shift
CREATE PROCEDURE sp_upsert_shift
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @start_time DATETIME,
    @end_time DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM shift WHERE id = @id)
    BEGIN
        UPDATE shift SET name = @name, start_time = @start_time, end_time = @end_time, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO shift(name, start_time, end_time, created_at, updated_at) VALUES (@name, @start_time, @end_time, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- Employee
-- SELECT para employee
CREATE PROCEDURE sp_select_employee
AS
BEGIN
    SELECT * FROM employee;
END;
GO
-- SELECT por ID para employee
CREATE PROCEDURE sp_select_employee_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM employee WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de employee
CREATE PROCEDURE sp_upsert_employee
    @id UNIQUEIDENTIFIER = NULL,
    @first_name VARCHAR(50),
    @last_name VARCHAR(50),
    @phone VARCHAR(50),
    @start_date DATETIME,
    @end_date DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM employee WHERE id = @id)
    BEGIN
        UPDATE employee SET first_name = @first_name, last_name = @last_name, phone = @phone, start_date = @start_date, end_date = @end_date, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO employee(first_name, last_name, phone, start_date, end_date, created_at, updated_at) VALUES (@first_name, @last_name, @phone, @start_date, @end_date, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_employee(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employee SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- employee_shift
-- SELECT para employee_shift
CREATE PROCEDURE sp_select_employee_shift
AS
BEGIN
    SELECT * FROM employee_shift;
END;
GO
-- SELECT por ID para employee_shift
CREATE PROCEDURE sp_select_employee_shift_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM employee_shift WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de employee_shift
CREATE PROCEDURE sp_upsert_employee_shift
    @id UNIQUEIDENTIFIER = NULL,
    @employee_id UNIQUEIDENTIFIER,
    @shift_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM employee_shift WHERE id = @id)
    BEGIN
        UPDATE employee_shift SET employee_id = @employee_id, shift_id = @shift_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO employee_shift(employee_id, shift_id, created_at, updated_at) VALUES (@employee_id, @shift_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_employee_shift(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employee_shift SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- =========================================
-- BRANCHES
-- =========================================
-- SELECT para branch
CREATE PROCEDURE sp_select_branch
AS
BEGIN
    SELECT * FROM branch;
END;
GO
-- SELECT por ID para branch
CREATE PROCEDURE sp_select_branch_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM branch WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de branch
CREATE PROCEDURE sp_upsert_branch
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @country VARCHAR(50),
    @city VARCHAR(50),
    @address VARCHAR(50),
    @phone VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM branch WHERE id = @id)
    BEGIN
        UPDATE branch SET name = @name, country = @country, city = @city, address = @address, phone = @phone, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO branch(name, country, city, address, phone, created_at, updated_at) VALUES (@name, @country, @city, @address, @phone, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_branch(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE branch SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- SELECT para pos
CREATE PROCEDURE sp_select_pos
AS
BEGIN
    SELECT * FROM pos;
END;
GO
-- SELECT por ID para pos
CREATE PROCEDURE sp_select_pos_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM pos WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de pos
CREATE PROCEDURE sp_upsert_pos
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @branch_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM pos WHERE id = @id)
    BEGIN
        UPDATE pos SET name = @name, branch_id = @branch_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO pos(name, branch_id, created_at, updated_at) VALUES (@name, @branch_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_pos(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE pos SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- SELECT para table_restaurant
CREATE PROCEDURE sp_select_table_restaurant
AS
BEGIN
    SELECT * FROM table_restaurant;
END;
GO
-- SELECT por ID para table_restaurant
CREATE PROCEDURE sp_select_table_restaurant_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM table_restaurant WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de table_restaurant
CREATE PROCEDURE sp_upsert_table_restaurant
    @id UNIQUEIDENTIFIER = NULL,
    @number INT,
    @capacity INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM table_restaurant WHERE id = @id)
    BEGIN
        UPDATE table_restaurant SET number = @number, capacity = @capacity, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO table_restaurant(number, capacity, created_at, updated_at) VALUES (@number, @capacity, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_table_restaurant(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE table_restaurant SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- SELECT para reservation
CREATE PROCEDURE sp_select_reservation
AS
BEGIN
    SELECT * FROM reservation;
END;
GO
-- SELECT por ID para reservation
CREATE PROCEDURE sp_select_reservation_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM reservation WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de reservation
CREATE PROCEDURE sp_upsert_reservation
    @id UNIQUEIDENTIFIER = NULL,
    @customer_id UNIQUEIDENTIFIER,
    @table_id UNIQUEIDENTIFIER,
    @reservation_date DATETIME,
    @number_of_people INT,
    @note VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM reservation WHERE id = @id)
    BEGIN
        UPDATE reservation SET customer_id = @customer_id, table_id = @table_id, reservation_date = @reservation_date, number_of_people = @number_of_people, note = @note, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO reservation(customer_id, table_id, reservation_date, number_of_people, note, created_at, updated_at) VALUES (@customer_id, @table_id, @reservation_date, @number_of_people, @note, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
CREATE OR REPLACE PROCEDURE sp_delete_reservation(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE reservation SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- =========================================
-- CASH
-- =========================================
-- SELECT para cash_register
CREATE PROCEDURE sp_select_cash_register
AS
BEGIN
    SELECT * FROM cash_register;
END;
GO
-- SELECT por ID para cash_register
CREATE PROCEDURE sp_select_cash_register_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM cash_register WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de cash_register
CREATE PROCEDURE sp_upsert_cash_register
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @pos_id UNIQUEIDENTIFIER,
    @description VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM cash_register WHERE id = @id)
    BEGIN
        UPDATE cash_register SET name = @name, pos_id = @pos_id, description = @description, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO cash_register(name, pos_id, description, created_at, updated_at) VALUES (@name, @pos_id, @description, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para cash_register_session
CREATE PROCEDURE sp_select_cash_register_session
AS
BEGIN
    SELECT * FROM cash_register_session;
END;
GO
-- SELECT por ID para cash_register_session
CREATE PROCEDURE sp_select_cash_register_session_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM cash_register_session WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de cash_register_session
CREATE PROCEDURE sp_upsert_cash_register_session
    @id UNIQUEIDENTIFIER = NULL,
    @cash_register_id UNIQUEIDENTIFIER,
    @employee_id UNIQUEIDENTIFIER,
    @opened_at DATETIME,
    @closed_at DATETIME = NULL,
    @opening_amount DECIMAL(10,2),
    @closing_amount DECIMAL(10,2) = NULL,
    @expected_balance DECIMAL(10,2) = NULL,
    @discrepancy DECIMAL(10,2) = NULL,
    @status VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM cash_register_session WHERE id = @id)
    BEGIN
        UPDATE cash_register_session SET cash_register_id = @cash_register_id, employee_id = @employee_id, opened_at = @opened_at, closed_at = @closed_at, opening_amount = @opening_amount, closing_amount = @closing_amount, expected_balance = @expected_balance, discrepancy = @discrepancy, status = @status, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO cash_register_session(cash_register_id, employee_id, opened_at, closed_at, opening_amount, closing_amount, expected_balance, discrepancy, status, created_at, updated_at) VALUES (@cash_register_id, @employee_id, @opened_at, @closed_at, @opening_amount, @closing_amount, @expected_balance, @discrepancy, @status, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para cash_movement
CREATE PROCEDURE sp_select_cash_movement
AS
BEGIN
    SELECT * FROM cash_movement;
END;
GO
-- SELECT por ID para cash_movement
CREATE PROCEDURE sp_select_cash_movement_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM cash_movement WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de cash_movement
CREATE PROCEDURE sp_upsert_cash_movement
    @id UNIQUEIDENTIFIER = NULL,
    @session_id UNIQUEIDENTIFIER,
    @movement_type VARCHAR(50),
    @description TEXT,
    @amount DECIMAL(10,2),
    @performed_at DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM cash_movement WHERE id = @id)
    BEGIN
        UPDATE cash_movement SET session_id = @session_id, movement_type = @movement_type, description = @description, amount = @amount, performed_at = @performed_at, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO cash_movement(session_id, movement_type, description, amount, performed_at, updated_at) VALUES (@session_id, @movement_type, @description, @amount, @performed_at, SYSDATETIME());
    END
END;
GO
-- SELECT para session_approval
CREATE PROCEDURE sp_select_session_approval
AS
BEGIN
    SELECT * FROM session_approval;
END;
GO
-- SELECT por ID para session_approval
CREATE PROCEDURE sp_select_session_approval_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM session_approval WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de session_approval
CREATE PROCEDURE sp_upsert_session_approval
    @id UNIQUEIDENTIFIER = NULL,
    @session_id UNIQUEIDENTIFIER,
    @approved_by UNIQUEIDENTIFIER,
    @approved_at DATETIME,
    @note TEXT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM session_approval WHERE id = @id)
    BEGIN
        UPDATE session_approval SET session_id = @session_id, approved_by = @approved_by, approved_at = @approved_at, note = @note, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO session_approval(session_id, approved_by, approved_at, note, updated_at) VALUES (@session_id, @approved_by, @approved_at, @note, SYSDATETIME());
    END
END;
GO

-- =========================================
-- INVOICING
-- =========================================
-- SELECT para invoice
CREATE PROCEDURE sp_select_invoice
AS
BEGIN
    SELECT * FROM invoice;
END;
GO
-- SELECT por ID para invoice
CREATE PROCEDURE sp_select_invoice_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM invoice WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de invoice
CREATE PROCEDURE sp_upsert_invoice
    @id UNIQUEIDENTIFIER = NULL,
    @batch_id INT,
    @sale_id UNIQUEIDENTIFIER,
    @cash_register_id UNIQUEIDENTIFIER,
    @key_code VARCHAR(50),
    @consecutive_number VARCHAR(50),
    @issue_date DATETIME,
    @currency_code VARCHAR(10),
    @exchange_rate DECIMAL(10,2),
    @invoice_comment VARCHAR(255) = NULL,
    @document VARCHAR(255) = NULL,
    @email_copy VARCHAR(255) = NULL,
    @other_content VARCHAR(255) = NULL,
    @other_text VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM invoice WHERE id = @id)
    BEGIN
        UPDATE invoice SET batch_id = @batch_id, sale_id = @sale_id, cash_register_id = @cash_register_id, key_code = @key_code, consecutive_number = @consecutive_number, issue_date = @issue_date, currency_code = @currency_code, exchange_rate = @exchange_rate, invoice_comment = @invoice_comment, document = @document, email_copy = @email_copy, other_content = @other_content, other_text = @other_text, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO invoice(batch_id, sale_id, cash_register_id, key_code, consecutive_number, issue_date, currency_code, exchange_rate, invoice_comment, document, email_copy, other_content, other_text, created_at, updated_at) VALUES (@batch_id, @sale_id, @cash_register_id, @key_code, @consecutive_number, @issue_date, @currency_code, @exchange_rate, @invoice_comment, @document, @email_copy, @other_content, @other_text, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para receipt_type
CREATE PROCEDURE sp_select_receipt_type
AS
BEGIN
    SELECT * FROM receipt_type;
END;
GO
-- SELECT por ID para receipt_type
CREATE PROCEDURE sp_select_receipt_type_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM receipt_type WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de receipt_type
CREATE PROCEDURE sp_upsert_receipt_type
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @description VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM receipt_type WHERE id = @id)
    BEGIN
        UPDATE receipt_type SET name = @name, description = @description, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO receipt_type(name, description, created_at, updated_at) VALUES (@name, @description, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- =========================================
-- CUSTOMER
-- =========================================
-- SELECT para customer
CREATE PROCEDURE sp_select_customer
AS
BEGIN
    SELECT * FROM customer;
END;
GO
-- SELECT por ID para customer
CREATE PROCEDURE sp_select_customer_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM customer WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de customer
CREATE PROCEDURE sp_upsert_customer
    @id UNIQUEIDENTIFIER = NULL,
    @id_type_id UNIQUEIDENTIFIER,
    @id_number VARCHAR(50),
    @name VARCHAR(50),
    @lastname VARCHAR(50),
    @phone VARCHAR(50),
    @email VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM customer WHERE id = @id)
    BEGIN
        UPDATE customer SET id_type_id = @id_type_id, id_number = @id_number, name = @name, lastname = @lastname, phone = @phone, email = @email, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO customer(id_type_id, id_number, name, lastname, phone, email, created_at, updated_at) VALUES (@id_type_id, @id_number, @name, @lastname, @phone, @email, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para id_type
CREATE PROCEDURE sp_select_id_type
AS
BEGIN
    SELECT * FROM id_type;
END;
GO
-- SELECT por ID para id_type
CREATE PROCEDURE sp_select_id_type_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM id_type WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de id_type
CREATE PROCEDURE sp_upsert_id_type
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM id_type WHERE id = @id)
    BEGIN
        UPDATE id_type SET name = @name WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO id_type(name) VALUES (@name);
    END
END;
GO
-- SELECT para loyalty_program
CREATE PROCEDURE sp_select_loyalty_program
AS
BEGIN
    SELECT * FROM loyalty_program;
END;
GO
-- SELECT por ID para loyalty_program
CREATE PROCEDURE sp_select_loyalty_program_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM loyalty_program WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de loyalty_program
CREATE PROCEDURE sp_upsert_loyalty_program
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @points INT,
    @customer_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM loyalty_program WHERE id = @id)
    BEGIN
        UPDATE loyalty_program SET name = @name, points = @points, customer_id = @customer_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO loyalty_program(name, points, customer_id, created_at, updated_at) VALUES (@name, @points, @customer_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- =========================================
-- PAYMENTS
-- =========================================
-- SELECT para payment_method
CREATE PROCEDURE sp_select_payment_method
AS
BEGIN
    SELECT * FROM payment_method;
END;
GO
-- SELECT por ID para payment_method
CREATE PROCEDURE sp_select_payment_method_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM payment_method WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de payment_method
CREATE PROCEDURE sp_upsert_payment_method
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM payment_method WHERE id = @id)
    BEGIN
        UPDATE payment_method SET name = @name, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO payment_method(name, created_at, updated_at) VALUES (@name, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para payment_gateway
CREATE PROCEDURE sp_select_payment_gateway
AS
BEGIN
    SELECT * FROM payment_gateway;
END;
GO
-- SELECT por ID para payment_gateway
CREATE PROCEDURE sp_select_payment_gateway_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM payment_gateway WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de payment_gateway
CREATE PROCEDURE sp_upsert_payment_gateway
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @code VARCHAR(50),
    @config NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM payment_gateway WHERE id = @id)
    BEGIN
        UPDATE payment_gateway SET name = @name, code = @code, config = @config, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO payment_gateway(name, code, config, created_at, updated_at) VALUES (@name, @code, @config, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para gateway_customer
CREATE PROCEDURE sp_select_gateway_customer
AS
BEGIN
    SELECT * FROM gateway_customer;
END;
GO
-- SELECT por ID para gateway_customer
CREATE PROCEDURE sp_select_gateway_customer_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM gateway_customer WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de gateway_customer
CREATE PROCEDURE sp_upsert_gateway_customer
    @id UNIQUEIDENTIFIER = NULL,
    @customer_id UNIQUEIDENTIFIER,
    @payment_gateway_id UNIQUEIDENTIFIER,
    @config_json NVARCHAR(MAX) = NULL,
    @api_key VARCHAR(255) = NULL,
    @secret_key VARCHAR(255) = NULL,
    @redirect_url VARCHAR(255) = NULL,
    @external_customer_id VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM gateway_customer WHERE id = @id)
    BEGIN
        UPDATE gateway_customer SET customer_id = @customer_id, payment_gateway_id = @payment_gateway_id, config_json = @config_json, api_key = @api_key, secret_key = @secret_key, redirect_url = @redirect_url, external_customer_id = @external_customer_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO gateway_customer(customer_id, payment_gateway_id, config_json, api_key, secret_key, redirect_url, external_customer_id, created_at, updated_at) VALUES (@customer_id, @payment_gateway_id, @config_json, @api_key, @secret_key, @redirect_url, @external_customer_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para gateway_payment_methods
CREATE PROCEDURE sp_select_gateway_payment_methods
AS
BEGIN
    SELECT * FROM gateway_payment_methods;
END;
GO
-- SELECT por ID para gateway_payment_methods
CREATE PROCEDURE sp_select_gateway_payment_methods_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM gateway_payment_methods WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de gateway_payment_methods
CREATE PROCEDURE sp_upsert_gateway_payment_methods
    @id UNIQUEIDENTIFIER = NULL,
    @gateway_customer_id UNIQUEIDENTIFIER,
    @method_type VARCHAR(50),
    @external_method_id VARCHAR(255) = NULL,
    @meta_json NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM gateway_payment_methods WHERE id = @id)
    BEGIN
        UPDATE gateway_payment_methods SET gateway_customer_id = @gateway_customer_id, method_type = @method_type, external_method_id = @external_method_id, meta_json = @meta_json, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO gateway_payment_methods(gateway_customer_id, method_type, external_method_id, meta_json, created_at, updated_at) VALUES (@gateway_customer_id, @method_type, @external_method_id, @meta_json, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para gateway_transactions
CREATE PROCEDURE sp_select_gateway_transactions
AS
BEGIN
    SELECT * FROM gateway_transactions;
END;
GO
-- SELECT por ID para gateway_transactions
CREATE PROCEDURE sp_select_gateway_transactions_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM gateway_transactions WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de gateway_transactions
CREATE PROCEDURE sp_upsert_gateway_transactions
    @id UNIQUEIDENTIFIER = NULL,
    @gateway_customer_id UNIQUEIDENTIFIER,
    @gateway_payment_method_id UNIQUEIDENTIFIER,
    @amount DECIMAL(10,2),
    @currency VARCHAR(10),
    @status VARCHAR(50),
    @request_json NVARCHAR(MAX) = NULL,
    @response_json NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM gateway_transactions WHERE id = @id)
    BEGIN
        UPDATE gateway_transactions SET gateway_customer_id = @gateway_customer_id, gateway_payment_method_id = @gateway_payment_method_id, amount = @amount, currency = @currency, status = @status, request_json = @request_json, response_json = @response_json, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO gateway_transactions(gateway_customer_id, gateway_payment_method_id, amount, currency, status, request_json, response_json, created_at, updated_at) VALUES (@gateway_customer_id, @gateway_payment_method_id, @amount, @currency, @status, @request_json, @response_json, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- =========================================
-- INVENTORY
-- =========================================
-- SELECT para inventory
CREATE PROCEDURE sp_select_inventory
AS
BEGIN
    SELECT * FROM inventory;
END;
GO
-- SELECT por ID para inventory
CREATE PROCEDURE sp_select_inventory_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM inventory WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de inventory
CREATE PROCEDURE sp_upsert_inventory
    @id UNIQUEIDENTIFIER = NULL,
    @bar_code VARCHAR(50),
    @product_id UNIQUEIDENTIFIER,
    @warehouse_id UNIQUEIDENTIFIER,
    @min_stock INT,
    @max_stock INT,
    @current_stock INT,
    @alert_high_stock INT,
    @alert_low_stock INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM inventory WHERE id = @id)
    BEGIN
        UPDATE inventory SET bar_code = @bar_code, product_id = @product_id, warehouse_id = @warehouse_id, min_stock = @min_stock, max_stock = @max_stock, current_stock = @current_stock, alert_high_stock = @alert_high_stock, alert_low_stock = @alert_low_stock, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO inventory(bar_code, product_id, warehouse_id, min_stock, max_stock, current_stock, alert_high_stock, alert_low_stock, created_at, updated_at) VALUES (@bar_code, @product_id, @warehouse_id, @min_stock, @max_stock, @current_stock, @alert_high_stock, @alert_low_stock, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para supplier
CREATE PROCEDURE sp_select_supplier
AS
BEGIN
    SELECT * FROM supplier;
END;
GO
-- SELECT por ID para supplier
CREATE PROCEDURE sp_select_supplier_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM supplier WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de supplier
CREATE PROCEDURE sp_upsert_supplier
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @contact VARCHAR(50) = NULL,
    @email VARCHAR(50) = NULL,
    @address VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM supplier WHERE id = @id)
    BEGIN
        UPDATE supplier SET name = @name, contact = @contact, email = @email, address = @address, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO supplier(name, contact, email, address, created_at, updated_at) VALUES (@name, @contact, @email, @address, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para product
CREATE PROCEDURE sp_select_product
AS
BEGIN
    SELECT * FROM product;
END;
GO
-- SELECT por ID para product
CREATE PROCEDURE sp_select_product_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM product WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de product
CREATE PROCEDURE sp_upsert_product
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @description VARCHAR(255) = NULL,
    @image_uri VARCHAR(255) = NULL,
    @supplier_id UNIQUEIDENTIFIER = NULL,
    @product_type_id UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM product WHERE id = @id)
    BEGIN
        UPDATE product SET name = @name, description = @description, image_uri = @image_uri, supplier_id = @supplier_id, product_type_id = @product_type_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO product(name, description, image_uri, supplier_id, product_type_id, created_at, updated_at) VALUES (@name, @description, @image_uri, @supplier_id, @product_type_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para price
CREATE PROCEDURE sp_select_price
AS
BEGIN
    SELECT * FROM price;
END;
GO
-- SELECT por ID para price
CREATE PROCEDURE sp_select_price_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM price WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de price
CREATE PROCEDURE sp_upsert_price
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @cost_price DECIMAL(10,2),
    @markup_pct DECIMAL(5,2),
    @tax_pct DECIMAL(5,2),
    @final_price DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM price WHERE id = @id)
    BEGIN
        UPDATE price SET name = @name, cost_price = @cost_price, markup_pct = @markup_pct, tax_pct = @tax_pct, final_price = @final_price, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO price(name, cost_price, markup_pct, tax_pct, final_price, created_at, updated_at) VALUES (@name, @cost_price, @markup_pct, @tax_pct, @final_price, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para product_price
CREATE PROCEDURE sp_select_product_price
AS
BEGIN
    SELECT * FROM product_price;
END;
GO
-- SELECT por ID para product_price
CREATE PROCEDURE sp_select_product_price_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM product_price WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de product_price
CREATE PROCEDURE sp_upsert_product_price
    @id UNIQUEIDENTIFIER = NULL,
    @product_id UNIQUEIDENTIFIER,
    @price_id UNIQUEIDENTIFIER,
    @valid_from DATE,
    @valid_to DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM product_price WHERE id = @id)
    BEGIN
        UPDATE product_price SET product_id = @product_id, price_id = @price_id, valid_from = @valid_from, valid_to = @valid_to, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO product_price(product_id, price_id, valid_from, valid_to, created_at, updated_at) VALUES (@product_id, @price_id, @valid_from, @valid_to, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para detail_storage_type
CREATE PROCEDURE sp_select_detail_storage_type
AS
BEGIN
    SELECT * FROM detail_storage_type;
END;
GO
-- SELECT por ID para detail_storage_type
CREATE PROCEDURE sp_select_detail_storage_type_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM detail_storage_type WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de detail_storage_type
CREATE PROCEDURE sp_upsert_detail_storage_type
    @id UNIQUEIDENTIFIER = NULL,
    @warehouse_category_id UNIQUEIDENTIFIER,
    @product_id UNIQUEIDENTIFIER,
    @quantity INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM detail_storage_type WHERE id = @id)
    BEGIN
        UPDATE detail_storage_type SET warehouse_category_id = @warehouse_category_id, product_id = @product_id, quantity = @quantity, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO detail_storage_type(warehouse_category_id, product_id, quantity, created_at, updated_at) VALUES (@warehouse_category_id, @product_id, @quantity, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- =========================================
-- ORDERS
-- =========================================
-- SELECT para order_type
CREATE PROCEDURE sp_select_order_type
AS
BEGIN
    SELECT * FROM order_type;
END;
GO
-- SELECT por ID para order_type
CREATE PROCEDURE sp_select_order_type_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM order_type WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de order_type
CREATE PROCEDURE sp_upsert_order_type
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @description VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM order_type WHERE id = @id)
    BEGIN
        UPDATE order_type SET name = @name, description = @description, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO order_type(name, description, created_at, updated_at) VALUES (@name, @description, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para orders
CREATE PROCEDURE sp_select_orders
AS
BEGIN
    SELECT * FROM orders;
END;
GO
-- SELECT por ID para orders
CREATE PROCEDURE sp_select_orders_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM orders WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de orders
CREATE PROCEDURE sp_upsert_orders
    @id UNIQUEIDENTIFIER = NULL,
    @table_id UNIQUEIDENTIFIER = NULL,
    @employee_id UNIQUEIDENTIFIER,
    @customer_id UNIQUEIDENTIFIER = NULL,
    @order_date DATETIME,
    @total DECIMAL(10,2),
    @order_type_id UNIQUEIDENTIFIER = NULL,
    @order_status VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM orders WHERE id = @id)
    BEGIN
        UPDATE orders SET table_id = @table_id, employee_id = @employee_id, customer_id = @customer_id, order_date = @order_date, total = @total, order_type_id = @order_type_id, order_status = @order_status, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO orders(table_id, employee_id, customer_id, order_date, total, order_type_id, order_status, created_at, updated_at) VALUES (@table_id, @employee_id, @customer_id, @order_date, @total, @order_type_id, @order_status, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para order_detail
CREATE PROCEDURE sp_select_order_detail
AS
BEGIN
    SELECT * FROM order_detail;
END;
GO
-- SELECT por ID para order_detail
CREATE PROCEDURE sp_select_order_detail_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM order_detail WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de order_detail
CREATE PROCEDURE sp_upsert_order_detail
    @id UNIQUEIDENTIFIER = NULL,
    @order_id UNIQUEIDENTIFIER,
    @product_id UNIQUEIDENTIFIER,
    @product_price_id UNIQUEIDENTIFIER = NULL,
    @unit_price DECIMAL(10,2),
    @quantity INT,
    @subtotal DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM order_detail WHERE id = @id)
    BEGIN
        UPDATE order_detail SET order_id = @order_id, product_id = @product_id, product_price_id = @product_price_id, unit_price = @unit_price, quantity = @quantity, subtotal = @subtotal, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO order_detail(order_id, product_id, product_price_id, unit_price, quantity, subtotal, created_at, updated_at) VALUES (@order_id, @product_id, @product_price_id, @unit_price, @quantity, @subtotal, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- =========================================
-- AUDIT
-- =========================================
-- SELECT para audit_log
CREATE PROCEDURE sp_select_audit_log
AS
BEGIN
    SELECT * FROM audit_log;
END;
GO
-- SELECT por ID para audit_log
CREATE PROCEDURE sp_select_audit_log_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM audit_log WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de audit_log
CREATE PROCEDURE sp_upsert_audit_log
    @id UNIQUEIDENTIFIER = NULL,
    @employee_id UNIQUEIDENTIFIER,
    @action VARCHAR(50),
    @entity_name VARCHAR(50),
    @entity_id UNIQUEIDENTIFIER,
    @timestamp DATETIME,
    @description VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM audit_log WHERE id = @id)
    BEGIN
        UPDATE audit_log SET employee_id = @employee_id, action = @action, entity_name = @entity_name, entity_id = @entity_id, timestamp = @timestamp, description = @description WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO audit_log(employee_id, action, entity_name, entity_id, timestamp, description) VALUES (@employee_id, @action, @entity_name, @entity_id, @timestamp, @description);
    END
END;
GO

-- =========================================
-- MOVEMENTS
-- =========================================
-- SELECT para movement_type
CREATE PROCEDURE sp_select_movement_type
AS
BEGIN
    SELECT * FROM movement_type;
END;
GO
-- SELECT por ID para movement_type
CREATE PROCEDURE sp_select_movement_type_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM movement_type WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de movement_type
CREATE PROCEDURE sp_upsert_movement_type
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM movement_type WHERE id = @id)
    BEGIN
        UPDATE movement_type SET name = @name, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO movement_type(name, created_at, updated_at) VALUES (@name, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para inventory_movement
CREATE PROCEDURE sp_select_inventory_movement
AS
BEGIN
    SELECT * FROM inventory_movement;
END;
GO
-- SELECT por ID para inventory_movement
CREATE PROCEDURE sp_select_inventory_movement_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM inventory_movement WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de inventory_movement
CREATE PROCEDURE sp_upsert_inventory_movement
    @id UNIQUEIDENTIFIER = NULL,
    @inventory_id UNIQUEIDENTIFIER,
    @movement_date DATETIME,
    @movement_type_id UNIQUEIDENTIFIER,
    @quantity INT,
    @description VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM inventory_movement WHERE id = @id)
    BEGIN
        UPDATE inventory_movement SET inventory_id = @inventory_id, movement_date = @movement_date, movement_type_id = @movement_type_id, quantity = @quantity, description = @description, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO inventory_movement(inventory_id, movement_date, movement_type_id, quantity, description, created_at, updated_at) VALUES (@inventory_id, @movement_date, @movement_type_id, @quantity, @description, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- =========================================
-- WAREHOUSE
-- =========================================
-- SELECT para warehouse
CREATE PROCEDURE sp_select_warehouse
AS
BEGIN
    SELECT * FROM warehouse;
END;
GO
-- SELECT por ID para warehouse
CREATE PROCEDURE sp_select_warehouse_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM warehouse WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de warehouse
CREATE PROCEDURE sp_upsert_warehouse
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @shortname VARCHAR(50) = NULL,
    @parent_warehouse_id UNIQUEIDENTIFIER = NULL,
    @branch_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM warehouse WHERE id = @id)
    BEGIN
        UPDATE warehouse SET name = @name, shortname = @shortname, parent_warehouse_id = @parent_warehouse_id, branch_id = @branch_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO warehouse(name, shortname, parent_warehouse_id, branch_id, created_at, updated_at) VALUES (@name, @shortname, @parent_warehouse_id, @branch_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- SELECT para storage_type
CREATE PROCEDURE sp_select_storage_type
AS
BEGIN
    SELECT * FROM storage_type;
END;
GO
-- SELECT por ID para storage_type
CREATE PROCEDURE sp_select_storage_type_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM storage_type WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de storage_type
CREATE PROCEDURE sp_upsert_storage_type
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @maximum_weight VARCHAR(50) = NULL,
    @allow_new_product BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM storage_type WHERE id = @id)
    BEGIN
        UPDATE storage_type SET name = @name, maximum_weight = @maximum_weight, allow_new_product = @allow_new_product, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO storage_type(name, maximum_weight, allow_new_product, created_at, updated_at) VALUES (@name, @maximum_weight, @allow_new_product, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- =========================================
-- COMPLEMENTO: CRUD FALTANTES
-- =========================================
-- SELECT para product_type
CREATE PROCEDURE sp_select_product_type
AS
BEGIN
    SELECT * FROM product_type;
END;
GO
-- SELECT por ID para product_type
CREATE PROCEDURE sp_select_product_type_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM product_type WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de product_type
CREATE PROCEDURE sp_upsert_product_type
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @description VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM product_type WHERE id = @id)
    BEGIN
        UPDATE product_type SET name = @name, description = @description, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO product_type(name, description, created_at, updated_at) VALUES (@name, @description, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- SELECT para product_tax
CREATE PROCEDURE sp_select_product_tax
AS
BEGIN
    SELECT * FROM product_tax;
END;
GO
-- SELECT por ID para product_tax
CREATE PROCEDURE sp_select_product_tax_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM product_tax WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de product_tax
CREATE PROCEDURE sp_upsert_product_tax
    @id UNIQUEIDENTIFIER = NULL,
    @product_id UNIQUEIDENTIFIER,
    @tax_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM product_tax WHERE id = @id)
    BEGIN
        UPDATE product_tax SET product_id = @product_id, tax_id = @tax_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO product_tax(product_id, tax_id, created_at, updated_at) VALUES (@product_id, @tax_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- SELECT para role_permission
CREATE PROCEDURE sp_select_role_permission
AS
BEGIN
    SELECT * FROM role_permission;
END;
GO
-- SELECT por ID para role_permission
CREATE PROCEDURE sp_select_role_permission_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM role_permission WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de role_permission
CREATE PROCEDURE sp_upsert_role_permission
    @id UNIQUEIDENTIFIER = NULL,
    @role_id UNIQUEIDENTIFIER,
    @permission_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM role_permission WHERE id = @id)
    BEGIN
        UPDATE role_permission SET role_id = @role_id, permission_id = @permission_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO role_permission(role_id, permission_id, created_at, updated_at) VALUES (@role_id, @permission_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- SELECT para Sale_order
CREATE PROCEDURE sp_select_sale_order
AS
BEGIN
    SELECT * FROM Sale_order;
END;
GO
-- SELECT por ID para Sale_order
CREATE PROCEDURE sp_select_sale_order_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM Sale_order WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de Sale_order
CREATE PROCEDURE sp_upsert_sale_order
    @id UNIQUEIDENTIFIER = NULL,
    @sale_id UNIQUEIDENTIFIER,
    @order_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM Sale_order WHERE id = @id)
    BEGIN
        UPDATE Sale_order SET sale_id = @sale_id, order_id = @order_id, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO Sale_order(sale_id, order_id, created_at, updated_at) VALUES (@sale_id, @order_id, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- SELECT para sales_channel
CREATE PROCEDURE sp_select_sales_channel
AS
BEGIN
    SELECT * FROM sales_channel;
END;
GO
-- SELECT por ID para sales_channel
CREATE PROCEDURE sp_select_sales_channel_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM sales_channel WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de sales_channel
CREATE PROCEDURE sp_upsert_sales_channel
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @description VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM sales_channel WHERE id = @id)
    BEGIN
        UPDATE sales_channel SET name = @name, description = @description, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO sales_channel(name, description, created_at, updated_at) VALUES (@name, @description, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- SELECT para discount
CREATE PROCEDURE sp_select_discount
AS
BEGIN
    SELECT * FROM discount;
END;
GO
-- SELECT por ID para discount
CREATE PROCEDURE sp_select_discount_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM discount WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de discount
CREATE PROCEDURE sp_upsert_discount
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @description VARCHAR(255) = NULL,
    @discount_type VARCHAR(50),
    @value DECIMAL(10,2),
    @start_date DATETIME,
    @end_date DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM discount WHERE id = @id)
    BEGIN
        UPDATE discount SET name = @name, description = @description, discount_type = @discount_type, value = @value, start_date = @start_date, end_date = @end_date, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO discount(name, description, discount_type, value, start_date, end_date, created_at, updated_at) VALUES (@name, @description, @discount_type, @value, @start_date, @end_date, SYSDATETIME(), SYSDATETIME());
    END
END;
GO

-- =========================================
-- PROCEDIMIENTOS DELETE FALTANTES
-- =========================================
-- DELETE para user_system
CREATE OR REPLACE PROCEDURE sp_delete_user_system(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE user_system SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- DELETE para role
CREATE OR REPLACE PROCEDURE sp_delete_role(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE role SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- DELETE para permission
CREATE OR REPLACE PROCEDURE sp_delete_permission(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE permission SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- DELETE para shift
CREATE OR REPLACE PROCEDURE sp_delete_shift(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE shift SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- DELETE para sale
CREATE OR REPLACE PROCEDURE sp_delete_sale(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE sale SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- DELETE para sale_condition
CREATE OR REPLACE PROCEDURE sp_delete_sale_condition(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE sale_condition SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- DELETE para cash_register
CREATE OR REPLACE PROCEDURE sp_delete_cash_register(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE cash_register SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para cash_register_session
CREATE OR REPLACE PROCEDURE sp_delete_cash_register_session(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE cash_register_session SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para cash_movement
CREATE OR REPLACE PROCEDURE sp_delete_cash_movement(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE cash_movement SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para session_approval
CREATE OR REPLACE PROCEDURE sp_delete_session_approval(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE session_approval SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para invoice
CREATE OR REPLACE PROCEDURE sp_delete_invoice(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE invoice SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para receipt_type
CREATE OR REPLACE PROCEDURE sp_delete_receipt_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE receipt_type SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para customer
CREATE OR REPLACE PROCEDURE sp_delete_customer(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE customer SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para id_type
CREATE OR REPLACE PROCEDURE sp_delete_id_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM id_type WHERE id = _id;
END;$$;

-- DELETE para loyalty_program
CREATE OR REPLACE PROCEDURE sp_delete_loyalty_program(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE loyalty_program SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para payment_method
CREATE OR REPLACE PROCEDURE sp_delete_payment_method(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE payment_method SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para payment_gateway
CREATE OR REPLACE PROCEDURE sp_delete_payment_gateway(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE payment_gateway SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para gateway_customer
CREATE OR REPLACE PROCEDURE sp_delete_gateway_customer(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE gateway_customer SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para gateway_payment_methods
CREATE OR REPLACE PROCEDURE sp_delete_gateway_payment_methods(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE gateway_payment_methods SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para gateway_transactions
CREATE OR REPLACE PROCEDURE sp_delete_gateway_transactions(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE gateway_transactions SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para inventory
CREATE OR REPLACE PROCEDURE sp_delete_inventory(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE inventory SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para supplier
CREATE OR REPLACE PROCEDURE sp_delete_supplier(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE supplier SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para product
CREATE OR REPLACE PROCEDURE sp_delete_product(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE product SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para price
CREATE OR REPLACE PROCEDURE sp_delete_price(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE price SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para product_price
CREATE OR REPLACE PROCEDURE sp_delete_product_price(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE product_price SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para detail_storage_type
CREATE OR REPLACE PROCEDURE sp_delete_detail_storage_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE detail_storage_type SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para order_type
CREATE OR REPLACE PROCEDURE sp_delete_order_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM order_type WHERE id = _id;
END;$$;

-- DELETE para orders
CREATE OR REPLACE PROCEDURE sp_delete_orders(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE orders SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para order_detail
CREATE OR REPLACE PROCEDURE sp_delete_order_detail(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE order_detail SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para audit_log
CREATE OR REPLACE PROCEDURE sp_delete_audit_log(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE audit_log SET is_deleted = TRUE WHERE id = _id;
END;$$;

-- DELETE para movement_type
CREATE OR REPLACE PROCEDURE sp_delete_movement_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE movement_type SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para inventory_movement
CREATE OR REPLACE PROCEDURE sp_delete_inventory_movement(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE inventory_movement SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para warehouse
CREATE OR REPLACE PROCEDURE sp_delete_warehouse(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE warehouse SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- DELETE para storage_type
CREATE OR REPLACE PROCEDURE sp_delete_storage_type(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE storage_type SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- DELETE para product_type
CREATE OR REPLACE PROCEDURE sp_delete_product_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE product_type SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para product_tax
CREATE OR REPLACE PROCEDURE sp_delete_product_tax(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE product_tax SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para role_permission
CREATE OR REPLACE PROCEDURE sp_delete_role_permission(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE role_permission SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para sale_order
CREATE OR REPLACE PROCEDURE sp_delete_sale_order(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Sale_order SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para sales_channel
CREATE OR REPLACE PROCEDURE sp_delete_sales_channel(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE sales_channel SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- DELETE para discount
CREATE OR REPLACE PROCEDURE sp_delete_discount(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE discount SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- =========================================
-- PROCEDIMIENTOS FALTANTES: TAX, SALE_CONDITION, CASH_REGISTER_SESSION_APPROVAL
-- =========================================

-- =========================================
-- TAX
-- =========================================
-- SELECT para tax
CREATE PROCEDURE sp_select_tax
AS
BEGIN
    SELECT * FROM tax;
END;
GO
-- SELECT por ID para tax
CREATE PROCEDURE sp_select_tax_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM tax WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de tax
CREATE PROCEDURE sp_upsert_tax
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50),
    @rate DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM tax WHERE id = @id)
    BEGIN
        UPDATE tax SET name = @name, rate = @rate, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO tax(name, rate, created_at, updated_at) VALUES (@name, @rate, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- DELETE para tax
CREATE OR REPLACE PROCEDURE sp_delete_tax(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE tax SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- =========================================
-- SALE_CONDITION
-- =========================================
-- SELECT para sale_condition
CREATE PROCEDURE sp_select_sale_condition
AS
BEGIN
    SELECT * FROM sale_condition;
END;
GO
-- SELECT por ID para sale_condition
CREATE PROCEDURE sp_select_sale_condition_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM sale_condition WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de sale_condition
CREATE PROCEDURE sp_upsert_sale_condition
    @id UNIQUEIDENTIFIER = NULL,
    @name VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM sale_condition WHERE id = @id)
    BEGIN
        UPDATE sale_condition SET name = @name, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO sale_condition(name, created_at, updated_at) VALUES (@name, SYSDATETIME(), SYSDATETIME());
    END
END;
GO
-- DELETE para sale_condition
CREATE OR REPLACE PROCEDURE sp_delete_sale_condition(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE sale_condition SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- =========================================
-- CASH_REGISTER_SESSION_APPROVAL
-- =========================================
-- SELECT para cash_register_session_approval
CREATE PROCEDURE sp_select_cash_register_session_approval
AS
BEGIN
    SELECT * FROM cash_register_session_approval;
END;
GO
-- SELECT por ID para cash_register_session_approval
CREATE PROCEDURE sp_select_cash_register_session_approval_by_id
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * FROM cash_register_session_approval WHERE id = @id;
END;
GO
-- Adaptación a T-SQL del UPSERT de cash_register_session_approval
CREATE PROCEDURE sp_upsert_cash_register_session_approval
    @id UNIQUEIDENTIFIER = NULL,
    @session_id UNIQUEIDENTIFIER,
    @approved_by UNIQUEIDENTIFIER,
    @approved_at DATETIME,
    @note NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @id IS NOT NULL AND EXISTS (SELECT 1 FROM cash_register_session_approval WHERE id = @id)
    BEGIN
        UPDATE cash_register_session_approval SET session_id = @session_id, approved_by = @approved_by, approved_at = @approved_at, note = @note, updated_at = SYSDATETIME() WHERE id = @id;
    END
    ELSE
    BEGIN
        INSERT INTO cash_register_session_approval(session_id, approved_by, approved_at, note, updated_at) VALUES (@session_id, @approved_by, @approved_at, @note, SYSDATETIME());
    END
END;
GO
-- DELETE para cash_register_session_approval
CREATE OR REPLACE PROCEDURE sp_delete_cash_register_session_approval(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE cash_register_session_approval SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;