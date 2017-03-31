function ntable = getNeighborTable(N, nx, ny, R)
ntable  = cell(1, N);
for k=1:N-1
    for q=k+1:N
        dist = sqrt( (nx(k)-nx(q))^2 + (ny(k)-ny(q))^2 );
        if(dist < R)    % the node is in range
            ntable{k} = [ntable{k} q];  % add node q to k's neighbor table
            ntable{q} = [ntable{q} k];  % add node k to q's neighbor table
        end
    end
end