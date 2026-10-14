with cte as (
    select 
        TO_TIMESTAMP(STARTTIME) STARTTIME,
        DATE(TO_TIMESTAMP(STARTTIME)) DATE_STARTTIME,
        HOUR(TO_TIMESTAMP(STARTTIME)) HOUR_STARTTIME,
        CASE
            WHEN DAYNAME(TO_TIMESTAMP(STARTTIME)) IN ('Sat','Sun') THEN 'WEEKEND'
            ELSE 'BUSINESSDAY'
        END AS DAY_TYPE,
        {{get_season('STARTTIME')}} AS SEASON_OF_YEAR
      from {{ source('demo', 'bike') }}   
    )
    select * from cte