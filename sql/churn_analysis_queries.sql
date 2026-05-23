#CREATE DATABASE churn_project;
#USE churn_project;

#For total customers
SELECT COUNT(*) AS total_customers
FROM telco_churn;

#Churned out customers
SELECT COUNT(*) AS churned_customers
FROM telco_churn
WHERE `Churn Label` = 'Yes'; 

# % of Churned customers
SELECT 
    ROUND(
        (SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) * 100.0)
        / COUNT(*),
        2
    ) AS churn_rate
FROM telco_churn;

# Add all the churned customers
SELECT 
    ROUND(
        (SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) * 100.0)
        / COUNT(*),
        2
    ) AS churn_rate
FROM telco_churn;

#Contract type with the highest churn rate
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate
FROM telco_churn
GROUP BY Contract
ORDER BY churn_rate DESC;


#Tech support's role in churning
SELECT 
    `Tech Support`,
    COUNT(*) AS total_customers,

    SUM(
        CASE 
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE 
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco_churn
GROUP BY `Tech Support`
ORDER BY churn_rate DESC;

#Avg Monthly charges by churn
SELECT 
    `Churn Label`,
    ROUND(AVG(`Monthly Charges`), 2) AS avg_monthly_charges
FROM telco_churn
GROUP BY `Churn Label`;

#Do newer customers churn more?
SELECT 
    CASE
        WHEN `Tenure Months` <= 12 THEN '0-12 Months'
        WHEN `Tenure Months` <= 24 THEN '13-24 Months'
        WHEN `Tenure Months` <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
    END AS tenure_group,

    COUNT(*) AS total_customers,

    SUM(
        CASE 
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE 
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco_churn
GROUP BY tenure_group
ORDER BY churn_rate DESC;



#Churn rate as per payment methods
SELECT 
    `Payment Method`,
    
    COUNT(*) AS total_customers,

    SUM(
        CASE 
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE 
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco_churn
GROUP BY `Payment Method`
ORDER BY churn_rate DESC;


#Churn rate by internet services
SELECT 
    `Internet Service`,
    
    COUNT(*) AS total_customers,

    SUM(
        CASE 
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE 
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco_churn
GROUP BY `Internet Service`
ORDER BY churn_rate DESC;


#Possible reasons for Customers exit
SELECT 
    `Churn Reason`,
    COUNT(*) AS total_churns
FROM telco_churn
WHERE `Churn Label` = 'Yes'
GROUP BY `Churn Reason`
ORDER BY total_churns DESC;


#Monthly revenue lost from Valuable consumers
SELECT 
    ROUND(SUM(`Monthly Charges`), 2) AS monthly_revenue_lost
FROM telco_churn
WHERE `Churn Label` = 'Yes';

#High-Value constomers at risk
SELECT 
    CustomerID,
    `Monthly Charges`,
    `Total Charges`,
    `Tenure Months`,
    `Internet Service`,
    `Contract`
FROM telco_churn
WHERE `Churn Label` = 'Yes'
ORDER BY `Total Charges` DESC
LIMIT 10;


#Effect of tech support on churning rate
SELECT 
    `Tech Support`,
    
    COUNT(*) AS total_customers,

    SUM(
        CASE 
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE 
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco_churn
GROUP BY `Tech Support`
ORDER BY churn_rate DESC;