classdef AESURF < mni.printing.cards.BaseCard
    %AERO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ID;
        LABEL;
        CID1;
        ALID1;
        CID2;
        ALID2;
        EFF;
        LDW;
        CREFC;
        CREFS;
        PLLIM;
        PULIM;
        HMLLIM;
        HMULIM;
        TQLLIM;
        TQULIM;
    end
    
    methods
        function obj = AESURF(ID,LABEL,CID1,ALID1,opts)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                ID {mustBeGreaterThan(ID,0)}
                LABEL {mustBeTextScalar}
                CID1 {mustBeGreaterThan(CID1,0)}
                ALID1 {mustBeGreaterThan(ALID1,0)}
                opts.CID2 double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.CID2,0)} = []
                opts.ALID2 double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.ALID2,0)} = []
                opts.EFF = []
                opts.LDW {mni.printing.cards.mustBeEmptyOrMember(opts.LDW,{'LDW','NOLDW'})} = ''
                opts.CREFC double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.CREFC,0)} = []
                opts.CREFS double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.CREFS,0)} = []
                opts.PLLIM = ''
                opts.PULIM = ''
                opts.HMLLIM = ''
                opts.HMULIM = ''
                opts.TQLLIM = ''
                opts.TQULIM = ''
            end
            if ~isempty(opts.EFF)
                if opts.EFF == 0
                    error('EFF must be non-zero when supplied.')
                end
            end

            obj.ID = ID;
            obj.LABEL = LABEL;
            obj.CID1 = CID1;
            obj.ALID1 = ALID1;
            obj.CID2 = opts.CID2;
            obj.ALID2 = opts.ALID2;
            obj.EFF = opts.EFF;
            obj.LDW = opts.LDW;
            obj.CREFC = opts.CREFC;
            obj.CREFS = opts.CREFS;
            obj.PLLIM = opts.PLLIM;
            obj.PULIM = opts.PULIM;
            obj.HMLLIM = opts.HMLLIM;
            obj.HMULIM = opts.HMULIM;
            obj.TQLLIM = opts.TQLLIM;
            obj.TQULIM = opts.TQULIM;
            obj.Name = 'AESURF';
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
            data = [{obj.ID},{obj.LABEL},{obj.CID1},{obj.ALID1}...
                {obj.CID2},{obj.ALID2},{obj.EFF},{obj.LDW},{obj.CREFC},...
                {obj.CREFS},{obj.PLLIM},{obj.PULIM},{obj.HMLLIM},...
                {obj.HMULIM},{obj.TQLLIM},{obj.TQULIM}];
            format = 'isiiiirsrrrrrrii';
            obj.fprint_nas(fid,format,data);
        end
    end
end

