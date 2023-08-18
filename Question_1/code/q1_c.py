from numpy import pi, random,exp
random.seed(0)

x1 = 0; x2 = pi; x3 = pi/3   # x-coordinate of vertices of triangle
y1 = 0; y2 = 0;  y3 = exp(1) # y-coordinate of vertices of triangle

u = random.uniform(0,1)		 # randomly generate a number in (0,1)
v = random.uniform(0,1)
w = 1-u-v

if w < 0:
    u = 1 - u
    v = 1 - v
    w = -w

x = u*x1 + v*x2 + w*x3
y = u*y1 + v*y2 + w*y3

print(x,y)
