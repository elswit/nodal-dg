clear;
% Driver script for solving the 2D Euler equations
Globals2D;

% Order of polynomials used for approximation 
N = 3;

% Read in Mesh
sim = 'IsentropicVortex';
switch sim
case {'IsentropicVortex'}
  filename = 'vortexA04.neu';
  filename = 'VortexSmall.msh';
  InitialSolution = @IsentropicVortexIC2D;
  ExactSolution   = @IsentropicVortexIC2D;
  BCSolution      = @IsentropicVortexBC2D;
case {'ChannelFlow'}
  filename = 'Euler01.neu';
  filename= 'FStep.msh';
  InitialSolution = @ChannelIC2D;
  ExactSolution   = [];
  BCSolution      = @ChannelBC2D;
otherwise 
  disp('Simulation case unknown');  stop;
end

% read mesh from file
%[Nv, VX, VY, K, EToV, BCType] = MeshReaderGambitBC2D(filename);

[Nv, VX, VY, K, EToV, BCType] = MeshReaderGmsh2D(filename);

% set up nodes and basic operations
StartUp2D;



% compute initial condition
Q0 = InitialSolution(x, y, 0);

% Solve Problem
FinalTime = 2  ;

setupODE45


refsol = ode45(rhs, tspan, y0, odeset('AbsTol', 1e-13, 'RelTol', 1e-13));

numericalSolRho = reshape(refsol.y(:,end), nnodes, nelements, nfields);
numericalSolRho = numericalSolRho(:,:,1);
save refsol.mat numericalSolRho
% load refsol.mat

% [solQ, ~] = Euler2DFixedStep(Q0, FinalTime, BCSolution, 10000); 
% numericalSolRho =  solQ(:,:,1,end);


refQ = ExactSolution(x,y,FinalTime);
refSolRho = refQ(:,:,1);

%%
err2=[]; err=[];
stepRange = round(linspace(100,500,8))

for idx=1:length(stepRange) 
    [solQ, ~] = Euler2DFixedStep(Q0, FinalTime, ...
        BCSolution, stepRange(idx));
    
    solRho =  solQ(:,:,1,end);
    
    err(idx) = norm(solRho - refSolRho)/norm(refSolRho)
    err2(idx) = norm(solRho - numericalSolRho)/norm(numericalSolRho)
end

figure()
polyfit(log10(stepRange),log10(err2),1)
loglog(stepRange, err2 ,'bo-','MarkerSize',8, 'markerfacecolor','b')
shg

% 
% save refsol.mat  err2 err stepRange solRho  ...
%     refSolRho numericalSolRho N FinalTime 
