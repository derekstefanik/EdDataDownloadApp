#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyFiles)

#To download the file with downloadHandler you need to provide the full name including the path as a string, but your variable filepathsObject is an object of class "shiny.render.function.

#The parseFilePaths function will return a list with all the information needed, but you need convert it to character. Below is you code modified to download the previously uploaded file.

#Please note that the download button doesn't works well on the RStudio viewer, so launch the app in a browser if you want to have the original file name as default.


server <- function(input, output) {

  roots =  c(wd = '~/Desktop/Anemones/filedownloader/')

  shinyFileChoose(input, 'files', 
                  roots =  roots, 
                  filetypes=c('', 'txt' , 'gz' , 'md5' , 'pdf' , 'fasta' , 'fastq' , 'aln'))

  output$rawInputValue <- renderPrint({str(input$files)})

  output$filepaths <- renderPrint({parseFilePaths(roots, input$files)})

  output$downloadFiles <- downloadHandler(
    filename = function() {
      as.character(parseFilePaths(roots, input$files)$name)
    },
    content = function(file) {
      fullName <- as.character(parseFilePaths(roots, input$files)$datapath)
      file.copy(fullName, file)
    }
  )
}
