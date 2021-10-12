function [ oImages ] = loadImagesFromDirectory( iFolder )

imageFormat = '/*.bmp';
folderString = strcat(iFolder, imageFormat);
directoryContents = dir(folderString);

for contentIdx = 1 : size ( directoryContents, 1 )
    imageName = strcat(iFolder,directoryContents(contentIdx).name);
    imageData = imread(imageName);
    oImages{contentIdx} = double(imageData);
end



