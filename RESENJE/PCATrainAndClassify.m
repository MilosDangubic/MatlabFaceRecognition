function [ result ] = PCATrainAndClassify( iPCAMFactor, iImageSplitPartCount, iTrainingImages, iTestingImages)
%% iPCAMFactor - Faktor M za PCA transformaciju
% iImageSplitPartCount - Na koliko delova ce se svaka slika podeliti (N)
% iTrainingImages - skup celija koje su matrica svake slike za treniranje mreze
% iTestingImages - skup celija koje su matrica svake slike za testiranje

% Kreiranje i formatiranje trening podataka
% Isto ce biti uradjeno za test podatke

disp('(6) .. Creating Training Set');
[ meanFaceParts,eigenVectors,meanDataRed] =createTrainingSet(iTrainingImages,iImageSplitPartCount,iPCAMFactor);

disp('(7) .. Creating Test Set');
[testDataRed,testLabel]=createTestSet(iTestingImages,iImageSplitPartCount,meanFaceParts,eigenVectors);

%treniranje uzoraka
tempLabel=OneNNclassify(meanDataRed,testDataRed);
tempLabel=tempLabel';
tempMat=confusionmat(testLabel,tempLabel);

accuracy=trace(tempMat)/sum(sum(tempMat));
%izrazavanje preciznosti u procentima
accuracy=accuracy*100;

fprintf('Za parametar M = %.2f  ImageSplitPartCount = %d tacnost iznosi : %f % \n ', iPCAMFactor,iImageSplitPartCount,accuracy);
result=strcat(num2str(accuracy),'%');


end

