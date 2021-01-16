library(shiny)
library(shinyFiles)

navbarPage("Downloads",
           
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