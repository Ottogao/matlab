%This function define the traffic type for every nodes

function nodes=traffic_type(users, Cell_Num, N,p_idol,p_voice,p_video,ave_call_dur,ave_video_dur,voice_bit_rate,video_bit_rate,min_data_rate)

% load parameters
x_pos=users(:,1);              % get users coordinates
y_pos=users(:,2);
dx_pos=users(:,8);
dy_pos=users(:,9);
offsite=users(:,3:4);
traffic=zeros(N*Cell_Num,12);
traf_type=users(:,10);
traf_dur=users(:,11);
data_rate=users(:,12);
sf=users(:,13);
remained_time=users(:,14);
is_servered=users(:,15);
is_handover=users(:,16);
real_sf=users(:,17);
in_cell = users(:,5);           % check in which cell the node is
v = users(:,6);                   % velocity
dir = users(:,7);               % direction
burst=users(:,18:19);

global new_cbr TOTAL_EVANT
new_cbr=zeros(1,N*Cell_Num);

vo_mean=ave_call_dur;
vo_deviation=ave_call_dur/4;
vi_mean=ave_video_dur;
vi_deviation=ave_video_dur/4;

str1=strcat('exp(mu+(sigma^2/2))=',num2str(vo_mean));
str2=strcat('sqrt((exp(sigma^2)-1)*exp(2*mu+sigma^2))=',num2str(vo_deviation));
S1=solve(str1,str2);
vo_mu=double(S1.mu);
vo_sigma=double(S1.sigma);
for k=1:size(vo_mu,1)
    if isreal(vo_mu(k)) && real(vo_mu(k))>=0 && isreal(vo_sigma(k)) && real(vo_sigma(k))>=0
        vo_mu=vo_mu(k);
        vo_sigma=vo_sigma(k);
        break
    end
end

str3=strcat('exp(mu+(sigma^2/2))=',num2str(vi_mean));
str4=strcat('sqrt((exp(sigma^2)-1)*exp(2*mu+sigma^2))=',num2str(vi_deviation));
S2=solve(str3,str4);
vi_mu=double(S2.mu);
vi_sigma=double(S2.sigma);
for k=1:size(vi_mu,1)
    if isreal(vi_mu(k)) && real(vi_mu(k))>=0 && isreal(vi_sigma(k)) && real(vi_sigma(k))>=0
        vi_mu=vi_mu(k);
        vi_sigma=vi_sigma(k);
        break
    end
end

for n=1:N*Cell_Num
    m=rand;
    
    if remained_time(n)==0      %change traffic type when the traffic is end
        traf_type(n)=0;
        sf(n)=0;
        real_sf(n)=0;
        traf_dur(n)=0;
        data_rate(n)=0;
        is_servered(n)=0;
    end
    
    
    if traf_type(n)==0          %if the node is idol
        if m<p_idol                 %idol
          traf_type(n)=0;
        else                        %if the node will generate new traffic
             if m>=p_idol && m<(p_idol+p_voice)       %voice traffic
                 
                 new_cbr(n)=1;
                traf_type(n)=1;
                traf_dur(n)=round(logninv(rand,vo_mu,vo_sigma)*10^2)/10^2;
                data_rate(n)=voice_bit_rate;
                sf(n)=ceil(voice_bit_rate/min_data_rate);
                remained_time(n)=traf_dur(n);
                              
                    TOTAL_EVANT=TOTAL_EVANT+1;  % calculate the number of total calls
             end
        
             if m>=(p_idol+p_voice) && m<(p_idol+p_voice+p_video)  %video traffic
                 
                 new_cbr(n)=1;
                traf_type(n)=2;
                traf_dur(n)=round(logninv(rand,vi_mu,vi_sigma)*10^2)/10^2;
                data_rate(n)=video_bit_rate;
                sf(n)=ceil(video_bit_rate/min_data_rate);
                remained_time(n)=traf_dur(n);
                             
                    TOTAL_EVANT=TOTAL_EVANT+1;               % calculate the number of total calls
             end
            
        end        
    end 
end

traffic(:,1)=traf_type;
traffic(:,2)=traf_dur;
traffic(:,3)=data_rate;
traffic(:,4)=sf;
traffic(:,5)=remained_time;
traffic(:,6)=is_servered;
traffic(:,7)=is_handover;
traffic(:,8)=real_sf;

nodes = [x_pos y_pos offsite in_cell v dir dx_pos dy_pos traffic burst]; %save data

