-- PostgreSQL schema for Restaurant Management System in snake_case using UUID primary keys
-- Requires pgcrypto extension for gen_random_uuid()

-- Habilitar extensión para UUID
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- =======================
-- Table: branch
-- =======================
CREATE TABLE branch (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    country       VARCHAR(50) NOT NULL,
    city          VARCHAR(50) NOT NULL,
    address       VARCHAR(50) NOT NULL,
    phone         VARCHAR(50),
    status        VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: warehouse
-- =======================
CREATE TABLE warehouse (
    id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                  VARCHAR(50) NOT NULL,
    shortname             VARCHAR(50),
    parent_warehouse_id   UUID REFERENCES warehouse(id),
    branch_id             UUID NOT NULL REFERENCES branch(id),
    created_at            TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: storage_type
-- =======================
CREATE TABLE storage_type (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                VARCHAR(50) NOT NULL,
    maximum_weight      VARCHAR(50),
    allow_new_product   BOOLEAN NOT NULL DEFAULT FALSE,
    status              VARCHAR(50),
    created_at          TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: product
-- =======================
CREATE TABLE product (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name             VARCHAR(50) NOT NULL,
    description      VARCHAR(50),
    image_uri        VARCHAR(255),
    cost_price       DECIMAL NOT NULL,
    utility          DECIMAL NOT NULL,
    final_price      DECIMAL NOT NULL,
    supplier_id      UUID REFERENCES supplier(id),
    product_type_id  UUID NOT NULL REFERENCES product_type(id),
    created_at       TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: detail_storage_type
-- =======================
CREATE TABLE detail_storage_type (
    id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    warehouse_category_id UUID NOT NULL REFERENCES storage_type(id),
    product_id            UUID NOT NULL REFERENCES product(id),
    quantity              INT NOT NULL,
    created_at            TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: pos
-- =======================
CREATE TABLE pos (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    branch_id     UUID NOT NULL REFERENCES branch(id),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: id_type
-- =======================
CREATE TABLE id_type (
    id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL
);

-- =======================
-- Table: customer
-- =======================
CREATE TABLE customer (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_type_id    UUID NOT NULL REFERENCES id_type(id),
    id_number     VARCHAR(50) NOT NULL,
    name          VARCHAR(50) NOT NULL,
    lastname      VARCHAR(50) NOT NULL,
    phone         VARCHAR(50),
    email         VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: table_restaurant
-- =======================
CREATE TABLE table_restaurant (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    number        INT NOT NULL,
    capacity      INT NOT NULL,
    status        VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: employee
-- =======================
CREATE TABLE employee (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    role          VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: order_type
-- =======================
CREATE TABLE order_type (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    description   VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: "order"
-- =======================
CREATE TABLE orders (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    table_id        UUID NOT NULL REFERENCES table_restaurant(id),
    employee_id     UUID NOT NULL REFERENCES employee(id),
    customer_id     UUID REFERENCES customer(id),
    order_date      TIMESTAMP NOT NULL,
    total           DECIMAL NOT NULL,
    order_type_id   UUID NOT NULL REFERENCES order_type(id),
    order_status    VARCHAR(50),
    status          VARCHAR(50),
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: order_detail
-- =======================
CREATE TABLE order_detail (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id      UUID NOT NULL REFERENCES orders(id),
    product_id    UUID NOT NULL REFERENCES product(id),
    quantity      INT NOT NULL,
    subtotal      DECIMAL NOT NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: product_type
-- =======================
CREATE TABLE product_type (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    description   VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: product_tax
-- =======================
CREATE TABLE product_tax (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id    UUID NOT NULL REFERENCES product(id),
    tax_id        UUID NOT NULL REFERENCES tax(id),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: inventory
-- =======================
CREATE TABLE inventory (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bar_code         VARCHAR(50),
    product_id       UUID NOT NULL REFERENCES product(id),
    warehouse_id     UUID NOT NULL REFERENCES warehouse(id),
    min_stock        INT,
    max_stock        INT,
    current_stock    INT,
    alert_high_stock INT,
    alert_low_stock  INT,
    created_at       TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: payment_method
-- =======================
CREATE TABLE payment_method (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    status        INT,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: role
-- =======================
CREATE TABLE role (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: permission
-- =======================
CREATE TABLE permission (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    description   VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: role_permission
-- =======================
CREATE TABLE role_permission (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_id         UUID NOT NULL REFERENCES role(id),
    permission_id   UUID NOT NULL REFERENCES permission(id),
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: user_system
-- =======================
CREATE TABLE user_system (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username      VARCHAR(50) NOT NULL,
    password      VARCHAR(50) NOT NULL,
    role_id       UUID NOT NULL REFERENCES role(id),
    status        INT,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: receipt_type
-- =======================
CREATE TABLE receipt_type (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    description   VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: sales_channel
-- =======================
CREATE TABLE sales_channel (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    description   VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: sale_condition
-- =======================
CREATE TABLE sale_condition (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL
);

-- =======================
-- Table: sale
-- =======================
CREATE TABLE sale (
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date               TIMESTAMP NOT NULL,
    user_id            UUID NOT NULL REFERENCES user_system(id),
    total              DECIMAL NOT NULL,
    customer_id        UUID REFERENCES customer(id),
    receipt_type_id    UUID NOT NULL REFERENCES receipt_type(id),
    payment_method_id  UUID NOT NULL REFERENCES payment_method(id),
    sales_channel_id   UUID NOT NULL REFERENCES sales_channel(id),
    pos_id             UUID NOT NULL REFERENCES pos(id),
    sale_condition_id  UUID NOT NULL REFERENCES sale_condition(id),
    discount_id        UUID REFERENCES discount(id),
    credit_term        VARCHAR(10),
    tax_id             UUID REFERENCES tax(id),
    created_at         TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at         TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: sale_order_details
-- =======================
CREATE TABLE sale_order_details (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sale_id       UUID NOT NULL REFERENCES sale(id),
    order_id      UUID NOT NULL REFERENCES orders(id),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: movement_type
-- =======================
CREATE TABLE movement_type (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: inventory_movement
-- =======================
CREATE TABLE inventory_movement (
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    inventory_id       UUID NOT NULL REFERENCES inventory(id),
    movement_date      TIMESTAMP NOT NULL,
    movement_type_id   UUID NOT NULL REFERENCES movement_type(id),
    quantity           INT NOT NULL,
    description        VARCHAR(50),
    created_at         TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at         TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: reservation
-- =======================
CREATE TABLE reservation (
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id        UUID NOT NULL REFERENCES customer(id),
    table_id           UUID NOT NULL REFERENCES table_restaurant(id),
    reservation_date   TIMESTAMP NOT NULL,
    number_of_people   INT NOT NULL,
    status             VARCHAR(50),
    note               VARCHAR(50),
    created_at         TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at         TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: tax
-- =======================
CREATE TABLE tax (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    rate          DECIMAL NOT NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: cash_register
-- =======================
CREATE TABLE cash_register (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name            VARCHAR(50) NOT NULL,
    pos_id          UUID NOT NULL REFERENCES pos(id),
    open_time       TIMESTAMP NOT NULL,
    close_time      TIMESTAMP,
    initial_amount  DECIMAL NOT NULL,
    final_amount    DECIMAL,
    description     VARCHAR(50),
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: cash_register_operation
-- =======================
CREATE TABLE cash_register_operation (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mount               DECIMAL NOT NULL,
    cash_register_id    UUID NOT NULL REFERENCES cash_register(id),
    movement_type_id    UUID NOT NULL REFERENCES movement_type(id),
    user_id             UUID NOT NULL REFERENCES user_system(id),
    description         TEXT,
    created_at          TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: discount
-- =======================
CREATE TABLE discount (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    description   VARCHAR(50),
    discount_type VARCHAR(50) NOT NULL,
    value         DECIMAL NOT NULL,
    start_date    TIMESTAMP NOT NULL,
    end_date      TIMESTAMP NOT NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: shift
-- =======================
CREATE TABLE shift (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    branch_id     UUID NOT NULL REFERENCES branch(id),
    start_time    TIMESTAMP NOT NULL,
    end_time      TIMESTAMP NOT NULL,
    status        VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: audit_log
-- =======================
CREATE TABLE audit_log (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id       UUID NOT NULL REFERENCES user_system(id),
    action        VARCHAR(50) NOT NULL,
    entity_name   VARCHAR(50) NOT NULL,
    entity_id     UUID NOT NULL,
    timestamp     TIMESTAMP NOT NULL DEFAULT NOW(),
    description   VARCHAR(50)
);

-- =======================
-- Table: supplier
-- =======================
CREATE TABLE supplier (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    contact       VARCHAR(50),
    email         VARCHAR(50),
    address       VARCHAR(50),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: loyalty_program
-- =======================
CREATE TABLE loyalty_program (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    points        INT NOT NULL,
    customer_id   UUID NOT NULL REFERENCES customer(id),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: employee_shift
-- =======================
CREATE TABLE employee_shift (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id   UUID NOT NULL REFERENCES employee(id),
    shift_id      UUID NOT NULL REFERENCES shift(id),
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: invoice
-- =======================
CREATE TABLE invoice (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    batch_id            INT,
    sale_id             UUID NOT NULL REFERENCES sale(id),
    cash_register_id    UUID NOT NULL REFERENCES cash_register(id),
    key_code            VARCHAR(50),
    consecutive_number  VARCHAR(20),
    issue_date          TIMESTAMP NOT NULL,
    currency_code       VARCHAR(3) NOT NULL,
    exchange_rate       DECIMAL(18,5),
    invoice_comment     VARCHAR(255),
    document            VARCHAR(255),
    email_copy          VARCHAR(255),
    other_content       VARCHAR(255),
    other_text          VARCHAR(255)
);

-- =======================
-- Table: payment_gateway
-- =======================
CREATE TABLE payment_gateway (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    code          VARCHAR(50) NOT NULL,
    config        JSONB,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: gateway_customer
-- =======================
CREATE TABLE gateway_customer (
    id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id           UUID NOT NULL REFERENCES customer(id),
    payment_gateway_id    UUID NOT NULL REFERENCES payment_gateway(id),
    config_json           JSONB,
    api_key               VARCHAR(255),
    secret_key            VARCHAR(255),
    redirect_url          VARCHAR(500),
    external_customer_id  VARCHAR(100),
    created_at            TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =======================
-- Table: gateway_payment_methods
-- =======================
CREATE TABLE gateway_payment_methods (
    id                     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    gateway_customer_id    UUID NOT NULL REFERENCES gateway_customer(id),
    method_type            VARCHAR(50) NOT NULL,
    external_method_id     VARCHAR(100),
    meta_json              JSONB
);

-- =======================
-- Table: gateway_transactions
-- =======================
CREATE TABLE gateway_transactions (
    id                         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    gateway_customer_id        UUID NOT NULL REFERENCES gateway_customer(id),
    gateway_payment_method_id  UUID REFERENCES gateway_payment_methods(id),
    amount                     DECIMAL(18,2) NOT NULL,
    currency                   VARCHAR(10) NOT NULL,
    status                     VARCHAR(50),
    request_json               JSONB,
    response_json              JSONB,
    created_at                 TIMESTAMP NOT NULL DEFAULT NOW()
);
