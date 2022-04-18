function img=loadImageProperly(rep)
% charge l'image située dans le répertoire rep
% sous format jpg en prenant en compte
% correctement l'information d'orientation 
% du fichier (EXIF)



img = imread(rep);
    info = imfinfo(rep);
    if isfield(info,'Orientation')
       orient = info(1).Orientation;
       switch orient
         case 1
            %normal, leave the data alone
         case 2
            img = img(:,end:-1:1,:);         %right to left
         case 3
            img = img(end:-1:1,end:-1:1,:);  %180 degree rotation
         case 4
            img = img(end:-1:1,:,:);         %bottom to top
         case 5
            img = permute(img, [2 1 3]);     %counterclockwise and upside down
         case 6
            img = rot90(img,3);              %undo 90 degree by rotating 270
         case 7
            img = rot90(img(end:-1:1,:,:));  %undo counterclockwise and left/right
         case 8
            img = rot90(img);                %undo 270 rotation by rotating 90
         otherwise
            warning(sprintf('unknown orientation %g ignored\n', orient));
       end
     end
end