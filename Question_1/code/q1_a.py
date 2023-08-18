from numpy import pi, random, cos, sin, sqrt
random.seed(0)

major_axis = 2; minor_axis = 1
a = major_axis/2; b = minor_axis/2

r = random.uniform(0,1)        # random radius in (0,1)
theta = random.uniform(0,2*pi) # random angle in (0,2*pi)

x = sqrt(r)*cos(theta)         # converting into cartesian coordinates
y = sqrt(r)*sin(theta)     

x=x*b           # multiplying x,y coordinate with length of semiminor,semimajor axis
y=y*a           # to get all points inside ellipse

print(x,y)
