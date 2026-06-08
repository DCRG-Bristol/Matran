classdef AELINK < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ID;
        LABLD;
        LABLn = {};
        Cn = {};
    end
    
    methods
        function obj = AELINK(LABLD,LABLn_Cn,opts)
            %AELINK Construct an instance of this class
            % see NASTRAN Quick Ref Guide for info on AELINK
            % Inputs:
            %   - ID: integer specifing which trim case it applies to ()
            %
            arguments
                LABLD
                LABLn_Cn
                opts.ID = 0
            end
            
            obj.ID = opts.ID;
            obj.LABLD = LABLD;
            
            for i = 1:length(LABLn_Cn)
                if length(LABLn_Cn{i})~= 2
                    error('LABLn_Cn must be a cell array of cells containing two elements')
                end
                obj.LABLn{i} = LABLn_Cn{i}{1};
                obj.Cn{i} = LABLn_Cn{i}{2};
            end
            obj.Name = 'AELINK';
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
            if obj.ID == 0
                data = [{'ALWAYS'},{obj.LABLD}];
                format = 'ss';
            else
                data = [{obj.ID},{obj.LABLD}];
                format = 'is';
            end
            for i = 1:length(obj.LABLn)
                data = [data,{obj.LABLn{i}},{obj.Cn{i}}];
                format = [format,'sr'];
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

