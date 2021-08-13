# command line arguments
import sys

# fisher's exact test
import scipy.stats as stats

# checking num of arguments
if(len(sys.argv) < 2):
    print("Specify number of iterations!")
    exit()

# our contingency table
data = [
    [1982, 3018],
    [2056, 2944]
]

pvalue = 0.0
for i in range(0, int(sys.argv[1])):
    _, pvalue = stats.fisher_exact(data)

print("pvalue = ", pvalue)
