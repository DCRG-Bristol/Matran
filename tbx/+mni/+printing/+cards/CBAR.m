classdef CBAR < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        PID;
        GA;
        GB;
        G0;
        X;
        Wa;
        Wb;
        OFFST;
        PA;
        PB;
    end
    
    methods
        function obj = CBAR(EID,PID,GA,GB,opts)
            %CAERO1 Construct an instance of this class
            %   required inputs are as follows:
            % EID - element identification
            % PID - Property Indetification of PAERO
            % GA - grid Point for start of beam
            % GB - Grid Point for end of beam
            %
            %   optional parameters are
            % G0 - see quick reference guide
            % X - orientation vector (x1-3 in qrg)
            % Wa - see quick reference guide
            % Wb - see quick reference guide
            % OFFST - see quick reference guide
            % PA - see quick reference guide
            % PB - see quick reference guide
            %
            % see NASTRAN users guide for more info
            arguments
                EID
                PID
                GA
                GB
                opts.G0 double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.G0,0)} = []
                opts.X double {mni.printing.cards.mustBeEmptyOr3x1Vec(opts.X)} = []
                opts.Wa double {mni.printing.cards.mustBeEmptyOr3x1Vec(opts.Wa)} = []
                opts.Wb double {mni.printing.cards.mustBeEmptyOr3x1Vec(opts.Wb)} = []
                opts.OFFST = ''
                opts.PA double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.PA,0)} = []
                opts.PB double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.PB,0)} = []
            end

            if ~isempty(opts.OFFST)
                mustBeTextScalar(opts.OFFST)
            end

            obj.EID = EID;
            obj.PID = PID;
            obj.GA = GA;
            obj.GB = GB;
            obj.G0 = opts.G0;
            obj.X = opts.X;
            obj.Wa = opts.Wa;
            obj.Wb = opts.Wb;
            obj.OFFST = opts.OFFST;
            obj.PA = opts.PA;
            obj.PB = opts.PB;
            obj.Name = 'CBAR';
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
            if isempty(obj.G0)
                data = [{obj.EID},{obj.PID},{obj.GA},{obj.GB},...
                {obj.X(1)},{obj.X(2)},{obj.X(3)},{obj.OFFST},...
                {obj.PA},{obj.PB},{obj.Wa(1)},{obj.Wa(2)},{obj.Wa(3)},...
                {obj.Wb(1)},{obj.Wb(2)},{obj.Wb(3)}];
                format = 'iiiirrrsiirrrrrr';
            else
                data = [{obj.EID},{obj.PID},{obj.GA},{obj.GB},...
                {obj.G0},{obj.OFFST},{obj.PA},{obj.PB},...
                {obj.Wa(1)},{obj.Wa(2)},{obj.Wa(3)},...
                {obj.Wb(1)},{obj.Wb(2)},{obj.Wb(3)}];
                format = 'iiiiibbsiirrrrrr';
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end

