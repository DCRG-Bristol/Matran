classdef Constraint < bulk.BulkData
    %Constraint Describes a constraint applied to a node.
    %
    % The definition of the 'Constraint' object matches that of the SPC1
    % bulk data type from MSC.Nastran.
    %
    % Valid Bulk Data Types:
    %   - 'SPC1'
            
    methods % construction
        function obj = Constraint(varargin)
                    
            %Initialise the bulk data sets
            addBulkDataSet(obj, 'SPC', ...
                'BulkProps'  , {'SID', 'Gi', 'Ci', 'Di'}, ...
                'PropTypes'  , {'i'  , 'i' , 'r' , 'r' }, ...
                'PropDefault', {0    , 0   , 0   , 0   }, ...
                'IDProp'     , 'SID', ...
                'ListProp'   , {'Gi', 'Ci', 'Di'}, ...
                'Connections', {'Gi', 'bulk.Node', 'Nodes'});
            addBulkDataSet(obj, 'SPC1', ...
                'BulkProps'  , {'SID', 'C', 'G'}, ...
                'PropTypes'  , {'i'  , 'c', 'i'}, ...
                'PropDefault', {''   , '' ,''}  , ...
                'IDProp'     , 'SID', ...
                'ListProp'   , {'G'}, ...
                'Connections', {'G', 'bulk.Node', 'Nodes'}, ...
                'SetMethod'  , {'C', @validateDOF});
            
            varargin = parse(obj, varargin{:});
            preallocate(obj);
            
        end
    end
    
    methods % visualisation
        function hg = drawElement(obj, hAx)
            %drawElement Draws the constraint objects as a discrete marker
            %at the specified nodes and returns a single handle for all the
            %beams in the collection.
            
            coords = obj.Nodes.X(:, obj.NodesIndex);
            
            switch obj.CardName
                case 'SPC'
                    txt = obj.Ci;
                case 'SPC1'
                    txt = obj.C;
                otherwise
                    error('Update draw method for new constraint cards.');
            end
            
            hg  = line(hAx, ...
                'XData', coords(1, :), ...
                'YData', coords(2, :), ...
                'ZData', coords(3, :), ...
                'LineStyle'      , 'none' , ...
                'Marker'         , '^'    , ...
                'MarkerFaceColor', 'c'    , ...
                'MarkerEdgeColor', 'k'    , ...
                'Tag'            , 'Constraints', ...
                'SelectionHighlight', 'off');
            hT = text(hAx, ...
                coords(1, :), coords(2, :), coords(3, :), txt, ...
                'Color'              , hg.MarkerFaceColor, ...
                'VerticalAlignment'  , 'top', ...
                'HorizontalAlignment', 'left', ...
                'Tag'                , 'Constraint DOFs');

        end
    end
    
end  