classdef SPCADD < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        Si;
    end
    
    methods
        function obj = SPCADD(SID,Si)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            obj.SID = SID;
            obj.Si = Si;
            obj.Name = 'SPCADD';
            
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
            for i = 1: length(obj.Si)
                data(end+1) = {obj.Si(i)};
                format(end+1) = 'i';        
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

