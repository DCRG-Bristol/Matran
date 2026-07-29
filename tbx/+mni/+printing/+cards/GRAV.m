classdef GRAV < mni.printing.cards.BaseCard
    %GRAV Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SID;
        CID;
        A;
        Ni;
        MB;
    end
    
    methods
        function obj = GRAV(SID,A,Ni,opts)
            %CAERO1 Construct an instance of this class
            %   required inputs are as follows:
            % SID - Set Identification Number
            % PID - Acceleration vector scale factor
            % Ni - Acceleration vector components measured in coordinate
            %           system CID (3x1 vector)
            %
            % optional parameters are
            % CID - coordinate system ID (default = 0)
            % MB - see quick reference guide
            %
            % see NASTRAN users guide for more info
            arguments
                SID {mustBeGreaterThan(SID,0)}
                A (1,1) double
                Ni (3,1) double
                opts.MB = []
                opts.CID double {mni.printing.cards.mustBeValidID(opts.CID,0)} = []
            end

            obj.SID = SID;
            obj.A = A;
            obj.Ni = Ni;
            obj.MB = opts.MB;
            obj.CID = opts.CID;
            obj.Name = 'GRAV';
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
            data = [{obj.SID},{obj.CID},{obj.A},...
                {obj.Ni(1)},{obj.Ni(2)},{obj.Ni(3)},{obj.MB}];
            format = 'iirrrri';
            obj.fprint_nas(fid,format,data);
        end
    end
end

