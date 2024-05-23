function [dataOut,a,b]=lowpass(data,fs,f,n)
%低通滤波：滤除 f HZ以上的信号
[b,a] = butter(n,f/fs*2);
dataOut = filter(b,a,data);