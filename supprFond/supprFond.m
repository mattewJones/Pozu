clc;  clear all; close all;


rep='.\fond1\';
list=dir([rep '*.jpg']);
nbIm=numel(list);

size1=[400 300];

imgmoy=zeros(size1);

for i=1:nbIm
    rep=[list(i).folder '\' list(i).name];
    img=double(loadImageProperly(rep));
    % figure();
    % imshow(uint8(img),[])
    imgR=imresize(img,size1);
    imgmoy=imgmoy+imgR;

end

imgmoy=imgmoy/nbIm;
figure();
imshow(imgmoy,[]);


%%
i=8;
img=double(loadImageProperly([list(i).folder '\' list(i).name]));
imgR=imresize(img,size1);
x=uint8(abs(imgR-imgmoy));
figure();
imshow(x,[]);


xHSV=rgb2hsv(x);
Intens=xHSV(:,:,3);
mask=Intens>0.2;

figure();
imshow(Intens,[]);colorbar();

figure();
imshow(mask,[]);colorbar();