classdef SPLINE1 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        CAERO;
        BOX1;
        BOX2;
        SETG;
        DZ;
        METH;
        USAGE;
        NELEM;
        MELEM;
    end
    
    methods
        function obj = SPLINE1(EID,opts)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                EID {mustBeGreaterThan(EID,0)}
                opts.CAERO double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.CAERO,0)} = []
                opts.BOX1 double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.BOX1,0)} = []
                opts.BOX2 double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.BOX2,0)} = []
                opts.SETG double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.SETG,0)} = []
                opts.DZ double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.DZ,0)} = []
                opts.METH {mni.printing.cards.mustBeEmptyOrMember(opts.METH,{'IPS','TPS','FPS','RIS'})} = []
                opts.USAGE {mni.printing.cards.mustBeEmptyOrMember(opts.USAGE,{'FORCE','DISP','BOTH'})} = []
                opts.NELEM double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.NELEM,0)} = []
                opts.MELEM double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.MELEM,0)} = []
            end
            
            obj.Name = 'SPLINE1';
            obj.EID = EID;
            obj.CAERO = opts.CAERO;
            obj.BOX1 = opts.BOX1;
            obj.BOX2 = opts.BOX2;
            obj.SETG = opts.SETG;
            obj.DZ = opts.DZ;
            obj.METH = opts.METH;
            obj.USAGE = opts.USAGE;
            obj.NELEM = opts.NELEM;
            obj.MELEM = opts.MELEM;
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
            data = [{obj.EID},{obj.CAERO},{obj.BOX1},{obj.BOX2}...
                {obj.SETG},{obj.DZ},{obj.METH},{obj.USAGE},...
                {obj.NELEM},{obj.MELEM}];
            format = 'iiiiirssii';
            obj.fprint_nas(fid,format,data);
        end
    end
end

