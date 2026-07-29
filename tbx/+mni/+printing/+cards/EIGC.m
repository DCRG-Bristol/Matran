classdef EIGC < mni.printing.cards.BaseCard    
    properties
        SID;
        METHOD;
        NORM;       
        G;
        C;
        E;
        ND;
    end
    
    methods
        function obj = EIGC(SID,METHOD,ND,opts)
            arguments
                SID double {mustBePositive(SID),mustBeInteger(SID)}
                METHOD char {mustBeMember(METHOD,{'INV','HESS','CLAN','IRAM'})}
                ND double {mustBeInteger(ND)}
                opts.NORM char {mustBeMember(opts.NORM,{'','MAX','POINT'})} = '';
                opts.G double {mustBeInteger(opts.G)} = [];
                opts.C double {mustBeInteger(opts.C)} = [];
                opts.E double = [];
            end
            obj.SID = SID;
            obj.METHOD = METHOD;
            obj.ND = ND;
            obj.NORM = opts.NORM;
            obj.G = opts.G;
            obj.C = opts.C;
            obj.E = opts.E;
            obj.Name = 'EIGC';
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
            data = [{obj.SID},{obj.METHOD},{obj.NORM},...
                {obj.G},{obj.C},{obj.E},{obj.ND}];
            format = 'issiiri';
            obj.fprint_nas(fid,format,data);
        end
    end
end

