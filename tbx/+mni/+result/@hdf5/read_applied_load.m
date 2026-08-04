function [res] = read_applied_load(obj)
%READ_APPLIED_LOAD Reads the applied load vector (OLOAD) from the .h5 file
% requires 'OLOAD = ALL' (or a SET) in the case control of the solution.
% ======================================================================= %

% get the applied load vector
meta = h5read(obj.filepath,'/INDEX/NASTRAN/RESULT/NODAL/APPLIED_LOAD');
load = h5read(obj.filepath,'/NASTRAN/RESULT/NODAL/APPLIED_LOAD');
%convert to familar format
res = struct();
for i = 1:length(meta.DOMAIN_ID)
    idx = load.DOMAIN_ID == meta.DOMAIN_ID(i);
    res(i).GID =  load.ID(idx);       %   grid point IDs
    res(i).X =    load.X(idx);   %
    res(i).Y =    load.Y(idx);   %   forces in XYZ
    res(i).Z =    load.Z(idx);   %
    res(i).RX =   load.RX(idx); %
    res(i).RY =   load.RY(idx); %   moments in XYZ
    res(i).RZ =   load.RZ(idx); %
end
end
