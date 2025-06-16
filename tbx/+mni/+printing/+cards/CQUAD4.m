classdef CQUAD4 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        PID;
        G1;
        %Theta;
        %ZOFFS;
    end
    
    methods
        function obj = CQUAD4(EID,PID,G1)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            p = inputParser();
            p.addRequired('EID')
            p.addRequired('PID')
            %p.addRequired('G1')
            
            
            p.addRequired('G1',@(x)~any(x<=0))

            %p.addParameter('Alpha','')
            p.parse(EID,PID,G1)
            
            obj.Name = 'CQUAD4';
            obj.EID = p.Results.EID;
            obj.PID = p.Results.PID;
            obj.G1 = p.Results.G1;

       
        end
        
        function writeToFile(obj,fid,varargin)
            %writeToFile print DMI entry to file
            writeToFile@mni.printing.cards.BaseCard(obj,fid,varargin{:})
            data = [{obj.EID},{obj.PID}];
            format = 'ii';
            for i = 1:length(obj.G1)
                data = [data,{obj.G1(i).ID}];
                format = [format,'i'];
            end
            
            obj.fprint_nas(fid,format,data);
        end
    end
end

