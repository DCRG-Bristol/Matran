classdef EIGR < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        METHOD;
        F1;
        F2;
        NE;
        ND;
        NORM;
        G;
        C;
    end
    
    methods
        function obj = EIGR(SID,METHOD,opts)
            %CAERO1 Construct an instance of this class
            %   required inputs are as follows:
            % SID,METHOD
            %
            % optional parameters are:
            % F1, F2, NE, ND, NORM, G, C
            %
            % see NASTRAN users guide for more info
            arguments
                SID {mustBeGreaterThan(SID,0)}
                METHOD {mustBeMember(METHOD,{'LAN','AHOU','INV','SINV','GIV','MGIV','HOU','MHOU','AGIV'})}
                opts.F1 double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.F1,0)} = []
                opts.F2 double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.F2,0)} = []
                opts.NE double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.NE,0)} = []
                opts.ND double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.ND,0)} = []
                opts.NORM {mni.printing.cards.mustBeEmptyOrMember(opts.NORM,{'MASS','MAX','POINT'})} = []
                opts.G double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.G,0)} = []
                opts.C double {mni.printing.cards.mustBeEmptyOrInRange(opts.C,1,6)} = []
            end

            obj.SID = SID;
            obj.METHOD = METHOD;
            obj.F1 = opts.F1;
            obj.F2 = opts.F2;
            obj.NE = opts.NE;
            obj.ND = opts.ND;
            obj.NORM = opts.NORM;
            obj.G = opts.G;
            obj.C = opts.C;
            obj.Name = 'EIGR';
            
            if ~isempty(obj.F1)
                if isempty(obj.F2)
                    error('For EIGR card either both or neither frequency bounds must be supplied')
                end
                if obj.F1>=obj.F2
                   error('For EIGR card the following must be true F1 < F2') 
                end
            end
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
            data = [{obj.SID},{obj.METHOD},{obj.F1},...
                {obj.F2},{obj.NE},{obj.ND},{obj.NORM},...
                {obj.G},{obj.C}];
            format = 'isrriibbsii';
            obj.fprint_nas(fid,format,data);
        end
    end
end

