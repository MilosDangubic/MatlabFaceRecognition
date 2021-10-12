function [ eigenFace] = creatingEigenFace( eigenFaceAsVector )
eigenFace=[];
eigenFaceAsVector=eigenFaceAsVector';
for i=1:100:length(eigenFaceAsVector)
    tempVector=[];
   for j=i:i+99
        tempVector=[tempVector, eigenFaceAsVector(j)];
   end
    eigenFace=[eigenFace;tempVector];
    
end




end

