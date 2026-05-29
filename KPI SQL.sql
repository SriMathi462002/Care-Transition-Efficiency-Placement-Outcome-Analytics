use mathi;
select * from health_care
#Transfer efficiency ratio
SELECT 
    Date,
    Transition,
    `Stock(CBP)`,
    CASE 
        WHEN `Stock(CBP)` = 0 THEN 0 
        ELSE ROUND((1.0 * Transition) / `Stock(CBP)`, 2)
    END AS Transfer_Efficiency_Ratio
FROM health_care;
#Discharge effictiveness index
SELECT 
    Date,
    Outflow,
    `Stock(HHS)`, 
    CASE 
        WHEN `Stock(HHS)` = 0 THEN 0 
        ELSE ROUND(((1.0 * Outflow) / `Stock(HHS)`) * 100, 2)
    END AS Discharge_Effectiveness_Percent
FROM health_care;
#Pipeline throughput
SELECT 
    Date,
    Inflow,
    Outflow,
    CASE 
        WHEN Inflow = 0 THEN 0 
        ELSE ROUND((1.0 * Outflow) / Inflow, 2)
    END AS Pipeline_Throughput_Rate
FROM health_care;
#Backlog
SELECT 
    Date,
    Inflow,
    Outflow,
    `Net_Flow` AS Backlog_Accumulation_Rate -- ⭐ MySQL-க்காக backticks யூஸ் பண்ணலாம்
FROM health_care;
#Outcome stability score
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    AVG(Outflow) AS avg_outflow,
    CASE 
        WHEN AVG(Outflow) = 0 THEN 0
        ELSE round(STDDEV(Outflow) / AVG(Outflow),2)
    END AS stability_score
FROM health_care
GROUP BY Month;