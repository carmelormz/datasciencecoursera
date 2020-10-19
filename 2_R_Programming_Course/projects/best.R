
## Findig the best hospital in a state
best <- function(state, outcome) {
  ## Read csv data for outcomes
  outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Filter data by state
  filtered_state_data <- subset(outcome_data, outcome_data$State == state)
  
  ##Validate state
  if (nrow(filtered_state_data) == 0) {
    stop("invalid state")
  }
  
  ## Get column name and validate outcome name
  outcome_col <- 0
  if (outcome == "heart attack") {
    outcome_col <- 11
  } else if (outcome == "heart failure") {
    outcome_col <- 17
  } else if (outcome == "pneumonia") {
    outcome_col <- 23
  } else {
    stop("invalid outcome")
  }
  
  ## Get minimum
  min_value <- min(as.numeric(filtered_state_data[,outcome_col]), na.rm = TRUE)
  
  ## We get row with final value
  result <- subset(filtered_state_data, as.numeric(filtered_state_data[,outcome_col]) == min_value)
  
  ## If we have more than one result, we sort the results by alphabetical order
  if (nrow(result) > 1) {
    sorted_list <- sort(result$Hospital.Name)
    result <- sorted_list[1,]
  }
  ## Return result
  result$Hospital.Name
}