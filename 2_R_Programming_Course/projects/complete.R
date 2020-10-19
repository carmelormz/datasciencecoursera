complete <- function(directory, id = 1:332) {
  files_directory <- list.files(directory)
  col_ids <- c()
  col_nobs <- c()
  for (id_file in id) {
    monitor_data <- read.csv(paste(getwd(), directory, files_directory[id_file], sep = "/"))
    complete_cases <- subset(monitor_data, !is.na(monitor_data$sulfate) & !is.na(monitor_data$nitrate))
    col_ids <- c(col_ids, id_file)
    col_nobs <- c(col_nobs, nrow(complete_cases))
  }
  
  result <- data.frame(col_ids, col_nobs)
  colnames(result) <- c("ids", "nobs")
  result
}
