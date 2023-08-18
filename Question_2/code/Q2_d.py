from numpy import arctan, cos, double, random, matrix, linalg, diag, sin, sqrt, sum, tanh, transpose

import matplotlib.pyplot as plt
random.seed(0)

N = [10, 100, 1000, 10000, 100000] 

Mean = matrix([ [1], [2] ])
Cov = matrix([ [1.6250, -1.9486], [-1.9486, 3.8750] ])
[eigenvalues, eigenvectors] = linalg.eig(Cov)

l = matrix(diag(sqrt(eigenvalues)))
A = matrix(eigenvectors) * l

fig, ax = plt.subplots(1,5, figsize=(20,4))
for k in range(5):				# iterate over N values
    W=[]
    for j in range(2):		# generating (N*2) sample random number
        W.append(tuple(random.randn(N[k])))

    X = (A * W) + Mean    # random 2D variables with desired mean and covariance
    
    # plotting line 
    empirical_mean = matrix([ [sum(X[0])/N[k]], [sum(X[1])/N[k]] ])
    empirical_cov = ((X-empirical_mean) * (transpose(X-empirical_mean)))/(N[k]-1)
    [eigenvalues, eigenvectors] = linalg.eig(empirical_cov)
    
    eigenvalues = sqrt(eigenvalues)
    
    x1 = empirical_mean.item(0); y1 = empirical_mean.item(1)
    slope1 = (eigenvectors.item(1,0)/eigenvectors.item(0,0))
    slope2 = (eigenvectors.item(1,1)/eigenvectors.item(0,1))
    #print(empirical_cov)
    x2 = x1 + eigenvalues.item(0)*cos(arctan(slope1))
    y2 = y1 + eigenvalues.item(0)*sin(arctan(slope1))
    x3 = x1 + eigenvalues.item(1)*cos(arctan(slope2))
    y3 = y1 + eigenvalues.item(1)*sin(arctan(slope2))
    
    xw = [x1, x2]
    yw = [y1, y2]
    #plt.plot(x, y)
    #plt.show()
    
    
    x=[]; y=[]
    for i in range(N[k]):
        x.append( X.item((0,i)) )
        y.append( X.item((1,i)) )
    # ploting boxplot of error in mean       
    
    ax[k].set( title="Scatter plot for N="+str(N[k]))
    ax[k].scatter(x,y, label="Scatter plot of generated data")
    mean = [ 1, 2 ]
    x, y = random.multivariate_normal(mean, Cov, 100000).T

    #ax[k].scatter(x, y)

    ax[k].plot((x1,x2),(y1,y2), color='red', label="Mode of variation Line")
    ax[k].plot((x1,x3),(y1,y3), color='red')
    #plt.show()
    fig.savefig("Q2_d.png")
		
    	
        
