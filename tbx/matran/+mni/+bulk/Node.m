classdef Node < mni.bulk.BulkData
    %Node Describes a point in 3D-space for use in a finite element model.
    %
    % The definition of the 'Node' object matches that of the GRID bulk
    % data type from MSC.Nastran.
    %
    % Valid Bulk Data Types:
    %   - 'GRID'
    %   - 'SPOINT'
    %   - 'EPOINT'
    
    %Store results data
    properties (Hidden = true)
        GlobalTranslation = [0 ; 0 ; 0];
        LocalTranslation  = [0 ; 0 ; 0];
    end
    
    %Visualisation
    properties (Hidden, Dependent)
        %Coordinates for drawing
        DrawCoords
    end
    
    methods % construction
        function obj = Node(varargin)
            
            %Initialise the bulk data sets
            addBulkDataSet(obj, 'GRID', ...
                'BulkProps'  , {'GID', 'CP', 'X', 'CD', 'PS', 'SEID'}, ...
                'PropTypes'  , {'i'  , 'i' , 'r', 'i' , 'c' , 'i'}   , ...
                'PropDefault', {''   , 0   , 0  , 0   , ''  , 0 }    , ...
                'IDProp'     , 'GID', ...
                'Connections', { ...
                'CP', 'mni.bulk.CoordSystem', 'InputCoordSys', ...
                'CD', 'mni.bulk.CoordSystem', 'OutputCoordSys'}, ...
                'PropMask'   , {'X', 3}, ...
                'AttrList'   , {'X', {'nrows', 3}}, ...
                'SetMethod'  , {'PS', @validateDOF});
            addBulkDataSet(obj, 'SPOINT', ...
                'BulkProps'  , {'IDi'}, ...
                'PropType'   , {'i'}  , ...
                'PropDefault', {''}   , ...
                'IDProp'     , 'IDi'  , ...
                'ListProp'   , {'IDi'});
            addBulkDataSet(obj, 'EPOINT', ...
                'BulkProps'  , {'IDi'}, ...
                'PropType'   , {'i'}  , ...
                'PropDefault', {''}   , ...
                'IDProp'     , 'IDi'  , ...
                'ListProp'   , {'IDi'});
            
            varargin = parse(obj, varargin{:});
            preallocate(obj);
            
        end
    end
    
    methods % assigning data during import
        function assignListCardData(obj, propData, index, BulkMeta)
            %assignListCardData 
            
            assignListCardData@mni.bulk.BulkData(obj, propData, index, BulkMeta)
            
            %Stack all ID numbers for 'SPOINT' or 'EPOINT'
            %   - Cell notation for list bulk data doers not work with the
            %    'makeIndices' function for the 'mni.bulk.FEModel' class.
            obj.IDi = horzcat(obj.IDi{:});
        end
    end
    
    methods % visualisation
        function hg = drawElement(obj, hAx, mode)
            %drawElement Draws the node objects as a discrete marker and
            %returns a single graphics handle for all the nodes in the
            %collection.
            
            if nargin < 3
                mode = [];
            end
            
            coords = getDrawCoords(obj, mode);
            hg     = drawNodes(coords, hAx);
            
        end
        function X = getDrawCoords(obj, mode)
            %getDrawCoords Returns the coordinates of the node in the
            %global (MSC.Nastran Basic) coordinate system based on the
            %current 'DrawMode' of the object.
            %
            % Accepts object arrays.
            
            if nargin < 2
                mode = [];
            end
            
            %Assume the worst
            X = nan(3, numel(obj));
            
            %Check if the object has any undeformed data
            if isprop(obj, 'X')
                X_  = obj.X;
            else
                %EPOINT and SPOINT are set to the origin coordinates
                X_ = zeros(3, obj.NumBulk);
            end
            
            % convert into the global refernce frame
            for c_i = unique(obj.CP)
               X_(:,obj.CP==c_i) = obj.InputCoordSys.getPosition(X_(:,obj.CP==c_i),c_i); 
            end
            
            idx = cellfun(@isempty, {X_});
            if any(idx)
                warning(['Some ''awi.fe.Node'' objects do not have '   , ...
                    'any coordinate data. Update these objects before ', ...
                    'attempting to draw the model.']);
                return
            end
            X = horzcat(X_);
            
            %If the user wants the undeformed model then there is nothing
            %else to do
            if strcmp(mode, 'undeformed')
                return
            end
            
            %If we get this far then we need to add the displacements...
            
            idx = ismember(get(obj, {'DrawMode'}), 'deformed');
            
            %Check displacements have been defined
            dT  = {obj(idx).GlobalTranslation};
            if isempty(dT) || any(cellfun(@isempty, dT))
                if strcmp(mode, 'deformed')
                    warning(['Some ''awi.fe.Node'' objects do not have '   , ...
                        'any deformation data, returning undeformed model.', ...
                        'Update these objects before attempting to draw '  , ...
                        'the model.']);
                end
                return
            end
            dT = horzcat(dT{:});
            
            % convert into the global refernce frame
            for c_i = unique(obj.CD)
               dT(:,obj.CD==c_i) = obj.InputCoordSys.getPosition(dT(:,obj.CD==c_i),c_i); 
            end
            
            %Simple
            X(:, idx) = X(:, idx) + dT;
            
        end
    end
    
end
