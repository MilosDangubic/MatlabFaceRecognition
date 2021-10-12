function [ oDataSet ] = breakdownImage( iImage, iNParts, iDataSet )
%% iImage - slika koja se deli
%  iNParts - na koliko delova se slika deli
%  iDataSet - prazan skup celija
%			- koji je iNParts x iNParts
%			- za iNParts = 4 bilo bi:
%			- [] [] [] []
%			- [] [] [] []
%			- [] [] [] []
%			- [] [] [] []
%			- i na kraju funkcije ce u svakoj celiji biti taj blok slike
%			- redimenzionisan na 1: visinaBloka * sirinaBloka
%			- ako je iNParts = 4:
%			- [1:25*25] [1:25*25] [1:25*25] [1:25*25]
%			- [1:25*25] [1:25*25] [1:25*25] [1:25*25]
%			- [1:25*25] [1:25*25] [1:25*25] [1:25*25]
%			- [1:25*25] [1:25*25] [1:25*25] [1:25*25]


%% Broj redova u matrici od slike (visina)
%  ista je sirina
%  posto je od ovih slika velicina 100x100
%  image rows ce biti 100
imageRows = size(iImage,1);

%% Inicijalizacija matrice koja ce sadrzati blokove slika
%  dobicemo vektor jedinica, sa onoliko jedinica koliko je potrebno delova
%  ako je n = 2 -> 1 1, ako je 4 -> 1 1 1 1 ....
blockParts = ones( 1 , iNParts);

%% Blokovi slike
%  Za sliku koja je 100x100:
%  ako je broj delova = 1 dobijamo 100
%  ako je broj delova = 2 dobijamo 50 50
%  ako je broj delova = 4 dobijamo 25 25 25 25
%  ako je broj delova = 10 dobijamo 10 10 10 10 10 10 10 10 10 10
blocks = blockParts * imageRows / iNParts;

%% Direktno pravimo celije na osnovu broja blokova i same slike
%  za n = 1 i sliku 100x100 -> dobijemo [100x100] double
%  za n = 2 i sliku 100x100 -> dobijemo:
%										[50x50] [50x50]
%										[50x50] [50x50]
%										sto je po visini 100 a sirini opet
%										100
% za n = 4 i sliku 100x100 ->
%										[25x25] [25x25] [25x25] [25x25]
%										[25x25] [25x25] [25x25] [25x25]
%										[25x25] [25x25] [25x25] [25x25]
%										[25x25] [25x25] [25x25] [25x25]
cellFormat = mat2cell(iImage, blocks, blocks);

%% redimenzionisanje slike -> pretvaranje slike u jednodimenzioni niz (vektor)
%  prolazak po kvadratu dimenzija NxN
for i = 1 : iNParts * iNParts
	
	%%preuzimanje jednog bloka od slike
	% npr i-tih 25x25 ako nam je iNParts bilo 4
	%     i-tih 10x10 ako nam je iNParts bilo 10
	imageBlock = cellFormat{i};
	
	% redimenzionisanje -> preuzimaju se svi elementi jednodimenziono
	% i transponuje se da bi se dobio red
	imageBlockAsRow =creatingOneDimensionalVectorsOfPixels(imageBlock); 
    %size(iDataSet{i})
    %size(imageBlockAsRow)
	iDataSet{i} = [iDataSet{i}; imageBlockAsRow];
	
end

oDataSet = iDataSet;

