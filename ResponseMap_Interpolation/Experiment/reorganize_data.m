function sphericalz_out = reorganize_data(sphericalz, process)
    if nargin == 1  
       process=0; 
    elseif process==1
       process=1;
    else
       process=2;
    end
    
    if process==1
        m = 75;
        data = sphericalz(2:86,1:180);
        data_1 = sphericalz(1,1:180);

        data_tmp = sphericalz(m:86,1:180);
        data_tmp(data_tmp>0.45)=0.45;
        data(m-1:85,:)=data_tmp;

        data2  = sphericalz(2:86,181:360);
        data_2  = sphericalz(1,181:360);

        data_tmp2 = sphericalz(m:86,181:360);
        data_tmp2(data_tmp2>0.45)=0.45;
        data2(m-1:85,:)=data_tmp2;
    elseif process==2
        data = sphericalz(2:86,1:360);
        data_1 = sphericalz(1,1:360);

        data2  = sphericalz(2:86,361:720);
        data_2  = sphericalz(1,361:720);
    
    
    else
        data = sphericalz(2:86,1:180);
        data_1 = sphericalz(1,1:180);

        data2  = sphericalz(2:86,181:360);
        data_2  = sphericalz(1,181:360);
    end



data2 = flip(data2);
sphericalz_out = [data2;(data_1+data_2)./2;data];