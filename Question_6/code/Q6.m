% storing the matrices of all the fruit images from data_fruit folder into
% variable I
I=zeros(80,80,3,16);
I(:,:,:,1) = imread('data_fruit/image_1.png');
I(:,:,:,2) = imread('data_fruit/image_2.png');
I(:,:,:,3) = imread('data_fruit/image_3.png');
I(:,:,:,4) = imread('data_fruit/image_4.png');
I(:,:,:,5) = imread('data_fruit/image_5.png');
I(:,:,:,6) = imread('data_fruit/image_6.png');
I(:,:,:,7) = imread('data_fruit/image_7.png');
I(:,:,:,8) = imread('data_fruit/image_8.png');
I(:,:,:,9) = imread('data_fruit/image_9.png');
I(:,:,:,10) = imread('data_fruit/image_10.png');
I(:,:,:,11) = imread('data_fruit/image_11.png');
I(:,:,:,12) = imread('data_fruit/image_12.png');
I(:,:,:,13) = imread('data_fruit/image_13.png');
I(:,:,:,14) = imread('data_fruit/image_14.png');
I(:,:,:,15) = imread('data_fruit/image_15.png');
I(:,:,:,16) = imread('data_fruit/image_16.png');

resized_I=zeros(19200,16);

rng(2);% setting the seed value

% changing the size from 80x80x3 to 19200x1
for i = 1:16
    resized_I(:,i)=reshape(I(:,:,:,i),[19200,1]);
end

% calculating and plotting the mean image
mean = sum(resized_I,2)/16;
mean_plot1 = reshape(mean,[80,80,3]);
mean_plot2 = (mean_plot1-min(mean))/(max(mean)-min(mean));
subplot(1,5,1);
imshow(mean_plot2);


% calculating the covariance matrix
subtracted_matrix = resized_I - mean ;
cov = subtracted_matrix*subtracted_matrix.'/15;

[ievect,ieval] = eigs(cov,4); % calculating the top 4 eigen values and it's eigen vectors

% plotting the eigen vector 1
eigen_vector1_plot1 = reshape(ievect(:,1),[80,80,3]);
eigen_vector1_plot2 = (eigen_vector1_plot1-min(ievect(:,1)))/(max(ievect(:,1))-min(ievect(:,1)));
subplot(1,5,2);
imshow(eigen_vector1_plot2);

% plotting the eigen vector 2
eigen_vector2_plot1 = reshape(ievect(:,2),[80,80,3]);
eigen_vector2_plot2 = (eigen_vector2_plot1-min(ievect(:,2)))/(max(ievect(:,2))-min(ievect(:,2)));
subplot(1,5,3);
imshow(eigen_vector2_plot2);

% plotting the eigen vector 3
eigen_vector3_plot1 = reshape(ievect(:,3),[80,80,3]);
eigen_vector3_plot2 = (eigen_vector3_plot1-min(ievect(:,3)))/(max(ievect(:,3))-min(ievect(:,3)));
subplot(1,5,4);
imshow(eigen_vector3_plot2);

% plotting the eigen vector 4
eigen_vector4_plot1 = reshape(ievect(:,4),[80,80,3]);
eigen_vector4_plot2 = (eigen_vector1_plot1-min(ievect(:,4)))/(max(ievect(:,4))-min(ievect(:,4)));
subplot(1,5,5);
imshow(eigen_vector4_plot2);

% calculating and plotting the top 10 eigen vectors in descending order
top10_eval = eigs(cov,10);
input1=[1;2;3;4;5;6;7;8;9;10];
figure;
plot(input1,top10_eval);
xlabel('Component Number');
ylabel('Eigen value');

%,mean = reshape(mean_plot2,[19200,1]);
%%%%%%%%%%%%%%%%%% part b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% using the show_and_comp function defined at the end plotting the newly
% generated fruit and original fruit side by side for all 16 fruits
for i=1:16
show_and_comp(i,resized_I,mean,ievect);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% part c %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calling the new_fruit function thrice to generate three new fruits.
new_fruit(mean,ievect);
new_fruit(mean,ievect);
new_fruit(mean,ievect);

% generating a new fruit image as a linear combination of mean and four
% eigen vectors where mean has low weight because of it's dominancy in the
% newly generated vector and the coefficients of eigen vectors are obtained
% from const function defined below
function new_fruit(mean,ievect)
new_image = 0.000000001*mean + const(1,ievect)*ievect(:,1) + const(2,ievect)*ievect(:,2) + const(3,ievect)*ievect(:,3) + const(4,ievect)*ievect(:,4);

new_image_plot1 = (new_image-min(new_image))/(max(new_image)-min(new_image));
new_image_plot2 = reshape(new_image_plot1,[80,80,3]);

figure;
imshow(new_image_plot2);
end

% returning a value which is randomly choosen from -(S.D) to (S.D) of that
% corresponding eigen vector
function k = const(i,ievect)
mean_v = sum(ievect(:,i))/19200;
var_v = (ievect(:,i)-mean_v).'*(ievect(:,i)-mean_v)/19200;
a_k = -1*sqrt(var_v);
b_k = sqrt(var_v);
k = (b_k-a_k)*rand(1,1) + a_k ;

end

% function to regenerate fruits and show along this with original fruit
function show_and_comp(i,resized_I1,mean,ievect)

% regenerating and plotting the fruit using mean and top 4 eigen vectors
c1 = resized_I1(:,i).'*ievect(:,1);
c2 = resized_I1(:,i).'*ievect(:,2);
c3 = resized_I1(:,i).'*ievect(:,3);
c4 = resized_I1(:,i).'*ievect(:,4);

added_vector = mean + c1*ievect(:,1) + c2*ievect(:,2) + c3*ievect(:,3) + c4*ievect(:,4);
added_vector_plot1 = (added_vector-min(added_vector))/(max(added_vector)-min(added_vector));
added_vector_plot2 = reshape(added_vector_plot1,[80,80,3]);

figure;
subplot(1,2,1);
imshow(added_vector_plot2);

% plotting the  original fruit
original_image1_plot1=reshape(resized_I1(:,i),[80,80,3]);
original_image1_plot2=(original_image1_plot1-min(resized_I1(:,i)))/(max(resized_I1(:,i))-min(resized_I1(:,i)));
subplot(1,2,2);
imshow(original_image1_plot2);

end
