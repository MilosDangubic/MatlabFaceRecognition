function [covarianceMatrix,meanFace,takenEigenVectors,eigenValues,order,realM,imagesProjectedToEigenFaceSpace] = PCA_transformation( imageVectors,M)
%transponujemo matricu kako bi nam kolone bile vektori slika, a ne redovi
imageVectors=imageVectors';

%prvi korak PCA transformacije je oduzimanje srednje vrednosti od svih
%elemenata skupa podataka(slika)

meanFace=mean(imageVectors,2);
standardisedMatrix= [];
for i=1:size(imageVectors,2) 
    temp =imageVectors(:,i) - meanFace;
    standardisedMatrix = [standardisedMatrix temp];
end
%trazenje kovariansne matrice
%po formuli kovariansna matrica se dobija C=A*A'(A-standardizovana matrica) medjutim to bi nam dalo
%matricu N^2*N^2 koja je prevelika da sa njom nesto radimo
% neka je L=A'*A, za svaku kovariansnu matricu vazi C*Vi=Vi*Ki gde je
% Vi-eigenVector a Ki eigen value,neka su vi,ki, redom karakteristicni
% vektori i karakteristicki koreni matrice L,
% dobijamo L*vi=vi*ki, A'*A*vi=vi*ki, pomnozimo obe strane sa A
% A*A'*A*vi=A*vi*ki, (A*A')*(A*vi)=(A*vi)*ki, C*(A*vi)=(A*vi)*ki, odavde
% dobijamo da za kovariansu matricu C karakteristicni vektoris su A*vi=Vi, a
% karakteristicni koreni su ki=Ki
covarianceMatrix= standardisedMatrix'*standardisedMatrix;

%trazenje karakteristicnih vrednosti i karakteristicnih vektora
%ovo su karakteristicni vektori i vrednosti za matricu L, nama trebaju
%karakteristicni vektori i vrednosti za matricu C-kovariansnu matricu
[eigenVectors,eigenValues]=eig(covarianceMatrix);

% A-standardisedMatrix A*vi-karakteristicni vektori koji namam trebaju
realEigenVectors=standardisedMatrix*eigenVectors;
%sortiranje kakarteristicnih vrednosti u opadajucem poretku
[eigenValues,order]=sort(diag(eigenValues),'descend');
%sortiranje kakrakteristicnih vektora na osnovu sortiranih karakteristicnih
%vrednosti
realEigenVectors=realEigenVectors(:,order);

contributionOfComponents=eigenValues/sum(eigenValues);

cumulativeContributionOfComponents=cumsum(contributionOfComponents);

%smanjenje dimenzije prostora, parametar M govori koliko procenata
%informacija zadrzavamo (npr M=1 znaci 100% komponenti cuvamo, M=0.6 znaci
%cuvamo 60% komponenti itd..)

if (M==1)
    %realM predstavlja tacan broj informacija koje zadrzavamo
    realM=length(cumulativeContributionOfComponents);
else
   
    realM=length(cumulativeContributionOfComponents(cumulativeContributionOfComponents<M))+1;  
end

takenEigenVectors=realEigenVectors(:,1:realM);
%projekcija svake slike  u eigen space
%transponovanje je stavljenjo kako bi se lakse lokalni vektori obelezja
%zdruzili u 1 vektor(vidi createTrainingSet)
imagesProjectedToEigenFaceSpace=(takenEigenVectors'*standardisedMatrix)';

end

