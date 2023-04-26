function [pop,queue] = initialize_population_power(popsize)

% prepare the queue
import java.util.LinkedList
queue = LinkedList();

index = 1:popsize;
index = index(randperm(length(index)));

% prepare the stucture that stores the population
pop = struct('N',[zeros(1)],'Q',[zeros(3)],'R',[zeros(2)],'S',[zeros(3)]);
pop = repmat(pop,popsize,1);

for i = 1:popsize

    % randomly select the horizon N between 1 to 10; 
    maxN = 10;
    N = randi([1 maxN],1,1);

    % randomly select the state weight matrix Q and control weight matrix R 
    minWeight = -5;
    maxWeight = 1;
    r = 10 .^ ((maxWeight-minWeight).*rand(5,1) + minWeight);
    % r = (maxWeight-minWeight).*rand(5,1) + minWeight;
    r = round(r,10);
    %disp([r])
    Q = diag([r(1) r(2) r(3)]);     
    R = diag([r(4) r(5)]);
    
    minTermCost = -5;
    maxTermCost = 1;
    p = 10 .^ ((maxTermCost-minTermCost).*rand(3,1) + minTermCost);
    % p = (maxTermCost-minTermCost).*rand(3,1) + minTermCost;
    p = round(p,10);
    S = diag([p(1) p(2) p(3)]);    

    % stores the generated matrices into the population
    pop(i).N = N;
    pop(i).Q = Q;
    pop(i).R = R;
    pop(i).S = S;

    % insert the index into the queue
    queue.add(index(i));
end






end