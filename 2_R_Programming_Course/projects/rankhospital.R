rankhospital <- function(state, outcome, num = "best") {
  result <- NULL
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
  
  ## filter data by outcome
  filtered_outcome_data <- filtered_state_data[, c(2,outcome_col)]
  
  
  ## Convert values to numeric
  filtered_outcome_data[, 2] <- as.numeric(filtered_outcome_data[, 2])
  
  ## Delete na values
  final_data <- subset(filtered_outcome_data, !is.na(filtered_outcome_data[, 2]))
  
  ## Order results first by mortality then by alphabetical order
  order_results <- order(final_data[,2], final_data[,1])
  final_data <- final_data[order_results,]
  
  ##Get result
  if (num == "best") {
    result <- final_data[1,]
  } else if (num == "worst") {
    result <- final_data[nrow(final_data),]
  } else {
    if(num > nrow(final_data)) {
      result <- NA
    } else {
       result <- final_data[num,] 
    }
   
  }
  
  ##Validate if results was found, if not return NA
  if(is.na(result)) {
    result
  } else {
    result$Hospital.Name
  }
  
  
}