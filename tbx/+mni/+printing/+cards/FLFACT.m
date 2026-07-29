classdef FLFACT < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        VALUES;
    end
    
    methods
        function obj = FLFACT(SID,VALUES)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            obj.SID = SID;
            obj.VALUES = VALUES;
            obj.Name = 'FLFACT';
            
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
            data = [{obj.SID}];
            format = 'i';
            for i = 1: length(obj.VALUES)
                data(end+1) = {obj.VALUES(i)};
                format(end+1) = 'f';        
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

