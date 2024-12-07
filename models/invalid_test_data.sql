{{ config(
    materialized='table'
) }}

WITH source_data AS (
    SELECT
        id,
        first_name,
        last_name,
        created_at
    FROM {{ source('inventory', 'customer') }}
),
formatted_data AS (
    SELECT
        CASE WHEN id = 1 THEN id ELSE id * -1 END AS id,  -- Duplicate ID for failure
        CONCAT(first_name, ' ', last_name) AS full_name,
        CASE WHEN id = 2 THEN NULL ELSE DATE(created_at) END AS signup_date  -- NULL value for failure
    FROM source_data
)
SELECT
    *
FROM
    formatted_data