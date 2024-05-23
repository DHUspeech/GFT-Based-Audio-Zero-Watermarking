function [signal_y,titleName,ff6]=select_no_repeat(sel,rawSignall,fs,M,ff5,y_input2,y_input3,y_input4,y_input5,y_input6,y_input7,y_input8)
% function [signal_y ,titleName,ff6]=select_no_repeat(sel,rawSignall,fs,M,ff5)
switch sel
    case 0
        [signal_y,ff6]=Enframef(rawSignall,M);
        titleName='未攻击';
    case 1
        y = awgn(rawSignall,20,'measured');
        [signal_y,ff6]=Enframef(y,M);
        titleName='噪声攻击10';
  case 2
        y = awgn(rawSignall,30,'measured');
        [signal_y,ff6]=Enframef(y,M);
        titleName='噪声攻击20';        
 case 3
%         y=lowpass(rawSignall,fs,6000,2);
        y=lowpass(rawSignall,fs,11025,2);
        [signal_y,ff6]=Enframef(y,M);
        titleName='滤波攻击';
 case 4
        y=resample(rawSignall,fs/2,fs);
        y=resample(y,fs,fs/2);
        [signal_y,ff6]=Enframef(y,M);
        titleName='重采样攻击';
 case 5
        y=y_input;
        [signal_y,ff6]=Enframef(y,M);
        titleName='MP3compress攻击';
 case 6
%         qpath = quantizer('fixed','round','saturate',[16,16]);
%        y0 = quantize(qpath,rawSignall);
       qpath1 = quantizer('fixed','round','saturate',[8,8]);
       y1 = quantize(qpath1, rawSignall);
        qpath2 = quantizer('fixed','round','saturate',[16,16]);
        y = quantize(qpath2, y1);
        [signal_y,ff6]=Enframef(y,M);
        titleName='模数攻击';     
        
 case 7
        y = rawSignall;
        a = 1.5;
        y = a*y;
       [signal_y,ff6]=Enframef(y,M);
       titleName='Amplitude attack 1.5 times';     
  case 8
        y = rawSignall;
        a = 2;
        y = a*y;
       [signal_y,ff6]=Enframef(y,M);
       titleName='Amplitude attack 2 times'; 
       
 case 9
        y = y_input1;
       [signal_y,ff6]=Enframef(y,M);
       titleName='TSM0.8攻击';          
       case 10
        y = y_input2;
       [signal_y,ff6]=Enframef(y,M);
       titleName='TSM0.9攻击';    
       case 11
        y = y_input3;
       [signal_y,ff6]=Enframef(y,M);
       titleName='TSM1.1攻击';    
       case 12
        y = y_input4;
       [signal_y,ff6]=Enframef(y,M);
       titleName='TSM1.2';    
       case 13
        y = y_input5;
       [signal_y,ff6]=Enframef(y,M);
       titleName='pitch0.8攻击';          
       case 14
        y = y_input6;
       [signal_y,ff6]=Enframef(y,M);
       titleName='pitch0.9攻击';    
       case 15
        y = y_input7;
       [signal_y,ff6]=Enframef(y,M);
       titleName='pitch1.1攻击';    
       case 16
        y = y_input8;
       [signal_y,ff6]=Enframef(y,M);
       titleName='pitch1.2';   
case 17
        y = rawSignall;
        a = 1*ff5;
        y(1:a)=[];
       [signal_y,ff6]=Enframef(y,M);
       titleName='cropping 1 frames front';          
       
 case 18
        y = rawSignall;
        a = 5*ff5;
        y(1:a)=[];
       [signal_y,ff6]=Enframef(y,M);
       titleName='cropping 5 frames front';        
       
  case 19
        y = rawSignall;
        a = 10*ff5;
        y(1:a)=[];
       [signal_y,ff6]=Enframef(y,M);
       titleName='cropping 10 frames front';     
 case 20
        y = rawSignall;
        a = 20*ff5;
        y(1:a)=[];
       [signal_y,ff6]=Enframef(y,M);
       titleName='cropping 20 frames front';     
case 21
        y = rawSignall;
        a = 1*ff5;
        len = length(y);
        y(len-a+1:end)=[];
       [signal_y,ff6]=Enframef(y,M);
       titleName='cropping 1 frames behind';          
       
case 22
        y = rawSignall;
        a = 5*ff5;
       len = length(y);
        y(len-a+1:end)=[];
       [signal_y,ff6]=Enframef(y,M);
       titleName='cropping 5 frames behind';        
       
case 23
        y = rawSignall;
        a = 10*ff5;
        len = length(y);
        y(len-a+1:end)=[];
       [signal_y,ff6]=Enframef(y,M);
       titleName='cropping 10 frames behind';     
 case 24
        y = rawSignall;
        a = 20*ff5;
       len = length(y);
        y(len-a+1:end)=[];
       [signal_y,ff6]=Enframef(y,M);
       titleName='cropping 20 frames behind';     
             
   case 25
        y=rawSignall;       
        y(1:100,:)=[];
         [signal_y,ff6]=Enframef(y,M); 
        titleName='帧不同步攻击0.5s前'; 
        case 26
        y=rawSignall;       
        y(1:200,:)=[];
         [signal_y,ff6]=Enframef(y,M); 
        titleName='帧不同步攻击1s前';
         case 27
        y=rawSignall;       
        y(1:500,:)=[];
         [signal_y,ff6]=Enframef(y,M); 
        titleName='帧不同步攻击0.5s中'; 
        case 28
        y=rawSignall;       
        y(44100:44200,:)=[];
         [signal_y,ff6]=Enframef(y,M); 
        titleName='帧不同步攻击1s中';  
              
    case 29
        y=rawSignall;  
        len = length(y);
        y(44100:44300,:)=[];
         [signal_y,ff6]=Enframef(y,M); 
        titleName='帧不同步攻击0.5s后'; 
         case 30
        y=rawSignall;  
        len = length(y);
        y(44100:44600,:)=[];
         [signal_y,ff6]=Enframef(y,M); 
        titleName='帧不同步攻击1s后'; 
         case 31
        y=rawSignall;  
        len = length(y);
        y(len-100+1:end,:)=[];
         [signal_y,ff6]=Enframef(y,M); 
        titleName='帧不同步攻击2s后';   
case 32
        y=rawSignall;  
        len = length(y);
        y(len-200+1:end,:)=[];
         [signal_y,ff6]=Enframef(y,M); 
        titleName='帧不同步攻击2s后';
        case 33
        y=rawSignall;  
        len = length(y);
        y(len-500+1:end,:)=[];
         [signal_y,ff6]=Enframef(y,M); 
        titleName='帧不同步攻击2s后'; 
        %% 
        
      case 34
        y=rawSignall; 
        n = 500;
        num_insertions = floor(length(y)/n) - 1;
for i = 1:num_insertions
    index = i * n;
    y = [y(1:index-1); 0; y(index:end)];
end

 [signal_y,ff6]=Enframef(y,M);
       titleName='抖动500';
       
       case 35
        y=rawSignall; 
        n = 1000;
        num_insertions = floor(length(y)/n) - 1;
for i = 1:num_insertions
    index = i * n;
    y = [y(1:index-1); 0; y(index:end)];
end

 [signal_y,ff6]=Enframef(y,M);
       titleName='抖动1000';   
       
       case 36
        y=rawSignall; 
        n = 2000;
        num_insertions = floor(length(y)/n) - 1;
for i = 1:num_insertions
    index = i * n;
    y = [y(1:index-1); 0; y(index:end)];
end

 [signal_y,ff6]=Enframef(y,M);
       titleName='抖动2000'; 
       
        case 37
       y=rawSignall;
        n = 2500;
        num_insertions = floor(length(y)/n) - 1;
for i = 1:num_insertions
    index = i * n;
    y = [y(1:index-1); 0; y(index:end)];
end
       [signal_y,ff6]=Enframef(y,M);
       titleName='抖动2500';
       
        case 38
     y=rawSignall;
        n = 3000;
        num_insertions = floor(length(y)/n) - 1;
for i = 1:num_insertions
    index = i * n;
    y = [y(1:index-1); 0; y(index:end)];
end

  [signal_y,ff6]=Enframef(y,M);

       titleName='抖动3000';
   
       case 39
     y=rawSignall;
        n = 4000;
        num_insertions = floor(length(y)/n) - 1;
for i = 1:num_insertions
    index = i * n;
    y = [y(1:index-1); 0; y(index:end)];
end

 [signal_y,ff6]=Enframef(y,M);

       titleName='抖动4000';
        
    case 40
     y=rawSignall;
        n = 5000;
        num_insertions = floor(length(y)/n) - 1;
for i = 1:num_insertions
    index = i * n;
    y = [y(1:index-1); 0; y(index:end)];
end

 [signal_y,ff6]=Enframef(y,M);

       titleName='抖动5000';   
       
      case 41
      y=rawSignall;
        n = 6000;
        num_insertions = floor(length(y)/n) - 1;
for i = 1:num_insertions
    index = i * n;
    y = [y(1:index-1); 0; y(index:end)];
end

  [signal_y,ff6]=Enframef(y,M);

       titleName='抖动6000';   
       
        case 42
      y=rawSignall;
        n = 7000;
        num_insertions = floor(length(y)/n) - 1;
for i = 1:num_insertions
    index = i * n;
    y = [y(1:index-1); 0; y(index:end)];
end

 [signal_y,ff6]=Enframef(y,M);

       titleName='抖动7000';
       
         case 43
     y=rawSignall;
        n = 8000;
        num_insertions = floor(length(y)/n) - 1;
for i = 1:num_insertions
    index = i * n;
    y = [y(1:index-1); 0; y(index:end)];
end

 [signal_y,ff6]=Enframef(y,M);

       titleName='抖动8000';
       
       
end
end

function [signal_y,ff6]=Enframef(rawSignall,M)
%       rawSignall = repelem(rawSignall,3);
      ff6=floor(length(rawSignall)/M);
%       y2 = enframe(rawSignall,ff6); 
%      len=size(y2,1);
%      if len >=M
%          signal_y = y2(1:M,:);
%      else
%          a=zeros(M-len,ff);
%          signal_y = [y2;a];
  y2 = enframe(rawSignall,ff6); 
  signal_y = y2(1:M,:);
end
