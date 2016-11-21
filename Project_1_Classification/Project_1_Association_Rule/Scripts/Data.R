# Other Configuration ---
options(max.print = 230);

# Load Data Sets ---
groceries <- read.csv("Data/GroceryStoreDataSet.csv", FALSE);

onlineRetail.table <- read_excel("Data/Online Retail.xlsx");
onlineRetail <- onlineRetail.table[onlineRetail.table$Quantity > 0, c("InvoiceNo", "StockCode")]
onlineRetail$InvoiceNo <- as.numeric(onlineRetail$InvoiceNo)
onlineRetail$StockCode <- as.character(onlineRetail$StockCode)
onlineRetail <- ddply(onlineRetail, c("InvoiceNo"), function(df1) paste(onlineRetail$StockCode, collapse = ","), .parallel = TRUE)

cl = makeCluster(6)
registerDoParallel(cl)
clusterCall(cl, function(x) .libPaths(x), .libPaths())
onlineRetail <- ddply(
    onlineRetail, 
    .(InvoiceNo),
    function(idx) { paste(onlineRetail$StockCode, collapse = ",") }, 
    .parallel = TRUE, 
    .paropts = list(.export = c('onlineRetail', 'paste'), .packages = .packages(all.available = T))
)