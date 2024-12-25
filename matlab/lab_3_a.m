function g = intrans(f, varargin)
error(nargchk(2, 4, nargin)) 
classin = class(f);

if strcmp(class(f), 'double') && max(f(:)) > 1 && ~strcmp(varargin{1}, 'log')
f = mat2gray(f);
else
f = im2double(f);
end

method = varargin{1};

switch method
case 'neg'
    g = imcomplement(f);
case 'log'
    if length(varargin) == 1
        c = 1;
    elseif length(varargin) == 2
        c = varargin{2};
    elseif length(varargin) == 3
        c = varargin{2};
        classin = varargin{3};
    else
        error('Incorrect number of inputs for the log option.')
    end
    g = c * (log(1 + double(f)));
case 'gamma'
    if length(varargin) < 2
        error('Not enough inputs for the gamma option.')
    end
    gam = varargin{2};
    g = imadjust(f, [], [], gam);
case 'stretch'
    if length(varargin) < 2
        M = mean2(im2double(f));
        E = 4;
    else
        M = varargin{2};
        if length(varargin) < 3
            E = 4;
        else
            E = varargin{3};
        end
    end
    g = 1 ./ (1 + (M ./ (f + eps)).^E);
otherwise
    error('Unknown enhancement method.')
end

switch classin
case 'uint8'
    g = im2uint8(g);
case 'uint16'
    g = im2uint16(g);
case 'double'
    g = im2double(g);
otherwise
    error('Unsupported image class.');
end
end


img = imread('tire.tif');

stretch1 = intrans(img, 'stretch', 0.3, 4);
stretch2 = intrans(img, 'stretch', 0.4, 3);
stretch3 = intrans(img, 'stretch', 0.2, 5);
stretch4 = intrans(img, 'stretch', 0.5, 2);
stretch5 = intrans(img, 'stretch', 0.35, 6);
stretch6 = intrans(img, 'stretch', 0.25, 3);

figure;
subplot(2,3,1), imshow(stretch1), title('1');
subplot(2,3,2), imshow(stretch2), title('2');
subplot(2,3,3), imshow(stretch3), title('3');
subplot(2,3,4), imshow(stretch4), title('4');
subplot(2,3,5), imshow(stretch5), title('5');
subplot(2,3,6), imshow(stretch6), title('6');
