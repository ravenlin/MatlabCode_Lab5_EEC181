function test = Number_Isolate(x)
load('NN.mat');
load('testSet.mat');
[ROI, grayscale] = ROI_function(x);
%ROI = imfill(ROI,'holes');

%imshow(ROI);

%[y,u] = size(ROI);
%ROI = imfill(ROI,'holes');
region = regionprops(ROI, 'BoundingBox');


    max_width = 0;
    max_height = 0;
    number = 1;
    sub_image1 = [];
    for j = 1:(length(region))
        %disp(region)
        temp = region(j).BoundingBox;
        sub_image = imcrop(ROI,region(j).BoundingBox);
        %figure(j),imshow(sub_image);
        %disp(temp);


        if ((max_width*max_height) < (temp(3)*temp(4)))
            try
                if(sub_image == ROI)
                    continue;
                end
            catch
                    max_height = temp(4);
                    max_width = temp(3);
            end
        end
    end
    %disp(max_height)
    %disp(max_width)
    number = 0;
    for k = 1:(length(region))
        %need to check for numbers going outside the border
        temp2 = region(k).BoundingBox;
        %sub_image = imcrop(ROI,region(k).BoundingBox);
        %figure(k),imshow(sub_image);
        %disp(temp2);

        if ( (abs(max_width - temp2(3)) < 90) && (abs(max_height - temp2(4)) < 40) )
            sub_image1 = [sub_image1 k];
            number = number + 1;
        end    
    end


test_1 = [];
for p = 1:(length(sub_image1))
    
    sub_image_test = imcrop(ROI,region(sub_image1(p)).BoundingBox);
    %[x,y] = size(sub_image_test)
    sub_image_test = padarray(sub_image_test,[45 40]);
    sub_image_test = imresize(sub_image_test, [28,28]);
    %figure(p),imshow(sub_image_test)
    data = reshape(sub_image_test,784,1);
    test = build(data);
    test_1 = [test_1 test];
    %output = check(finalB1L1, finalB1L2, finalW1L1, finalW1L2, finalSoftmaxTheta,data);
    %disp(output);

end
disp(test_1);
%imshow(ROI);

end