classdef SPLINE7 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        CAERO;
        AELIST;
        SETG;
        DZ;
        DTOR;
        CID;
        USAGE;
        METHOD;
        DZR;
        IA2;
        EPSBM;
    end
    
    methods
        function obj = SPLINE7(EID,CAERO,AELIST,SETG,CID,opts)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                EID {mustBeGreaterThan(EID,0)}
                CAERO {mustBeGreaterThan(CAERO,0)}
                AELIST {mustBeGreaterThan(AELIST,0)}
                SETG {mustBeGreaterThan(SETG,0)}
                CID {mustBeGreaterThanOrEqual(CID,0)}
                opts.DZ double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.DZ,0)} = []
                opts.DTOR double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.DTOR,0)} = []
                opts.METHOD {mni.printing.cards.mustBeEmptyOrMember(opts.METHOD,{'FBS6','FBS3'})} = ''
                opts.DZR double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.DZR,0)} = []
                opts.IA2 double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.IA2,0)} = []
                opts.USAGE {mni.printing.cards.mustBeEmptyOrMember(opts.USAGE,{'FORCE','DISP','BOTH'})} = []
                opts.EPSBM double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.EPSBM,0)} = []
            end
            
            obj.Name = 'SPLINE7';
            obj.EID = EID;
            obj.CAERO = CAERO;
            obj.AELIST = AELIST;
            obj.SETG = SETG;
            obj.CID = CID;
            obj.DZ = opts.DZ;
            obj.DTOR = opts.DTOR;
            obj.METHOD = opts.METHOD;
            obj.DZR = opts.DZR;
            obj.IA2 = opts.IA2;
            obj.USAGE = opts.USAGE;
            obj.EPSBM = opts.EPSBM;
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
            data = [{obj.EID},{obj.CAERO},{obj.AELIST},...
                {obj.SETG},{obj.DZ},{obj.DTOR},{obj.CID},{obj.USAGE},...
                {obj.METHOD},{obj.DZR},{obj.IA2},{obj.EPSBM}];
            format = 'iiibirribbbssrrr';
            obj.fprint_nas(fid,format,data);
        end
    end
end

