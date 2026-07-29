classdef RBE3 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        REFGRID;
        REFC;
        WTi;
        Ci;
        Gij;
        UM;
        GMi;
        CMi;
        Alpha;
    end
    
    methods

        function obj = RBE3(EID, REFGRID, REFC, WTi, Ci, Gij, opts)
            arguments
                EID (1,1) double {mustBePositive}
                REFGRID
                REFC
                WTi
                Ci
                Gij
                opts.UM = ''
                opts.GMi (1,:) double {mustBePositive} = [] 
                opts.CMi (1,:) double {mustBePositive} = []
                opts.Alpha = []
            end

            obj.Name = 'RBE3';
            obj.EID     = EID;
            obj.REFGRID = REFGRID;
            obj.REFC    = REFC;
            obj.WTi     = WTi;
            obj.Ci      = Ci;
            obj.Gij     = Gij;
            obj.UM      = opts.UM;
            obj.GMi     = opts.GMi;
            obj.CMi     = opts.CMi;
            obj.Alpha   = opts.Alpha;
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
            data = {obj.EID};
            format = 'ib';
            data = [data,{obj.REFGRID},{obj.REFC},{obj.WTi},{obj.Ci}];
             format = [format,'iiri'];
            for i = 1:(length(obj.Gij))
                data = [data,{obj.Gij(i)}];
                format = [format,'i'];
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

