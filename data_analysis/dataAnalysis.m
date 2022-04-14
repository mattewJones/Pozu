%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ___                               ___         _           _____             _                     
% (  _ \                            (  _ \      ( )_        (  _  )           (_ )            _      
% | |_) )  _   ____ _   _   ______  | | ) |  _ _|  _)  _ _  | (_) | ___    _ _ | | _   _  ___(_) ___ 
% |  __/ / _ \(_   ) ) ( ) (______) | | | )/ _  ) |  / _  ) (  _  )  _  \/ _  )| |( ) ( )  __) |  __)
% | |   ( (_) )/ /_| (_) |          | |_) | (_| | |_( (_| | | | | | ( ) | (_| || || (_) |__  \ |__  \
% (_)    \___/(____)\___/           (____/ \__ _)\__)\__ _) (_) (_)_) (_)\__ _)___)\__  |____/_)____/
%                                                                                 ( )_| |            
%                                                                                  \___/             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clc;  clear all; close all;

%% détermination de la classe de chaque image


rep='..\DATABASE\';
list=dir([rep '*.jpg']);
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


%% histogrammes de teinte (pour chaque image)


for c=unique(classNumber)
    sampleIndices=find(classNumber==c);
    hues=zeros(0,1);
    % parcours des images de la classe c
    for n=sampleIndices
        img = imread([list(n).folder '\' list(n).name]);
        imgHSV=rgb2hsv(img);
        hues=imgHSV(:,:,1);
        figure();
        histogram(hues(:));
        title(sprintf('teintes image %d : %s, classe %d : %s',n,nom{n},c,nom_classe{n}),"interpreter","none")
    end

end



