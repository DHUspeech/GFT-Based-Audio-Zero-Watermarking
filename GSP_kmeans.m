currentFolder = pwd;
addpath(genpath(currentFolder))
warning off;
clear;close all;home
tic;
pack;

%%%%%%%%%%%%%%%产生水印序列%%%%%%%%%%%

waveDir_T='data\test_pop\';
TspeakerData = dir(waveDir_T);
TspeakerData(1:2)=[];
TspeakerNum=length(TspeakerData);

fff = 44100;%采样频率
% ff = 1024;%帧长
M = 4096;%帧数
% mp3waveDir_T='data\MP3_pop\';
% mp3WspeakerData = dir(mp3waveDir_T);
% mp3WspeakerData(1:2)=[];

% tsmwaveDir_T='data\syn\tsm_pop\0.8-33s\';
% tsmWspeakerData = dir(tsmwaveDir_T);
% tsmWspeakerData(1:2)=[];

tsmwaveDir_T1='data\syn\tsm_pop\0.9-36s\';
tsmWspeakerData1 = dir(tsmwaveDir_T1);
tsmWspeakerData1(1:2)=[];

tsmwaveDir_T2='data\syn\tsm_pop\0.95\';
tsmWspeakerData2 = dir(tsmwaveDir_T2);
tsmWspeakerData2(1:2)=[];

tsmwaveDir_T3='data\syn\tsm_pop\0.99\';
tsmWspeakerData3 = dir(tsmwaveDir_T3);
tsmWspeakerData3(1:2)=[];

tsmwaveDir_T4='data\syn\tsm_pop\1.01\';
tsmWspeakerData4 = dir(tsmwaveDir_T4);
tsmWspeakerData4(1:2)=[];

tsmwaveDir_T5='data\syn\tsm_pop\1.05\';
tsmWspeakerData5 = dir(tsmwaveDir_T5);
tsmWspeakerData5(1:2)=[];

tsmwaveDir_T6='data\syn\tsm_pop\1.1\';
tsmWspeakerData6 = dir(tsmwaveDir_T6);
tsmWspeakerData6(1:2)=[];

% tsmwaveDir_T7='data\syn\pitch_pop\1.2\';
% tsmWspeakerData7 = dir(tsmwaveDir_T7);
% tsmWspeakerData7(1:2)=[];
%% 读取原始水印图像并画出二值图像
% src = imread('cc_64.png');
src = imread('c_64.jpg');
level=graythresh(src);
bw=im2bw(src,level);
bl= reshape(bw,[1,M]);

%%
SEL_BER=[];
SEL_nc=[];

for m=2
 tic; 
    [rawSignal0,fs]=audioread([waveDir_T TspeakerData(m,1).name]);
    disp(TspeakerData(m,1).name);
%     rawSignal=resample(rawSignal,fff,ff1);
    rawSignal=rawSignal0(:,1);  
%     ff5=floor((length(rawSignal))/M);
%     Signal = enframe(rawSignal,ff5);
%     rawSignal = repelem(rawSignal0,3);
    ff5=floor((length(rawSignal))/M);  
    Signal = enframe(rawSignal,ff5);   
%     Signal = enframe(rawSignal,ff);
    Signal =  Signal(1:M,:);
     
k = 3;
D = zeros(ff5,ff5);
D0 = [ones(1,k),zeros(1,ff5-k)];% first row
D(1,:) = D0;
for i=2:ff5                       
    D0 = circshift(D0,[0,1]);
    D(i,:) = D0;
end
[U,S_,V] = svd(D); 
IN = inv(V);
% subplot(2,2,1);
% figure;
% imshow(bw);
% title('original');  
     SegNum=size(Signal,1);
     KEY=[];
     SN0=zeros(1,M);
     S = zeros(1,M);
 tic;  
for i=1:SegNum 
   v = Signal(i,:).'; 
   y_g = D * v; 
   dc = gft(IN,y_g);
   [dc_sort,dc_sort_index]=sort(abs(dc),'descend');
   dc_sel=dc(dc_sort_index(1));
   S(i) = abs(dc_sel);
     
end
%% enconding 
[idx,C] = kmeans(S',2, 'Start', 'plus');
SX=S';                                  
% 绘制聚类结果
% figure;
% plot(SX(idx==1), 'b.'); hold on;
% plot(SX(idx==2), 'g.'); hold on;
% 
%  plot(C, 'kx', 'MarkerSize', 15, 'LineWidth', 3); hold off;
% legend('Cluster 1', 'Cluster 2', 'Centroids');


if C(1)>C(2) 
    for j=1:SegNum
        if idx(j) == 1
          SN0(j)=1;
        else
          SN0(j)=0; 
        end
    KEY(j)=xor(SN0(j),bl(j));%异或
    end
else
    for j=1:SegNum
        if idx(j) == 2
          SN0(j)=1;
        else
          SN0(j)=0; 
        end
     KEY(j)=xor(SN0(j),bl(j));%异或
    end
    
end
toc;
%% 以下是攻击
% [y_input,f1]=mp3read([mp3waveDir_T mp3WspeakerData(m,1).name]);
% y_input = y_input(:,1);

% [y_input1,f2]=audioread([tsmwaveDir_T tsmWspeakerData(m,1).name]);
% disp(tsmWspeakerData(m,1).name);
% y_input1 = y_input1(:,1);

[y_input2,f3]=audioread([tsmwaveDir_T1 tsmWspeakerData1(m,1).name]);
disp(tsmWspeakerData1(m,1).name);
y_input2 = y_input2(:,1);

[y_input3,f4]=audioread([tsmwaveDir_T2 tsmWspeakerData2(m,1).name]);
disp(tsmWspeakerData2(m,1).name);
y_input3 = y_input3(:,1);

[y_input4,f5]=audioread([tsmwaveDir_T3 tsmWspeakerData3(m,1).name]);
disp(tsmWspeakerData3(m,1).name);
y_input4 = y_input4(:,1);

[y_input5,f6]=audioread([tsmwaveDir_T4 tsmWspeakerData4(m,1).name]);
disp(tsmWspeakerData4(m,1).name);
y_input5 = y_input5(:,1);

[y_input6,f7]=audioread([tsmwaveDir_T5 tsmWspeakerData5(m,1).name]);
disp(tsmWspeakerData5(m,1).name);
y_input6 = y_input6(:,1);

[y_input7,f8]=audioread([tsmwaveDir_T6 tsmWspeakerData6(m,1).name]);
disp(tsmWspeakerData6(m,1).name);
y_input7 = y_input7(:,1);

% [y_input8,f9]=audioread([tsmwaveDir_T7 tsmWspeakerData7(m,1).name]);
% disp(tsmWspeakerData7(m,1).name);
% y_input8 = y_input8(:,1);

% sel=[4,6,7,8];%选择攻击方式
%sel=[12,13,14,15];
sel=[1,3];

Extract_watermark1=[];
BER_A=[];
nc_A=[];
INDEX=zeros(length(sel),M);

for s=1:length(sel)
[Signal_y,titleName,ff6]=select_no_repeat(sel(s),rawSignal,fff,M,ff5,y_input2,y_input3,y_input4,y_input5,y_input6,y_input7);
% [Signal_y,titleName,ff6]=select_no_repeat(sel(s),rawSignal0,fff,M,ff5);
disp(titleName);

k1 = 3;
DD = zeros(ff6,ff6);
DD0 = [ones(1,k1),zeros(1,ff6-k1)];% first row
DD(1,:) = DD0;
for i=2:ff6 
    DD0 = circshift(DD0,[0,1]);
    DD(i,:) = DD0;
end
[U,S_,VV] = svd(DD);
IN = inv(VV);
%% 以下是提取水印图片
SegNum=size(Signal_y,1);%计算段数
Extract_KEY=[];
SN=zeros(1,M);
SS = zeros(1,M);
for i=1:SegNum

    Q = Signal_y(i,:).';
    y_g = DD * Q; % graph representation   
%     dc = gft(inv(VV),y_g);  
     dc = gft(IN,y_g); 
    [dc_sort,dc_sort_index]=sort(abs(dc),'descend');
    dc_sel=dc(dc_sort_index(1));
    SS(i) = abs(dc_sel);
%  %初始化正负特征序列
%     if dc_sel>=0
%         SN(i)=1;%如果大于零置1
%     else 
%         SN(i)=0;
%      end
%     KEY_seg=xor(SN(i),KEY(i));
%     Extract_KEY = [Extract_KEY,KEY_seg];
end

[idx,C] = kmeans(SS',2);
if C(1)> C(2)
    for j=1:SegNum
        if idx(j) == 1
          SN(j)=1;
        else
          SN(j)=0; 
        end
     Extract_KEY(j)=xor(SN(j),KEY(j));%异或
    end
else
    for j=1:SegNum
        if idx(j) == 2
          SN(j)=1;
        else
          SN(j)=0; 
        end
     Extract_KEY(j)=xor(SN(j),KEY(j));%异或
    end
end

%% 画水印图
% figure;
% fra1=1:1:M;
% index2=SN(:,1:M);
% plot(fra1,index2);

% figure;
% Ext = reshape(Extract_KEY,[64,64]);
% imshow(Ext);
Extract_watermark1 = [Extract_watermark1;Extract_KEY];

INDEX(s,:)=SS;

BER=myBer(bl,Extract_KEY);
nc=NC(bl,Extract_KEY);
BER_A=[BER_A,BER];
nc_A=[nc_A,nc];
end
Extract_watermark2=[];
Extract_watermark2=[Extract_watermark2,Extract_watermark1];


% Extract_watermark__1 = Extract_watermark2(1,:);
% Extract_watermark__2 = Extract_watermark2(2,:);
% Extract_watermark__3 = Extract_watermark2(3,:);
% Extract_watermark__4 = Extract_watermark2(4,:);
% Extract_watermark__5 = Extract_watermark2(5,:);
% Extract_watermark__6 = Extract_watermark2(6,:);
% Extract_watermark__7 = Extract_watermark2(7,:);
% Extract_watermark__8 = Extract_watermark2(8,:);
% Extract_watermark__9 = Extract_watermark2(9,:);
% Extract_watermark__10 = Extract_watermark2(10,:);

%  Ext_1= reshape(Extract_watermark__1,[64,64]);
%  Ext_2= reshape(Extract_watermark__2,[64,64]);
%  Ext_3= reshape(Extract_watermark__3,[64,64]);
%  Ext_4= reshape(Extract_watermark__4,[64,64]);
%  Ext_5= reshape(Extract_watermark__5,[64,64]);
%  Ext_6= reshape(Extract_watermark__6,[64,64]);
%  Ext_7= reshape(Extract_watermark__7,[64,64]);
%  Ext_8= reshape(Extract_watermark__8,[64,64]);
%  Ext_9= reshape(Extract_watermark__9,[64,64]);
%  Ext_10= reshape(Extract_watermark__10,[64,64]);
%  w=4;
%  subplot(1,w,1)
%  imshow(Ext_1);
%  title('PSM-10%');
%  subplot(1,w,2)
%  imshow(Ext_2);
%  title('PSM-1%');
%  subplot(1,w,3)
%  imshow(Ext_3);
%  title('PSM+1%');
%  subplot(1,w,4)
%  imshow(Ext_4);
%  title('PSM-10%');

%  v=4;
%  subplot(1,v,1)
%  imshow(Ext_1);
%  title('I');
%  subplot(1,v,2)
%  imshow(Ext_2);
%  title('J');
%  subplot(1,v,3)
%  imshow(Ext_3);
%  title('K');
%  subplot(1,v,4)
%  imshow(Ext_4);
%  title('L');
%  subplot(1,v,5)
%  imshow(Ext_5);
%  title('M');
%  subplot(1,v,6)
%  imshow(Ext_6);
%  title('N');
%  subplot(1,v,7)
%  imshow(Ext_7);
%  title('O');
%  subplot(1,v,8)
%  imshow(Ext_8);
%  title('P');
%   subplot(1,v,9)
%  imshow(Ext_9);
%  title('Q');
%  subplot(1,v,10)
%  imshow(Ext_10);
%  title('β');
%  subplot(1,4,1)
%  imshow(Ext_1);
%  title('PSM-80%');
%  subplot(1,4,2)
%  imshow(Ext_2);
%  title('PSM-90%');
%  subplot(1,4,3)
%  imshow(Ext_3);
%  title('PSM-110%');
%  subplot(1,4,4)
%  imshow(Ext_4);
%  title('PSM-120%');
%  w=6;
%  subplot(1,w,1)
%  imshow(Ext_1);
%  title('前0.5s');
%  subplot(1,w,2)
%  imshow(Ext_2);
%  title('前1s');
%  subplot(1,w,3)
%  imshow(Ext_3);
%  title('中0.5s');
%  subplot(1,w,4)
%  imshow(Ext_4);
%  title('中1s');
%  subplot(1,w,5)
%  imshow(Ext_5);
%  title('后0.5s');
%  subplot(1,w,6)
%  imshow(Ext_6);
%  title('后1s');
SEL_BER=[SEL_BER;BER_A];
SEL_nc=[SEL_nc;nc_A];
end

BER_A_M=mean(SEL_BER,1);
nc_A_M=mean(SEL_nc,1);

% figure;
% t=3584:1:4096;
% plot(t,S(3584:4096),t,SS(3584:4096));
% legend('original','attack');

figure;
fra=1:1:256;

S=S(:,1:256);
% index1=index1(:,1:M);
index2=INDEX(1,1:256);
index3=INDEX(2,1:256);
% index4=INDEX(3,1:256);
plot(fra,S, '-k',fra,index2,'-r',fra,index3,'-b');
xlabel('帧'); %横坐标名称
ylabel('最大谱系数绝对值');
legend('Original signal','PSM-10%','PSM10%');



disp(SEL_nc)
disp(nc_A_M)






        