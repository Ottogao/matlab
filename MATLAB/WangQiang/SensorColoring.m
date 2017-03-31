% beacon-based routing simulation
% simulation constants
close all
clear all
PT  = 0.01;          % pause time
INF = 1000;         % initial hop distance to sink, infinite...
N   = 80;          % number of nodes
X   = 100;          % simulation area width
Y   = 100;          % simulation area length
R   = 30;           % radio distance
CR  = R/20;         % node plot size
SINK = 1;           % sink node ID
relaydrop = 0.01;   % the packet drop probability caused by a relay
badlinkper = 0.2;
method  = {'ID', 'random', 'rssi', 'randoml', 'rssil', 'olsbr'};
mtd = length(method);
[nx ny] = generateNodePosition(N, X, Y, 'random');      % node position
nlayer  = ones(mtd,N)*INF;   % layer information
ncolor  = zeros(mtd, N);     % color information
nparent = ncolor;           % parent node ID
nsent   = ncolor;           % mark if this node has forwarded the beacon
nrssi   = ncolor;           % parent-to-me link RSSI
nPLR    = ncolor;           % for overall path delivery Packet Loss Ratio
meanhop = zeros(1,mtd);
maxhop = meanhop;           % hold the longest hop count
meanrssi = meanhop;         % average RSSI from all the links
ntable = getNeighborTable(N, nx, ny, R);    % find neighbor tables for all the scenarios

for q=1:mtd-1      % go through all the flooding methods
    fh=drawNodes(N, X, Y, CR, nx, ny, ncolor(q,:), q);
    bslist = 1;       % put sink into sender list
    nlayer(q,1) = 0;        % mark the sink layer = 0
    while ~isempty(bslist)
        sid = pickSender(bslist,nrssi(q,:),nlayer(q,:),R, method(q));
        fillCircle(fh, nx(sid), ny(sid), CR, 'r', sid);
        Nb = length(ntable{sid});
        for k=1:4
        %for k=1:Nb          % go through all the neighbors
            nid = ntable{sid}(k);
            if nlayer(q,nid) == INF     % if the node hears beacon first time
                nparent(q,nid) = sid;   % mark the sender as parent
                bslist = [bslist nid];  % add the node in sender list
                nlayer(q,nid) = nlayer(q,sid) + 1;  % set the receiver layer
                dist = sqrt( (nx(sid)-nx(nid))^2 + (ny(sid)-ny(nid))^2 );
                nrssi(q,nid) = dist;
                if linkPER(dist, R)> badlinkper
                    plot([nx(sid) nx(nid)], [ny(sid) ny(nid)],'r'); % draw link
                else
                    plot([nx(sid) nx(nid)], [ny(sid) ny(nid)]);
                end
                pause(PT*0.2);
            end
            if nlayer(q,nid) == nlayer(q,sid)   % the receiver has heard beacon, this is a duplicated from the same layer
                if nsent(q,nid) == 0    % if this node has not sent beacon
                    ncolor(q,nid) = ncolor(q,nid)+1;    % increase color
                end
            end
        end     % for k=1:Nb

        bslist = removeSender(bslist, sid);     % remove the sender
        nsent(q,sid) = 1;    % mark this node has sent beacon
        pause(PT);
        if(sid == 1)    % for the sink, fill blue color
            fillCircle(fh, nx(sid), ny(sid), CR, 'b', sid);
        else            % for other node, fill white
            fillCircle(fh, nx(sid), ny(sid), CR, 'w', sid);
        end
        pause(PT);
    end     % end while
    %     title(method(q));
    hold off
end

% following code is to use optimal link-state routing (OLSBR)
q = mtd;
rprr = zeros(1,N);   % describe the route rssi
slst = 1;           % put the sink into sender list
nlayer(q,1) = 0;    % sink's layer is marked as 0
rprr(1) = 1;        % sink's packet lost rate is 0
fh=drawNodes(N, X, Y, CR, nx, ny, ncolor(q,:), q);
while ~isempty(slst)    % go through until the sender list is empty
    sid = bestRPRR(slst, rprr); % pick up the best node
    fillCircle(fh, nx(sid), ny(sid), CR, 'r', sid);
    Nb = length(ntable{sid});   % get the sending node's neighbor table
    for k=1:Nb      % go through all the neighbors
        nid = ntable{sid}(k);
        dist = sqrt( (nx(sid)-nx(nid))^2 + (ny(sid)-ny(nid))^2 );
        linkprr = 1-linkPER(dist, R)-relaydrop;   % calculate link PRR
        if nlayer(q,nid) == INF     % the node first time receives a beacon
            nparent(q,nid) = sid;
            slst = [slst nid];
            nlayer(q,nid) = nlayer(q,sid) + 1;  % mark the layer
            rprr(nid) = linkprr*rprr(sid);  % accumulate link PRR
            nrssi(q,nid) = dist;    % record the link distance
            if linkPER(dist, R)> badlinkper
                plot([nx(sid) nx(nid)], [ny(sid) ny(nid)],'r'); % draw link
            else
                plot([nx(sid) nx(nid)], [ny(sid) ny(nid)]);
            end
            pause(PT*0.2);
        elseif rprr(nid) < (linkprr*rprr(sid)) % a better link from the new beacon
            oldparent = nparent(q, nid);    % take the old parent ID
            nparent(q,nid) = sid;           % now this one has a new parent
            nlayer(q,nid) = nlayer(q,sid) + 1; % layer increments
            rprr(nid) = linkprr*rprr(sid);  % new RPRR
            nrssi(q,nid) = dist;            % copy the link distance
            plot([nx(oldparent) nx(nid)], [ny(oldparent) ny(nid)], 'w');    % erase the previous link
            plot([nx(sid) nx(nid)], [ny(sid) ny(nid)]); % draw the new link link
            pause(PT*0.2);
        end
    end
    slst = removeSender(slst, sid);
    nsent(q,sid) = 1;
    pause(PT);
    if(sid == 1)    % for the sink, fill blue color
        fillCircle(fh, nx(sid), ny(sid), CR, 'b', sid);
    else            % for other node, fill white
        fillCircle(fh, nx(sid), ny(sid), CR, 'w', sid);
    end
    pause(PT);
end
% title(method(q));
hold off
% end of optimal link-state routing
redrawtree(fh, N, X, Y, R, CR, nx, ny, nparent(q,:), badlinkper);

% analysis the simulation results
MAXH = max(nlayer(nsent>0));    % find the maximum hop count from all the scenarios
hophist = zeros(mtd,MAXH);
for q=1:mtd      % find max and average hop count for each scenario
    snlayer = nlayer(q,nsent(q,:)>0);   % pick up those who have sent beacon(i.e., connected)
    maxhop(q) = max(snlayer);           % find the maximum hop
    hnprod = 0;             % initialize the accumulator
    for h=1:maxhop(q)       % find average distance to the sink, which is \sum_{i=1}^{maxhop} i*n_i
        n = sum(snlayer == h);
        hnprod = hnprod + n*h;  % accumulate the result
    end
    meanhop(q) = hnprod/length(snlayer);
    hophist(q,:) = hist(snlayer, 1:MAXH);
end
figure(mtd+1);   % make a new figure
plot(1:MAXH, cumsum(hophist')/N, '+-');
xlabel('Number of hops to the sink');
ylabel('Fraction of the total nodes');
%bar(hophist')
legend(method,'location','southeast');


% analysis path PLR
nplr = zeros(mtd, N);    % packet lose ratio (PLR)
for q=1:mtd
    for k=2:N   % go through all node excluding the sink
        prnt = nparent(q, k);       % get this node's parent
        if prnt == 0
            continue;
        end
        dist = nrssi(q,k);          % get link distance
        prracc = 1-linkPER(dist,R)-relaydrop;   % calculate the first link prr
        if prracc<0         % take care of negative link prr
            prracc = 0;
        end
        while prnt ~= SINK          % go through the route
            temp = nparent(q, prnt);    % get next hop parent
            dist = nrssi(q, temp);      % distance
            prrtemp = 1 - linkPER(dist,R) - relaydrop;
            if prrtemp < 0  % take care of negative link prr
                prrtemp = 0;
            end
            prracc = prracc*prrtemp; % accumulate
            prnt = temp;    % set new parent
        end
        nplr(q,k) = 1-prracc;   % calculate this node's PLR
    end
end
figure(mtd+2)    % show the packet lose ratios
bar(mean(nplr'));
set(gca,'XTickLabel',method)
xlabel('Beacon-based routing schemes');
ylabel('Average route PER');

% following code calculates number of downstream nodes
nchild = zeros(mtd,N);
nleaves = zeros(mtd,1);
for q=1:mtd
    for k=1:N
        nchild(q,k) = sum(nparent(q,:)==k);
    end
    nleaves(q) = sum(nchild(q,:)>0);
end
MAXC = max(max(nchild'));
histchd = zeros(mtd,MAXC);
for q=1:mtd
    histchd(q,:)=hist(nchild(q,:),1:MAXC);
    histchd(q,1)=histchd(q,1)-nleaves(q);
end
figure(mtd+3)
bar(histchd')
legend(method)
xlabel('Number of children');
ylabel('Number of nodes');

% following code calculates number of poor links
poorlinks = zeros(mtd,1);
for q=1:mtd     % go through all the schemes
    for k=2:N   % all the nodes
        if nparent(q,k)>0 % for the case the node is connected
            dist = sqrt( (nx(k)-nx(nparent(q,k)))^2 + (ny(k)-ny(nparent(q,k)))^2);
            if linkPER(dist, R) > badlinkper
                poorlinks(q) = poorlinks(q)+1;
            end
        end
    end
end
figure(mtd+4)
bar(poorlinks);
set(gca,'XTickLabel',method)
xlabel('Beacon-based routing schemes');
ylabel('No. of poor links');
