corr <- function(directory, threshold = 0) {
  result <- numeric(0)
  
  files_directory <- list.files(directory)
  
  monitors_data_completes <- complete(directory)
  monitors_data_threshold <- subset(monitors_data_completes, monitors_data_completes$nobs > threshold)
  
  for (id_file in monitors_data_threshold$id) {
    monitor_data <- read.csv(paste(getwd(), directory, files_directory[id_file], sep = "/"))
    monitor_data_filtered <- subset(monitor_data, !is.na(monitor_data$sulfate) & !is.na(monitor_data$nitrate))
    result <- c(result, cor(monitor_data_filtered$sulfate, monitor_data_filtered$nitrate))
    
  }
  
  result
}
