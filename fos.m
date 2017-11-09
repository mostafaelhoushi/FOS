function [ a, p ] = fos( x, y, K, L, order )
%FOS Summary of this function goes here
%   Detailed explanation goes here
N = length(x);
N0 = max(K,L);

h = waitbar(0,'1','Name','FOS Calculation...',...
    'CreateCancelBtn',...
    'setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0)
% Structure of p:
% p.x = delays of different x terms.
% p.y = delays of different y terms.
% p.x + p.y <= order
p = struct('const', 1, 'x', [], 'y', []);
P = struct(p);

g(0 +1) = mean(y(N0+1:N));
D(0 +1,0 +1) = 1;
C(0 +1) = mean(y(N0+1:N));
P(0 +1) = [];
Q(0 +1) = g(0 +1)^2 * D(0 +1,0 +1);

waitbar(0, h,'Generating Candidates...');

% generate all candidates
i = 1;
for torder = 1 : order
    waitbar(torder / order, h);
    for xorder = 0:torder
        if getappdata(h,'canceling')
            delete(h);
            return;
        end
        
        yorder = torder - xorder;
        
        xdelays = combsrep(0:K, xorder);
        ydelays = combsrep(1:L, yorder);
        
        if (size(xdelays,1) >= 1)
            for j = 1:size(xdelays,1)
                P(i).x = xdelays(j, :);
                if (size(ydelays,1) >= 1)
                    for k = 1:size(ydelays,1)
                        P(i).y = ydelays(k, :);
                        
                        i = i + 1;
                    end
                else
                    i = i+1;
                end
            end
        else
            for k = 1:size(ydelays,1)
                P(i).y = ydelays(k, :);
                
                i = i + 1;
            end
        end
    end
end

waitbar(0, h, 'Evaluating Candidates...');

M = 1;
while (true)
    if getappdata(h,'canceling')
        delete(h);
        return;
    end
    
    waitbar(0, h, sprintf('Evaluating Candidate %d...', M));
    m = M;
    
    % Evaluate Q for each candidate
    clear Qc;
    if (isempty(P))
        break;
    end
    for i=1:length(P)
        if getappdata(h,'canceling')
            delete(h);
            return;
        end
        
        waitbar(i / length(P), h);
        Pval = evalterm(x, y, P(i));
        
        D(m+1,1) = mean(Pval(N0+1:N));
        for j=1:m
            if getappdata(h,'canceling')
                delete(h);
                return;
            end
            
            alpha(m+1, j) = D(m+1, j) ./ D(j, j);
            if (j < M)
                pval = evalterm(x, y, p(j+1));
            else
                pval = Pval;
            end
            D(m+1, j+1) = mean(Pval(N0+1:N) .* pval(N0+1:N)) - sum(alpha(j+1, 1:j) .* D(m+1, 1:j));
        end
        C(m+1) = mean(y(N0+1:N) .* Pval(N0+1:N)) - sum(alpha(m+1, 1:m) .* C(1:m));
        
        g(m+1) = C(m+1)/D(m+1, m+1);
        Qc(i) = g(m+1)^2 * D(m+1, m+1);
    end
    
    % Find index of maximum Q
    index = find(Qc == max(Qc));
    Pval = evalterm(x, y, P(index(1)));
    
    for j=1:m
        if getappdata(h,'canceling')
            delete(h);
            return;
        end
        
        D(m+1,1) = mean(Pval(N0+1:N));
        for j=1:m
            if getappdata(h,'canceling')
                delete(h);
                return;
            end
            
            alpha(m+1, j) = D(m+1, j) ./ D(j, j);
            if (j < M)
                pval = evalterm(x, y, p(j+1));
            else
                pval = Pval;
            end
            D(m+1, j+1) = mean(Pval(N0+1:N) .* pval(N0+1:N)) - sum(alpha(j+1, 1:j) .* D(m+1, 1:j));
        end
        
    end
    C(m+1) = mean(y(N0+1:N) .* Pval(N0+1:N)) - sum(alpha(m+1, 1:m) .* C(1:m));
    Q(m+1) = max(Qc);
    
    diagD = diag(D)';
    if ( Q(M+1) < 4/(N - N0 + 1) *(mean(y(N0+1:N).^2) - sum(Q(1:M))))
        M = M - 1;
        break;
    end
      
    p(m+1) = P(index(1));
    P(index(1)) = []; % remove it from the P
    
    % find the coefficient of the chosen candidate
    g(m+1) = C(m+1) / D(m+1,m+1);
        
    if (isempty(P) || Q(m+1)<1e-26 )
        break;
    end
    
    M = M + 1;
end

figure(2);
plot(0:length(Q)-1, Q(1:end));
ylabel('Q[m]');
xlabel('m');

% Obtain a
for i=0:M
    v(i +1)=1;
    for j = i+1:M
        v(j +1) = -sum(alpha(j +1,i +1 : j-1 +1) .* v(i +1 : j-1 +1));
    end
    a(i +1) = sum(g(i +1:M +1).*v(i +1:M +1));
end

delete(h);

end