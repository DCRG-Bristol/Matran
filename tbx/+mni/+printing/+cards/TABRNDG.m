classdef TABRNDG < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        TID;
        TYPE;
        LpU;
        WG;
    end
    
    methods
        function obj = TABRNDG(TID,TYPE,LpU,WG)
            arguments
                TID
                TYPE double {mustBeMember(TYPE,[1,2])} % 1 for von Karman, 2 for Dyden
                LpU double % length scale divided by velocity
                WG double % root mean gust velocity
            end
            obj.TID = TID;
            obj.TYPE = TYPE;
            obj.LpU = LpU;
            obj.WG = WG;
            obj.Name = 'TABRNDG';            
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
            data = [{obj.TID},{obj.TYPE},{obj.LpU},{obj.WG}];
            format = 'iirr';
            obj.fprint_nas(fid,format,data);
        end
    end
end

