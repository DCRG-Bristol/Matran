classdef CBUSH < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        PID;
        GA;
        GB=[];
        G0=[];
        X1=[];
        X2=[];
        X3=[];
        CID=[];
        
        vectorType;
    end
    
    methods
        function obj = CBUSH(EID,PID,GA,GB,opts)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                EID {mustBeGreaterThan(EID,0)}
                PID {mustBeGreaterThan(PID,0)}
                GA {mustBeGreaterThan(GA,0)}
                GB double {mni.printing.cards.mustBeEmptyOrGreaterThanOrEqual(GB,0)} = []
                opts.X double {mni.printing.cards.mustBeEmptyOr3x1Vec(opts.X)} = []
                opts.G0 double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.G0,0)} = []
                opts.CID double {mni.printing.cards.mustBeEmptyOrGreaterThan(opts.CID,0)} = []
            end
            
            obj.Name = 'CBUSH';
            obj.EID = EID;
            obj.PID = PID;
            obj.GA = GA;
            obj.GB = GB;
            obj.CID = opts.CID;
            
            if ~isempty(opts.CID)
                obj.CID = opts.CID;
                obj.vectorType = 'cid';
            else            
                if xor(isempty(opts.G0),isempty(opts.X))
                    if ~isempty(opts.G0)
                        obj.G0 = opts.G0;
                        obj.vectorType = 'g0';
                    else
                        obj.X1 = opts.X(1);
                        obj.X2 = opts.X(2);
                        obj.X3 = opts.X(3);
                        obj.vectorType = 'x';
                    end
                else
                    error('Either G0 or Xn is defined in CBUSH Element not both')
                end   
            end
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
            
            data = [{obj.EID},{obj.PID},{obj.GA},{obj.GB}];
            format = 'iiii';
            switch obj.vectorType
                case 'g0'
                    data = [data,{obj.G0}];
                    format = [format,'ibbb'];
                case 'x'
                    data = [data,{obj.G0}];
                    format = [format,'ibbb'];
                case 'cid'
                    data = [data,{obj.CID}];
                    format = [format,'bbbi'];
            end            
            obj.fprint_nas(fid,format,data);
        end
    end
end

