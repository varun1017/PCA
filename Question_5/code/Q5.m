load('mnist.mat');  % loading the given data(mnist.mat) to use in this file
allmean=zeros(784,10);  % creating a 2D array of size 784x10 with all zeros later on which will store mean of each digit in a column
allcovariance=zeros(784,784,10); % creating a 3D array of size 784x784x10 with all zeros later on which will store covariance of each digit in a 2D array corresponding to the 3rd dimension
n = 60000; % total number of examples
conc=zeros(784,n); 
% storing all the 60000 matrices into conc variable after resizing it
for i=1:n
    temp1 = digits_train(:,:,i);
    temp1 = reshape(temp1,[784,1]);
    conc(:,i)=temp1;
end

% for each digit we are calculating the mean and covariance by this loop
% and storing it in appropriate variables
for j=0:9
    indj=find(labels_train==j);

    add=zeros(784,1);
    full_matj=zeros(784,length(indj));
    
    for i=1:length(indj)
        add=add+conc(:,indj(i,1));
        full_matj(:,i)=conc(:,indj(i,1));
    end
    mean=add/length(indj);
    allmean(:,j+1) = mean; % storing mean of digits from 0 to 9

    subtracted_mat = full_matj - mean;
    cov=subtracted_mat*subtracted_mat.'/(size(full_matj.',1)-1);
    allcovariance(:,:,j+1) = cov ; % storing covariance of digits from 0 to 9
end

% showing the reconstructed and original images side by side by calling the
% function for all digits
show_and_comp(0,allcovariance,allmean);
show_and_comp(1,allcovariance,allmean);
show_and_comp(2,allcovariance,allmean);
show_and_comp(3,allcovariance,allmean);
show_and_comp(4,allcovariance,allmean);
show_and_comp(5,allcovariance,allmean);
show_and_comp(6,allcovariance,allmean);
show_and_comp(7,allcovariance,allmean);
show_and_comp(8,allcovariance,allmean);
show_and_comp(9,allcovariance,allmean);

% function to plot the mean image and reconstructed image
function show_and_comp(j,allcovariance,allmean)

[s1,s2] = computing_84_coord(j,allcovariance); % computing the 84 co-ordinates using the function

first_term = allmean(:,j+1);
coeff_matrix=first_term.'*s1; % calculating co-efficients of those 84 eigen vectors to generate a new vector by linear combination of those
newly_generated_vector = s1*coeff_matrix.';
newly_generated_vector_plot1 = reshape(newly_generated_vector,[28,28]);
newly_generated_vector_plot2 = (newly_generated_vector_plot1-min(newly_generated_vector))/(max(newly_generated_vector)-min(newly_generated_vector));
figure;
subplot(1,2,1);
imshow(newly_generated_vector_plot2); % plotting the newly generated vector

mean_vector_plot1 = reshape(allmean(:,j+1),[28,28]);
mean_vector_plot2 = (mean_vector_plot1-min(allmean(:,j+1)))/(max(allmean(:,j+1))-min(allmean(:,j+1)));
subplot(1,2,2);
imshow(mean_vector_plot2); % plotting the mean vector of this digit

end

% function to calculate the 84 co-ordinates 
function [s1,s2] = computing_84_coord(j,allcovariance)
   
    [ievect,ieval] = eigs(allcovariance(:,:,j+1),84); %ievect is intial eigen vectors and ieval is initial eigen values
    d=diag(ieval); %sorting eigen values, d stores sorted numbers and ind stores it's corresponding index of original
    s1 = ievect;
    s2 = d;
    
end

