function [dataOut,a,b]=lowpass(data,fs,f,n)
%��ͨ�˲����˳� f HZ���ϵ��ź�
[b,a] = butter(n,f/fs*2);
dataOut = filter(b,a,data);