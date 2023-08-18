from numpy import double, random, matrix, linalg, diag, sqrt, sum, transpose
import matplotlib.pyplot as plt
random.seed(0)

N = [10, 100, 1000, 10000, 100000] 

Mean = matrix([ [1], [2] ])
Cov = matrix([ [1.6250, -1.9486], [-1.9486, 3.8750] ])
[eigenvalues, eigenvectors] = linalg.eig(Cov)

l = matrix(diag(sqrt(eigenvalues)))
A = matrix(eigenvectors)*l 

mean_error = [[] for i in range(5)]

for k in range(5):				# iterate over N values
    for i in range(100):		# observing 100 times the experiment for each N
        W=[]
        for j in range(2):		# generating (N*2) sample random number
            W.append(tuple(random.randn(N[k])))

        X = (A * W) + Mean    # random 2D variables with desired mean and covariance
	
		# Error calculation of mean
        MLE_mean=( [sum(X[0])/N[k]], [sum(X[1])/N[k]]) #MLE of mean
        difference_error = (Mean - MLE_mean)

        norm_Estimated_error = sqrt(difference_error[0]**2 + difference_error[1]**2)
        norm_true_mean = (sqrt(Mean[0]**2 + Mean[1]**2))

        mean_error[k].append(double(norm_Estimated_error/norm_true_mean))
    	
   
# ploting boxplot of error in mean       
fig, ax = plt.subplots()
ax.set(xlabel=u'log\u2081\u2080N', ylabel="Error", title="Mean Error plot")
ax.boxplot(mean_error)
fig.savefig("mean_error.png")
ax.clear()


