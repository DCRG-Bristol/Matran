classdef DLOAD < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        S;
        Ss;
        Ls;
    end
    
    methods
        function obj = DLOAD(SID,S,Ss,Ls)
            arguments
                SID {mustBeGreaterThan(SID,0)}
                S
                Ss {mustBeNonempty}
                Ls {mustBeNonempty}
            end
            if numel(Ss)~=numel(Ls)
                error('Ss and Ls must be the same length')
            end

            obj.SID = SID;
            obj.S = S;
            obj.Ss = Ss;
            obj.Ls = Ls;  
            obj.Name = 'DLOAD';
            
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
            data = [{obj.SID},{obj.S}];
            format = 'ir';
            for i = 1:length(obj.Ss)
                data = [data,obj.Ss(i),obj.Ls(i)];
                format = [format,'ri'];
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

