classdef PARAM < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        N;
        V1;
        V2;
        Type;
    end
    
    methods
        function obj = PARAM(N,Type,V1,V2)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                N
                Type {mustBeMember(Type,{'s','r','f','i'})}
                V1
                V2 = []
            end

            obj.N = N;
            obj.V1 = V1;
            obj.V2 = V2;
            obj.Type = Type;
            obj.Name = 'PARAM';
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
            data = [{obj.N},{obj.V1},{obj.V2}];
            format = ['s',obj.Type,obj.Type];
            obj.fprint_nas(fid,format,data);
        end
    end
end

