classdef AESTAT < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ID;
        LABEL;
    end
    
    methods
        function obj = AESTAT(ID,LABEL)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            obj.ID = ID;
            obj.LABEL = LABEL;
            obj.Name = 'AESTAT';
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
            data = [{obj.ID},{obj.LABEL}];
            format = 'is';  
            obj.fprint_nas(fid,format,data);
        end
    end
end

