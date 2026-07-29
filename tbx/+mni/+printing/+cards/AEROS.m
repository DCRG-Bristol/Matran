classdef AEROS < mni.printing.cards.BaseCard
    %AERO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ACSID;
        RCSID;
        REFC;
        REFB;
        REFS;
        SYMXZ;
        SYMXY;
    end
    
    methods
        function obj = AEROS(REFC,REFB,REFS,opts)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                REFC {mustBeGreaterThan(REFC,0)}
                REFB {mustBeGreaterThan(REFB,0)}
                REFS {mustBeGreaterThan(REFS,0)}
                opts.ACSID double {mni.printing.cards.mustBeValidID(opts.ACSID,0)} = []
                opts.RCSID double {mni.printing.cards.mustBeValidID(opts.RCSID,0)} = []
                opts.SYMXZ {validateEmptySymmetry(opts.SYMXZ)} = []
                opts.SYMXY {validateEmptySymmetry(opts.SYMXY)} = []
            end

            obj.ACSID = opts.ACSID;
            obj.RCSID = opts.RCSID;
            obj.REFC = REFC;
            obj.REFB = REFB;
            obj.REFS = REFS;
            obj.SYMXZ = opts.SYMXZ;
            obj.SYMXY = opts.SYMXY;
            obj.Name = 'AEROS';
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
            data = [{obj.ACSID},{obj.RCSID},{obj.REFC},...
                {obj.REFB},{obj.REFS},{obj.SYMXZ},{obj.SYMXY}];
            format = 'iirrrii';
            obj.fprint_nas(fid,format,data);
        end
    end
end

function validateEmptySymmetry(x)
if ~isempty(x)
    mustBeMember(x,[-1,0,1])
end
end

