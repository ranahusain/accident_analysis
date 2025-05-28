library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(moments) # For skewness calculation

# Load dataset
# Update the path to your dataset
dataset_path <- "./accidents_2017_to_2023_english.csv"
data <- read.csv(dataset_path)

# Define UI
ui <- dashboardPage(
  skin = "black",
  
  dashboardHeader(title = "Accident Data Analysis", titleWidth = 300),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Statistical Distributions", tabName = "stat_distributions", icon = icon("chart-area")),
      menuItem("Statistical Analysis", tabName = "stat_analysis", icon = icon("chart-line")),
      hr(),
      h4("Filters", align = "center"),
      selectInput("filter_state", "Select State", choices = c("All States", sort(unique(data$state))), selected = "All States"),
      selectInput("filter_weekday", "Select Weekday", choices = c("All Days", sort(unique(data$week_day))), selected = "All Days"),
      actionButton("update", "Update Plots", class = "btn-primary"),
      actionButton("removeFilter", "Remove Filters", class = "btn-danger")
    )
  ),
  
  dashboardBody(
    tags$head(
      tags$style(HTML("
        .main-header .logo {
          background-color: #212121;
        }
        .main-sidebar {
          background-color: #333333;
        }
        .box {
          border-radius: 10px;
          background-color: #2c3e50;
          color: #ecf0f1;
        }
        .btn-primary {
          background-color: #1abc9c;
        }
        .btn-danger {
          background-color: #e74c3c;
        }
        .btn-warning {
          background-color: #f39c12;
        }
        .box-title {
          color: #ecf0f1;
        }
        .description {
          font-style: italic;
          font-size: 12px;
          color: #bdc3c7;
        }
      "))
    ),
    
    tabItems(
      # Dashboard Tab
      tabItem(tabName = "dashboard",
              fluidRow(
                box(
                  title = "Exploratory Data Analysis (EDA)", status = "primary", solidHeader = TRUE, width = 12,
                  verbatimTextOutput("eda_summary")
                )
              ),
              
              fluidRow(
                box(
                  title = "Histogram: Total Injuries", status = "info", solidHeader = TRUE, width = 6,
                  plotOutput("histogramPlot"),
                  p(class = "description", "This histogram shows the distribution of total injuries.")
                ),
                box(
                  title = "Bar Chart: Accidents by Weekday", status = "info", solidHeader = TRUE, width = 6,
                  plotOutput("barPlot"),
                  p(class = "description", "This bar chart highlights accident counts for each weekday, helping identify peak days.")
                )
              ),
              
              fluidRow(
                box(
                  title = "Boxplot: Injuries by Victim Condition", status = "warning", solidHeader = TRUE, width = 6,
                  plotOutput("boxPlot"),
                  p(class = "description", "This boxplot shows the spread of total injuries grouped by victim condition.")
                ),
                box(
                  title = "Pie Chart: Accident Types", status = "warning", solidHeader = TRUE, width = 6,
                  plotOutput("pieChart"),
                  p(class = "description", "This pie chart shows the percentages of different accident types in all states.")
                )
              ),
              
              fluidRow(
                box(
                  title = "Scatterplot: Vehicles vs Injuries", status = "danger", solidHeader = TRUE, width = 12,
                  plotOutput("scatterPlot"),
                  p(class = "description", "This scatterplot examines the relationship between vehicles involved and total injuries.")
                )
              ),
              
              fluidRow(
                box(
                  title = "Descriptive Statistical Analysis", status = "primary", solidHeader = TRUE, width = 12,
                  collapsible = TRUE,
                  collapsed = TRUE,
                  verbatimTextOutput("stat_analysis"),
                  p(class = "description", "It provides detailed analysis including central tendency, dispersion, and skewness.")
                )
              )
      ),
      
      # Statistical Distributions Tab
      tabItem(tabName = "stat_distributions",
              fluidRow(
                box(
                  title = "Binomial Distribution for Fatalities", status = "primary", solidHeader = TRUE, width = 12,
                  plotOutput("binomialPlot"),
                  verbatimTextOutput("binomialSummary"),
                  p(class = "description", "This section estimates the probability of an accident being fatal based on our dataset.")
                )
              ),
              fluidRow(
                box(
                  title = "Poisson Distribution for Vehicles Involved", status = "info", solidHeader = TRUE, width = 12,
                  plotOutput("poissonPlot"),
                  verbatimTextOutput("poissonSummary"),
                  p(class = "description", "This section shows the distribution of accidents involving a certain number of vehicles.")
                )
              ),
              fluidRow(
                box(
                  title = "Probability of Severe Accidents on Weekdays vs Weekends", status = "warning", solidHeader = TRUE, width = 12,
                  plotOutput("severityPlot"),
                  verbatimTextOutput("severitySummary"),
                  p(class = "description", "This section calculates the likelihood of severe accidents on weekdays vs. weekends.")
                )
              )
      ),
      
      # Statistical Analysis Tab
      tabItem(tabName = "stat_analysis",
              fluidRow(
                box(
                  title = "Simple Linear Regression", status = "primary", solidHeader = TRUE, width = 12,
                  plotOutput("regressionPlot"),
                  verbatimTextOutput("regressionSummary"),
                  p(class = "description", "This section determines how total injuries increase as more vehicles are involved.")
                )
              ),
              fluidRow(
                box(
                  title = "Correlation Analysis", status = "danger", solidHeader = TRUE, width = 12,
                  verbatimTextOutput("correlationAnalysis"),
                  p(class = "description", "Computing the correlation between vehicles involved and total injuries to determine the strength and direction of their relationship.")
                )
              ),
              fluidRow(
                box(
                  title = "Confidence Interval", status = "success", solidHeader = TRUE, width = 12,
                  plotOutput("confidenceIntervalPlot"),
                  verbatimTextOutput("confidenceInterval"),
                  p(class = "description", "Calculating a 95% confidence interval for the mean total injuries to understand the range of values for average injuries.")
                )
              )
      )
    )
  )
)

# Define Server
server <- function(input, output, session) {
  
  # Reactive dataset filtered by state and weekday
  filtered_data <- reactive({
    input$update
    isolate({
      data_subset <- data
      if (input$filter_state != "All States") {
        data_subset <- data_subset %>% filter(state == input$filter_state)
      }
      if (input$filter_weekday != "All Days") {
        data_subset <- data_subset %>% filter(week_day == input$filter_weekday)
      }
      return(data_subset)
    })
  })
  
  # Remove Filters
  observeEvent(input$removeFilter, {
    updateSelectInput(session, "filter_state", selected = "All States")
    updateSelectInput(session, "filter_weekday", selected = "All Days")
  })
  
  # EDA Output
  output$eda_summary <- renderPrint({
    eda <- filtered_data() %>%
      summarise(
        Total_Records = n(),
        Average_Injuries = mean(total_injured, na.rm = TRUE),
        Average_Vehicles = mean(vehicles_involved, na.rm = TRUE),
        Max_Injuries = max(total_injured, na.rm = TRUE),
        Min_Injuries = min(total_injured, na.rm = TRUE)
      )
    print(eda)
  })
  
  # Histogram
  output$histogramPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = total_injured)) +
      geom_histogram(binwidth = 1, fill = "blue", color = "black") +
      theme_minimal() +
      labs(title = "Distribution of Total Injuries", x = "Total Injuries", y = "Frequency")
  })
  
  # Bar Plot
  output$barPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = week_day)) +
      geom_bar(fill = "orange") +
      theme_minimal() +
      labs(title = "Accidents by Weekday", x = "Weekday", y = "Count")
  })
  
  # Boxplot
  output$boxPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = victims_condition, y = total_injured)) +
      geom_boxplot(fill = "green") +
      theme_minimal() +
      labs(title = "Total Injuries by Victim Condition", x = "Victim Condition", y = "Total Injuries")
  })
  
  # Pie Chart
  output$pieChart <- renderPlot({
    pie_data <- filtered_data() %>%
      group_by(type_of_accident) %>%
      summarise(count = n())
    ggplot(pie_data, aes(x = "", y = count, fill = type_of_accident)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0) +
      theme_void() +
      labs(title = "Accident Type Distribution", fill = "Accident Type")
  })
  
  # Scatter Plot
  output$scatterPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = vehicles_involved, y = total_injured)) +
      geom_point(color = "blue") +
      geom_smooth(method = "lm", color = "red") +
      theme_minimal() +
      labs(title = "Vehicles Involved vs Total Injuries", x = "Vehicles Involved", y = "Total Injuries")
  })
  
  # Descriptive Statistical Analysis
  output$stat_analysis <- renderPrint({
    analysis <- filtered_data() %>%
      summarise(
        Mean_Injuries = mean(total_injured, na.rm = TRUE),
        Median_Injuries = median(total_injured, na.rm = TRUE),
        Variance_Injuries = var(total_injured, na.rm = TRUE),
        SD_Injuries = sd(total_injured, na.rm = TRUE),
        Range_Injuries = diff(range(total_injured, na.rm = TRUE)),
        IQR_Injuries = IQR(total_injured, na.rm = TRUE),
        Skewness_Injuries = skewness(total_injured, na.rm = TRUE)
      )
    print(analysis)
  })
  
  # Binomial Distribution for Fatalities
  output$binomialSummary <- renderPrint({
    total_accidents <- nrow(filtered_data())
    fatal_accidents <- sum(filtered_data()$deaths > 0, na.rm = TRUE)
    p_hat <- fatal_accidents / total_accidents
    cat("Total Accidents:", total_accidents, "\n")
    cat("Fatal Accidents:", fatal_accidents, "\n")
    cat("Estimated Probability of Fatal Accident (p):", round(p_hat, 4), "\n")
  })
  
  output$binomialPlot <- renderPlot({
    p_hat <- sum(filtered_data()$deaths > 0, na.rm = TRUE) / nrow(filtered_data())
    n <- 10
    k <- 0:n
    binom_probs <- dbinom(k, size = n, prob = p_hat)
    barplot(binom_probs, names.arg = k, xlab = "Number of Fatal Accidents in Sample of 10", ylab = "Probability", main = "Binomial Distribution of Fatal Accidents")
  })
  
  # Poisson Distribution for Vehicles Involved
  output$poissonSummary <- renderPrint({
    lambda <- mean(filtered_data()$vehicles_involved, na.rm = TRUE)
    cat("Estimated Lambda (Average Vehicles Involved per Accident):", round(lambda, 4), "\n")
  })
  
  output$poissonPlot <- renderPlot({
    lambda <- mean(filtered_data()$vehicles_involved, na.rm = TRUE)
    k <- 0:10
    pois_probs <- dpois(k, lambda = lambda)
    barplot(pois_probs, names.arg = k, xlab = "Number of Vehicles Involved", ylab = "Probability", main = "Poisson Distribution of Vehicles Involved")
  })
  
  # Estimation of Event Probabilities
  output$severitySummary <- renderPrint({
    weekend_days <- c("saturday", "sunday")
    
    data <- filtered_data()
    
    data$day_type <- ifelse(tolower(data$week_day) %in% weekend_days, "Weekend", "Weekday")
    
    data$severe_accident <- ifelse(data$deaths > 0 | data$severely_injured > 0, 1, 0)
    
    severe_weekday <- sum(data$severe_accident[data$day_type == "Weekday"], na.rm = TRUE)
    total_weekday <- sum(data$day_type == "Weekday", na.rm = TRUE)
    
    severe_weekend <- sum(data$severe_accident[data$day_type == "Weekend"], na.rm = TRUE)
    total_weekend <- sum(data$day_type == "Weekend", na.rm = TRUE)
    
    prob_severe_weekday <- severe_weekday / total_weekday
    prob_severe_weekend <- severe_weekend / total_weekend
    
    cat("Weekday Severe Accidents Probability:", round(prob_severe_weekday, 4), "\n")
    cat("Weekend Severe Accidents Probability:", round(prob_severe_weekend, 4), "\n")
  })
  
  output$severityPlot <- renderPlot({
    weekend_days <- c("saturday", "sunday")
    
    data <- filtered_data()
    
    data$day_type <- ifelse(tolower(data$week_day) %in% weekend_days, "Weekend", "Weekday")
    
    data$severe_accident <- ifelse(data$deaths > 0 | data$severely_injured > 0, 1, 0)
    
    summary_data <- data %>%
      group_by(day_type) %>%
      summarise(
        severe_accidents = sum(severe_accident, na.rm = TRUE),
        total_accidents = n()
      ) %>%
      mutate(probability = severe_accidents / total_accidents)
    
    ggplot(summary_data, aes(x = day_type, y = probability, fill = day_type)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      labs(title = "Probability of Severe Accidents: Weekdays vs Weekends", x = "Day Type", y = "Probability") +
      scale_fill_manual(values = c("Weekday" = "blue", "Weekend" = "orange")) +
      theme(legend.position = "none")
  })
  
  # Simple Linear Regression
  output$regressionSummary <- renderPrint({
    model <- lm(total_injured ~ vehicles_involved, data = filtered_data())
    summary_stats <- summary(model)
    r_squared <- summary_stats$r.squared
    coefficients <- summary_stats$coefficients
    slope <- coefficients["vehicles_involved", "Estimate"]
    p_value <- coefficients["vehicles_involved", "Pr(>|t|)"]
    
    cat("Linear Regression Summary:\n")
    cat("Relationship: Total Injured ~ Vehicles Involved\n")
    cat("For each additional vehicle involved, total injuries increase by an average of", round(slope, 2), "\n")
    cat("R-squared:", round(r_squared, 4), "indicating the model explains", round(r_squared * 100, 2), "% of the variance\n")
    cat("p-value:", format.pval(p_value, digits = 3), "showing the relationship is statistically significant\n")
  })
  output$regressionPlot <- renderPlot({
    model <- lm(total_injured ~ vehicles_involved, data = filtered_data())
    ggplot(filtered_data(), aes(x = vehicles_involved, y = total_injured)) + 
      geom_point(color = "blue") +
      geom_smooth(method = "lm", color = "red") +
      theme_minimal() +
      labs(title = "Linear Regression: Total Injured vs Vehicles Involved",
           x = "Vehicles Involved",
           y = "Total Injured")
  })
  
  
  # Correlation Analysis
  output$correlationAnalysis <- renderPrint({
    correlation <- cor(filtered_data()$vehicles_involved, filtered_data()$total_injured, use = "complete.obs")
    cat("Correlation between Vehicles Involved and Total Injuries:", round(correlation, 4), "\n")
  })
  
  # Confidence Interval
  output$confidenceInterval <- renderPrint({
    mean_injuries <- mean(filtered_data()$total_injured, na.rm = TRUE)
    sd_injuries <- sd(filtered_data()$total_injured, na.rm = TRUE)
    n <- sum(!is.na(filtered_data()$total_injured))
    error <- qt(0.975, df = n - 1) * sd_injuries / sqrt(n)
    lower_bound <- mean_injuries - error
    upper_bound <- mean_injuries + error
    cat("95% Confidence Interval for Mean Total Injuries: [", round(lower_bound, 4), ", ", round(upper_bound, 4), "]\n")
  })
  
  # Confidence Interval Plot
  output$confidenceIntervalPlot <- renderPlot({
    mean_injuries <- mean(filtered_data()$total_injured, na.rm = TRUE)
    sd_injuries <- sd(filtered_data()$total_injured, na.rm = TRUE)
    n <- sum(!is.na(filtered_data()$total_injured))
    error <- qt(0.975, df = n - 1) * sd_injuries / sqrt(n)
    lower_bound <- mean_injuries - error
    upper_bound <- mean_injuries + error
    
    ci_data <- data.frame(
      mean = mean_injuries,
      lower = lower_bound,
      upper = upper_bound
    )
    
    ggplot(ci_data, aes(x = 1, y = mean)) +
      geom_point(size = 3) +
      geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.1) +
      theme_minimal() +
      labs(title = "95% Confidence Interval for Mean Total Injuries",
           x = "",
           y = "Total Injuries") +
      ylim(0, NA) +
      theme(axis.text.x = element_blank(),
            axis.ticks.x = element_blank())
  })
}

# Run the application
shinyApp(ui = ui, server = server)
