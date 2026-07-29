function varargout = import_matran(filename, options)
%import_matran Entry point function for importing data into the Matran
%framework.
%
% Syntax:
%   - Importing Matran data using 'uigetfile' to select file.
%       >> MatranData = import_matran();
%
%   - Importing Matran data using 'uigetfile' and using parameters
%       >> MatranData = import_matran("", 'Param1', val1, ...)
%
%	- Importing a FE model from text file (.bdf, .dat)
%       >> FEM = import_matran('models/uob_harw_R.bdf')
%
%   - Importing a FE model from a MSC.Nastran HDF5 file (.h5)
%       >> FEM = import_matran()
%
%   - Importing data and suppressing output to log
%       >> FEM = import_matran(..., 'Verbose', false);
%
%   - Importing data and providing a custom log function
%       >> fid = fopen('import_diary.txt', 'w');
%       >> log_fcn = @(str, bNewLine, bLiteral) fprintf(fid, '%s', str)
%       >> FEM = import_matran(..., 'LogFcn', log_fcn);
%
% Detailed Description:
%	- The import function is selected based on the extension of the file.
%
% See also: 
%
% References:
%	[1]. 
%
% Author    : Christopher Szczyglowski
% Email     : chris.szczyglowski@gmail.com
% Timestamp : 29-Apr-2020 20:46:17
%
% Copyright (c) 2020 Christopher Szczyglowski
% All Rights Reserved
%
%
% Revision: 1.0 29-Apr-2020 20:46:17
%	- Initial function:
%
% <end_of_pre_formatted_H1>
%
% TODO - Add .pch output reading
% TODO - Add .f06 output reading
% TODO - Add .op2 output reading

arguments
    filename string = ""
    options.LogFcn (1, 1) function_handle = @logger
    options.Verbose (1, 1) logical = true
    options.ImportMode = 'both'
end

varargout = {[]};

prmpt = 'Select a file to import';
file_filter = {'*.dat;*.bdf;*.pch;*.h5', 'Supported files (*.dat, *.bdf, *.pch, *.h5)'};

if strlength(filename) == 0
    [filename_, filepath] = uigetfile(file_filter, prmpt);
    if isnumeric(filename_) && isnumeric(filepath)
        return
    end
    filename = string(fullfile(filepath, filename_));
end

[~, ~, ext] = fileparts(filename);
ext = lower(char(ext));
switch lower(ext)
    case {'.dat', '.bdf', '.pch'}
        import_fcn = @importBulkData;
    case '.h5'
        import_fcn = @importH5;
    otherwise
        error('Unsupported file extension: ''%s''.', ext);
end

if options.Verbose
    log_fcn = options.LogFcn;
else
    log_fcn = @(varargin) []; %dummy function
end

%Construct additional arguments to be passed straight to import method
args = {'ImportMode', options.ImportMode};
filename = char(filename);

%Import the data
[MatranData, Meta] = import_fcn(filename, log_fcn, args{:});

%Do post-import actions
idxModel = arrayfun(@(o) isa(o, 'mni.bulk.FEModel'), MatranData);
if any(idxModel)
    FEModel = MatranData(idxModel);
    %Print summary
    printSummary(FEModel, 'LogFcn', log_fcn, 'RootFile', filename);
    if isempty(Meta.SkippedBulk)
        log_fcn('All bulk data entries were successfully extracted!');
    else
        log_fcn(sprintf(['The following cards have not been extracted ', ...
            'from the file ''%s'':\n\n\t%-s\n'], filename, ...
            sprintf('%s\n\t', Meta.SkippedBulk{:})));
    end
    %Make indices between bulk data objects
    makeIndices(FEModel);
end
idxRes = arrayfun(@(o) isa(o, 'mni.result.ResultSet'), MatranData);
if any(idxRes) && any(idxModel)
    Results = MatranData(idxRes);
    Results.processResultsData(FEModel);
end

varargout{1} = MatranData;

end

