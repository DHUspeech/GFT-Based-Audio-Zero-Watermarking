function P=NC(rawMark,ExtractMark)
%计算互相关系数
    Len=length(rawMark);
    s12=0;
    s1=0;
    s2=0;
    for i=1:Len
        s12=s12+rawMark(i)*ExtractMark(i);
        s1=s1+rawMark(i).^2;
        s2=s2+ExtractMark(i).^2;
    end
    P=s12/(sqrt(s1)*sqrt(s2));
end