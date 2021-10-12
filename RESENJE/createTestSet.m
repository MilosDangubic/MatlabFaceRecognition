function [testDataRed,testLabel] = createTestSet( iTestImages,iNParts,meanFaceParts,eigenVectors )
%CREATETESTSET Summary of this function goes here
%   Detailed explanation goes here
testLabel = reshape(([1:(length(iTestImages)/5)]' * ones(1,5))',[],1);

imagePartsAsVectors = cell(iNParts);

for i = 1 : length(iTestImages) 
	imagePartsAsVectors= breakdownImage(iTestImages{i}, iNParts, imagePartsAsVectors);
end

imagePartsAsVectors=cellfun(@transpose,imagePartsAsVectors,'un',0);
standardisedImagePartsAsVectors=cell(iNParts);


for i=1:iNParts*iNParts
    standardisedImagePartsAsVectorsMatrix=[];
    matrix=imagePartsAsVectors{i};
    for j=1:size(matrix,2)
       temp=matrix(:,j)-meanFaceParts{i};
       standardisedImagePartsAsVectorsMatrix=[standardisedImagePartsAsVectorsMatrix temp];
       
    end
    standardisedImagePartsAsVectors{i}=standardisedImagePartsAsVectorsMatrix;
end
    
   
testDataRed=[];

for i=1:iNParts*iNParts
   
   takenEigenVectors=eigenVectors{i};
   temp=(takenEigenVectors'*standardisedImagePartsAsVectors{i})';
   testDataRed=[testDataRed temp] ;
   
                                         
end
testDataRed=testDataRed';
end

