clc;  clear all; close all;


repImgContent='..\DB_RESIZED\';

list=dir([repImgContent '*.jpg']);
nbIm=numel(list);

currClassNumber=0;
currClassName="";

for n = 1:nbIm
    match_nom=regexp(list(n).name,'(_[1-9]*|_)','split'); 
    nom_classe{n}=match_nom{1}; %nom de la classe, convention : <nom classe>_<nom pose>_<nom echantillon>.bmp
    nom_pose{n}=match_nom{2}; %la pose
    nom{n}=list(n).name; %nom de l'image
    if ~strcmp(nom_classe{n},currClassName)
        currClassNumber=currClassNumber+1;
        currClassName=nom_classe{n};
    end
    classNumber(n)=currClassNumber; %numéro de la classe (attribué selon l'ordre de parcours de la bdd)
end

nbClasses=currClassNumber; %nombre total de classes


%% le détecteur

bodyDetector = vision.CascadeObjectDetector('ProfileFace'); 

%% appication du detecteur sur chaque image

for c=1:nbClasses
    sampleIndices=find(classNumber==c);
    % parcours des images de la classe c
    for n=sampleIndices
        img = imread([list(n).folder '\' list(n).name]);
        bboxBody = bodyDetector(img);
        IBody = insertObjectAnnotation(img,'rectangle',bboxBody,'Face');
        figure();
        imshow(IBody);
        title('Detected face');;
    end
end
