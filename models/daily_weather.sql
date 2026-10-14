with weather as (
    select 
        date(TIME) date,
        weather,
        round(avg(temp),2) avg_temp,
        round(avg(pressure),2) avg_pressure,
        round(avg(humidity),2) avg_humidity,
        round(avg(clouds),2) avg_clouds,
    from {{ source('demo', 'weather') }}
    group by time, weather
    qualify row_number() OVER (partition by date order by count(weather) desc)=1
)
select * from weather