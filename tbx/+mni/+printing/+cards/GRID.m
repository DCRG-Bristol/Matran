classdef GRID < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ID;
        CP;
        X1;
        X2;
        X3;
        CD;
        PS;
        SEID;
    end
    
    methods
        function obj = GRID(ID,X,opts)
            arguments
                ID {mustBeGreaterThanOrEqual(ID,0)}
                X (3,1) double
                opts.CP {mni.printing.cards.mustBeValidID(opts.CP,0)} = [];
                opts.CD {mni.printing.cards.mustBeValidID(opts.CD,-1)} = [];
                opts.PS = '';
                opts.SEID {mni.printing.cards.mustBeValidID(opts.SEID,0)} = [];
            end
            
            obj.Name = 'GRID';
            obj.ID = ID;
            obj.CP = opts.CP;
            obj.X1 = X(1);
            obj.X2 = X(2);
            obj.X3 = X(3);
            obj.CD = opts.CD;
            obj.PS = opts.PS;
            obj.SEID = opts.SEID;            
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
            data = [{obj.ID},{obj.CP},{obj.X1},{obj.X2},...
                {obj.X3},{obj.CD},{obj.PS},{obj.SEID}];
            format = 'iifffisi';
            obj.fprint_nas(fid,format,data);
        end
    end
end

