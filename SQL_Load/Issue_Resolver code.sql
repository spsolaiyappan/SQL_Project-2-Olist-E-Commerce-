-- products table has a foreign key constraint on product_category_name, but the data in the CSV file has product_category_name values that do not exist in the product_categories table. Therefore, we need to drop the foreign key constraint temporarily, load the data, and then re-add the foreign key constraint after inserting the missing product category names into the product_categories table.    

ALTER TABLE public.products DROP CONSTRAINT products_product_category_name_fkey;
-- Drops the foreign key constraint temporarily

\COPY products FROM 'C:\Users\spsol\OneDrive\Documents\Power Query exercise\SQL Project 2\Datasets\olist_products_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Temporarily copies data into the products table without the foreign key constraint


INSERT INTO public.product_categories (product_category_name)
SELECT DISTINCT product_category_name 
FROM public.products 
WHERE product_category_name IS NOT NULL
  AND product_category_name NOT IN (SELECT product_category_name FROM public.product_categories)
ON CONFLICT (product_category_name) DO NOTHING;
-- Inserts distinct product category names from the products table into the product_categories table, avoiding duplicates

ALTER TABLE public.products ADD CONSTRAINT products_product_category_name_fkey 
FOREIGN KEY (product_category_name) REFERENCES public.product_categories (product_category_name);
-- Re-adds the foreign key constraint to the products table, linking it to the product_categories table

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- order items table has a composite primary key of order_id and order_item_id, but the data in the CSV file has duplicate order_id values. Therefore, we need to drop the primary key constraint and create a new one with only order_item_id as the primary key.  

-- Drop the incorrect primary key
ALTER TABLE public.order_items DROP CONSTRAINT order_items_pkey;

-- Add a composite primary key using BOTH order_id and order_item_id
ALTER TABLE public.order_items 
ADD PRIMARY KEY (order_id, order_item_id);

-- Wipe out any partial data from previous attempts
TRUNCATE TABLE public.order_items;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- order_reviews table has a primary key for order_reviews, but the data in the CSV file has duplicate order_id values. Therefore, we need to drop the primary key constraint and create a new one with serial No.
-- Wipe out any partial data from previous attempts
TRUNCATE TABLE public.order_reviews;

-- Drop the old primary key that was blocking duplicates
ALTER TABLE public.order_reviews DROP CONSTRAINT order_reviews_pkey;

-- Add a brand new auto-incrementing serial ID as the true primary key for every row
ALTER TABLE public.order_reviews ADD COLUMN internal_id SERIAL PRIMARY KEY;