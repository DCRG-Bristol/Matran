classdef COLUMNDELIM < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fieldType;
    end
    
    methods
        function obj = COLUMNDELIM(fieldType)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                fieldType {mustBeMember(fieldType,{'long','short','large','normal','8','16'})} = 'large'
            end
            obj.fieldType = fieldType;         
        end
        
        function writeToFile(obj,fid,varargin)
            %writeToFile print DMI entry to file
            mni.printing.bdf.writeColumnDelimiter(fid,obj.fieldType)
        end
    end
end

