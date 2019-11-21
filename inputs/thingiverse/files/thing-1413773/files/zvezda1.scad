k=5;//[3:1:20]
alpha=360/k;
high=30;//[1:1:100]
r1=50;//[1:1:100]
r2=100;//[1:1:100]
for (i=[0:alpha:360]){
rotate(a=i,v=[0,0,1]){
polyhedron(
points=[[0,0,0],[0,0,high],[r1*cos(alpha),r1*sin(alpha),0],[r2,0,0],[r1*cos(alpha),-r1*sin(alpha),0]],
faces=[[0,1,4],[0,2,1],[1,3,4],[1,2,3],[0,4,2],[4,3,2]]
);
  }
    }