function C = two_d_forward(Cinit,T,S)
dt = 0.002; t = 0:dt:T; Nt = length(t);
dx = 0.25;x = dx/2:dx:20-dx/2;Nx = length(x);
dy = 0.25;y = dy/2:dy:10-dy/2;Ny = length(y);
v = [-2.5,0];
D = [0.5;0.5];

%% Lagrangian 
C = zeros(Nx,Ny,Nt);
C(:,:,1) = Cinit;
for i = 1:Nt-1
    C(:,:,i+1) = C(:,:,i)+dt/dx*v(1)*(circshift(C(:,:,i),[-1,0])-C(:,:,i))+...
        dt/dy*v(2)*(circshift(C(:,:,i),[0,-1])-C(:,:,i))+...
        dt/dx^2*D(1)*(circshift(C(:,:,i),[-1,0])-2*C(:,:,i)+circshift(C(:,:,i),[1,0]))...
        +dt/dy^2*D(2)*(circshift(C(:,:,i),[0,-1])-2*C(:,:,i)+circshift(C(:,:,i),[0,1]))+dt*S;
    C(1,:,i+1) = C(2,:,i+1);
    C(end,:,i+1) = C(end-1,:,i+1);
    C(:,1,i+1) = C(:,2,i+1);
    C(:,end,i+1) = C(:,end-1,i+1);
end
end