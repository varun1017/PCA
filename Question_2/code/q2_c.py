from numpy import double, random, matrix, linalg, diag, sqrt, sum, transpose
import matplotlib.pyplot as plt
random.seed(0)

N = [10, 100, 1000, 10000, 100000] 

Mean = matrix([ [1], [2] ])
Cov = matrix([ [1.6250, -1.9486], [-1.9486, 3.8750] ])
[eigenvalues, eigenvectors] = linalg.eig(Cov)

l = matrix(diag(sqrt(eigenvalues)))
A = matrix(eigenvectors)*l 

cov_error = [[] for i in range(5)]

for k in range(5):				# iterate over N values
    for i in range(100):		# observing 100 times the experiment for each N
        W=[]
        for j in range(2):		# generating (N*2) sample random number
            W.append(tuple(random.randn(N[k])))

        X = (A * W) + Mean    # random 2D variables with desired mean and covariance
	
		# Error calculation of covariance
        MLE_mean=( [sum(X[0])/N[k]], [sum(X[1])/N[k]]) #MLE of mean
        
        MLE_cov = ((X-MLE_mean) * (transpose(X-MLE_mean)))/N[k]
        difference_error = (Cov - MLE_cov)
        
        norm_Estimated_error = 0.0; norm_true_cov = 0.0
        for a in range(2):
            for b in range(2):
                norm_Estimated_error += difference_error.item((a,b))**2
                norm_true_cov += Cov.item((a,b))**2

        norm_Estimated_error = double(sqrt(norm_Estimated_error))
        norm_true_cov = double(sqrt(norm_true_cov))
        
        cov_error[k].append(double(norm_Estimated_error/norm_true_cov))
        

# ploting boxplot of error in covariance
fig, ax = plt.subplots()
ax.set(xlabel=u'log\u2081\u2080N', ylabel="Error", title="Covariance Error plot")
ax.boxplot(cov_error)
fig.savefig("cov_error.png")

