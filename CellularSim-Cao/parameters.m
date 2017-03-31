simu_time=100;               % simulation time in sec
N=50;                       % number of users in each cell
Cell_Num=7;                 % number of cells
R=1000;                     % cell radius (m)
BS_location=[0, 0, -1.5*R, -1.5*R, 0, 1.5*R, 1.5*R;
    0, sqrt(3)*R, sqrt(3)*R/2, -sqrt(3)*R/2, -sqrt(3)*R, -sqrt(3)*R/2, sqrt(3)*R/2];

T_s=10*1e-3;                % Slot length in sec
ts_number = 100;            % number of time slots in one second
v_min=40*1000/3600;         % Minimum mobile speed (m/s)
v_max=80*1000/3600;         % Maximum mobile speed (m/s) 

ave_call_dur=80;            %average call duration(seconds)
ave_video_dur=60;           %average video phone duration(seconds)

voice_bit_rate=12.2;       %desired bit rate for voice traffic(kbps)
video_bit_rate=200;      %desired bit rate for video traffic(kbps)

p_traffic_hour=8;         %traffics per person per hour
p_traffic=p_traffic_hour/3600;                 %traffics per person per second
p_idol=1-p_traffic;
p_voice=p_traffic*0.7;                %when the node is not idol, the probability to make a voice call
p_video=p_traffic*0.3;               % when the node is not idol, the probability to make a video call

minimum_cbr_rate=0.1;

available_sf=512;
max_chip_rate=3840;         %maxium chip rate is 3840kcps
min_data_rate=max_chip_rate/2/available_sf;   %minimum user data rate

average_burst_rate=0.01;       %how many packets per second per users in average
burst_packet_size=10;        %burst packet size(kb)

%save parameters