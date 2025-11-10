classdef PlotOpts
    properties
        Scale double = 1;
        Mode char {mustBeMember(Mode,{'undeformed','deformed'})} = 'deformed';
        Phase double = 0;
        Cycles = 1; % for animatitions
        gifFile char = ''
        A (3,3) double = eye(3); % Rotation matrix
    end
    methods
        function obj = PlotOpts(opts)
            arguments
                opts.?mni.bulk.PlotOpts
            end
            % Assign all fields in opts to matching properties
            for prop = string(fieldnames(opts))'
                obj.(prop) = opts.(prop);
            end
        end
    end
end