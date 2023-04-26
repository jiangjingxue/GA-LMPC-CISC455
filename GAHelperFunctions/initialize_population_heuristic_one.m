function [pop,queue] = initialize_population_heuristic_one(popsize)

% check population size, has to equal to 20
if popsize ~= 20
    msg = 'Error occurred.';
    error(msg)
end 

% prepare the queue
import java.util.LinkedList
queue = LinkedList();

index = 1:popsize;
index = index(randperm(length(index)));

% prepare the stucture that stores the population
pop = struct('N',[zeros(1)],'Q',[zeros(3)],'R',[zeros(2)],'S',[zeros(3)]);
pop = repmat(pop,popsize,1);

% max and min for Q and R 
minWeight = 0;
maxWeight = 100;

% prepare the indexes 
A = [1,2,3,4,5];
B = A;
[m,n] = ndgrid(A,B);
Z = [n(:),m(:)];

% remove the combinations that has identical elements
while ~isempty(find(Z(:,1) == Z(:,2), 1))
    same_idx = find(Z(:,1) == Z(:,2), 1);
    Z(same_idx(1),:) = [];
end

for i = 1:popsize
    % randomly select the horizon N between 1 to 10; 
    maxN = 10;
    N = randi([1 maxN],1,1);
    pop(i).N = N;

    % random generate termination penalty matrix S
    minTermCost = 0;
    maxTermCost = 10;
    p = (maxTermCost-minTermCost).*rand(3,1) + minTermCost;
    p = round(p,3);
    S = diag([p(1) p(2) p(3)]); 
    pop(i).S = S; 

    % extract the index from the ith row in Z 
    idx = Z(i,:);

    % generate a large number(random number from 5 to 100)
    % generate a small number between 0.001 to 1 (power is 3)
    rb = randi([2 100],1,1); 
    rs = rand^3; 

    % decide which index will be assign to the smaller numb/larger num
    coin = randi([0,1],1,1); 

    % assign values to the matrices Q and R 
    for j = 1:5       
        if j == idx(1)
            if j <= 3
                pop(i).Q(j,j) = coin * rs + (1 - coin) * rb;
            else
                pop(i).R(j-3,j-3) = coin * rs + (1 - coin) * rb;
            end
        
        elseif j == idx(2)
            if j <= 3
                pop(i).Q(j,j) = (1 - coin) * rs + coin * rb;
            else
                pop(i).R(j-3,j-3) = (1 - coin) * rs + coin * rb;
            end
        else
            r = (maxWeight-minWeight).*rand(1,1) + minWeight;
            r = round(r,3);

            if j <= 3
                pop(i).Q(j,j) = 1;
            else
                pop(i).R(j-3,j-3) = 1;
            end
        end

    end

    % insert the index into the queue
    queue.add(index(i));
end 



    

    

end 

 