from numpy import pi, random,exp
import matplotlib.pyplot as plt
random.seed(0)

x1 = 0; x2 = pi; x3 = pi/3
y1 = 0; y2 = 0;  y3 = exp(1)
N = 10000000

u = random.uniform(0,1,N)
v = random.uniform(0,1,N)
w = 1-u-v

for i in range(N):
    if w[i] < 0:
        u[i] = 1 - u[i]
        v[i] = 1 - v[i]
        w[i] = -w[i]

x = u*x1 + v*x2 + w*x3
y = u*y1 + v*y2 + w*y3

fig, ax = plt.subplots(figsize=(8,8))
ax.set(title="Random Points inside Triangle")
plt.hist2d(x, y, bins=500)
plt.savefig("q1_d.png")
