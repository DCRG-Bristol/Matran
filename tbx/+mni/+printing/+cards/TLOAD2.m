classdef TLOAD2 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        EXCITEID;
        DELAYI = [];
        DELAYR = [];
        TYPE = [];
        T1 = [];
        T2 = [];
        F = [];
        P = [];
        C = [];
        B = [];
        US0 = [];
        VS0 = [];
    end
    
    methods
        function obj = TLOAD2(SID,EXCITEID,opts)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                SID {mustBeGreaterThan(SID,0)}
                EXCITEID {mustBeGreaterThan(EXCITEID,0)}
                opts.DELAYI double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.DELAYI,0)} = []
                opts.DELAYR = []
                opts.TYPE = []
                opts.T1 double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.T1,0)} = []
                opts.T2 double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.T2,0)} = []
                opts.F double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(opts.F,0)} = []
                opts.P = []
                opts.C = []
                opts.B = []
                opts.US0 = []
                opts.VS0 = []
            end

            if ~isempty(opts.DELAYI) && ~isempty(opts.DELAYR)
                error('Only one of DELAYI or DELAYR can be defined')
            end

            obj.SID = SID;
            obj.EXCITEID = EXCITEID;
            obj.DELAYI = opts.DELAYI;
            obj.DELAYR = opts.DELAYR;
            obj.TYPE = opts.TYPE;
            obj.T1 = opts.T1;
            obj.T2 = opts.T2;
            obj.F = opts.F;
            obj.P = opts.P;
            obj.C = opts.C;
            obj.B = opts.B;
            obj.US0 = opts.US0;
            obj.VS0 = opts.VS0;
            obj.Name = 'TLOAD2';            
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
            data = [{obj.SID},{obj.EXCITEID}];
            format = 'ii';
            if isempty(obj.DELAYI) && isempty(obj.DELAYR)
                format = [format,'b'];
            elseif ~isempty(obj.DELAYI)
                data = [data,{obj.DELAYI}];
                format = [format,'i'];
            else
                data = [data,{obj.DELAYR}];
                format = [format,'r'];
            end
            data = [data,{obj.TYPE},{obj.T1},{obj.T2},{obj.F},{obj.P}];
            format = [format,'irrrr'];
            if ~isempty(obj.C) || ~isempty(obj.B) || ~isempty(obj.US0) || ~isempty(obj.VS0)
                data = [data,{obj.C},{obj.B},{obj.US0},{obj.VS0}];
                format = [format,'rrrr'];
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

