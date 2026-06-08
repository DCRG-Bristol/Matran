classdef CAERO1 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        PID;
        CP;
        NSPAN;
        NCHORD;
        LSPAN;
        LCHORD;
        IGID;
        P1;
        P4;
        X12;
        X43;
    end
    
    methods
        function obj = CAERO1(EID,PID,P1,P4,X12,X43,IGID,opts)
            %CAERO1 Construct an instance of this class
            %   required inputs are as follows:
            % EID - element identification
            % PID - Property Indetification of PAERO
            % P1 - 3x1 vector of point 1
            % P4 - 3x1 vector of point 4
            % X12 - edge chord length at P1
            % X34 - edge chord length at P4
            % IGID - interferance group identification
            %
            % optional parameters are
            % CP - coordinate system ID
            % NSPAN - number of spanwise panels
            % NCHORD - number of chordwise panels
            % LSPAN - ID for AEFACT for spanwise panels
            % LCHORD - ID for AEFACT for chordwise panels
            %
            % see NASTRAN users guide for more info
            arguments
                EID
                PID
                P1 (3,1) double
                P4 (3,1) double
                X12
                X43
                IGID
                opts.CP {mni.printing.cards.mustBeValidID(opts.CP,0)} = 0
                opts.NSPAN {mni.printing.cards.mustBeValidID(opts.NSPAN,1)} = []
                opts.NCHORD {mni.printing.cards.mustBeValidID(opts.NCHORD,1)} = []
                opts.LSPAN {mni.printing.cards.mustBeValidID(opts.LSPAN,1)} = []
                opts.LCHORD {mni.printing.cards.mustBeValidID(opts.LCHORD,1)} = []
            end

            obj.EID = EID;
            obj.PID = PID;
            obj.CP = opts.CP;
            obj.NSPAN = opts.NSPAN;
            obj.NCHORD = opts.NCHORD;
            obj.LSPAN = opts.LSPAN;
            obj.LCHORD = opts.LCHORD;
            obj.IGID = IGID;
            obj.P1 = P1;
            obj.P4 = P4;
            obj.X12 = X12;
            obj.X43 = X43;
            obj.Name = 'CAERO1';
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
            data = [{obj.EID},{obj.PID},{obj.CP},...
                {obj.NSPAN},{obj.NCHORD},{obj.LSPAN},{obj.LCHORD},...
                {obj.IGID},{obj.P1(1)},{obj.P1(2)},{obj.P1(3)},...
                {obj.X12},{obj.P4(1)},{obj.P4(2)},{obj.P4(3)},{obj.X43}];
            format = 'iiiiiiiiffffffff';
            obj.fprint_nas(fid,format,data);
        end
    end
end

