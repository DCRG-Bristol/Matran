classdef CORD2R < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        CID;
        RID;
        A;
        B;
        C;
    end
    
    methods
        function obj = CORD2R(CID,A,B,C,opts)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                CID {mustBeGreaterThan(CID,0)}
                A (3,1) double
                B (3,1) double
                C (3,1) double
                opts.RID {mni.printing.cards.mustBeValidID(opts.RID,0)} = 0
                opts.LongFormat logical = false
            end
            
            obj.Name = 'CORD2R';
            obj.CID = CID;
            obj.RID = opts.RID;
            obj.A = A;
            obj.B = B;
            obj.C = C;
            obj.LongFormat = opts.LongFormat;
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
            data = [{obj.CID},{obj.RID},...
                {obj.A(1)},{obj.A(2)},{obj.A(3)},...
                {obj.B(1)},{obj.B(2)},{obj.B(3)},...
                {obj.C(1)},{obj.C(2)},{obj.C(3)}];
            format = 'iirrrrrrrrr';
            obj.fprint_nas(fid,format,data);
        end
    end
    %staic constructors
    methods(Static)
        function obj = FromRMatrix(CID,origin,RMatrix,varargin)
            A = origin(:);
            B = RMatrix*[0 0 1]'+A;
            C = RMatrix*[1 0 0]'+A;
            obj = mni.printing.cards.CORD2R(CID,A,B,C,varargin{:});
        end
    end
end

