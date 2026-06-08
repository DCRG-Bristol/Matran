classdef DELAY < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        Ps;
        Cs;
        Ts;
    end
    
    methods
        function obj = DELAY(SID,Ps,Cs,Ts)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            if numel(Ps) ~= numel(Cs) || numel(Ps) ~= numel(Ts)
                error('Ps,Cs,and As must be arrays of the same length')
            end
            if numel(Ps)>2
                error('max array length is 2')
            end
            obj.SID = SID;
            obj.Ps = Ps;
            obj.Cs = Cs;
            obj.Ts = Ts;
            obj.Name = 'DELAY';
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
            data = [{obj.SID}];
            format = 'i';
            for i = 1:length(obj.Ps)
                data = [data,{obj.Ps(i)},{obj.Cs(i)},{obj.Ts(i)}];
                format = [format,'iir'];
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

