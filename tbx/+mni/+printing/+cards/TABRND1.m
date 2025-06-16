classdef TABRND1 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        TID;
        XAXIS;
        YAXIS;
        fi;
        gi;
    end
    
    methods
        function obj = TABRND1(TID,fi,gi,varargin)
            types = {'LINEAR','LOG'};
            if numel(fi)~=numel(gi)
                error('xs and Ys must be the same length')
            end            
            p = inputParser();
            p.addRequired('TID',@(x)x>0);
            p.addRequired('fi',@(x)numel(x)>1);
            p.addRequired('gi',@(x)numel(x)>1);
            p.addParameter('XAXIS',[],@(x)any(validatestring(x,types)));
            p.addParameter('YAXIS',[],@(x)any(validatestring(x,types)));
            p.parse(TID,fi,gi,varargin{:}); 

            obj.TID = TID;
            obj.fi = fi;
            obj.gi = gi;
            obj.XAXIS = p.Results.XAXIS;  
            obj.YAXIS = p.Results.YAXIS; 
            obj.Name = 'TABRND1';
            
        end
        
        function writeToFile(obj,fid,varargin)
            %writeToFile print DMI entry to file
            writeToFile@mni.printing.cards.BaseCard(obj,fid,varargin{:})
            data = [{obj.TID},{obj.XAXIS},{obj.YAXIS}];
            format = 'issn';
            for i = 1:length(obj.fi)
                data = [data,obj.fi(i),obj.gi(i)];
                format = [format,'rr'];
            end
            data = [data,'ENDT'];
            format = [format,'s'];
            obj.fprint_nas(fid,format,data);
        end
    end
end

