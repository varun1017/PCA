load('mnist.mat');  % loading the given data(mnist.mat) to use in this file
allmean=zeros(784,10);  % creating a 2D array of size 784x10 with all zeros later on which will store mean of each digit in a column
allcovariance=zeros(784,784,10); % creating a 3D array of size 784x784x10 with all zeros later on which will store covariance of each digit in a 2D array corresponding to the 3rd dimension
largest_eigen_values=zeros(1,10); % creating a 1D array od size 1x10 with all zeros in which we will later store the largest eigen value corresponding to each digit from 0 to 9
all_eigen_values=zeros(784,10); % creating a 2D array of size 784x10 with all zeros in which we will later store all the eigen values in  each column for each digit from 0 to 9
pmov_eigen_vectors=zeros(784,10); % creating a 2D array of size 784x10 with all zeros in which we will later store the eigen vector corresponding to largest eigen value also known as principal mode of variation   in  each column for each digit from 0 to 9
n = 60000; % total number of examples
conc=zeros(784,n); % creating a variable to store the resized array of 60000 examples in digits_train
%iterating through the for loop to store all the 60000 examples of size
%784x1 in conc variable
for i=1:n
    temp1 = digits_train(:,:,i);
    temp1 = reshape(temp1,[784,1]);
    conc(:,i)=temp1;
end

% each iteration will do for digits from 0 to 9
for j=0:9
    indj = find(labels_train==j); % finding the all indices of the present iteration digit in labels_train

    add = zeros(784,1);
    full_matj = zeros(784,length(indj));
    full_matmean = zeros(784,length(indj));
    % iterating through for loop to add all the column vectors of the same
    for i = 1:length(indj)
        add = add+conc(:,indj(i,1)); % adding all columns
        full_matj(:,i) = conc(:,indj(i,1)); % storing all columns of the same digit
    end
    mean = add/length(indj); %calculating mean
    allmean(:,j+1) = mean; % storing mean of each digit from 0 to 9

    subtracted_mat = full_matj - mean; % forming a subtracted matrix of original data and mean for the digit in present iteration
    cov = subtracted_mat*subtracted_mat.'/(size(full_matj.',1)-1); % calculating covariance using the subtracted matrix
    allcovariance(:,:,j+1) = cov ; % storing the covariance matrix of all digits
    [ievect,ieval] = eig(cov); %ievect is intial eigen vectors and ieval is initial eigen values
    [d,ind] = sort(diag(ieval)); %sorting eigen values, d stores sorted numbers and ind stores it's corresponding index of original
    all_eigen_values(:,j+1) = d; % storing eigen values of each digit from 0 to 9
    feval = ieval(ind,ind); %final eigen value matrix containing diagonal sorted elemnets
    fevect = ievect(:,ind); %final eigen vector matrix , each column corresponds to it's eigen vector in above

    largeval = feval(784,784); %largest eigen value
    largest_eigen_values(1,j+1) = largeval; % storing largest eigen values of each digit from 0 to 9
    pmov = fevect(:,784); %principal mode of variation aka eigen vector of largest eigen value
    pmov_eigen_vectors(:,j+1) = pmov; % storing the above calculated pmov of each digit from 0 to 9
    
end

% iterating through the for loop to plot the required images for each digit
% from 0 to 9
for k=1:10
    
    figure;
    hold on;
    plot(flip(all_eigen_values(:,k))); % plotting all the eigen values in descending order
    constant_line = zeros(784,1);
    constant_line(:,1) = largest_eigen_values(1,k)/100; % also plotting a line of 1 percent the highest eigen value to check significant eigen values
    plot(constant_line);
    title('For digit',k-1);
    xlabel('Component Number');
    ylabel('Eigen Value');
    hold off;
    
    % caculating and plotting the (i) part of last part of given question
    var1 = allmean(:,k)-(sqrt(largest_eigen_values(1,k))*pmov_eigen_vectors(:,k));
    var1_plot1 = reshape(var1,[28,28]);
    var1_plot2 = (var1_plot1-min(var1))/(max(var1)-min(var1));
    figure;
    subplot(1,3,1);
    imshow(var1_plot2);
    
    % caculating and plotting the (ii) part of last part of given question
    var2 = reshape(allmean(:,k),[28,28]);
    var2_plot2 = (var2-min(allmean(:,k)))/(max(allmean(:,k))-min(allmean(:,k)));
    subplot(1,3,2);
    imshow(var2_plot2);
    
    % caculating and plotting the (iii) part of last part of given question
    var3=allmean(:,k)+(sqrt(largest_eigen_values(1,k))*pmov_eigen_vectors(:,k));
    var3_plot1 = reshape(var3,[28,28]);
    var3_plot2 = (var3_plot1-min(var3))/(max(var3)-min(var3));
    subplot(1,3,3);
    imshow(var3_plot2);
end