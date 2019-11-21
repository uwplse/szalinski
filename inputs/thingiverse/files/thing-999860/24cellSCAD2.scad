//A 24-cell from any angle.


//Angle in xy-plane
a1 = 0;//[0:360]

//Angle from xy-plane
a2 = 0;//[-89:89]

//angle from xyz-space
a3 = 0;//[-89:89]

//distance of view point from the center
view_radius = 55;//[5:400]

//of an edge 
min_thickness = 1;//[1:0.2:5]

//of an edge 
max_thickness = 10;//[1:0.2:10]

// of circumhypersphere 
Radius = 50;//[5:100]

plot_points = 20;//[20:100]

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

 Hcube_verts = [project(Radius/sqrt(2)*[1,1,0,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[1,-1,0,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[1,0,1,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[1,0,-1,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[1,0,0,1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[1,0,0,-1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[-1,1,0,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[-1,-1,0,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[-1,0,1,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[-1,0,-1,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[-1,0,0,1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[-1,0,0,-1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,1,1,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,1,-1,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,1,0,1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,1,0,-1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,-1,1,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,-1,-1,0],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,-1,0,1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,-1,0,-1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,0,1,1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,0,1,-1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,0,-1,1],v,XB,YB,ZB),
                project(Radius/sqrt(2)*[0,0,-1,-1],v,XB,YB,ZB)];
 
 Hcube_dists = [norm(v-Radius/sqrt(2)*[1,1,0,0]),
                norm(v-Radius/sqrt(2)*[1,-1,0,0]),
                norm(v-Radius/sqrt(2)*[1,0,1,0]),
                norm(v-Radius/sqrt(2)*[1,0,-1,0]),
                norm(v-Radius/sqrt(2)*[1,0,0,1]),
                norm(v-Radius/sqrt(2)*[1,0,0,-1]),
                norm(v-Radius/sqrt(2)*[-1,1,0,0]),
                norm(v-Radius/sqrt(2)*[-1,-1,0,0]),
                norm(v-Radius/sqrt(2)*[-1,0,1,0]),
                norm(v-Radius/sqrt(2)*[-1,0,-1,0]),
                norm(v-Radius/sqrt(2)*[-1,0,0,1]),
                norm(v-Radius/sqrt(2)*[-1,0,0,-1]),
                norm(v-Radius/sqrt(2)*[0,1,1,0]),
                norm(v-Radius/sqrt(2)*[0,1,-1,0]),
                norm(v-Radius/sqrt(2)*[0,1,0,1]),
                norm(v-Radius/sqrt(2)*[0,1,0,-1]),
                norm(v-Radius/sqrt(2)*[0,-1,1,0]),
                norm(v-Radius/sqrt(2)*[0,-1,-1,0]),
                norm(v-Radius/sqrt(2)*[0,-1,0,1]),
                norm(v-Radius/sqrt(2)*[0,-1,0,-1]),
                norm(v-Radius/sqrt(2)*[0,0,1,1]),
                norm(v-Radius/sqrt(2)*[0,0,1,-1]),
                norm(v-Radius/sqrt(2)*[0,0,-1,1]),
                norm(v-Radius/sqrt(2)*[0,0,-1,-1])];
               
 Hcube_edges = [[0,2],[0,3],[0,4],[0,5],//1
                [1,2],[1,3],[1,4],[1,5],
                [2,4],[2,5],[3,4],[3,5],
                [6,8],[6,9],[6,10],[6,11],//2
                [7,8],[7,9],[7,10],[7,11],
                [8,10],[8,11],[9,10],[9,11],
                [0,12],[0,13],[0,14],[0,15],//3
                [6,12],[6,13],[6,14],[6,15],
                [12,14],[12,15],[13,14],[13,15],
                [1,16],[1,17],[1,18],[1,19],//4
                [7,16],[7,17],[7,18],[7,19],
                [16,18],[16,19],[17,18],[17,19],
                [2,12],[2,16],[2,20],[2,21],//5
                [8,12],[8,16],[8,20],[8,21],
                [12,20],[12,21],[16,20],[16,21],
                [3,13],[3,17],[3,22],[3,23],//6
                [9,13],[9,17],[9,22],[9,23],
                [13,22],[13,23],[17,22],[17,23],
                [4,14],[4,18],[4,20],[4,22],//7
                [10,14],[10,18],[10,20],[10,22],
                [14,20],[14,22],[18,20],[18,22],
                [5,15],[5,19],[5,21],[5,23],//9
                [11,15],[11,19],[11,21],[11,23],
                [15,21],[15,23],[19,21],[19,23]
                ];
 
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