classdef RJOINT < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        GA;
        GB;
        CB;
    end
    
    methods
        function obj = RJOINT(EID,GA,GB,opts)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                EID {mustBeGreaterThan(EID,0)}
                GA {mustBeGreaterThan(GA,0)}
                GB {mustBeGreaterThan(GB,0)}
                opts.CB = ''
            end

            obj.EID = EID;
            obj.GA = GA;
            obj.GB = GB;
            obj.CB = opts.CB;
            obj.Name = 'RJOINT';          
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
            data = [{obj.EID},{obj.GA},{obj.GB},{obj.CB}];
            format = 'iiis';
            obj.fprint_nas(fid,format,data);
        end
    end
end

