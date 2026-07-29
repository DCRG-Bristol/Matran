function mustBeEmptyOr3x1Vec(value)
    if isempty(value)
        return
    end

    if ~isnumeric(value) || ~isequal(size(value), [3,1])
        error('Value must be empty or a 3x1 numeric vector.')
    end
end