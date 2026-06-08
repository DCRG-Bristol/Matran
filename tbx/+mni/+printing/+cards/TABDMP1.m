classdef TABDMP1 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        TID;
        TYPE;
        Fs;
        Gs;
    end
    
    methods
        function obj = TABDMP1(TID,TYPE,Fs,Gs)
            %CAERO1 Construct an instance of this class
            %   required inputs are as follows:
            % SID,METHOD
            %
            % optional parameters are:
            % F1, F2, NE, ND, NORM, G, C
            %
            % see NASTRAN users guide for more info
            arguments
                TID {mustBeGreaterThan(TID,0)}
                TYPE {mustBeMember(TYPE,{'G','CRIT','Q'})}
                Fs
                Gs
            end
            if numel(Fs)~=numel(Gs)
                error('Fs and Gs must be the same length')
            end
            assert(numel(Fs)>1 && all(Fs>=0))
            assert(numel(Gs)>1)

            obj.TID = TID;
            obj.TYPE = TYPE;
            obj.Fs = Fs;
            obj.Gs = Gs;  
            obj.Name = 'TABDMP1';
            
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
            data = [{obj.TID},{obj.TYPE}];
            format = 'isn';
            for i = 1:length(obj.Fs)
                data = [data,obj.Fs(i),obj.Gs(i)];
                format = [format,'rr'];
            end
            data = [data,'ENDT'];
            format = [format,'s'];
            obj.fprint_nas(fid,format,data);
        end
    end
end

