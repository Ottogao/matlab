%image noise
clf; clear all;
a = imread('definitionfig2.gif');
% a = imread('test1.jpg');
n = 200;
[rows, cols, dep] = size(a);
figure(2)
noise = n*randn(rows,cols,dep);
da = double(a);
db = da + noise;
imshow(uint8(db));
% dff = db-da;
