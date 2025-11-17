SELECT A.USERID,
    channel2,
    CASE
        WHEN channel2 IN ('Trace TV', 'Channel O', 'Vuzu', 'E! Entertainment') THEN 'Music/Entertainment'
        WHEN channel2 IN ('kykNET', 'MK', 'Africa Magic') THEN 'Local/Regional Content'
        WHEN channel2 IN ('Wimbledon', 'SuperSport Live Events', 'Supersport Live Events', 
                          'ICC Cricket World Cup 2011', 'Live on SuperSport', 'SuperSport Blitz') THEN 'Sports'
        WHEN channel2 = 'M-Net' THEN 'Movies/Premium'
        WHEN channel2 IN ('Cartoon Network', 'Boomerang') THEN 'Kids/Animation'
        WHEN channel2 IN ('DStv Events 1') THEN 'Special Events'
        WHEN channel2 IN ('Break in transmission', 'SawSee', 'Sawsee') THEN 'Miscellaneous / Unclassified Content'
        ELSE 'Other'
    END AS channel_category,
    

DATEADD(HOUR,2,TO_TIMESTAMP(RECORDDATE2,'YYYY/MM/DD HH24:MI')) AS RECORDDATE,
    EXTRACT(YEAR from (TO_DATE(RECORDDATE2,'YYYY/MM/DD HH24:MI'))) AS YEAR_WATCHED,
    MONTHNAME(TO_DATE(RECORDDATE2,'YYYY/MM/DD HH24:MI')) AS MONTH_WATCHED,
    EXTRACT(DAY from (TO_DATE(RECORDDATE2,'YYYY/MM/DD HH24:MI'))) AS DAY_WATCHED,
    DAYNAME(TO_DATE(RECORDDATE2,'YYYY/MM/DD HH24:MI')) AS DAYNAME_WATCHED,
    TIME(DATEADD(HOUR,2,TO_TIMESTAMP(RECORDDATE2,'YYYY/MM/DD HH24:MI'))) AS TIME_WATCHED,
    EXTRACT(HOUR FROM DATEADD(HOUR,2,TO_TIMESTAMP(RECORDDATE2,'YYYY/MM/DD HH24:MI'))) AS HOUR_WATCHED,

    COUNT(*) AS Total_users,

    CASE
   WHEN TIME_WATCHED BETWEEN '00:00:00' AND '05:59:59' THEN 'Late Night'
   WHEN TIME_WATCHED  BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
   WHEN TIME_WATCHED  BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
   WHEN TIME_WATCHED  BETWEEN '18:00:00' AND '23:59:59' THEN 'Evening'
    ELSE 'Unknown'
  END AS Time_of_day,

  CASE
  WHEN DAYNAME_WATCHED NOT IN('Sat', 'Sun') THEN 'Weekday_watches'
  ELSE 'Weekend_watches'
  END AS WEEK_WATCHES,
    

    DURATION2 AS viewing_duration,
    CASE
        WHEN duration2 <= '01:00:00' THEN 'Short Duration'
        WHEN duration2 BETWEEN '01:00:00' AND '04:00:00' THEN 'Medium Duration '
        WHEN duration2 BETWEEN '04:00:00' AND  '11:29:28' THEN 'Long Duration'
        ELSE 'Other / Unusual duration'
    END AS duration_category_description,

    
    NAME,
    SURNAME,
    EMAIL,
    GENDER,
    RACE,
AGE,
CASE
        WHEN age BETWEEN 0 AND 12 THEN 'Child (0-12)'
        WHEN age BETWEEN 13 AND 17 THEN 'Teen (13-17)'
        WHEN age BETWEEN 18 AND 24 THEN 'Young Adult (18-24)'
        WHEN age BETWEEN 25 AND 34 THEN 'Adult (25-34)'
        WHEN age BETWEEN 35 AND 44 THEN 'Mid-Age Adult (35-44)'
        WHEN age BETWEEN 45 AND 54 THEN 'Mature Adult (45-54)'
        WHEN age BETWEEN 55 AND 64 THEN 'Senior (55-64)'
        WHEN age BETWEEN 65 AND 114 THEN 'Elderly (65+)'
        ELSE 'Unknown / Invalid Age'
    END AS age_group,

    PROVINCE,
    SOCIAL_MEDIA_HANDLE

    FROM CASE_STUDY3.BRIGHTTV_VIEWERSHIP.TABLE1 AS A
    FULL OUTER JOIN CASE_STUDY3.BRIGHTTV_VIEWERSHIP.TABLE2 AS B
    ON A.USERID = B.USERID 
    
    WHERE NAME <> 'None' AND SURNAME <> 'None'AND RACE IS NOT NULL AND RACE <> 'None' AND GENDER <> 'None' AND GENDER IS NOT NULL AND PROVINCE <> 'None' AND PROVINCE IS NOT NULL
    GROUP BY ALL;
