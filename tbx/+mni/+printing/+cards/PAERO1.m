classdef PAERO1 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        PID;
        B1;
        B2;
        B3;
        B4;
        B5;
        B6;
    end
    
    methods
        function obj = PAERO1(PID,B1,B2,B3,B4,B5,B6)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                PID {mustBeGreaterThan(PID,0)}
                B1 double {mni.printing.cards.mustBeEmptyOrGreaterThan(B1,0)} = []
                B2 double {mni.printing.cards.mustBeEmptyOrGreaterThan(B2,0)} = []
                B3 double {mni.printing.cards.mustBeEmptyOrGreaterThan(B3,0)} = []
                B4 double {mni.printing.cards.mustBeEmptyOrGreaterThan(B4,0)} = []
                B5 double {mni.printing.cards.mustBeEmptyOrGreaterThan(B5,0)} = []
                B6 double {mni.printing.cards.mustBeEmptyOrGreaterThan(B6,0)} = []
            end
            
            obj.Name = 'PAERO1';
            obj.PID = PID;
            obj.B1 = B1;
            obj.B2 = B2;
            obj.B3 = B3;
            obj.B4 = B4;
            obj.B5 = B5;
            obj.B6 = B6;
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
            data = [{obj.PID},{obj.B1},{obj.B2},...
                {obj.B3},{obj.B4},{obj.B5},{obj.B6}];
            format = 'iiiiiii';            
            obj.fprint_nas(fid,format,data);
        end
    end
end

