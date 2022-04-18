clc;  clear all; close all;


rep='.\DB_RESIZED_fonds\';
listFonds=dir([rep '*']);
nbFonds=numel(listFonds);

size1=[400 300]; %la taille de ttes les images recadrees

for f=3:1:nbFonds %les 2 1ers resultats sont les fichiers-mots-clés "." et ".."
    repFond=[listFonds(f).folder '\' listFonds(f).name '\'];
    list=dir([repFond '*.jpg']);
    nbIm=numel(list);
    
    imgmoy=zeros(size1);

    for i=1:nbIm
        rep=[list(i).folder '\' list(i).name];
        img=double(loadImageProperly(rep));
        imgmoy=imgmoy+img;
    end
    
 


    imgmoy=imgmoy/nbIm;
    figure();
    imshow(uint8(imgmoy),[]);
    title(sprintf('fond : %s',listFonds(f).name),'interpreter','none')
    
    for i=1:nbIm
        rep=[list(i).folder '\' list(i).name];
        img=double(loadImageProperly(rep));
        x=uint8(abs(img-imgmoy));
        xHSV=rgb2hsv(x);
        Intens=xHSV(:,:,3);
        mask=Intens>0.2;
        mask=imclose(mask,strel('disk',10));
        % figure();
        % imshow(mask,[]);colorbar();
        maskFormatted=repmat(mask,[1 1 3]);
        imgContent=uint8(zeros([size1 3]));
        imgContent(maskFormatted)=round(img(maskFormatted));
        % figure();
        % imshow(imgContent,[]);
        imwrite(imgContent,['.\DB_NO_BKGND'  '\' list(i).name])
        imwrite(mask,['.\FOREGROUND_MASKS'  '\' list(i).name])
    end
end



