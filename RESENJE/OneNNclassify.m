function [ outputLabel] = OneNNclassify( trainingDataSet,testDataSet )

%normalizacija skupa podataka
trainingDataSet=zscore(trainingDataSet);
testDataSet=zscore(testDataSet);

for i=1:size(testDataSet,2)
   for j=1:size(trainingDataSet,2)
    tempVec=trainingDataSet(:,j)-testDataSet(:,i);
   tempVec=tempVec.^2;
   
   eDistance(j)=sqrt(sum(tempVec));
   end
   [~,minIndex]=min(eDistance);
   outputLabel(i)=minIndex;
   
end


end

