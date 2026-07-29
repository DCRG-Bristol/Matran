classdef HEADING < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        text;
    end
    
    methods
        function obj = HEADING(text)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            obj.text = text;         
        end
        
        function writeToFile(obj,fid,bComment)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            arguments
                obj
                fid
                bComment logical = false
            end
            
            %writeToFile print DMI entry to file
            mni.printing.bdf.writeHeading(fid,obj.text)
        end
    end
end

