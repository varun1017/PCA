load points2D_Set2.mat
%disp(x)
data = [x y];
data =  transpose(data);
mean = [sum(x)/length(x); sum(y)/length(y)]; %calculating mean of observation

cov = ((data-mean)*transpose((data-mean)))/(length(x)-1);   % calculating covariance of observation
eigenvalues = eig(cov);       % eigenvalues and eigenvector of 
[eigenvectors,D] = eig(cov);  % covariance matrix

% initial point of linear graph
x1 = mean(1); y1 = mean(2);

%finding other 2 points for plotting the linear relationship between X and Y
slope1 = (eigenvectors(2,1)/eigenvectors(1,1));
slope2 = (eigenvectors(2,2)/eigenvectors(1,2));
eigenvalues = sqrt(eigenvalues);

x2 = x1 + eigenvalues(1)*cos(atan(slope1));
y2 = y1 + eigenvalues(1)*sin(atan(slope1));
x3 = x1 + eigenvalues(2)*cos(atan(slope2));
y3 = y1 + eigenvalues(2)*sin(atan(slope2));

set_x=[x1,x2,x3];set_y=[y1,y2,y3];

figure;
scatter(x,y)
hold on
plot(set_x,set_y,'r')%plotting mean
xlabel('X');
ylabel('Y');
%axis('equal');
hold on
grid on
