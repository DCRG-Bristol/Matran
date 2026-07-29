function mustBeEmptyOrLength(value, expectedLength)
    if isempty(value)
        return
    end
    if length(value) ~= expectedLength
        error('Value must be empty or have length %d.', expectedLength);
    end
end