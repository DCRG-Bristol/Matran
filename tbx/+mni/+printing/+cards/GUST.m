classdef GUST < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        DLOAD;
        WG;
        X0;
        V;
    end
    
    methods
        function obj = GUST(SID,DLOAD,WG,X0,V)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                SID {mustBeGreaterThan(SID,0)}
                DLOAD {mustBeGreaterThan(DLOAD,0)}
                WG {mustBeNonzero}
                X0
                V {mustBeGreaterThan(V,0)}
            end

            obj.SID = SID;
            obj.DLOAD = DLOAD;
            obj.WG = WG;
            obj.X0 = X0;
            obj.V = V;
            obj.Name = 'GUST';
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
            data = [{obj.SID},{obj.DLOAD},{obj.WG},{obj.X0},{obj.V}];
            format = 'iirrr';
            obj.fprint_nas(fid,format,data);
        end
    end
end

