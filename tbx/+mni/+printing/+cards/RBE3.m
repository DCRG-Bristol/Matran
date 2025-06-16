classdef RBE3 < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        EID;
        REFGRID;
        REFC;
        WTi;
        Ci;
        Gij;
        UM;
        GMi;
        CMi;
        Alpha;
    end
    
    methods
        function obj = RBE3(EID,REFGRID,REFC,WTi,Ci,Gij,varargin)
            %GRID_CARD Construct an instance of this class
            %   Detailed explanation goes here
            p = inputParser();
            p.addRequired('EID',@(x)x>0)
            p.addRequired('REFGRID')
            p.addRequired('REFC')
            p.addRequired('WTi')
            p.addRequired('Ci')
            p.addRequired('Gij')
            p.addParameter('UM','')
            p.addParameter('GMi',[],@(x)~any(x<=0))
            p.addParameter('CMi',[],@(x)~any(x<=0))
            p.addParameter('Alpha',[])
            p.parse(EID,REFGRID,REFC,WTi,Ci,Gij,varargin{:})
            
            obj.Name = 'RBE3';
            obj.EID     = p.Results.EID;
            obj.REFGRID = p.Results.REFGRID;
            obj.REFC    = p.Results.REFC;
            obj.WTi     = p.Results.WTi;
            obj.Ci      = p.Results.Ci;
            obj.Gij     = p.Results.Gij;
            obj.UM      = p.Results.UM;
            obj.GMi     = p.Results.GMi;
            obj.CMi     = p.Results.CMi;
            obj.Alpha   = p.Results.Alpha;

            % obj.EID = p.Results.EID;
            % obj.GN = p.Results.GN;
            % obj.CM = p.Results.CM;
            % obj.GMi = p.Results.GMi;
            % obj.Alpha = p.Results.Alpha;           
        end
        
        function writeToFile(obj,fid,varargin)
            %writeToFile print DMI entry to file
            writeToFile@mni.printing.cards.BaseCard(obj,fid,varargin{:})
            data = {obj.EID};
            format = 'ib';
            data = [data,{obj.REFGRID.ID},{obj.REFC},{obj.WTi},{obj.Ci}];
             format = [format,'iiri'];
            for i = 1:(length(obj.Gij))
                data = [data,{obj.Gij(i).ID}];
                format = [format,'i'];
            end
            % for j=1:length(obj.Ci)
            % %j=1;
            % data = [data,{obj.REFGRID.ID},{obj.REFC(j)},{obj.WTi(1)}];
            % 
            % for i = 1:(length(obj.WTi)-1)
            %     data = [data,{obj.Gij(i).ID},{obj.Ci(j)},{obj.WTi(i+1)},];
            %     if i==1
            %     format = [format,'iir'];
            %     elseif mod(i,2)==1 && i>1 
            %     format = [format,'biir'];
            %     else
            %     format = [format,'iirb'];
            %     end
            % end
            % 
            % end
            
            % for i = 1:length(obj.Gij)
            %     data = [data,{obj.Gij(i)}];
            %     format = [format,'i'];
            % end
            % data = [data,{obj.UM}];
            % format = [format,'s'];
            % for i = 1:length(obj.GMi)
            %     data = [data,{obj.GMi(i)}];
            %     format = [format,'i'];
            % end
            % for i = 1:length(obj.CMi)
            %     data = [data,{obj.CMi(i)}];
            %     format = [format,'i'];
            % end
            % data = [data,{obj.Alpha}];
            % format = [format,'r'];
            % 
            obj.fprint_nas(fid,format,data);
        end
    end
end

