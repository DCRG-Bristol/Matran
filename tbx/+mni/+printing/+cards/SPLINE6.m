classdef SPLINE6 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        CAERO;
        AELIST;
        SETG;
        DZ;
        DZR;
        METH;
        USAGE;
        I2VNUM;
        D2VNUM;
        METHCON;
        NGRID;
        AUGWEI;
        METHVS;
        ELTOL;
        NCYCLE;
    end
    
    methods
        function obj = SPLINE6(EID,CAERO,AELIST,SETG,opts)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                EID {mustBeGreaterThan(EID,0)}
                CAERO {mustBeGreaterThan(CAERO,0)}
                AELIST {mustBeGreaterThan(AELIST,0)}
                SETG {mustBeGreaterThan(SETG,0)}
                opts.DZ double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.DZ,0)} = []
                opts.DZR double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.DZR,0)} = []
                opts.AUGWEI double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.AUGWEI,0)} = []
                opts.I2VNUM double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.I2VNUM,0)} = []
                opts.D2VNUM double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.D2VNUM,0)} = []
                opts.METHCON {mni.printing.cards.mustBeEmptyOrMember(opts.METHCON,{'NODEPROX','CIRCBIAS'})} = []
                opts.METHVS {mni.printing.cards.mustBeEmptyOrMember(opts.METHVS,{'VS3','VS6'})} = []
                opts.NGRID double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.NGRID,0)} = []
                opts.METH {mni.printing.cards.mustBeEmptyOrMember(opts.METH,{'FPS6','FPS3'})} = ''
                opts.USAGE {mni.printing.cards.mustBeEmptyOrMember(opts.USAGE,{'FORCE','DISP','BOTH'})} = []
                opts.ELTOL double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.ELTOL,0)} = []
                opts.NCYCLE double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.NCYCLE,0)} = []
            end
            
            obj.Name = 'SPLINE6';
            obj.EID = EID;
            obj.CAERO = CAERO;
            obj.AELIST = AELIST;
            obj.SETG = SETG;
            obj.DZ = opts.DZ;
            obj.METH = opts.METH;
            obj.USAGE = opts.USAGE;
            obj.I2VNUM = opts.I2VNUM;
            obj.D2VNUM = opts.D2VNUM;
            obj.DZR = opts.DZR;
            obj.METHCON = opts.METHCON;
            obj.NGRID = opts.NGRID;
            obj.AUGWEI = opts.AUGWEI;
            obj.METHVS = opts.METHVS;
            obj.ELTOL = opts.ELTOL;
            obj.NCYCLE = opts.NCYCLE;
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
                {obj.SETG},{obj.DZ},{obj.METH},{obj.USAGE},{obj.I2VNUM},{obj.D2VNUM},...
                {obj.METHVS},{obj.DZR},{obj.METHCON},{obj.NGRID},{obj.ELTOL},{obj.NCYCLE},{obj.AUGWEI}];
            format = 'iiibifssbbiisrsirir';
            obj.fprint_nas(fid,format,data);
        end
    end
end

