data = load('Lena128x128g_8bits_r.dat');

w = 128;
h = 126;

d = mat2gray(bin2dec(num2str(data)));
im = reshape(d, w,h)';
imwrite(im, 'Lena128x128g_8bits_r.bmp');