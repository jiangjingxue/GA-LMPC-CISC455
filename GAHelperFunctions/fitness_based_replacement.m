function [population,fitness,queue] = fitness_based_replacement(population,fitness,queue,offspring,offspring_fitness)

off_size = length(offspring);

for i = 1:off_size
    [worst_fitness,worst_index] = min(fitness);

    if worst_fitness < offspring_fitness(i)
        % replace the worst individual with the offspring
        population(worst_index) = offspring(i);
        fitness(worst_index) = offspring_fitness(i);

        % update the queue
        % youngest_index = queue.pop();
        % queue.add(youngest_index);
    else
    % The offspring has worse fitness than the current worst
    % individual in population
    end
end 
