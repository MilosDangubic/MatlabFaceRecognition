function [ oRecognized] = recognition( iTransformedTrainingDataSet,iTransformedTestDataSet)
%transforming Test image into column vector
%transforming testImage into eigen space
%transTestImage=takenEigenVectors'*(iTestImage-meanFace);
eDistance=[];
iTransformedTrainingDataSet=zscore(iTransformedTrainingDataSet);
iTransformedTestDataSet=zscore(iTransformedTestDataSet);
for i=1:size(iTransformedTrainingDataSet,2)
   tempVec=iTransformedTrainingDataSet(:,i)-iTransformedTestDataSet(:,114);
   tempVec=tempVec.^2;
   
   eDistance(i)=sqrt(sum(tempVec));
end


oRecognized=eDistance;

end

