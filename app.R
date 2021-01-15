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



ui <- navbarPage("Downloads",
    
    # set navbar                 
    tabPanel("E. lineata",
    
    # set the title
    titlePanel("NGS Data Download Panel"),
    
    # set the side panel
    sidebarPanel(
    shinyFilesButton('files', label='File select', title='Please select a file', multiple=T),
    verbatimTextOutput('rawInputValue'),
    verbatimTextOutput('filepaths') ,
    downloadButton("downloadFiles", "Download Files")),
    
    # main panel
    mainPanel(
        h1("Sequence Data Information"),
        
        p("The Illunina sequencing reads and assembled transcriptome described in the 2014 BMC Genomics paper can be downloaded using the interface in the sidebar to the left."),
        br(),
        p("All sequencing data pertaining to",
            em("E. lineata"),
          "generated during my PhD training in The Finnerty Lab, including unpublished sequencing reads from life stages and body regions, are included within the folders accessible through this site."),
        br(),
        h2("About this app"),
        p("This web app is built with the Shiny framework within R.  The file selection portion utilizes the shinyFiles library, while the download button uses the basic downloadhandler from the shiny library"),
        p("The app is hosted on an AWS Elastic Compute Server.")
        
        )
    
)
)
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

shinyApp(ui = ui , server = server)