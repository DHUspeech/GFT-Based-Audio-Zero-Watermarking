function BER=myBer(rawMark,ExtractMark)
    BER=sum((rawMark~=ExtractMark))/length(rawMark);
end