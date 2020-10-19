pollutantmean <- function(directory, pollutant, id = 1:332) {
  files_directory <- list.files(directory)
  pollutant_values <- c()
  for(id_file in id) {
    monitor_data <- read.csv(paste(getwd(), directory, files_directory[id_file], sep = "/"))
    pollutantdata <- monitor_data[pollutant]
    pollutant_values <- c(pollutant_values, pollutantdata[!is.na(pollutantdata)])
  }
  
  mean(pollutant_values)
}

