clc;  clear all; close all;


rep='..\DATABASE\';
list=dir([rep '*\*.jpg']);
nbIm=numel(list);

size1=[400 300];


for i=1:nbIm
    rep=[list(i).folder '\' list(i).name];
    img=loadImageProperly(rep);
    imgR=imresize(img,size1);
    imwrite(imgR,['.\DB_RESIZED'  '\' list(i).name])
end
