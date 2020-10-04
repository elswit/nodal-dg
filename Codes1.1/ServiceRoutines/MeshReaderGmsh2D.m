function [Nv, VX, VY, K, EToV, BCType] = MeshReaderGmsh2D(FileName)

% function [Nv, VX, VY, K, EToV, BCType] = MeshReaderGmsh2D(FileName)
% Purpose  : Read in basic grid information to build grid
% NOTE     : GMESH *.msh format is assumed

Globals2D;

Fid = fopen(FileName, 'rt');
% read intro
line = '';

while ~strcmp(line,'$Nodes')
  line = fgetl(Fid);
end
line = fgetl(Fid);


% Find number of nodes and number of elements
Nv = sscanf(line, '%d');
%K = dims(2);

% read node coordinates
VX = 0*(1:Nv); VY = 0*(1:Nv);
VToBCType = 0*(1:Nv);

for i = 1:Nv
  line = fgetl(Fid);
  tmpx = sscanf(line, '%lf');
  idx  = tmpx(1);
  VX(idx) = tmpx(2); VY(idx) = tmpx(3);
end

while ~strcmp(line,'$Elements')
  line = fgetl(Fid);
end
line = fgetl(Fid);

K = sscanf(line, '%d');

% read element to node connectivity
EToV = [];
for k = 1:K
  line   = fgetl(Fid);
  tmpcon = sscanf(line, '%lf');
  if tmpcon(2) == 1
      bctype = tmpcon(4); 
      vertices = tmpcon(6:7);
      VToBCType(vertices) = bctype;
  elseif tmpcon(2) == 2
      EToV(end+1,:) = [tmpcon(6:8)];
  end
end
K = size(EToV,1);

% boundary codes (defined in Globals2D)
VToBCType(VToBCType==111) = In;
VToBCType(VToBCType==222) = Out;
VToBCType(VToBCType==333) = Wall;

BCType = zeros(K,3);

for e = 1:K
    
    BCType(e,:) = VToBCType(EToV(e,:));
end
    
% Close file
st = fclose(Fid);
return
