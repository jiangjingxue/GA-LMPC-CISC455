function parents = multi_pointer_selection(fitness, num_parents)
total_fitness = sum(fitness);

% Calculate each individual's relative fitness
relative_fitness = fitness / total_fitness;

% Calculate the cumulative probability distribution
cum_prob = cumsum(relative_fitness);

% We divide the cumulative probability distribution into num_parents segments
seg_size = 1 / num_parents;
seg_edges = 0:seg_size:1;
segments = cell(num_parents, 1);

% Find the index of individuals whose cumulative probability is within the segment
for i = 1:num_parents
    segments{i} = find(cum_prob >= seg_edges(i) & cum_prob < seg_edges(i+1));
end

% Select parents using multiple pointers
parents = zeros(num_parents, 1);
selected_index = [];

while length(selected_index) < num_parents
    pointer = rand();

    segment_index = find(pointer >= seg_edges, 1, 'last');
    pool = segments{segment_index};

    % setdiff function leaves only those candidates that have not been previously selected
    pool = setdiff(pool, selected_index);

    %If there are no remaining candidate individuals after deleting an already selected individual, the loop continues and a continue statement is issued.
    if isempty(pool)
        continue;
    end

    % Otherwise, choose the first
    chosen_index = pool(1);
    selected_index = [selected_index, chosen_index];
    parents(length(selected_index)) = chosen_index;
end
end