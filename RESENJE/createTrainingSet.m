function [ meanFaceParts,eigenVectors,meanDataRed] = createTrainingSet( iTrainingImages, iNParts, iMFactor )
%% iTrainingImages - skup slika za kreiranje trening podataka
%  iMFactor - M faktor za PCA transformaciju
%  iNParts - Na koliko N delova se deli slika
numberOfImagesPerPerson=3;
%% Ovde ce se sadrzati rezultat razbijanja slike na blokove gde je svaki blok vektor piksela
imagePartsAsVectors = cell(iNParts);

for i = 1 : length(iTrainingImages)
	imagePartsAsVectors = breakdownImage(iTrainingImages{i}, iNParts, imagePartsAsVectors);
end
%PCA transformacija nad svim slikama
eigenVectors=cell(iNParts);
dataRedParts=cell(iNParts);
meanFaceParts=cell(iNParts);
numberOfComponents=[];
for i=1:iNParts*iNParts
    [~,meanFace,eigenVectors{i},~,~,numberOfComponents(i),imagesProjectedToEigenFaceSpace]=PCA_transformation(imagePartsAsVectors{i},iMFactor);
    dataRedParts{i}=imagesProjectedToEigenFaceSpace;
    meanFaceParts{i}=meanFace;
end
%usrednjavanje slika. Od svake osobe u trening skupu imamo po 3 slike. 
meanDataRedParts=cell(iNParts);
meanDataRed=[];
%prolazak kroz blokove slika

for i=1:iNParts*iNParts
    meanData=[];
    dataRedPartLength=dataRedParts{i};
   for j=0:numberOfImagesPerPerson:size(dataRedPartLength,1)-numberOfImagesPerPerson
       tempMean=dataRedParts{i}';
       temp=mean(tempMean(:,j+[1:numberOfImagesPerPerson]),2);
       meanData=[meanData temp];
   end
   
   meanDataRed=[meanDataRed meanData'];
   
   
end
meanDataRed=meanDataRed';
end
