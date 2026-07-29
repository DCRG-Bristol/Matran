classdef PBUSH < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        PID;
        K;
        B;
        GE;
        RCV;
        M;
    end
    
    methods
        function obj = PBUSH(PID,opts)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                PID {mustBeGreaterThan(PID,0)}
                opts.K {mni.printing.cards.mustBeEmptyOrLength(opts.K,6)} = []
                opts.B {mni.printing.cards.mustBeEmptyOrLength(opts.B,6)} = []
                opts.GE {mni.printing.cards.mustBeEmptyOrLength(opts.GE,6)} = []
                opts.RCV {mni.printing.cards.mustBeEmptyOrLength(opts.RCV,4)} = []
                opts.M {mni.printing.cards.mustBeEmptyOrLength(opts.M,1)} = []
            end
            
            obj.Name = 'PBUSH';
            obj.PID = PID;
            obj.K = opts.K;
            obj.B = opts.B;
            obj.GE = opts.GE;
            obj.RCV = opts.RCV;
            obj.M = opts.M;
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
            data = [{obj.PID}];
            format = 'i';
            if ~isempty(obj.K)
                data = [data,{'K'}];
                format = [format,'s'];
                for i = 1:length(obj.K)
                    if obj.K(i) == 0
                        format = [format,'b'];
                    else
                        data = [data,{obj.K(i)}];
                        format = [format,'f'];
                    end
                end
                format = [format,'b'];
            end
            if ~isempty(obj.B)
                data = [data,{'B'}];
                format = [format,'s'];
                for i = 1:length(obj.B)
                    if obj.B(i) == 0
                        format = [format,'b'];
                    else
                        data = [data,{obj.B(i)}];
                        format = [format,'f'];
                    end
                end
                format = [format,'b'];
            end
            if ~isempty(obj.GE)
                data = [data,{'GE'}];
                format = [format,'s'];
                for i = 1:length(obj.GE)
                    if obj.GE(i) == 0
                        format = [format,'b'];
                    else
                        data = [data,{obj.GE(i)}];
                        format = [format,'f'];
                    end
                end
                format = [format,'b'];
            end
            if ~isempty(obj.RCV)
                data = [data,{'RCV'}];
                format = [format,'s'];
                for i = 1:length(obj.RCV)
                    if obj.RCV(i) == 0
                        format = [format,'b'];
                    else
                        data = [data,{obj.RCV(i)}];
                        format = [format,'f'];
                    end
                    format = [format,'f'];
                end
                format = [format,'nb'];
            end
            if ~isempty(obj.M)
                data = [data,{'M'},{obj.M}];
                format = [format,'sf'];
            end
            if endsWith(format,'b')
                format = format(1:end-1);
            end
            
            obj.fprint_nas(fid,format,data);
        end
    end
end

