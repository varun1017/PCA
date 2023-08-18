from numpy import pi, random,cos,sin,sqrt
import matplotlib.pyplot as plt
random.seed(0)

major_axis = 2; minor_axis = 1
a = major_axis/2; b = minor_axis/2
N = 10000000

r = random.uniform(0,1,N)      	 # random radius in (0,1)
theta = random.uniform(0,2*pi,N) # random angle in (0,2*pi)

x = sqrt(r)*cos(theta)     # converting into cartesian coordinates
y = sqrt(r)*sin(theta)     

x=x*b           # multiplying x,y coordinate with length of semimajor,minor axis
y=y*a           # to get all points inside ellipse

# plotting the 2D histogram of sample points
fig, ax = plt.subplots(figsize=(4,8))
ax.set(title="Random Points inside Ellipse")
ax.hist2d(x, y, bins=500)
fig.savefig("q1_b.png")
