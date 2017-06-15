clear;

load farm-ads-vect.mat;
% load stdFarmAds.mat;

% 
% [S,I] = max(sum(X));
% 
% figure;
% plot(X(:,I));
% fprintf('Most used words: %d \n',I);
% 
% [S,I] = min(sum(X));
% 
% figure;
% plot(X(:,I));
% fprintf('Least used words: %d \n',I);

% X=bsxfun(@rdivide, bsxfun(@minus,X,mean(X)), sX);
 

T = X * X' * 0.5;
[v,e] = eigs(T,3);
F = T*v;

Indices = crossvalind('Kfold', Y, 5);
xs = F(find(Indices==1),:);
ys = Y(find(Indices==1),:);
xs = full(xs);

xt = F(find(Indices~=1),:);
yt = Y(find(Indices~=1),:);
xt = full(xt);

for kernel = {'RBF','linear'}

model = fitcsvm(full(xs),ys,'KernelFunction',char(kernel));
nSv = size(model.SupportVectors(:,1),1);
ratio = nSv / size(xs,1);
nIter = model.NumIterations;


[label,score] = predict(model,xt);

errs	= sum(label(yt== -1)~=-1) + sum(label(yt==1)~=1);
erate = errs/size(yt,1);

fprintf('Kernel: %s \n',char(kernel));
fprintf('Numbers of Support Vectors: %d \n',nSv);
fprintf('Ration nSv vs size: %0.2f \n',ratio);
fprintf('Numbers of Iterations: %d \n',nIter);
fprintf('Error-Rate: %0.4f \n',erate);
fprintf('----------------------------------------\n');
figure;
hold on;
plot3(xt(find(label==1),1),xt(find(label==1),2),xt(find(label==1),3),'bo');
plot3(xt(find(label==-1),1),xt(find(label==-1),2),xt(find(label==-1),3),'go');
plot3(model.SupportVectors(:,1),model.SupportVectors(:,2),model.SupportVectors(:,1),'rx');
hold off;
end

