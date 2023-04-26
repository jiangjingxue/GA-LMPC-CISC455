function [fitness,xActual,D,u_k,du,v_k,theta_k,cte,x_error,y_error,points,euclid_error,fval] = evaluate_fitness(xActual,u_k,du, ...
    total_sim_iter,v_k,theta_k,dT,sys,i_ref,D,c,refTrajectory,unicycle,x_ref,y_ref,theta_ref,v_ref,w_ref,individual)

% initialize the fitness of the individual to be zero 
fitness = 0;
k = 0;             % k is the scaling factor in the objective function

% run the simulation
mpc = individual;
N = mpc.N;
[xActual,u_k,du,D,convergence_flag,v_k,theta_k,isValid_flag,fval] = run_simulation_GA(xActual,u_k,du,total_sim_iter,v_k,theta_k,dT,sys,mpc,i_ref,D,c,N,refTrajectory,unicycle,x_ref,y_ref);

% adjust the size of x_ref and y_ref
xref = x_ref(1:length(xActual));
yref = y_ref(1:length(xActual));
thetaref = theta_ref(1:length(xActual));
vref = v_ref(1:length(xActual));
wref = w_ref(1:length(xActual));

% get lateral error, vertial error, angular error, control inputs errors 
x_error = abs(xActual(1,:)' - xref);
y_error = abs(xActual(2,:)' - yref);
theta_error = abs(xActual(3,:)' - thetaref);
v_error = abs(u_k(1,:)' - vref);
w_error = abs(u_k(2,:)' - wref);

% compute crosstrack error 
cte = [];
for i = 1:length(xActual) - 1       
    robot_pos = [xActual(1,i+1),xActual(2,i+1)];
    prev_path_pos = [x_ref(i),y_ref(i)];
    path_pos = [x_ref(i+1),y_ref(i+1)];
    cte(end+1) = compute_crosstrack_error(prev_path_pos,robot_pos,path_pos);
    % cte(end+1) = compute_crosstrack_error([0 0],robot_pos,path_pos);
    % disp(cte(i))
end

% compute points
points = 0;
euclid_error = [];
for i = 1:length(x_error)
    
    euclid_error(end+1) = norm([x_error(i),y_error(i)]);

    if x_error(i) > 0.2
        points = points + 5;
    elseif x_error(i) > 0.1
        points = points + 1;
    end

    if y_error(i) > 0.2
        points = points + 5;
    elseif y_error(i) > 0.1
        points = points + 1;
    end
    
end
% fitness depends on the 
% 1) convergence time
% 2) euclidean norm of the state deviation
% fitness function = 0.5 * k * t_converge + 0.5 * D 
% where k is the scaling factor ( k = 10) 
% if the controller does not converge, assign a huge number to be the fitness 
if isValid_flag ~= 1
    fitness = -20000;
else
    if(convergence_flag == 1)

        [~,Index] = min(D);
        t_converge = Index;
        distance_error = 0 * sum(x_error) + 0 * sum(y_error) + 3 * sum(theta_error) + 4 * sum(abs(cte)) + 0 * sum(v_error) + 0 * sum(w_error) + 0 * sum(euclid_error) + 0 * points;

        value = 0.1 * k * t_converge + 1.0 * distance_error; 

        fitness = -1 * value;
        % fitness = 1 / (fval + 0.001);
    else
        fitness = -10000;
    end
end 
 
end