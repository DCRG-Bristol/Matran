function mustBeValidID(value, minValue)
    % Validate optional Nastran-style IDs: empty or integer >= minValue.
    if nargin < 2
        minValue = 1;
    end

    if isempty(value)
        return
    end

    isValid = isnumeric(value) && isscalar(value) && isreal(value) && ...
        isfinite(value) && floor(value) == value && value >= minValue;

    if ~isValid
        error('mni:printing:cards:mustBeValidID', ...
            'Value must be empty or an integer scalar >= %g.', minValue);
    end
end