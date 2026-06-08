classdef MOMENT < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        G;
        CID;
        M;
        N1;
        N2;
        N3;
    end
    
    methods
        function obj = MOMENT(SID,G,M,N,opts)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                SID
                G
                M
                N (3,1) double
                opts.CID double {mni.printing.cards.mustBeValidID(opts.CID,0)} = []
            end
            
            obj.Name = 'MOMENT';
            obj.SID = SID;
            obj.G = G;
            obj.N1 = N(1);
            obj.N2 = N(2);
            obj.N3 = N(3);
            obj.M = M;
            obj.CID = opts.CID;
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
            data = [{obj.SID},{obj.G},{obj.CID},{obj.M},...
                {obj.N1},{obj.N2},{obj.N3}];
            format = 'iiiffff';
            obj.fprint_nas(fid,format,data);
        end
    end
end

