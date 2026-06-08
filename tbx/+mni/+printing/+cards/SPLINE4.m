classdef SPLINE4 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        CAERO;
        AELIST;
        SETG;
        DZ;
        METH;
        USAGE;
        FTYPE;
        RCORE;
    end
    
    methods
        function obj = SPLINE4(EID,CAERO,AELIST,SETG,opts)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                EID {mustBeGreaterThan(EID,0)}
                CAERO {mustBeGreaterThan(CAERO,0)}
                AELIST {mustBeGreaterThan(AELIST,0)}
                SETG {mustBeGreaterThan(SETG,0)}
                opts.RCORE double {mustBeGreaterThan(opts.RCORE,0)} = 1
                opts.DZ double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.DZ,0)} = []
                opts.METH {mni.printing.cards.mustBeEmptyOrMember(opts.METH,{'IPS','TPS','FPS','RIS'})} = ''
                opts.USAGE {mni.printing.cards.mustBeEmptyOrMember(opts.USAGE,{'FORCE','DISP','BOTH'})} = []
                opts.FTYPE {mni.printing.cards.mustBeEmptyOrMember(opts.FTYPE,{'WF0','WF2'})} = []
            end
            
            obj.Name = 'SPLINE4';
            obj.EID = EID;
            obj.CAERO = CAERO;
            obj.AELIST = AELIST;
            obj.SETG = SETG;
            obj.DZ = opts.DZ;
            obj.METH = opts.METH;
            obj.USAGE = opts.USAGE;
            obj.RCORE = opts.RCORE;
            obj.FTYPE = opts.FTYPE;
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
                {obj.SETG},{obj.DZ},{obj.METH},{obj.USAGE}];
            format = 'iiibifss';
            if  strcmp(obj.METH,'RIS')
                data = [data,{obj.FTYPE},{obj.RCORE}];
                format = [format,'bbsr'];
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

