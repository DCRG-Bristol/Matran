function mustBeEmptyOrInRange(value, minValue, maxValue)
    if isempty(value)
        return
    end
    if ~(value >= minValue && value <= maxValue)
        error('Value must be empty or in range [%g,%g].', minValue, maxValue);
    end
end