//A Hypercube from any angle.

/* Method 1 */
//Angle in xy-plane
a1 = 0;//[0:360]

//Angle from xy-plane
a2 = 0;//[-89:89]

//angle from xyz-space
a3 = 0;//[-89:89]

//distance of view point from the center
view_radius = 25;//[5:400]

//of an edge 
min_thickness = 1;//[1:0.2:5]

//of an edge 
max_thickness = 5;//[1:0.2:10]

// of circumhypersphere 
Radius = 20;//[5:100]

plot_points = 30;//[30:100]

/*  Hidden */

//The bone module generates a vertical cylinder that is capped by sphere.
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

 Hcube_verts = [project(Radius/2*[1,1,1,1],v,XB,YB,ZB),
                project(Radius/2*[-1,1,1,1],v,XB,YB,ZB),
                project(Radius/2*[1,-1,1,1],v,XB,YB,ZB),
                project(Radius/2*[1,1,-1,1],v,XB,YB,ZB),
                project(Radius/2*[1,1,1,-1],v,XB,YB,ZB),
                project(Radius/2*[-1,-1,1,1],v,XB,YB,ZB),
                project(Radius/2*[-1,1,-1,1],v,XB,YB,ZB),
                project(Radius/2*[-1,1,1,-1],v,XB,YB,ZB),
                project(Radius/2*[1,-1,-1,1],v,XB,YB,ZB),
                project(Radius/2*[1,-1,1,-1],v,XB,YB,ZB),
                project(Radius/2*[1,1,-1,-1],v,XB,YB,ZB),
                project(Radius/2*[-1,-1,-1,1],v,XB,YB,ZB),
                project(Radius/2*[-1,-1,1,-1],v,XB,YB,ZB),
                project(Radius/2*[-1,1,-1,-1],v,XB,YB,ZB),
                project(Radius/2*[1,-1,-1,-1],v,XB,YB,ZB),
                project(Radius/2*[-1,-1,-1,-1],v,XB,YB,ZB)];
 
 Hcube_dists = [norm(v-Radius/2*[1,1,1,1]),
                norm(v-Radius/2*[-1,1,1,1]),
                norm(v-Radius/2*[1,-1,1,1]),
                norm(v-Radius/2*[1,1,-1,1]),
                norm(v-Radius/2*[1,1,1,-1]),
                norm(v-Radius/2*[-1,-1,1,1]),
                norm(v-Radius/2*[-1,1,-1,1]),
                norm(v-Radius/2*[-1,1,1,-1]),
                norm(v-Radius/2*[1,-1,-1,1]),
                norm(v-Radius/2*[1,-1,1,-1]),
                norm(v-Radius/2*[1,1,-1,-1]),
                norm(v-Radius/2*[-1,-1,-1,1]),
                norm(v-Radius/2*[-1,-1,1,-1]),
                norm(v-Radius/2*[-1,1,-1,-1]),
                norm(v-Radius/2*[1,-1,-1,-1]),
                norm(v-Radius/2*[-1,-1,-1,-1])];
 
 Hcube_edges = [[0,1],[0,2],[0,3],[0,4],
                [1,5],[1,6],[1,7],
                [2,5],[2,8],[2,9],
                [3,6],[3,8],[3,10],
                [4,7],[4,9],[4,10],
                [5,11],[5,12],[6,11],[6,13],
                [7,12],[7,13],[8,11],[8,14],
                [9,12],[9,14],[10,13],[10,14],
                [11,15],[12,15],[13,15],[14,15]];
 
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