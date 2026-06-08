function mustBeEmptyOrMember(value, members)
    if isempty(value)
        return
    end
    mustBeMember(value, members)
end