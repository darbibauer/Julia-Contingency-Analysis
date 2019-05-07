test=0
load ('1.mat');
A = ones(Sz.r(grid.E),Sz.r(grid.E));

for i= 1 : Sz.r(grid.E)
    A(grid.E(i,1),grid.E(i,2))=0;
    A(grid.E(i,2),grid.E(i,1))=0;
end

world=A;
obstacleMap =world;
[obsx,obsy] = find(world == 1);
numObsSpaces=numel(obsy);
[freespacex,freespacey] = find(world == 0);
numFreeSpaces = numel(freespacey);

%initialize probabilities
belief = zeros(size(world)); 
belief = belief/sum(sum(belief));
probs = ones(numFreeSpaces,1)/numFreeSpaces; %uniformly distributed
for i11 = 1:numFreeSpaces
    belief(freespacex(i11),freespacey(i11)) = probs(i11);
end

for i12 = 1:numObsSpaces
    belief(obsx(i12),obsy(i12)) = 0.001;
end

oo1=grid.E(:,1);
oo2=grid.E(:,2);
oo=[oo1,oo2];
beliefoo=length(oo);
%beliefnum=numel(beliefbb);
rand1= randperm(beliefoo,1);
observation=grid.E(rand1,:);

index_x=0;
index_y=0;

max_W=max(W(:));
[index_x,index_y]=find(W==max_W);

initial=[10 13];
initialinitial=observation;

contingencyc1=[grid.E(index_x,1),grid.E(index_x,2)];
contingencyc2=[grid.E(index_y,1),grid.E(index_y,2)];

R= zeros(Sz.r(grid.E),Sz.r(grid.E));
R = min(R,-50);

for i= 1 : Sz.r(grid.E)
    
    R(grid.E(i,2),grid.E(i,1))=1;
    R(grid.E(i,1),grid.E(i,2))=1;
end 

R(grid.E(index_x,1),grid.E(index_x,2))=100;
R(grid.E(index_x,2),grid.E(index_x,1))=100;
R(grid.E(index_y,1),grid.E(index_y,2))=100;
R(grid.E(index_y,2),grid.E(index_y,1))=100;


pathnumber=zeros(size(world));
pay_off=zeros(size(world));  
    
 while initial~=contingencyc1
     
     
    possiblemovementx1 = find(grid.E(:,1) == initial(:,1));
    possiblemovementy1 = find(grid.E(:,2) == initial(:,1)); 
    possiblemovementx2 = find(grid.E(:,1) == initial(:,2));
    possiblemovementy2 = find(grid.E(:,2) == initial(:,2)); 
    possiblemovementx=cat(1,possiblemovementx1,possiblemovementy1);
    possiblemovementy=cat(1,possiblemovementx2,possiblemovementy2);
    possiblemovementxy = setxor(possiblemovementx,possiblemovementy);
    
    
       for i=1:length(possiblemovementxy)             
       x(i,:)= grid.E(possiblemovementxy(i),:);
       curpos= [x(i,1),x(i,2)];
       
    possiblemovementx3 = find(grid.E(:,1) == curpos(1));
    possiblemovementy3 = find(grid.E(:,2) == curpos(1)); 
    possiblemovementx4 = find(grid.E(:,1) == curpos(2));
    possiblemovementy4 = find(grid.E(:,2) == curpos(2)); 
    nextpossiblemovementx=cat(1,possiblemovementx3,possiblemovementy3);
    nextpossiblemovementy=cat(1,possiblemovementx4,possiblemovementy4);
    nextpossiblemovementxy = setxor(nextpossiblemovementx,nextpossiblemovementy);
    nextconnection=length(nextpossiblemovementxy) ; 
   
       oldProb = belief(curpos(1),curpos(2));
      % newProb = oldProb* nextconnection;
       belief(curpos(1),curpos(2)) = newProb;
       normalizer = 1/sum(sum(belief));
       newBelief = belief*normalizer;
       belief=newBelief;
       px = belief(curpos(1),curpos(2));
       newBelief(curpos(1),curpos(2)) = px +newBelief(curpos(1),curpos(2));

          
       end
       
              [m,n]= find(newBelief==max(newBelief(:)));
               rand= randperm(length(m),1);
               initial = [m(rand), n(rand)];
               initial =[m(1),n(1)]
           

 end
 
 
 

  
     
  
  