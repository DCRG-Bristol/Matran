classdef TABLED1 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        TID;
        XAXIS;
        YAXIS;
        Xs;
        Ys;
    end
    
    methods
        function obj = TABLED1(TID,Xs,Ys,opts)
            arguments
                TID {mustBeGreaterThan(TID,0)}
                Xs
                Ys
                opts.XAXIS {mni.printing.cards.mustBeEmptyOrMember(opts.XAXIS,{'LINEAR','LOG'})} = []
                opts.YAXIS {mni.printing.cards.mustBeEmptyOrMember(opts.YAXIS,{'LINEAR','LOG'})} = []
            end
            if numel(Xs)~=numel(Ys)
                error('xs and Ys must be the same length')
            end
            assert(numel(Xs)>1)
            assert(numel(Ys)>1)

            obj.TID = TID;
            obj.Xs = Xs;
            obj.Ys = Ys;
            obj.XAXIS = opts.XAXIS;
            obj.YAXIS = opts.YAXIS;
            obj.Name = 'TABLED1';
            
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
            data = [{obj.TID},{obj.XAXIS},{obj.YAXIS}];
            format = 'issn';
            for i = 1:length(obj.Xs)
                data = [data,obj.Xs(i),obj.Ys(i)];
                format = [format,'rr'];
            end
            data = [data,'ENDT'];
            format = [format,'s'];
            obj.fprint_nas(fid,format,data);
        end
    end
end

