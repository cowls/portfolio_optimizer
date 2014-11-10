library("shiny")
library("tseries")
library("zoo")
library("PerformanceAnalytics")
source('./functions.R')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  asset1_data <- reactive({
    asset1.returns = get.asset.returns(input$asset1)
  })
  
  asset2_data <- reactive({
    asset2.returns = get.asset.returns(input$asset2)
  })
  
  asset1_data_mat <- reactive({
     asset1.returns.mat = get.asset.data(input$asset1)
  })
  
  asset2_data_mat <- reactive({
     asset2.returns.mat = get.asset.data(input$asset2)
  })
  
  output$data_table <- renderDataTable({
      wealth = as.numeric(input$w0)
      asset1.vec = get.asset.summary(assetName=input$asset1,data=asset1_data_mat(),w0=wealth)
      asset2.vec = get.asset.summary(assetName=input$asset2,data=asset2_data_mat(),w0=wealth)
      
      
      
      summary.matrix = matrix(c(asset1.vec, asset2.vec),ncol=4, byrow=TRUE)
      colnames(summary.matrix) = c("Asset Name", "Expected Return (Monthly)", "Volatility", "5% VaR")
      
      summary.matrix
  },options=list(searching=FALSE,paging=FALSE))
  
  output$asset1_plotReturns <- renderPlot({
    plot(asset1_data(), main="Asset Returns", ylab="Returns",xlab="Date",col="blue", type="l")
    lines(asset2_data(), col="orange", type="l")
    abline(h=0)

    legend('topright', c(input$asset1,input$asset2),lty=c(1,1), lwd=c(2.5,2.5),col=c("blue","orange"))
  })
})