classdef TRIM < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        MACH=0;
        Q=0;
        label_values = [];
        AEQR =1;

       
    end
    
    methods
        function obj = TRIM(SID,MACH,Q,label_values,opts)
            %CAERO1 Construct an instance of this class
            %   required inputs are as follows:
            % SID - set identification number
            % MACH - Mach Number
            % Q - Dynamic pressure
            % label_values - a list of cells, in each cell the first elemnt
            %               is the label string, the second is the value
            %
            % optional parameters are
            % AEQR - Flag to request a rigid trim analysis (default 1.0)
            %
            % see NASTRAN users guide for more info
            arguments
                SID {mustBeGreaterThan(SID,0)}
                MACH {mustBeGreaterThanOrEqual(MACH,0)}
                Q {mustBeGreaterThan(Q,0)}
                label_values {check_labels}
                opts.AEQR = []
            end

            if MACH == 1
                error('MACH must not equal 1.')
            end
            if ~isempty(opts.AEQR)
                if ~(opts.AEQR>=0 && opts.AEQR<=1)
                    error('AEQR must be in the range [0,1].')
                end
            end

            obj.SID = SID;
            obj.MACH = MACH;
            obj.Q = Q;
            obj.label_values = label_values;
            obj.AEQR = opts.AEQR;
            obj.Name = 'TRIM';
            
            % clear blank labels
            labels = {};
            for i = 1:length(obj.label_values)/2
                lab = obj.label_values{(i-1)*2+1};
                val = obj.label_values{(i-1)*2+2};
                if ~isempty(val) && ~isnan(val)
                    labels = [labels,{lab},{val}];
                end
            end
            obj.label_values = labels;
        end
        
        function writeToFile(obj,fid,bComment)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            arguments
                obj
                fid
                bComment logical = false
            end
            
            if bComment %Comments by standard
                mni.printing.bdf.writeComment([obj.Name 'card'],fid)
            end
            data = [{obj.SID},{obj.MACH},{obj.Q}];
            format = 'irr';
            if length(obj.label_values)==2
                [data,format] = obj.write_labels(data,format,obj.label_values);
                data = [data,{obj.AEQR}];
                format = [format,'bbr'];
            elseif length(obj.label_values)==4
                [data,format] = obj.write_labels(data,format,obj.label_values);
                data = [data,{obj.AEQR}];
                format = [format,'r'];
            else
                [data,format] = obj.write_labels(data,format,obj.label_values(1:4));
                data = [data,{obj.AEQR}];
                format = [format,'r'];
                [data,format] = obj.write_labels(data,format,obj.label_values(5:end));
            end
            obj.fprint_nas(fid,format,data);
        end
    end
    methods(Access = private)
        function [data,format] = write_labels(~,data,format,labels)
            for i = 1:length(labels)/2
                data = [data,{labels{(i-1)*2+1}},{labels{(i-1)*2+2}}];
                format = [format,'sr'];
            end
        end
    end
end

function out = check_labels(x)
    out = true;
    if isempty(x)
        error('labels cannot be empty')
    end
    if mod(length(x),2)==1
        error('labels must have an even number of elements')
    end
    for i =1:length(x)/2
        if ~ischar(x{(i-1)*2+1})
            error('First value is label-value pairs must be a charcter string not %s',class(x{1}));
        elseif ~isnumeric(x{(i-1)*2+2})
            error('First value is label-value pairs must be numeric, not %s',class(x{2}));
        end
    end        
end

