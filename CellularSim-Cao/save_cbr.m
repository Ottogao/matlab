%This function is to save the information of cbr traffic

function CBRs=save_cbr(CBRs,users);
%load parameters
cbr_id=CBRs(:,1);
cbr_time_dif=CBRs(:,2);
cbr_n_id=CBRs(:,3);
cbr_percent=CBRs(:,4);

global new_cbr
new_cbr_index=find(new_cbr==1)';            %find all new cbr traffic
amount=size(new_cbr_index,1);

if amount~=0                                %if now new cbr traffic
     if cbr_id(1)==0                     %if the array is empty
            cbr_id=[1:amount]';                  %create id for every traffic
            cbr_time_dif=zeros(amount,1);          %how many milliseconds has past
            cbr_n_id=new_cbr_index;                     %get mobile id for every traffic
            cbr_percent=zeros(amount,1);  
     else                                    %if the array is not empby
        cbr_id(end+1:end+amount,1)=[cbr_id(end)+1:cbr_id(end)+amount]';
        cbr_time_dif(end+1:end+amount,1)=zeros(amount,1);
        cbr_n_id(end+1:end+amount,1)=new_cbr_index;
        cbr_percent(end+1:end+amount,1)=zeros(amount,1);
     end
end
%save data
    CBRs=[cbr_id cbr_time_dif cbr_n_id cbr_percent];