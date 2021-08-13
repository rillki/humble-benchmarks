# getting command line arguments
args <- commandArgs(trailingOnly = TRUE)

# checking num of arguments
if(length(args) < 1) {
    print("Specify number of iterations!")
    invokeRestart("abort")
}

# our contingency table
data <- matrix(c(1982, 3018, 2056, 2944), nrow = 2)

pvalue <- 0.0
for(i in 0:strtoi(args[1])) {
    pvalue <- fisher.test(data)
}

print(paste("pvalue =", pvalue["p.value"]))
