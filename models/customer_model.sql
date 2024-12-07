{{ config(
    materialized="table"  
) }}


WITH source_data AS (
    SELECT
        id,
        first_name,
        last_name,
        created_at
    FROM
        {{ source('inventory', 'customer') }}
),
formatted_data AS (
    SELECT
        id,
        CONCAT(first_name, ' ', last_name) AS full_name,
        DATE(created_at) AS signup_date
		
    FROM
        source_data
)
SELECT
    *
FROM
    formatted_data