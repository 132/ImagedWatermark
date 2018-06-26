function a = tinhhistogram(OI)
a = OI;
    for hang=1:512
        for cot=1:512
            if(157<OI(hang,cot))
                a(hang,cot)=OI(hang,cot)+1;
            end
        end
    end
    
end