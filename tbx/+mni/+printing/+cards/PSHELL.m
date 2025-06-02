classdef PSHELL < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        PID;
        MID1;
        T;
        MID2;
        I12;
        MID3;
    end
    
    methods
        function obj = PSHELL(PID,MID1,T,MID2,I12,MID3)
            %CONM2 Construct an instance of this class
            %   required inputs are as follows:
            % PID - property identification
            % MID - material identification
            % NSM - non-structural mass per unit length
            %
            % optional parameters are
            % A - Area of bar cross section
            % I1,I2,I12 - Area moments of inertia
            % J - Torsional constant
            % C1,C2,D1,D2,E1,E2,F1,F2 - Stress recovery coefficients
            % K1,K2 - Area factor for shear
            %
            % see NASTRAN users guide for more info
            arguments
                PID (1,1) double {mustBePositive}
                MID1 (1,1) double {mustBePositive}
                T (1,1) double {mustBePositive}
                MID2 (1,1) double {mustBePositive}
                I12 (:,1) double {mustBePositive}
                MID3 (1,1) double {mustBePositive}
                
            end 
            obj.PID = PID;
            obj.MID1 = MID1;
            obj.T = T;
            obj.MID2 = MID2;
            obj.I12 = I12;
            obj.MID3 = MID3;
            obj.Name = 'PSHELL';
        end
        
        function writeToFile(obj,fid,varargin)
            %writeToFile print DMI entry to file
            writeToFile@mni.printing.cards.BaseCard(obj,fid,varargin{:})
            data = [{obj.PID},{obj.MID1},{obj.T},{obj.MID2},{obj.I12},{obj.MID3}];
            format = 'iiriri';
            obj.fprint_nas(fid,format,data);
            
        end
    end
end

