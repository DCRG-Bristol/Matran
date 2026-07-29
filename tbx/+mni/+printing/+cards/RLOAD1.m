classdef RLOAD1 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        EXCITEID;
        DELAYI = [];
        DELAYR = [];
        DPHASEI = [];
        DPHASER = [];
        TC = [];
        RC = [];
        TD = []
        RD = [];
        TYPE = [];
    end
    
    methods
        function obj = RLOAD1(SID,EXCITEID,opts)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                SID {mustBeGreaterThan(SID,0)}
                EXCITEID {mustBeGreaterThan(EXCITEID,0)}
                opts.DELAYI double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.DELAYI,0)} = []
                opts.DELAYR = []
                opts.DPHASEI double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.DPHASEI,0)} = []
                opts.DPHASER = []
                opts.TC double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.TC,0)} = []
                opts.RC = []
                opts.TD double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.TD,0)} = []
                opts.RD = []
                opts.TYPE = []
            end

            if ~isempty(opts.DELAYI) && ~isempty(opts.DELAYR)
                error('Only one of DELAYI or DELAYR can be defined')
            end
            if ~isempty(opts.DPHASEI) && ~isempty(opts.DPHASER)
                error('Only one of DPHASEI or DPHASER can be defined')
            end
            if ~isempty(opts.TC) && ~isempty(opts.RC)
                error('Only one of TC or RC can be defined')
            end
            if ~isempty(opts.TD) && ~isempty(opts.RD)
                error('Only one of TD or RD can be defined')
            end

            obj.SID = SID;
            obj.EXCITEID = EXCITEID;
            obj.DELAYI = opts.DELAYI;
            obj.DELAYR = opts.DELAYR;
            obj.DPHASEI = opts.DPHASEI;
            obj.DPHASER = opts.DPHASER;
            obj.TC = opts.TC;
            obj.RC = opts.RC;
            obj.TD = opts.TD;
            obj.RD = opts.RD;
            obj.TYPE = opts.TYPE;
            obj.Name = 'RLOAD1';            
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
            [format,data] = blank_ID_real(format,data,obj.DELAYI,obj.DELAYR);
            [format,data] = blank_ID_real(format,data,obj.DPHASEI,obj.DPHASER);
            [format,data] = blank_ID_real(format,data,obj.TC,obj.RC);
            [format,data] = blank_ID_real(format,data,obj.TD,obj.RD);
            data = [data,{obj.TYPE}];
            format = [format,'i'];
            obj.fprint_nas(fid,format,data);
        end
    end
end

function [format,data] = blank_ID_real(format,data,ID_value,real_value)
    if isempty(ID_value) && isempty(real_value)
        format = [format,'b'];
    elseif ~isempty(ID_value)
        data = [data,{ID_value}];
        format = [format,'i'];
    else
        data = [data,{real_value}];
        format = [format,'r'];
    end
end

