-- =========================================
-- USERS
-- =========================================
-- Users
CREATE OR REPLACE PROCEDURE sp_upsert_user_system(
    @_id       UNIQUEIDENTIFIER,
    @_username VARCHAR(50),
    @_password VARCHAR(50),
    @_role_id  UNIQUEIDENTIFIER,
    @_employee_id UNIQUEIDENTIFIER
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE user_system
        SET username = @_username, role_id = @_role_id, password = @_password, employee_id = @_employee_id, updated_at = GETDATE()
        WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO user_system(username, password, role_id, employee_id, created_at, updated_at)
        VALUES (@_username, @_password, @_role_id, @_employee_id, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_user_system(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE user_system SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
CREATE OR REPLACE PROCEDURE sp_upsert_user_password(@_user_id UNIQUEIDENTIFIER, @_password VARCHAR(50))
AS
BEGIN
    UPDATE user_system SET password = @_password, updated_at = GETDATE() WHERE id = @_user_id;
END;
-- Roles
CREATE OR REPLACE PROCEDURE sp_upsert_role(@_id UNIQUEIDENTIFIER, @_name VARCHAR(50))
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE role SET name = @_name, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO role(name, created_at, updated_at) VALUES (@_name, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_role(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE role SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- Permissions
CREATE OR REPLACE PROCEDURE sp_upsert_permission(@_id UNIQUEIDENTIFIER, @_name VARCHAR(50), @_description VARCHAR(50))
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE permission SET name = @_name, description = @_description, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO permission(name, description, created_at, updated_at) VALUES (@_name, @_description, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_permission(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE permission SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- shift
CREATE OR REPLACE PROCEDURE sp_upsert_shift(@_id UNIQUEIDENTIFIER, @_name VARCHAR(50), @_start_time DATETIME2, @_end_time DATETIME2)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE shift SET name = @_name, start_time = @_start_time, end_time = @_end_time, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO shift(name, start_time, end_time, created_at, updated_at) VALUES (@_name, @_start_time, @_end_time, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_shift(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE shift SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
-- Employee
CREATE OR REPLACE PROCEDURE sp_upsert_employee(@_id UNIQUEIDENTIFIER, @_first_name VARCHAR(50), @_last_name VARCHAR(50), @_phone VARCHAR(50), @_start_date DATETIME2, @_end_date DATETIME2)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE employee SET first_name = @_first_name, last_name = @_last_name, phone = @_phone, start_date = @_start_date, end_date = @_end_date, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO employee(first_name, last_name, phone, start_date, end_date, created_at, updated_at) VALUES (@_first_name, @_last_name, @_phone, @_start_date, @_end_date, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_employee(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employee SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
CREATE OR REPLACE PROCEDURE sp_upsert_employee_shift(@_id UNIQUEIDENTIFIER, @_employee_id UNIQUEIDENTIFIER, @_shift_id UNIQUEIDENTIFIER)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE employee_shift SET employee_id = @_employee_id, shift_id = @_shift_id, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO employee_shift(employee_id, shift_id, created_at, updated_at) VALUES (@_employee_id, @_shift_id, GETDATE(), GETDATE());
    END
END;
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
CREATE OR REPLACE PROCEDURE sp_upsert_branch(@_id UNIQUEIDENTIFIER, @_name VARCHAR(50), @_country VARCHAR(50), @_city VARCHAR(50), @_address VARCHAR(50), @_phone VARCHAR(50))
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE branch SET name = @_name, country = @_country, city = @_city, address = @_address, phone = @_phone, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO branch(name, country, city, address, phone, created_at, updated_at) VALUES (@_name, @_country, @_city, @_address, @_phone, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_branch(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE branch SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
CREATE OR REPLACE PROCEDURE sp_upsert_pos(@_id UNIQUEIDENTIFIER, @_name VARCHAR(50), @_branch_id UNIQUEIDENTIFIER)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE pos SET name = @_name, branch_id = @_branch_id, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO pos(name, branch_id, created_at, updated_at) VALUES (@_name, @_branch_id, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_pos(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE pos SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
CREATE OR REPLACE PROCEDURE sp_upsert_table_restaurant(@_id UNIQUEIDENTIFIER, @_number INT, @_capacity INT)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE table_restaurant SET number = @_number, capacity = @_capacity, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO table_restaurant(number, capacity, created_at, updated_at) VALUES (@_number, @_capacity, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_table_restaurant(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE table_restaurant SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
CREATE OR REPLACE PROCEDURE sp_upsert_reservation(@_id UNIQUEIDENTIFIER, @_customer_id UNIQUEIDENTIFIER, @_table_id UNIQUEIDENTIFIER, @_reservation_date DATETIME2, @_number_of_people INT, @_note VARCHAR(50))
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE reservation SET customer_id = @_customer_id, table_id = @_table_id, reservation_date = @_reservation_date, number_of_people = @_number_of_people, note = @_note, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO reservation(customer_id, table_id, reservation_date, number_of_people, note, created_at, updated_at) VALUES (@_customer_id, @_table_id, @_reservation_date, @_number_of_people, @_note, GETDATE(), GETDATE());
    END
END;
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
CREATE OR REPLACE PROCEDURE sp_upsert_sale(@_id UNIQUEIDENTIFIER, @_sale_date DATETIME2, @_employee_id UNIQUEIDENTIFIER, @_total DECIMAL(10,2), @_customer_id UNIQUEIDENTIFIER, @_receipt_type_id UNIQUEIDENTIFIER, @_payment_method_id UNIQUEIDENTIFIER, @_sales_channel_id UNIQUEIDENTIFIER, @_pos_id UNIQUEIDENTIFIER, @_sale_condition_id UNIQUEIDENTIFIER, @_discount_id UNIQUEIDENTIFIER, @_credit_term VARCHAR(10), @_tax_id UNIQUEIDENTIFIER)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE sale SET sale_date = @_sale_date, employee_id = @_employee_id, total = @_total, customer_id = @_customer_id, receipt_type_id = @_receipt_type_id, payment_method_id = @_payment_method_id, sales_channel_id = @_sales_channel_id, pos_id = @_pos_id, sale_condition_id = @_sale_condition_id, discount_id = @_discount_id, credit_term = @_credit_term, tax_id = @_tax_id, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO sale(sale_date, employee_id, total, customer_id, receipt_type_id, payment_method_id, sales_channel_id, pos_id, sale_condition_id, discount_id, credit_term, tax_id, created_at, updated_at) VALUES (@_sale_date, @_employee_id, @_total, @_customer_id, @_receipt_type_id, @_payment_method_id, @_sales_channel_id, @_pos_id, @_sale_condition_id, @_discount_id, @_credit_term, @_tax_id, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_sale(_id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE sale SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
CREATE OR REPLACE PROCEDURE sp_upsert_sale_condition(@_id UNIQUEIDENTIFIER, @_name VARCHAR(50))
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE sale_condition SET name = @_name, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO sale_condition(name, created_at, updated_at) VALUES (@_name, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_sale_condition(_id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE sale_condition SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- =========================================
-- CASH
-- =========================================
CREATE OR REPLACE PROCEDURE sp_upsert_cash_register(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_pos_id UNIQUEIDENTIFIER,
    @_description VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE cash_register SET name = @_name, pos_id = @_pos_id, description = @_description, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO cash_register(name, pos_id, description, created_at, updated_at) VALUES (@_name, @_pos_id, @_description, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_cash_register(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE cash_register SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_cash_register_session(
    @_id UNIQUEIDENTIFIER,
    @_cash_register_id UNIQUEIDENTIFIER,
    @_employee_id UNIQUEIDENTIFIER,
    @_opened_at DATETIME2,
    @_closed_at DATETIME2,
    @_opening_amount DECIMAL(10,2),
    @_closing_amount DECIMAL(10,2),
    @_expected_balance DECIMAL(10,2),
    @_discrepancy DECIMAL(10,2),
    @_status VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE cash_register_session SET cash_register_id = @_cash_register_id, employee_id = @_employee_id, opened_at = @_opened_at, closed_at = @_closed_at, opening_amount = @_opening_amount, closing_amount = @_closing_amount, expected_balance = @_expected_balance, discrepancy = @_discrepancy, status = @_status, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO cash_register_session(cash_register_id, employee_id, opened_at, closed_at, opening_amount, closing_amount, expected_balance, discrepancy, status, created_at, updated_at) VALUES (@_cash_register_id, @_employee_id, @_opened_at, @_closed_at, @_opening_amount, @_closing_amount, @_expected_balance, @_discrepancy, @_status, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_cash_register_session(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE cash_register_session SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_cash_movement(
    @_id UNIQUEIDENTIFIER,
    @_session_id UNIQUEIDENTIFIER,
    @_movement_type VARCHAR(50),
    @_description NVARCHAR(MAX),
    @_amount DECIMAL(10,2),
    @_performed_at DATETIME2
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE cash_movement SET session_id = @_session_id, movement_type = @_movement_type, description = @_description, amount = @_amount, performed_at = @_performed_at, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO cash_movement(session_id, movement_type, description, amount, performed_at, updated_at) VALUES (@_session_id, @_movement_type, @_description, @_amount, @_performed_at, GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_cash_movement(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE cash_movement SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_session_approval(
    @_id UNIQUEIDENTIFIER,
    @_session_id UNIQUEIDENTIFIER,
    @_approved_by UNIQUEIDENTIFIER,
    @_approved_at DATETIME2,
    @_note NVARCHAR(MAX)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE session_approval SET session_id = @_session_id, approved_by = @_approved_by, approved_at = @_approved_at, note = @_note, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO session_approval(session_id, approved_by, approved_at, note, updated_at) VALUES (@_session_id, @_approved_by, @_approved_at, @_note, GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_session_approval(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE session_approval SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- =========================================
-- INVOICING
-- =========================================
CREATE OR REPLACE PROCEDURE sp_upsert_invoice(
    @_id UNIQUEIDENTIFIER,
    @_batch_id INT,
    @_sale_id UNIQUEIDENTIFIER,
    @_cash_register_id UNIQUEIDENTIFIER,
    @_key_code VARCHAR(50),
    @_consecutive_number VARCHAR(50),
    @_issue_date DATETIME2,
    @_currency_code VARCHAR(50),
    @_exchange_rate DECIMAL(10,2),
    @_invoice_comment VARCHAR(50),
    @_document VARCHAR(50),
    @_email_copy VARCHAR(50),
    @_other_content VARCHAR(50),
    @_other_text VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE invoice SET batch_id = @_batch_id, sale_id = @_sale_id, cash_register_id = @_cash_register_id, key_code = @_key_code, consecutive_number = @_consecutive_number, issue_date = @_issue_date, currency_code = @_currency_code, exchange_rate = @_exchange_rate, invoice_comment = @_invoice_comment, document = @_document, email_copy = @_email_copy, other_content = @_other_content, other_text = @_other_text, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO invoice(batch_id, sale_id, cash_register_id, key_code, consecutive_number, issue_date, currency_code, exchange_rate, invoice_comment, document, email_copy, other_content, other_text, created_at, updated_at) VALUES (@_batch_id, @_sale_id, @_cash_register_id, @_key_code, @_consecutive_number, @_issue_date, @_currency_code, @_exchange_rate, @_invoice_comment, @_document, @_email_copy, @_other_content, @_other_text, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_invoice(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE invoice SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_receipt_type(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_description VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE receipt_type SET name = @_name, description = @_description, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO receipt_type(name, description, created_at, updated_at) VALUES (@_name, @_description, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_receipt_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE receipt_type SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- =========================================
-- CUSTOMER
-- =========================================
CREATE OR REPLACE PROCEDURE sp_upsert_customer(
    @_id UNIQUEIDENTIFIER,
    @_id_type_id UNIQUEIDENTIFIER,
    @_id_number VARCHAR(50),
    @_name VARCHAR(50),
    @_lastname VARCHAR(50),
    @_phone VARCHAR(50),
    @_email VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE customer SET id_type_id = @_id_type_id, id_number = @_id_number, name = @_name, lastname = @_lastname, phone = @_phone, email = @_email, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO customer(id_type_id, id_number, name, lastname, phone, email, created_at, updated_at) VALUES (@_id_type_id, @_id_number, @_name, @_lastname, @_phone, @_email, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_customer(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE customer SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_id_type(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE id_type SET name = @_name WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO id_type(name) VALUES (@_name);
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_id_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM id_type WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_loyalty_program(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_points INT,
    @_customer_id UNIQUEIDENTIFIER
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE loyalty_program SET name = @_name, points = @_points, customer_id = @_customer_id, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO loyalty_program(name, points, customer_id, created_at, updated_at) VALUES (@_name, @_points, @_customer_id, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_loyalty_program(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE loyalty_program SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- =========================================
-- PAYMENTS
-- =========================================
CREATE OR REPLACE PROCEDURE sp_upsert_payment_method(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE payment_method SET name = @_name, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO payment_method(name, created_at, updated_at) VALUES (@_name, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_payment_method(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE payment_method SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_payment_gateway(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_code VARCHAR(50),
    @_config NVARCHAR(MAX)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE payment_gateway SET name = @_name, code = @_code, config = @_config, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO payment_gateway(name, code, config, created_at, updated_at) VALUES (@_name, @_code, @_config, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_payment_gateway(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE payment_gateway SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_gateway_customer(
    @_id UNIQUEIDENTIFIER,
    @_customer_id UNIQUEIDENTIFIER,
    @_payment_gateway_id UNIQUEIDENTIFIER,
    @_config_json NVARCHAR(MAX),
    @_api_key VARCHAR(50),
    @_secret_key VARCHAR(50),
    @_redirect_url VARCHAR(50),
    @_external_customer_id VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE gateway_customer SET customer_id = @_customer_id, payment_gateway_id = @_payment_gateway_id, config_json = @_config_json, api_key = @_api_key, secret_key = @_secret_key, redirect_url = @_redirect_url, external_customer_id = @_external_customer_id, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO gateway_customer(customer_id, payment_gateway_id, config_json, api_key, secret_key, redirect_url, external_customer_id, created_at, updated_at) VALUES (@_customer_id, @_payment_gateway_id, @_config_json, @_api_key, @_secret_key, @_redirect_url, @_external_customer_id, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_gateway_customer(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE gateway_customer SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_gateway_payment_methods(
    @_id UNIQUEIDENTIFIER,
    @_gateway_customer_id UNIQUEIDENTIFIER,
    @_method_type VARCHAR(50),
    @_external_method_id VARCHAR(50),
    @_meta_json NVARCHAR(MAX)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE gateway_payment_methods SET gateway_customer_id = @_gateway_customer_id, method_type = @_method_type, external_method_id = @_external_method_id, meta_json = @_meta_json, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO gateway_payment_methods(gateway_customer_id, method_type, external_method_id, meta_json, created_at, updated_at) VALUES (@_gateway_customer_id, @_method_type, @_external_method_id, @_meta_json, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_gateway_payment_methods(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE gateway_payment_methods SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_gateway_transactions(
    @_id UNIQUEIDENTIFIER,
    @_gateway_customer_id UNIQUEIDENTIFIER,
    @_gateway_payment_method_id UNIQUEIDENTIFIER,
    @_amount DECIMAL(10,2),
    @_currency VARCHAR(50),
    @_status VARCHAR(50),
    @_request_json NVARCHAR(MAX),
    @_response_json NVARCHAR(MAX)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE gateway_transactions SET gateway_customer_id = @_gateway_customer_id, gateway_payment_method_id = @_gateway_payment_method_id, amount = @_amount, currency = @_currency, status = @_status, request_json = @_request_json, response_json = @_response_json, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO gateway_transactions(gateway_customer_id, gateway_payment_method_id, amount, currency, status, request_json, response_json, created_at, updated_at) VALUES (@_gateway_customer_id, @_gateway_payment_method_id, @_amount, @_currency, @_status, @_request_json, @_response_json, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_gateway_transactions(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE gateway_transactions SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- =========================================
-- INVENTORY
-- =========================================
CREATE OR REPLACE PROCEDURE sp_upsert_inventory(
    @_id UNIQUEIDENTIFIER,
    @_bar_code VARCHAR(50),
    @_product_id UNIQUEIDENTIFIER,
    @_warehouse_id UNIQUEIDENTIFIER,
    @_min_stock INT,
    @_max_stock INT,
    @_current_stock INT,
    @_alert_high_stock INT,
    @_alert_low_stock INT
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE inventory SET bar_code = @_bar_code, product_id = @_product_id, warehouse_id = @_warehouse_id, min_stock = @_min_stock, max_stock = @_max_stock, current_stock = @_current_stock, alert_high_stock = @_alert_high_stock, alert_low_stock = @_alert_low_stock, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO inventory(bar_code, product_id, warehouse_id, min_stock, max_stock, current_stock, alert_high_stock, alert_low_stock, created_at, updated_at) VALUES (@_bar_code, @_product_id, @_warehouse_id, @_min_stock, @_max_stock, @_current_stock, @_alert_high_stock, @_alert_low_stock, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_inventory(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE inventory SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_supplier(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_contact VARCHAR(50),
    @_email VARCHAR(50),
    @_address VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE supplier SET name = @_name, contact = @_contact, email = @_email, address = @_address, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO supplier(name, contact, email, address, created_at, updated_at) VALUES (@_name, @_contact, @_email, @_address, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_supplier(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE supplier SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_product(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_description VARCHAR(50),
    @_image_uri VARCHAR(50),
    @_supplier_id UNIQUEIDENTIFIER,
    @_product_type_id UNIQUEIDENTIFIER
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE product SET name = @_name, description = @_description, image_uri = @_image_uri, supplier_id = @_supplier_id, product_type_id = @_product_type_id, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO product(name, description, image_uri, supplier_id, product_type_id, created_at, updated_at) VALUES (@_name, @_description, @_image_uri, @_supplier_id, @_product_type_id, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_product(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE product SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_price(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_cost_price DECIMAL(10,2),
    @_markup_pct DECIMAL(10,2),
    @_tax_pct DECIMAL(10,2),
    @_final_price DECIMAL(10,2)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE price SET name = @_name, cost_price = @_cost_price, markup_pct = @_markup_pct, tax_pct = @_tax_pct, final_price = @_final_price, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO price(name, cost_price, markup_pct, tax_pct, final_price, created_at, updated_at) VALUES (@_name, @_cost_price, @_markup_pct, @_tax_pct, @_final_price, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_price(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE price SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_product_price(
    @_id UNIQUEIDENTIFIER,
    @_product_id UNIQUEIDENTIFIER,
    @_price_id UNIQUEIDENTIFIER,
    @_valid_from DATE,
    @_valid_to DATE
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE product_price SET product_id = @_product_id, price_id = @_price_id, valid_from = @_valid_from, valid_to = @_valid_to, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO product_price(product_id, price_id, valid_from, valid_to, created_at, updated_at) VALUES (@_product_id, @_price_id, @_valid_from, @_valid_to, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_product_price(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE product_price SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_detail_storage_type(
    @_id UNIQUEIDENTIFIER,
    @_warehouse_category_id UNIQUEIDENTIFIER,
    @_product_id UNIQUEIDENTIFIER,
    @_quantity INT
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE detail_storage_type SET warehouse_category_id = @_warehouse_category_id, product_id = @_product_id, quantity = @_quantity, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO detail_storage_type(warehouse_category_id, product_id, quantity, created_at, updated_at) VALUES (@_warehouse_category_id, @_product_id, @_quantity, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_detail_storage_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE detail_storage_type SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- =========================================
-- ORDERS
-- =========================================
CREATE OR REPLACE PROCEDURE sp_upsert_order_type(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_description VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE order_type SET name = @_name, description = @_description, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO order_type(name, description, created_at, updated_at) VALUES (@_name, @_description, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_order_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM order_type WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_orders(
    @_id UNIQUEIDENTIFIER,
    @_table_id UNIQUEIDENTIFIER,
    @_employee_id UNIQUEIDENTIFIER,
    @_customer_id UNIQUEIDENTIFIER,
    @_order_date DATETIME2,
    @_total DECIMAL(10,2),
    @_order_type_id UNIQUEIDENTIFIER,
    @_order_status VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE orders SET table_id = @_table_id, employee_id = @_employee_id, customer_id = @_customer_id, order_date = @_order_date, total = @_total, order_type_id = @_order_type_id, order_status = @_order_status, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO orders(table_id, employee_id, customer_id, order_date, total, order_type_id, order_status, created_at, updated_at) VALUES (@_table_id, @_employee_id, @_customer_id, @_order_date, @_total, @_order_type_id, @_order_status, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_orders(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE orders SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_order_detail(
    @_id UNIQUEIDENTIFIER,
    @_order_id UNIQUEIDENTIFIER,
    @_product_id UNIQUEIDENTIFIER,
    @_product_price_id UNIQUEIDENTIFIER,
    @_unit_price DECIMAL(10,2),
    @_quantity INT,
    @_subtotal DECIMAL(10,2)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE order_detail SET order_id = @_order_id, product_id = @_product_id, product_price_id = @_product_price_id, unit_price = @_unit_price, quantity = @_quantity, subtotal = @_subtotal, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO order_detail(order_id, product_id, product_price_id, unit_price, quantity, subtotal, created_at, updated_at) VALUES (@_order_id, @_product_id, @_product_price_id, @_unit_price, @_quantity, @_subtotal, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_order_detail(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE order_detail SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- =========================================
-- AUDIT
-- =========================================
CREATE OR REPLACE PROCEDURE sp_upsert_audit_log(
    @_id UNIQUEIDENTIFIER,
    @_employee_id UNIQUEIDENTIFIER,
    @_action VARCHAR(50),
    @_entity_name VARCHAR(50),
    @_entity_id UNIQUEIDENTIFIER,
    @_timestamp DATETIME2,
    @_description VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE audit_log SET employee_id = @_employee_id, action = @_action, entity_name = @_entity_name, entity_id = @_entity_id, timestamp = @_timestamp, description = @_description WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO audit_log(employee_id, action, entity_name, entity_id, timestamp, description) VALUES (@_employee_id, @_action, @_entity_name, @_entity_id, @_timestamp, @_description);
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_audit_log(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE audit_log SET is_deleted = TRUE WHERE id = _id;
END;$$;

-- =========================================
-- MOVEMENTS
-- =========================================
CREATE OR REPLACE PROCEDURE sp_upsert_movement_type(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE movement_type SET name = @_name, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO movement_type(name, created_at, updated_at) VALUES (@_name, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_movement_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE movement_type SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

CREATE OR REPLACE PROCEDURE sp_upsert_inventory_movement(
    @_id UNIQUEIDENTIFIER,
    @_inventory_id UNIQUEIDENTIFIER,
    @_movement_date DATETIME2,
    @_movement_type_id UNIQUEIDENTIFIER,
    @_quantity INT,
    @_description VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE inventory_movement SET inventory_id = @_inventory_id, movement_date = @_movement_date, movement_type_id = @_movement_type_id, quantity = @_quantity, description = @_description, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO inventory_movement(inventory_id, movement_date, movement_type_id, quantity, description, created_at, updated_at) VALUES (@_inventory_id, @_movement_date, @_movement_type_id, @_quantity, @_description, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_inventory_movement(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE inventory_movement SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- =========================================
-- WAREHOUSE
-- =========================================
CREATE OR REPLACE PROCEDURE sp_upsert_warehouse(@_id UNIQUEIDENTIFIER, @_name VARCHAR(50), @_shortname VARCHAR(50), @_parent_warehouse_id UNIQUEIDENTIFIER, @_branch_id UNIQUEIDENTIFIER)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE warehouse SET name = @_name, shortname = @_shortname, parent_warehouse_id = @_parent_warehouse_id, branch_id = @_branch_id, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO warehouse(name, shortname, parent_warehouse_id, branch_id, created_at, updated_at) VALUES (@_name, @_shortname, @_parent_warehouse_id, @_branch_id, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_warehouse(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE warehouse SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;
CREATE OR REPLACE PROCEDURE sp_upsert_storage_type(@_id UNIQUEIDENTIFIER, @_name VARCHAR(50), @_maximum_weight VARCHAR(50), @_allow_new_product BIT)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE storage_type SET name = @_name, maximum_weight = @_maximum_weight, allow_new_product = @_allow_new_product, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO storage_type(name, maximum_weight, allow_new_product, created_at, updated_at) VALUES (@_name, @_maximum_weight, @_allow_new_product, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_storage_type(IN _id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE storage_type SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;
$$;

-- =========================================
-- DASHBOARD, MENU, KITCHEN
-- =========================================
-- (Aquí agregarías los procedimientos de Dashboard, Menu, Kitchen si los tuvieras)

-- =========================================
-- COMPLEMENTO: CRUD FALTANTES
-- =========================================
-- tax
CREATE OR REPLACE PROCEDURE sp_upsert_tax(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_rate DECIMAL(10,2)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE tax SET name = @_name, rate = @_rate, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO tax(name, rate, created_at, updated_at) VALUES (@_name, @_rate, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_tax(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE tax SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- product_type
CREATE OR REPLACE PROCEDURE sp_upsert_product_type(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_description VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE product_type SET name = @_name, description = @_description, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO product_type(name, description, created_at, updated_at) VALUES (@_name, @_description, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_product_type(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE product_type SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- product_tax
CREATE OR REPLACE PROCEDURE sp_upsert_product_tax(
    @_id UNIQUEIDENTIFIER,
    @_product_id UNIQUEIDENTIFIER,
    @_tax_id UNIQUEIDENTIFIER
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE product_tax SET product_id = @_product_id, tax_id = @_tax_id, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO product_tax(product_id, tax_id, created_at, updated_at) VALUES (@_product_id, @_tax_id, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_product_tax(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE product_tax SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- role_permission
CREATE OR REPLACE PROCEDURE sp_upsert_role_permission(
    @_id UNIQUEIDENTIFIER,
    @_role_id UNIQUEIDENTIFIER,
    @_permission_id UNIQUEIDENTIFIER
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE role_permission SET role_id = @_role_id, permission_id = @_permission_id, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO role_permission(role_id, permission_id, created_at, updated_at) VALUES (@_role_id, @_permission_id, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_role_permission(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE role_permission SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- Sale_order
CREATE OR REPLACE PROCEDURE sp_upsert_sale_order(
    @_id UNIQUEIDENTIFIER,
    @_sale_id UNIQUEIDENTIFIER,
    @_order_id UNIQUEIDENTIFIER
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE Sale_order SET sale_id = @_sale_id, order_id = @_order_id, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO Sale_order(sale_id, order_id, created_at, updated_at) VALUES (@_sale_id, @_order_id, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_sale_order(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Sale_order SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- sales_channel
CREATE OR REPLACE PROCEDURE sp_upsert_sales_channel(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_description VARCHAR(50)
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE sales_channel SET name = @_name, description = @_description, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO sales_channel(name, description, created_at, updated_at) VALUES (@_name, @_description, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_sales_channel(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE sales_channel SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;

-- discount
CREATE OR REPLACE PROCEDURE sp_upsert_discount(
    @_id UNIQUEIDENTIFIER,
    @_name VARCHAR(50),
    @_description VARCHAR(50),
    @_discount_type VARCHAR(50),
    @_value DECIMAL(10,2),
    @_start_date DATETIME2,
    @_end_date DATETIME2
)
AS
BEGIN
    IF @_id IS NOT NULL
    BEGIN
        UPDATE discount SET name = @_name, description = @_description, discount_type = @_discount_type, value = @_value, start_date = @_start_date, end_date = @_end_date, updated_at = GETDATE() WHERE id = @_id;
    END
    ELSE
    BEGIN
        INSERT INTO discount(name, description, discount_type, value, start_date, end_date, created_at, updated_at) VALUES (@_name, @_description, @_discount_type, @_value, @_start_date, @_end_date, GETDATE(), GETDATE());
    END
END;
CREATE OR REPLACE PROCEDURE sp_delete_discount(IN _id UUID)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE discount SET is_deleted = TRUE, updated_at = NOW() WHERE id = _id;
END;$$;