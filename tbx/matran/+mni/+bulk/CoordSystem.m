classdef CoordSystem < mni.bulk.BulkData
    %CoordSystem Describes a rectangular coordinate system.
    %
    % The definition of the 'CoordSys' object matches that of the CORD2R
    % bulk data type from MSC.Nastran.
    %
    % Valid Bulk Data Types:
    %   - 'CORD1R' TODO
    %   - 'CORD2R'
    
    methods % construction
        function obj = CoordSystem(varargin)
            
            %Initialise the bulk data sets
            addBulkDataSet(obj, 'CORD2R', ...
                'BulkProps'  , {'CID', 'RID', 'A', 'B', 'C'}, ...
                'PropTypes'  , {'i'  , 'i'  , 'r', 'r', 'r'}, ...
                'PropDefault', {''   , 0    , 0  , 0  , 0  }, ...
                'IDProp'     , 'CID', ...
                'Connections', {'RID', 'mni.bulk.CoordSystem', 'InputCoordSys'}, ...
                'PropMask'   , {'A', 3, 'B', 3, 'C', 3}, ...
                'AttrList'   , {'A', {'nrows', 3}, 'B', {'nrows', 3}, 'C', {'nrows', 3}});
            
            varargin = parse(obj, varargin{:});
            preallocate(obj);
            
        end
    end
    
    methods % assigning data during import
        function assignH5BulkData(obj, bulkNames, bulkData)
            %assignH5BulkData Assigns the object data during the import
            %from a .h5 file.
            
            if ~strcmp(obj.CardName, 'CORD2R')
                error('Update code');
            end
            
            prpNames   = obj.CurrentBulkDataProps;
            
            %Build the prop data 
            prpData       = cell(size(prpNames));            
            prpData(ismember(prpNames, bulkNames)) = bulkData(ismember(bulkNames, prpNames));
            prpData{ismember(prpNames, 'A')}   = vertcat(bulkData{ismember(bulkNames, {'A1', 'A2', 'A3'})});
            prpData{ismember(prpNames, 'B')}   = vertcat(bulkData{ismember(bulkNames, {'B1', 'B2', 'B3'})});
            prpData{ismember(prpNames, 'C')}   = vertcat(bulkData{ismember(bulkNames, {'C1', 'C2', 'C3'})});
            
            assignH5BulkData@mni.bulk.BulkData(obj, prpNames, prpData)
        end
    end
    
    methods (Sealed)
        function rMatrix = getRotationMatrix(obj)
            %getRotationMatrix Calculates the 3x3 rotation matrix for each
            %coordinate system.
            
            rMatrix = [];
            
            switch obj.CardName
                case 'CORD2R'
                    
                    assert(~any(obj.RID), ['Update code to handle ', ...
                        'coordinate systems in the non-basic ', ...
                        'coordinate system.']);
                        
                    a = [obj.A];
                    b = [obj.B];
                    c = [obj.C];
                    
                    eZ = b - a;
                    eX = c - a;                    
                    eY = cross(eZ, eX);
                    
                    %Ensure unit vectors
                    eX = eX ./ repmat(sqrt(sum(eX.^2, 1)), [3, 1]);
                    eY = eY ./ repmat(sqrt(sum(eY.^2, 1)), [3, 1]);
                    eZ = eZ ./ repmat(sqrt(sum(eZ.^2, 1)), [3, 1]);
                                       
                    rMatrix = [ ...
                        permute(eX, [1, 3, 2]), ...
                        permute(eY, [1, 3, 2]), ...
                        permute(eZ, [1, 3, 2])];
                    
                otherwise
                    warning('Update code for new coordinate system type.');
            end
            
        end
        function originCoords = getOrigin(obj)
            %getOrigin Calculates the (x,y,z) coordinates of the origin of
            %the coordinates system in the local frame.
            
            originCoords = obj.A;
            
            if any(obj.RID ~= 0)
                warning('Update code to handle coordinate systems defined in a local frame.');
            end            
        end
        function pos = getPosition(obj,X,c_index)
            if c_index == 0
               pos = X;
               return
            end
            % get rotation matrix and origin in refrence frame
            r = obj.getRotationMatrix;
            o = obj.getOrigin;
            r = r(:,:,c_index);
            o = repmat(o(:,c_index),1,size(X,2));
            
            % calc position in reference frame
            pos = o+r*X;
            % if the reference frame is not the global frame recurisvely
            % call this function
            if obj.RID(c_index) ~= 0
                pos = obj.getPosition(pos,obj.RID(c_index));
            end         
        end
        function vec = getVector(obj,X,c_index)
            if c_index == 0
               vec = X;
               return
            end
            % get rotation matrix and origin in refrence frame
            r = obj.getRotationMatrix;
            r = r(:,:,c_index);
            
            % calc position in reference frame
            vec = r*X;
            % if the reference frame is not the global frame recurisvely
            % call this function
            if obj.RID(c_index) ~= 0
                vec = obj.getVector(vec,obj.RID(c_index));
            end         
        end
    end
    
    methods % visualiation
        function hg = drawElement(obj, hAx, varargin)
            
            hg = [];
            
            %Calculate the origin and rotation matrix
            r = getRotationMatrix(obj);
            o = getOrigin(obj);
            
            if isempty(r)
                return
            end
            
            %Construct coordinates of eX, eY, eZ vectors
            eX = squeeze(r(:, 1, :));
            eY = squeeze(r(:, 2, :));
            eZ = squeeze(r(:, 3, :));
            oX = o + eX;
            oY = o + eY;
            oZ = o + eZ;
                        
            %Plot
            %hg    = gobjects(1, 3);
            hg = drawLines(o, oX, hAx, 'Color', [0, 1, 0], 'LineWidth', 2, 'Tag', 'Coord Systems');
            hg(2) = drawLines(o, oY, hAx, 'Color', [0, 0, 1], 'LineWidth', 2, 'Tag', 'Coord Systems');
            hg(3) = drawLines(o, oZ, hAx, 'Color', [1, 0, 0], 'LineWidth', 2, 'Tag', 'Coord Systems');
                             
            if obj.NumBulk > 20
                return
            end
            
            %Add text annotation for CID numbers            
            text(o(1, :), o(2, :), o(3, :), ...
                strtrim(cellstr(num2str([obj.CID]'))'), ...
                'Color'   , 'black', ...
                'FontSize', 12     , ...
                'Parent'  , hAx, ...
                'Tag', 'Coord Systems');
            
            %Add text labels for x,y,z axes            
            text(oX(1, :), oX(2, :), oX(3, :), 'X', ...
                'Parent'  , hAx    , ...
                'Color'   , get(hg(1), 'Color'), ...
                'FontSize', 12, ...
                'Tag', 'Coord Systems');
            text(oY(1, :), oY(2, :), oY(3, :), 'Y', ...
                'Parent'  , hAx   , ...
                'Color'   , get(hg(2), 'Color'), ...
                'FontSize', 12, ...
                'Tag', 'Coord Systems');
            text(oZ(1, :), oZ(2, :), oZ(3, :), 'Z', ...
                'Parent'  , hAx   , ...
                'Color'   , get(hg(3), 'Color'), ...
                'FontSize', 12, ...
                'Tag', 'Coord Systems');
            hg = hg(1);
            
        end
    end
    
end

