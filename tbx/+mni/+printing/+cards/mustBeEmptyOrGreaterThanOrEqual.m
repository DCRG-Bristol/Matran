function mustBeEmptyOrGreaterThanOrEqual(value, threshold)
    if ~isempty(value) && value < threshold
        error('Value must be empty or greater than or equal to %d.', threshold);
    end
end