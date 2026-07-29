classdef CTRIA3 < mni.printing.cards.BaseCard
    properties
        EID;
        PID;
        Gi;
    end
    
    methods
        function obj = CTRIA3(EID,PID,Gi)
            %CQUAD4_CARD Construct an instance of this class
            arguments
                EID
                PID
                Gi (3,1) double
            end            
            obj.Name = 'CTRIA3';
            obj.EID = EID;
            obj.PID = PID;
            obj.Gi = Gi;
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
            data = [{obj.EID},{obj.PID}];
            format = 'ii';
            for i = 1:length(obj.Gi)
                data = [data,{obj.Gi(i)}];
                format = [format,'i'];
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

