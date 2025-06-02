classdef CQUAD4 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        PID;
        G1;
        G2;
        G3;
        G4;
        %Theta;
        %ZOFFS;
    end
    
    methods
        function obj = CQUAD4(EID,PID,G1,G2,G3,G4)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            p = inputParser();
            p.addRequired('EID')
            p.addRequired('PID')
            p.addRequired('G1')
            p.addRequired('G2')
            p.addRequired('G3')
            p.addRequired('G4')            
            
            
            %p.addParameter('Alpha','')
            p.parse(EID,PID,G1,G2,G3,G4)
            
            obj.Name = 'CQUAD4';
            obj.EID = p.Results.EID;
            obj.PID = p.Results.PID;
            obj.G1 = p.Results.G1;
            obj.G2 = p.Results.G2;
            obj.G3 = p.Results.G3;
            obj.G4 = p.Results.G4;
       
        end
        
        function writeToFile(obj,fid,varargin)
            %writeToFile print DMI entry to file
            writeToFile@mni.printing.cards.BaseCard(obj,fid,varargin{:})
            data = [{obj.EID},{obj.PID},{obj.G1},{obj.G2},{obj.G3},{obj.G4}];
            format = 'iiiiii';
            % for i = 1:length(obj.GMi)
            %     data = [data,{obj.GMi(i)}];
            %     format = [format,'i'];
            % end
            % data = [data,{obj.Alpha}];
            % format = [format,'r'];
            
            obj.fprint_nas(fid,format,data);
        end
    end
end

