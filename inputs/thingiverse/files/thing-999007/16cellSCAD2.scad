//A 16-cell from any angle.


//Angle in xy-plane
a1 = 1;//[0:360]

//Angle from xy-plane
a2 = 1;//[-89:89]

//angle from xyz-space
a3 = 1;//[-89:89]

//distance of view point from the center
view_radius = 60;//[5:400]

//of an edge 
min_thickness = 1;//[1:0.2:5]

//of an edge 
max_thickness = 5;//[1:0.2:10]

// of circumhypersphere 
Radius = 50;//[5:100]

plot_points = 30;//[30:100]

//The bone module generates a vertical cylinder that is capped by spheres
module bone2(rad1,rad2,height,fn){
hull(){
translate([0,0,height])
       sphere(r=rad2,center=true,$fn=fn);
sphere(r=rad1,center=true,$fn=fn);
  }  }     
 
 // The edge module defines a bone from point p1 to point p2
 module edge2(p1,p2,rad1,rad2,fn){
     translate(p1)
     rotate(acos(([0,0,1]*(p2-p1))/norm(p2-p1)),
         (pow((p2-p1)[0],2)+pow((p2-p1)[1],2)==0 &&(p2-p1)[2]<0)?
            [1,0,0]: cross([0,0,1],p2-p1))
     bone2(rad1,rad2,norm(p2-p1),fn);
 }
 
// Polytope draws all the edges. 
module polytope2(verts,edges,dists,minrad,maxrad,plot_points){      
 for(i=[0:len(edges)-1]){
     edge2(verts[edges[i][0]],verts[edges[i][1]],
            minrad+(maxrad-minrad)*pow(1.05,-1*dists[edges[i][0]]),
            minrad+(maxrad-minrad)*pow(1.05,-1*dists[edges[i][1]]),
     plot_points);}
 }
 
v=[view_radius*cos(a1)*cos(a2)*cos(a3),
   view_radius*sin(a1)*cos(a2)*cos(a3),
   view_radius*sin(a2)*cos(a3),
   view_radius*sin(a3)];
   
//XB YB ZB are an orthonormal basis for the space that we project onto. 
XB = triplecross([0,0,1,0],[0,0,0,1],v)/norm(triplecross([0,0,1,0],[0,0,0,1],v));

YB = triplecross([0,0,0,1],v,XB)/norm(triplecross([0,0,0,1],v,XB));

ZB = triplecross(v,XB,YB)/norm(triplecross(v,XB,YB));

 Hcube_verts = [project(Radius*[1,0,0,0],v,XB,YB,ZB),
                project(Radius*[-1,0,0,0],v,XB,YB,ZB),
                project(Radius*[0,1,0,0],v,XB,YB,ZB),
                project(Radius*[0,-1,0,0],v,XB,YB,ZB),
                project(Radius*[0,0,1,0],v,XB,YB,ZB),
                project(Radius*[0,0,-1,0],v,XB,YB,ZB),
                project(Radius*[0,0,0,1],v,XB,YB,ZB),
                project(Radius*[0,0,0,-1],v,XB,YB,ZB)];
 
 Hcube_dists = [norm(v-Radius*[1,0,0,0]),
                norm(v-Radius*[-1,0,0,0]),
                norm(v-Radius*[0,1,0,0]),
                norm(v-Radius*[0,-1,0,0]),
                norm(v-Radius*[0,0,1,0]),
                norm(v-Radius*[0,0,-1,0]),
                norm(v-Radius*[0,0,0,1]),
                norm(v-Radius*[0,0,0,-1])];
 
 Hcube_edges = [[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],
                [1,2],[1,3],[1,4],[1,5],[1,6],[1,7],
                [2,4],[2,5],[2,6],[2,7],
                [3,4],[3,5],[3,6],[3,7],
                [4,6],[4,7],[5,6],[5,7]];
 
// The cross product in 4D
function triplecross(v1,v2,v3) = 
         [v1[1]*(v2[2]*v3[3]-v2[3]*v3[2])
         -v1[2]*(v2[3]*v3[1]-v2[1]*v3[3])
         +v1[3]*(v2[1]*v3[2]-v2[2]*v3[1]),
             -v1[0]*(v2[2]*v3[3]-v2[3]*v3[2])
             +v1[2]*(v2[3]*v3[0]-v2[0]*v3[3])
             -v1[3]*(v2[0]*v3[2]-v2[2]*v3[0]),
                   v1[0]*(v2[1]*v3[3]-v2[3]*v3[1])
                  -v1[1]*(v2[3]*v3[0]-v2[0]*v3[3])
                  +v1[3]*(v2[0]*v3[1]-v2[1]*v3[0]),
                       -v1[0]*(v2[1]*v3[2]-v2[2]*v3[1])
                       +v1[1]*(v2[2]*v3[0]-v2[0]*v3[2])
                       -v1[2]*(v2[0]*v3[1]-v2[1]*v3[0])];

//Convert the 4D shadow to 3D coordinates                    
function project(p,V,xb,yb,zb,) = 
    [xb*shadow(p,V),yb*shadow(p,V),zb*shadow(p,V)];

// In 4D this calculates the point on the shadow or point p viewed from V
function shadow(p,V)=
    V-((V*V)/((p-V)*V)*(p-V));


 polytope2(Hcube_verts,Hcube_edges,Hcube_dists,
                min_thickness,max_thickness,plot_points);
 
 
 //programmed by Will Webber 2015