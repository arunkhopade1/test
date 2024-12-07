WITH data AS (
    SELECT
        *
    FROM {{ ref('customer_model') }}
)
SELECT
    *
FROM data
WHERE signup_date > CURRENT_DATE