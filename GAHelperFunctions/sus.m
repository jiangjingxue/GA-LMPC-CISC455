function parent_index = sus(population_size, fitness, num_parents)
    % Calculate the cumulative probability distribution
    cum_prob = cumsum(fitness / sum(fitness));
    
    % Select parents using cumulative fitness selection
    parent_index = zeros(num_parents, 1);
    current_member = 1;
    r = rand() / num_parents;
    for i = 1:population_size
        while r <= cum_prob(i)
            parent_index(current_member) = i;
            current_member = current_member + 1;
            r = r + 1 / num_parents;
            if current_member > num_parents
                return;
            end
        end
    end
end