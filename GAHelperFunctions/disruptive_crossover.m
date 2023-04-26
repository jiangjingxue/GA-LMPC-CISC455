function [child1, child1_fitness] = disruptive_crossover(parent1,parent2,xActual,u_k,du,total_sim_iter,v_k,theta_k,dT,sys,i_ref,D,c,refTrajectory,unicycle,x_ref,y_ref,theta_ref,v_ref,w_ref)

% initialise children as copies of their respective parents
child1 = parent1;
child2 = parent2;

% perfrom uniform crossover for integer N 
child1.N = uniform_crossover(parent1.N,parent2.N);
child2.N = uniform_crossover(parent1.N,parent2.N);

% calculate number of different genes
difgenes = 0;
for i = 1:3
    if i < 3
        if (parent1.R(i,i) ~= parent2.R(i,i))
            difgenes = difgenes + 1;
        end
    end
    if (parent1.Q(i,i) ~= parent2.Q(i,i))
        difgenes = difgenes + 1;
    end
    if (parent1.S(i,i) ~= parent2.S(i,i))
        difgenes = difgenes + 1;
    end
end

% randomly swap at least half of the different genes
swap = 0;
while swap < (difgenes / 2)
    for i = 1:3
        % swap R
        if i < 3
            if (child1.R(i,i) ~= parent2.R(i,i)) && (child1.R(i,i) ~= child2.R(i,i))
                if rand <= 0.5
                    child1.R(i,i) = parent2.R(i,i);
                    child2.R(i,i) = parent1.R(i,i);
                    swap = swap + 1;
                end
            end
        end
        % swap Q
        if (child1.Q(i,i) ~= parent2.Q(i,i)) && (child1.Q(i,i) ~= child2.Q(i,i))
            if rand <= 0.5
                child1.Q(i,i) = parent2.Q(i,i);
                child2.Q(i,i) = parent1.Q(i,i);
                swap = swap + 1;
            end
        end
        % swap S
        if (child1.S(i,i) ~= parent2.S(i,i)) && (child1.S(i,i) ~= child2.S(i,i))
            if rand <= 0.5
                child1.S(i,i) = parent2.S(i,i);
                child2.S(i,i) = parent1.S(i,i);
                swap = swap + 1;
            end
        end
        % disp(swap);
    end
end

% return the fittest child
[child1_fitness,~,~,~,~,~,~] = evaluate_fitness(xActual,u_k,du,total_sim_iter,v_k,theta_k,dT,sys,i_ref,D,c,refTrajectory,unicycle,x_ref,y_ref,theta_ref,v_ref,w_ref,child1);
[child2_fitness,~,~,~,~,~,~] = evaluate_fitness(xActual,u_k,du,total_sim_iter,v_k,theta_k,dT,sys,i_ref,D,c,refTrajectory,unicycle,x_ref,y_ref,theta_ref,v_ref,w_ref,child2);
if child2_fitness > child1_fitness
    child1 = child2;
    child1_fitness = child2_fitness;
end

end

function N = uniform_crossover(N1,N2)
% generate a random number
k = rand;
if k < 0.5 
    N = N1;
else
    N = N2;
end 
end