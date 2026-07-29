classdef DMI < mni.printing.cards.BaseCard
    %FLUTTER_CARD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        NAME;
        MATRIX;
        FORM;
        TIN;
        TOUT;
    end
    
    methods
        function obj = DMI(NAME,MATRIX,FORM,TIN,TOUT)
            %FLUTTER_CARD Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                NAME char
                MATRIX {mustBeNumeric}
                FORM {mustBeSupportedForm}
                TIN {mustBeSupportedT(TIN,[1,2])}
                TOUT {mustBeSupportedT(TOUT,[0,1,2])}
            end
            
            obj.Name = 'DMI';
            obj.NAME = NAME;
            obj.MATRIX = MATRIX;
            obj.FORM = FORM;
            obj.TIN = TIN;
            obj.TOUT = TOUT;
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
            % write the header card to the file
            data = [{obj.NAME},{0},{obj.FORM},{obj.TIN},{obj.TOUT},...
                {size(obj.MATRIX,1)},{size(obj.MATRIX,2)}];
            format = 'siiiibii';
            obj.fprint_nas(fid,format,data);
            
            % for each column in obj.MATRIX write a corresponding data card
            s = size(obj.MATRIX);
            for j = 1:s(2)
                %write header info
                data = [{obj.NAME},{j}];
                format = 'si';               
                %initilise counters
                i = 1;
                last = 0;
                is_data = 0;
                % only print non-zero data in card
                while i <= s(1)
                    tmp = obj.MATRIX(i,j);
                    if tmp ~= 0
                        if last == 0
                            data = [data,{i},{tmp}];
                            format = [format,'if'];
                            is_data = 1;
                        elseif (last == tmp)
                            % if consecutive terms use THRU simplification
                            data = [data,{'THRU'}];
                            format = [format,'s'];
                            last = tmp;
                            while tmp == last
                                i = i+1;
                                if i > s(1)
                                    break
                                end
                                tmp = obj.MATRIX(i,j);
                            end
                            i = i-1;
                            tmp = 0;
                            data = [data,{i}];
                            format = [format,'i'];
                        else
                            data = [data,{tmp}];
                            format = [format,'f'];
                        end
                    end
                    last = tmp;
                    i = i + 1;
                end
                
                %Write the data to the file
                if is_data
                    obj.fprint_nas(fid,format,data);
                end
            end
        end
    end
end

function mustBeSupportedForm(x)
if ~any([1,2,3] == x)
    error('only matrix forms 1,2,3 are currently supported')
end
end

function mustBeSupportedT(x,vals)
if ~any(vals == x)
    error('only real number forms are currently supported')
end
end

