**Road Accident Data Analysis (Brazil: 2017–2023)**

**Problem Statement**
Road accidents are a significant public safety concern, often resulting in injuries, fatalities, and property damage. Analyzing historical accident data helps uncover trends and contributing factors, leading to improved safety measures and potentially saving lives.

**Objectives**
>This project analyzes road accident data from Brazil (2017–2023) to:
>Explore how accidents are distributed across different factors.
>Estimate the probability of accidents being fatal.
>Understand how the number of vehicles involved affects the number of injuries.
>Test if the average number of injuries per accident is significantly different from a certain value.
>Compare accident severity between weekdays and weekends.
>Provide insights that can guide improvements in road safety.

**Dataset Information**
Source: Kaggle - Car Accidents in Brazil (2017–2023)
https://www.kaggle.com/datasets/mlippo/car-accidents-in-brazil-2017-2023

Total Records: 463,091 accidents

**Key Variables**
inverse_data – Date of the accident
week_day – Day of the week
hour – Time of the accident
state – State where the accident occurred
city – City where the accident occurred
cause_of_accident – Reported cause of the accident
type_of_accident – Type of collision or accident
victims_condition – Victim status (e.g., injured, dead)
weather_timestamp – Time of day (e.g., night, day)
wheather_condition – Weather conditions during the accident
road_type – Type of road (e.g., simple, double)
people – Total number of people involved
deaths – Number of fatalities
slightly_injured – Number of slightly injured individuals
severely_injured – Number of severely injured individuals
uninjured – Number of uninjured individuals
total_injured – Total injured individuals
vehicles_involved – Number of vehicles involved

**Exploratory Data Analysis (EDA)**

**Summary Statistics**
Average Injuries per Accident: Approximately 1.10
Average Vehicles Involved per Accident: Approximately 1.65
Maximum Injuries in a Single Accident: 66
Minimum Injuries: 0

**Visualizations and Insights**

**Histogram**: Total Injuries
Most accidents result in 1 injury.
Single-injury accidents are the most common.

**Bar Chart**: Accidents by Weekday
Saturday and Sunday show the highest accident counts.
Indicates increased risk during weekends.

**Boxplot**: Injuries by Victim Condition
Highest spread of injuries in accidents with injured victims.
Accidents with fatalities have fewer but sometimes extreme injury counts.
Accidents with no victims show minimal injuries.

**Pie Chart**: Accident Types
Rear-end and side collisions are the most common types.
Less frequent types include cargo spills and occupant falls.

**Scatterplot**: Vehicles Involved vs. Total Injuries
Most accidents involve 1–3 vehicles with relatively few injuries.
Rare high-injury cases typically involve multiple vehicles.
Weak positive correlation suggests additional vehicles contribute slightly to injury counts.

**Statistical Analysis**

**Binomial Distribution for Fatalities**
Total Accidents: 463,091
Fatal Accidents: 31,343
Estimated Probability of Fatal Accident: 6.77%

**Poisson Distribution for Vehicles Involved**
Average Vehicles Involved (λ): 1.65

**Probabilities:**
0 vehicles: 19.29% (may indicate data errors)
1 vehicle: 31.74%
2 vehicles: 26.12%
Probability decreases as vehicle count increases
Weekday vs. Weekend Analysis
Severe accidents (deaths or severe injuries):
Weekdays: 24.9%
Weekends: 28.52%

Slightly higher risk of severe accidents on weekends

**Simple Linear Regression**
Model: Total injuries ~ Vehicles involved
Slope: 0.18 injuries per additional vehicle
Insight: Injury count increases slightly with more vehicles

**Correlation Analysis**
Correlation coefficient between vehicles and injuries: 0.1093
Indicates a very weak positive relationship

**Confidence Interval for Mean Total Injuries**
Mean: Approximately 1.10
95% Confidence Interval: [1.0916, 1.0985]

Suggests high confidence in the stability of the average injury rate

**Conclusions**
Most accidents involve 1 to 2 vehicles and result in about 1 injury.
Fatal accidents are relatively uncommon but still significant.
Accidents with more vehicles tend to cause slightly more injuries.
Weekends are more prone to severe accidents, possibly due to increased travel and social activities.
The overall injury count per accident is generally low, which may indicate moderate severity in most cases.

Road Accident Data Analysis (Brazil: 2017–2023)
Problem Statement
Road accidents are a significant public safety concern, often resulting in injuries, fatalities, and property damage. Analyzing historical accident data helps uncover trends and contributing factors, leading to improved safety measures and potentially saving lives.

Objectives
This project analyzes road accident data from Brazil (2017–2023) to:

Explore how accidents are distributed across different factors.

Estimate the probability of accidents being fatal.

Understand how the number of vehicles involved affects the number of injuries.

Test if the average number of injuries per accident is significantly different from a certain value.

Compare accident severity between weekdays and weekends.

Provide insights that can guide improvements in road safety.

Dataset Information
Source: Kaggle - Car Accidents in Brazil (2017–2023)
https://www.kaggle.com/datasets/mlippo/car-accidents-in-brazil-2017-2023

Total Records: 463,091 accidents

Key Variables
inverse_data – Date of the accident

week_day – Day of the week

hour – Time of the accident

state – State where the accident occurred

city – City where the accident occurred

cause_of_accident – Reported cause of the accident

type_of_accident – Type of collision or accident

victims_condition – Victim status (e.g., injured, dead)

weather_timestamp – Time of day (e.g., night, day)

wheather_condition – Weather conditions during the accident

road_type – Type of road (e.g., simple, double)

people – Total number of people involved

deaths – Number of fatalities

slightly_injured – Number of slightly injured individuals

severely_injured – Number of severely injured individuals

uninjured – Number of uninjured individuals

total_injured – Total injured individuals

vehicles_involved – Number of vehicles involved

Exploratory Data Analysis (EDA)
Summary Statistics
Average Injuries per Accident: Approximately 1.10

Average Vehicles Involved per Accident: Approximately 1.65

Maximum Injuries in a Single Accident: 66

Minimum Injuries: 0

Visualizations and Insights
Histogram: Total Injuries

Most accidents result in 1 injury.

Single-injury accidents are the most common.

Bar Chart: Accidents by Weekday

Saturday and Sunday show the highest accident counts.

Indicates increased risk during weekends.

Boxplot: Injuries by Victim Condition

Highest spread of injuries in accidents with injured victims.

Accidents with fatalities have fewer but sometimes extreme injury counts.

Accidents with no victims show minimal injuries.

Pie Chart: Accident Types

Rear-end and side collisions are the most common types.

Less frequent types include cargo spills and occupant falls.

Scatterplot: Vehicles Involved vs. Total Injuries

Most accidents involve 1–3 vehicles with relatively few injuries.

Rare high-injury cases typically involve multiple vehicles.

Weak positive correlation suggests additional vehicles contribute slightly to injury counts.

Statistical Analysis
Binomial Distribution for Fatalities

Total Accidents: 463,091

Fatal Accidents: 31,343

Estimated Probability of Fatal Accident: 6.77%

Poisson Distribution for Vehicles Involved

Average Vehicles Involved (λ): 1.65

Probabilities:

0 vehicles: 19.29% (may indicate data errors)

1 vehicle: 31.74%

2 vehicles: 26.12%

Probability decreases as vehicle count increases

Weekday vs. Weekend Analysis

Severe accidents (deaths or severe injuries):

Weekdays: 24.9%

Weekends: 28.52%

Slightly higher risk of severe accidents on weekends

Simple Linear Regression

Model: Total injuries ~ Vehicles involved

Slope: 0.18 injuries per additional vehicle

Insight: Injury count increases slightly with more vehicles

Correlation Analysis

Correlation coefficient between vehicles and injuries: 0.1093

Indicates a very weak positive relationship

Confidence Interval for Mean Total Injuries

Mean: Approximately 1.10

95% Confidence Interval: [1.0916, 1.0985]

Suggests high confidence in the stability of the average injury rate

Conclusions
Most accidents involve 1 to 2 vehicles and result in about 1 injury.

Fatal accidents are relatively uncommon but still significant.

Accidents with more vehicles tend to cause slightly more injuries.

Weekends are more prone to severe accidents, possibly due to increased travel and social activities.

The overall injury count per accident is generally low, which may indicate moderate severity in most cases.

**Recommendations**
Increase public awareness and enforcement on weekends.
Monitor and review data inconsistencies.
Promote vehicle safety technologies and infrastructure improvements.
Encourage better emergency response planning for high-vehicle-count accidents.
Increase public awareness and enforcement on weekends.
Promote vehicle safety technologies and infrastructure improvements.
Encourage better emergency response planning for high-vehicle-count accidents.

