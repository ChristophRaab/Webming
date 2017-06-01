%Column - User / Row - Item

% load userartist;
ua = ua';
testSet = zeros(size(ua));
n=10;m=22;
%% ItemBasedKNN

% knnTest = ItemBasedKNN.createNewWithDatasets(ua, testSet); 
% knnTest.setSimilarityCalculatorTo(Similarity.PEARSON);
% knnTest.k = 2;
% prediction = knnTest.makePrediction(n, m);
% 
% fprintf("Prediction %.02f \n",prediction)
% fprintf("UA Value %.02f \n",ua(n,m));

%% MaxFN

maxf = MaxF.createNew(ua,testSet);
[topHitItems, hits] = maxf.getTopHitItems(ua);