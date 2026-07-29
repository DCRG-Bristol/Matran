function mustBeEmptyOrGreaterThan(value, threshold)
    if ~isempty(value) && value <= threshold
        error('Value must be empty or greater than %d.', threshold);
    end
end