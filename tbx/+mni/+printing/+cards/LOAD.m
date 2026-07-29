classdef LOAD < mni.printing.cards.BaseCard    
    properties
        SID;
        ScaleFactor;
        SIDs;
        Scales;
    end
    
    methods
        function obj = LOAD(SID,ScaleFactor,SIDs,Scales)
            arguments
                SID (1,1) double {mustBeInteger,mustBePositive}
                ScaleFactor (1,1) double {mustBeNumeric,mustBePositive}
                SIDs (:,1) double {mustBeInteger,mustBePositive}
                Scales (:,1) double {mustBeNumeric,mustBePositive}
            end
            if numel(SIDs)~=numel(Scales)
                error('SIDs and Scales must have the same number of elements')
            end            
            obj.SID = SID;
            obj.ScaleFactor = ScaleFactor;
            obj.SIDs = SIDs;
            obj.Scales = Scales;
            obj.Name = 'LOAD';            
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
            data = [{obj.SID},{obj.ScaleFactor}];
            format = 'ir';
            for i = 1:length(obj.SIDs)
                data = [data,obj.Scales(i),obj.SIDs(i)];
                format = [format,'ri'];
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

