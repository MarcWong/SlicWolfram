file = 'cluster4_100.dat';
img = imread('4small.png');
mat = load(file);
tag = importdata('tag4_new.dat');
%%
%params
width = 768;
height = 512;
mat = reshape(mat,height,width);
[x,y] = size(mat);
k = 1; %k=0:save patch, k=1:visualize tag
%%
for label = 0:max(max(mat))
    a = uint8(zeros(x,y));
    minx = height;
    maxx = 0;
    miny = width;
    maxy = 0;
    for i = 1:x
        for j = 1:y
            if mat(i,j) == label
                a(i,j) = 1;
                if(i<minx)
                    minx=i;
                end
                if(i>maxx)
                    maxx=i;
                end
                if(j<miny)
                    miny=j;
                end
                if(j>maxy)
                    maxy=j;
                end
            end
        end
    end
    %imagesc(a);
    patchinimg = zeros([height width 3]);
    patch = uint8([maxx-minx+1 maxy-miny+1]);
    for i = minx:maxx
        for j = miny:maxy
            %if a(i,j)==1
            patchinimg(i,j,1)=img(i,j,1);
            patchinimg(i,j,2)=img(i,j,2);
            patchinimg(i,j,3)=img(i,j,3);
            patch(i-minx+1,j-miny+1,1) = img(i,j,1);
            patch(i-minx+1,j-miny+1,2) = img(i,j,2);
            patch(i-minx+1,j-miny+1,3) = img(i,j,3);
            %end
        end
    end
    %if(k == 1)
        %subplot(1,2,1);
        %imshow(img,'InitialMagnification','fit');
        %pause();
        %imshow(uint8(patchinimg),'InitialMagnification','fit');
    %end
    
    if(k == 1)
        %subplot(1,2,2);
        imshow(patch,'InitialMagnification','fit');
        xlabel(tag(label+1));
        pause();
    else
        %imwrite(patch,['1/patch' num2str(label) '.jpg']);
    end
end