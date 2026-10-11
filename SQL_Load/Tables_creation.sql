-- This creates the customers table
Create TABLE public.customers
(
customer_id VARCHAR(200) PRIMARY KEY,
customer_unique_id VARCHAR(200),
customer_zip_code_prefix INT,
customer_city TEXT,
customer_state TEXT
);

-- This table creates the orders table
CREATE TABLE public.orders
(
    order_id VARCHAR(200) PRIMARY KEY,
    customer_id VARCHAR(200),
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES public.customers (customer_id)
);

-- This creates the product_categories table
CREATE TABLE public.product_categories
(
    product_category_name TEXT PRIMARY KEY,
    product_category_name_english TEXT
);

-- This creates the products table
CREATE TABLE public.products
(
    product_id VARCHAR(200) PRIMARY KEY,
    product_category_name TEXT,
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g NUMERIC,
    product_length_cm NUMERIC,
    product_height_cm NUMERIC,
    product_width_cm NUMERIC,
    FOREIGN KEY (product_category_name) REFERENCES public.product_categories (product_category_name)
);

-- This creates the sellers table
CREATE TABLE public.sellers
(
    seller_id VARCHAR(200) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city TEXT,
    seller_state TEXT
);

-- This creates the order_items table
CREATE TABLE public.order_items
(
    order_id VARCHAR(200),
    order_item_id INT PRIMARY KEY,
    product_id VARCHAR(200),
    seller_id VARCHAR(200),
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC,
    FOREIGN KEY (order_id) REFERENCES public.orders (order_id),
    FOREIGN KEY (product_id) REFERENCES public.products (product_id),
    FOREIGN KEY (seller_id) REFERENCES public.sellers (seller_id)
);



-- This creates the payments table
CREATE TABLE public.payments
(
    order_id VARCHAR(200),
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value NUMERIC,
    FOREIGN KEY (order_id) REFERENCES public.orders (order_id)
);
-- This creates the order_reviews table

CREATE TABLE public.order_reviews
(
    review_id VARCHAR(200) PRIMARY KEY,
    order_id VARCHAR(200),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES public.orders (order_id)
);

ALTER TABLE public.orders OWNER to postgres;
ALTER TABLE public.customers OWNER to postgres;     
ALTER TABLE public.order_items OWNER to postgres;
ALTER TABLE public.products OWNER to postgres;  
ALTER TABLE public.product_categories OWNER to postgres;
ALTER TABLE public.sellers OWNER to postgres;   
ALTER TABLE public.payments OWNER to postgres;
ALTER TABLE public.order_reviews OWNER to postgres; 

CREATE INDEX idx_customer_id ON public.orders (customer_id);    
CREATE INDEX idx_order_id ON public.order_items (order_id);
CREATE INDEX idx_product_id ON public.order_items (product_id);
CREATE INDEX idx_seller_id ON public.order_items (seller_id);
CREATE INDEX idx_product_category_name ON public.products (product_category_name);
CREATE INDEX idx_order_id_payments ON public.payments (order_id);
CREATE INDEX idx_order_id_reviews ON public.order_reviews (order_id);

        
