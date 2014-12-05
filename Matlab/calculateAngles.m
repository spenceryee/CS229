{\rtf1\ansi\ansicpg1252\cocoartf1343\cocoasubrtf160
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 newdat = zeros(565, 275643);\
col = 1;\
for i=1:2:161\
    for j=(i + 2):2:163\
        for k=(j + 2):2:165\
            a = (dat(:, i) - dat(:, j)) .^ 2 + (dat(:, i + 1) - dat(:, j + 1)) .^ 2;\
            b = (dat(:, k) - dat(:, j)) .^ 2 + (dat(:, k + 1) - dat(:, j + 1)) .^ 2;\
            c = (dat(:, i) - dat(:, k)) .^ 2 + (dat(:, i + 1) - dat(:, k + 1)) .^ 2;\
            newdat(:, col) = acos((a + b - c) ./ (2 .* sqrt(a .* b)));\
            newdat(:, col + 1) = acos((a + c - b) ./ (2 .* sqrt(a .* c)));\
            newdat(:, col + 2) = acos((c + b - a) ./ (2 .* sqrt(c .* b)));\
            col = col + 3;\
        end\
    end\
    disp(i);\
end}