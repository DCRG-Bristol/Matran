classdef NLPARM < mni.printing.cards.BaseCard
    %NLPARM Defines a set of parameters for the nonlinear iteration strategy
    % Used by SOL 106 / SOL 129 / SOL 400 and referenced from case control
    % with 'NLPARM = ID' (inside a STEP for SOL 400).
    %
    % Field layout (MSC Nastran QRG):
    %   1       2       3       4       5       6       7       8       9
    %   NLPARM  ID      NINC    DT      KMETHOD KSTEP   MAXITER CONV    INTOUT
    %           EPSU    EPSP    EPSW    MAXDIV  MAXQN   MAXLS   FSTRESS LSTOL
    %           MAXBIS                                  MAXR            RTOLB
    %
    % The second and third continuation lines are only written when at least
    % one of their fields has been supplied, so an NLPARM built with just an
    % ID prints a single line and every other parameter takes its Nastran
    % default.

    properties
        ID;
        NINC;
        DT;
        KMETHOD;
        KSTEP;
        MAXITER;
        CONV;
        INTOUT;
        EPSU;
        EPSP;
        EPSW;
        MAXDIV;
        MAXQN;
        MAXLS;
        FSTRESS;
        LSTOL;
        MAXBIS;
        MAXR;
        RTOLB;
    end

    methods
        function obj = NLPARM(ID,opts)
            %NLPARM Construct an NLPARM card
            % required input is the set ID, everything else is optional and
            % defaults to blank (i.e. the Nastran default).
            %
            % see the MSC Nastran Quick Reference Guide for the meaning of
            % each parameter.
            arguments
                ID {mustBePositive}
                opts.NINC {validateEmptyPositive(opts.NINC)} = [];
                opts.DT = [];
                opts.KMETHOD {validateEmptyMember(opts.KMETHOD,...
                    ["AUTO","ITER","SEMI","PFNT","FNT","AUTOQN","ITERQN"])} = [];
                opts.KSTEP {validateEmptyPositive(opts.KSTEP)} = [];
                opts.MAXITER = [];
                opts.CONV {validateEmptyMember(opts.CONV,...
                    ["U","P","W","UP","UW","PW","UPW"])} = [];
                opts.INTOUT {validateEmptyMember(opts.INTOUT,["YES","NO","ALL"])} = [];
                opts.EPSU = [];
                opts.EPSP = [];
                opts.EPSW = [];
                opts.MAXDIV = [];
                opts.MAXQN = [];
                opts.MAXLS = [];
                opts.FSTRESS = [];
                opts.LSTOL = [];
                opts.MAXBIS = [];
                opts.MAXR = [];
                opts.RTOLB = [];
            end
            obj.Name = 'NLPARM';
            obj.ID = ID;
            for prop = string(fieldnames(opts))'
                obj.(prop) = opts.(prop);
            end
        end

        function writeToFile(obj,fid,varargin)
            %writeToFile print the NLPARM entry to file
            writeToFile@mni.printing.cards.BaseCard(obj,fid,varargin{:})

            line1 = [{obj.ID},{obj.NINC},{obj.DT},{char2blank(obj.KMETHOD)},...
                {obj.KSTEP},{obj.MAXITER},{char2blank(obj.CONV)},{char2blank(obj.INTOUT)}];
            line2 = [{obj.EPSU},{obj.EPSP},{obj.EPSW},{obj.MAXDIV},...
                {obj.MAXQN},{obj.MAXLS},{obj.FSTRESS},{obj.LSTOL}];
            line3 = [{obj.MAXBIS},{obj.MAXR},{obj.RTOLB}];

            data = line1;
            format = 'iirsiiss';
            % only continue onto the extra lines if they carry information
            if isSet(line2) || isSet(line3)
                data = [data,line2];
                format = [format,'rrriiirr'];
            end
            if isSet(line3)
                data = [data,line3];
                format = [format,'ibbbbrbr'];
            end
            obj.fprint_nas(fid,format,data);
        end
    end
end
function validateEmptyPositive(x)
assert(isempty(x) || x>0)
end
function validateEmptyMember(x,valid)
assert(isempty(x) || ismember(upper(string(x)),valid),...
    "value must be one of: %s",strjoin(valid,", "))
end
function val = char2blank(val)
% normalise strings to char so they print through the 's' format spec
if isempty(val)
    val = [];
else
    val = char(upper(string(val)));
end
end
function tf = isSet(c)
% true if any entry of the cell array holds a usable value
tf = any(cellfun(@(v)~isempty(v) && ~(isnumeric(v) && all(isnan(v))),c));
end
