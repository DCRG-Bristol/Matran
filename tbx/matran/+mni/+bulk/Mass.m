classdef Mass < mni.bulk.BulkData
    %Mass Describes a mass element in the model which is associated with a
    %Node.
    %
    % Valid Bulk Data Types:
    %   - CONM1 
    %   - CONM2    
    
    methods % construction
        function obj = Mass(varargin)
            
            %Initialise the bulk data sets
            addBulkDataSet(obj, 'CONM1' , ...
                'BulkProps'  , {'EID', 'G', 'CID', 'M1', 'M2', 'M3', 'M4', 'M5', 'M6'}, ...
                'PropTypes'  , {'i'  , 'i', 'i'  , 'r' , 'r' , 'r' , 'r' , 'r' , 'r'} , ...
                'PropDefault', {''   , '' , 0    , 0   , 0   , 0   , 0   , 0   , 0  } , ...
                'IDProp'     , 'EID', ...
                'PropMask'   , {'M2', 2, 'M3', 3, 'M4', 4, 'M5', 5, 'M6', 6}, ...
                'AttrList'   , {'M2', {'nrows', 2}, 'M3', {'nrows', 3}, ...
                'M4', {'nrows', 4}, 'M5', {'nrows', 5}, 'M6', {'nrows', 6}}, ...
                'Connections', {'G', 'mni.bulk.Node', 'Nodes', 'CID', 'mni.bulk.CoordSystem', 'CoordSys'});
            addBulkDataSet(obj, 'CONM2', ...
                'BulkProps'  , {'EID', 'G', 'CID', 'M', 'X', 'I1', 'I2', 'I3'}, ...
                'PropTypes'  , {'i'  , 'i', 'i'  , 'r', 'r', 'r' , 'r' , 'r' }, ...
                'PropDefault', {''   , '' , 0    , 0  , 0  , 0   , 0   , 0   }, ...
                'IDProp'     , 'EID', ...
                'PropMask'   , {'X', 3, 'I2', 2, 'I3', 3}, ...
                'AttrList'   , {'X', {'nrows', 3}, 'I2', {'nrows', 2}, 'I3', {'nrows', 3}}, ...
                'Connections', {'G', 'mni.bulk.Node', 'Nodes', 'CID', 'mni.bulk.CoordSystem', 'CoordSys'});                        
            varargin = parse(obj, varargin{:});
            preallocate(obj);
            
        end
    end
    
    methods% assigning data during import
        function assignH5BulkData(obj, bulkNames, bulkData)
            %assignH5BulkData Assigns the object data during the import
            %from a .h5 file.
            
            prpNames   = obj.CurrentBulkDataProps;
            
            %Index of matching bulk data names
            [~, ind]  = ismember(bulkNames, prpNames);
            [~, ind_] = ismember(prpNames, bulkNames);
            
            %Build the prop data
            prpData  = cell(size(prpNames));
            prpData(ind(ind ~= 0)) = bulkData(ind_(ind_ ~= 0));            
            switch obj.CardName                
                case 'CONM2'
                     prpData{ismember(prpNames, 'X')} = ...
                         vertcat(bulkData{ismember(bulkNames, {'X1', 'X2', 'X3'})});                    
            end
            assignH5BulkData@mni.bulk.BulkData(obj, prpNames, prpData)
            
        end
    end
    
    methods % visualisation
        function hg = drawElement(obj, hAx, varargin)
            
            p = inputParser;
            addParameter(p, 'AddOffset', true, @(x)validateattributes(x, {'logical'}, {'scalar'}));
            parse(p, varargin{:});
            
            hg = [];
                       
            if isempty(obj.Nodes)
                return
            end
            
            coords = getDrawCoords(obj.Nodes, obj.DrawMode);
            if isempty(coords)
                return
            end
            coords = coords(:, obj.NodesIndex);
            
            if p.Results.AddOffset && isprop(obj, 'X') %Add offset
                coords = coords + obj.X;
            end
            
            hg = drawNodes(coords, hAx, ...
                'Marker', '^', 'MarkerFaceColor', 'b', 'Tag', 'Mass');
            
        end
    end
    
end

