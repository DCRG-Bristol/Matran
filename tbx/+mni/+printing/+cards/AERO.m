classdef AERO < mni.printing.cards.BaseCard
    %AERO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ACSID;
        VELOCITY;
        REFC;
        RHOREF;
        SYMXZ;
        SYMXY;
    end
    
    methods
        function obj = AERO(REFC,RHOREF,opts)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                REFC double {mustBeGreaterThan(REFC,0)}
                RHOREF double {mustBeGreaterThan(RHOREF,0)}
                opts.ACSID double {mustBeGreaterThan(opts.ACSID,0)} = []
                opts.VELOCITY double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.VELOCITY,0)} = []
                opts.SYMXZ logical = []
                opts.SYMXY logical = []
            end

            obj.ACSID = opts.ACSID;
            obj.VELOCITY = opts.VELOCITY;
            obj.REFC = REFC;
            obj.RHOREF = RHOREF;
            obj.SYMXZ = opts.SYMXZ;
            obj.SYMXY = opts.SYMXY;
            obj.Name = 'AERO';
            
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

            data = [{obj.ACSID},{obj.VELOCITY},{obj.REFC},...
                {obj.RHOREF},{obj.SYMXZ},{obj.SYMXY}];
            format = 'irrrii';
            obj.fprint_nas(fid,format,data);
        end
    end
end

