rankall <- function(outcome, num = "best") {
  result <- NULL
  
  ## Read csv data for outcomes
  outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Get outcome selected column
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
  
  ## Convert mortality column to numeric
  outcome_data[, outcome_col] <- as.numeric(outcome_data[, outcome_col])
  
  ## Get columns needed
  base_data <- outcome_data[, c(2, 7, outcome_col)]
  
  ## Delete NAs
  base_data <- subset(base_data, !is.na(base_data[,3]))
  
  ## Function to get hospital based on a rank
  get_rank <- function(state) {
    ## Get data from state
    data_copy <- subset(base_data, base_data$State == state)
    rank <- NA
    if (num == "best") {
      rank <- 1
    } else if (num == "worst") {
      rank <- nrow(data_copy)
    } else if (num < nrow(data_copy)) {
      rank <- num 
    }
    
    ## Order data by mortality then by alphabetical order
    order_data <- order(data_copy[,3], data_copy[, 1])
    data_copy <- data_copy[order_data,]
    
    ## Validate data
    if (!is.na(rank)) {
      c(data_copy[rank, 1], state)
    } else {
      c(NA, state)
    }
    
  }
  
  ## Get values of all states and order by alphabetical order
  states_names <- unique(outcome_data[, 7])
  states_names <- states_names[order(states_names)]
  
  for (state in states_names) {
    ## Get data of state
    state_data <- get_rank(state)
    
    if (length(state_data) <= 1) {
      state_data <- c(NA, state)
    }
    
    ##  Create data frame
    dataRow <- data.frame(hospital = state_data[1], state = state_data[2], row.names = state_data[2])
    result <- rbind(result, dataRow)
  }
  
  result
}