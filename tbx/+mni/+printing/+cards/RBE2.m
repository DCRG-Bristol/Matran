classdef RBE2 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        GN;
        CM;
        GMi;
        Alpha;
    end
    
    methods
        function obj = RBE2(EID,GN,CM,GMi,opts)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                EID {mustBeGreaterThan(EID,0)}
                GN {mustBeGreaterThan(GN,0)}
                CM
                GMi {validatePositiveVector(GMi)}
                opts.Alpha = ''
            end
            
            obj.Name = 'RBE2';
            obj.EID = EID;
            obj.GN = GN;
            obj.CM = CM;
            obj.GMi = GMi;
            obj.Alpha = opts.Alpha;
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
            data = [{obj.EID},{obj.GN},{obj.CM}];
            format = 'iii';
            for i = 1:length(obj.GMi)
                data = [data,{obj.GMi(i)}];
                format = [format,'i'];
            end
            data = [data,{obj.Alpha}];
            format = [format,'r'];
            
            obj.fprint_nas(fid,format,data);
        end
    end
end

function validatePositiveVector(x)
assert(~any(x <= 0))
end

