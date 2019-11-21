//An octahedron 

// of each edge
radius = 3;//[1:10]

// of circumsphere 
Radius = 50;//[5:100]

plot_points = 50;//[30:100]

//The bone module generates a vertical cylinder that is capped by spheres
module bone(rad,height,fn){
union(){
cylinder(r=rad,h=height,$fn=fn);
translate([0,0,height])
       sphere(r=rad,center=true,$fn=fn);
sphere(r=rad,center=true,$fn=fn);}
 }      
 
 // The edge module defines a bone from point p1 to point p2
 module edge(p1,p2,rad,fn){
     translate(p1)
     rotate(acos(([0,0,1]*(p2-p1))/norm(p2-p1)),cross([0,0,1],p2-p1))
     bone(rad,norm(p2-p1),fn);
 }
 

 
 octa_verts = [[1,0,0],[-1,0,0],[0,1,0],[0,-1,0],[0,0,1],[0,0,-1]];
 
 octa_edges = [[0,2],[0,3],[0,4],[0,5],
          [1,2],[1,3],[1,4],[1,5],
          [2,4],[2,5],[3,4],[3,5]];

module polytope(verts,edges,size,rad,plot_points){      
 for(i=[0:len(edges)-1]){
     edge(size*verts[edges[i][0]],size*verts[edges[i][1]],rad,plot_points);}
 }
 
 polytope(octa_verts,octa_edges,Radius,radius,plot_points);
 
 //programmed by Will Webber 2015