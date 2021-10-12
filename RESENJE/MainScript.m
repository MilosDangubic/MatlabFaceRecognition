%% ako ne postoji promenljiva sa slikama (ako postoji, postojace i promenljiva sa test slikama)
disp('(1) .. Loading Image Data');
if ( exist('trainImages') == 0 )
    disp('(1.1) .. Did not find variables.');
    
    if( exist ('trainImages.mat') == 0 )
        disp('(1.2) .. Did not find files.');
        trainImages = loadImagesFromDirectory('xm2vts/train set/');
        testImages = loadImagesFromDirectory('xm2vts/test set/');
    
        save('trainImages', 'trainImages');
        save('testImages', 'testImages');
    else
        disp('(1.2) .. Found mat file.');
        trainImages = load('trainImages.mat');
        testImages = load('testImages.mat');
		
		trainImages = trainImages.trainImages;
		testImages = testImages.testImages;
    end
else
    disp('(1.1) .. Found vars');
end


%% velicina ulazne slike - Radimo po predpostavci da su slike NxN, N = 100
disp('(2) .. Defining image width and height.');
imageWidth = 100;
imageHeight = 100;

%% Definisanje na koliko delova ce se deliti slika, nImageParts
%  ako je nImageParts = 2 -> deli se na 4 dela
%  ako je nImageParts = 3 -> deli se na 9 dela ... nImageParts^2
disp('(3) .. Defining number of parts to split image.');
imageSplitFactor = 1;

%% Definisanje faktora M koji odredjuje broj glavnih komponenti tokom PCA analize
disp('(4) .. Defining PCA factor M');
pcaMFactor = 0.75;

result = PCATrainAndClassify(pcaMFactor, imageSplitFactor, trainImages, testImages);

save result;
