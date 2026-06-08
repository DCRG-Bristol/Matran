classdef INCLUDE < mni.printing.cards.BaseCard
    %INCLUDE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        File;
    end
    
    methods
        function obj = INCLUDE(File)
            %INCLUDE Construct an instance of this class
            %   Detailed explanation goes here        
            obj.File = File;
            obj.Name = 'INCLUDE';
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
            %convert to literal string
            dubSep = [filesep, filesep];
            filepath = strrep(convertStringsToChars(obj.File), filesep, dubSep);
            fileSections = strsplit(filepath, dubSep);
            if length(fileSections) == 1;
                lines = fileSections;
            else
                lines = join(fileSections(1:2), dubSep);
            end
            for i = 3:length(fileSections)
                if length(lines{end}) + length(fileSections{i}) + 1 + 2 > 60
                    lines{end+1} = [dubSep, fileSections{i}];
                else
                    lines{end} = [lines{end}, dubSep,fileSections{i}];
                end
            end
            format = '';
            lines{1} = ['''',lines{1}];
            lines{end} = [lines{end},''''];
            for i = 1:length(lines)
                format = [format,'sn'];
            end
            obj.fprint_nas(fid,format,lines);
        end
    end
end

