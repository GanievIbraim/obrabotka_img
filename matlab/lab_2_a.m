function subImage = returnSubImage(imageMatrix, startingRow, startingCol, sizeOfSquare)
    if nargin < 4
        sizeOfSquare = 100;
    end

    [rows, cols] = size(imageMatrix);
    if startingRow + sizeOfSquare - 1 > rows || startingCol + sizeOfSquare - 1 > cols
        error('Фрагмент изображения выходит за границы исходного изображения.');
    end

    subImage = imageMatrix(startingRow:startingRow + sizeOfSquare - 1, startingCol:startingCol + sizeOfSquare - 1);
end

lifting = imread('liftingbody.jpg');
imshow(lifting);

lifting_sub1 = returnSubImage(lifting, 159, 33, 330);
figure, imshow(lifting_sub1);
title('Фрагмент изображения ближнего самолета');

lifting_sub2 = returnSubImage(lifting, 110, 360);
figure, imshow(lifting_sub2);
title('Фрагмент изображения второго самолета');

try
    lifting_sub = returnSubImage(lifting, 159, 33, 500);
catch ME
    disp('Ошибка: Фрагмент изображения выходит за границы исходного изображения.');
end
