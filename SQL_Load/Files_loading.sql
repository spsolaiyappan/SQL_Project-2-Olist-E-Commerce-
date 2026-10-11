\COPY customers FROM 'C:\Users\spsol\OneDrive\Documents\Power Query exercise\SQL Project 2\Datasets\olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\COPY orders FROM 'C:\Users\spsol\OneDrive\Documents\Power Query exercise\SQL Project 2\Datasets\olist_orders_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\COPY product_categories FROM 'C:\Users\spsol\OneDrive\Documents\Power Query exercise\SQL Project 2\Datasets\product_category_name_translation.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\COPY products FROM 'C:\Users\spsol\OneDrive\Documents\Power Query exercise\SQL Project 2\Datasets\olist_products_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\COPY sellers FROM 'C:\Users\spsol\OneDrive\Documents\Power Query exercise\SQL Project 2\Datasets\olist_sellers_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\COPY order_items FROM 'C:\Users\spsol\OneDrive\Documents\Power Query exercise\SQL Project 2\Datasets\olist_order_items_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\COPY payments FROM 'C:\Users\spsol\OneDrive\Documents\Power Query exercise\SQL Project 2\Datasets\olist_order_payments_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- This field names were added to this specific table as a serial primary key was added to the table to avoid duplicates in the data. The serial primary key is not present in the CSV file, so we need to specify the column names to match the CSV file structure.
\COPY order_reviews (review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp) FROM 'C:\Users\spsol\OneDrive\Documents\Power Query exercise\SQL Project 2\Datasets\olist_order_reviews_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');