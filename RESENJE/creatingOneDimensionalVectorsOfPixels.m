function [ imageVectors ] = creatingOneDimensionalVectorsOfPixels( image )
imageVectors=[];
     for j=1:size(image,1)
        vector=image(j,:);
        imageVectors=[imageVectors vector];
     end
     %size(vector)
    
  

end

