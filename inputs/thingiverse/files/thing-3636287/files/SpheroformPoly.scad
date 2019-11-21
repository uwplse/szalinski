// Symmetric Spheroform Tetrahedron
// Solid of Constant Width
// single polyhedron

// width of the object to be printed
width = 50;

// scale of negative internal volume
intscale = 0.8;

// Which one would you like to see?
part = "whole"; // [whole:Whole,altwhole:Whole (rotated),half:Half split,hollwhole:Hollow Whole,hollhalf:Hollow Half split,althalfm:Other Half split (male),althalff:Other Half split (female)]

// Number of segments to edges
segs = 48;

// Number of segments to internal edges (for hollow)
isegs = 48;

// Number of teeth +1 (actually gaps between teeth)
teeth = 6;

// Epsilon (for rounding bias
AT = 0.001/1;

// vertices and edge length of Reuleaux Tetrahedron from Wikipedia
v1 = [sqrt(8/9), 0, -1/3]/1;
v2 = [-sqrt(2/9), sqrt(2/3), -1/3]/1;
v3 = [-sqrt(2/9), -sqrt(2/3), -1/3]/1;
v4 = [0, 0, 1]/1;
a = sqrt(8/3); // edge length given by above vertices
k = width / a; // scaling constant to generate desired width from standard vertices

// Helper functions. Plenty of room for simplification (mostly constant calculations).
// cumulative index preserving nested structure - for referring to points
function indx(v,i=0,t=0,r=[])=i<len(v)?indx(v,i+1,t+len(v[i]),concat(r,[[for(j=[0:len(v[i])-1])j+t]])):r;
// Envelope sphere radius and offset
function env(x) = width*(((4*sqrt(2)-8)*x*x+2-sqrt(2))/8);
// vector to sphere sweep center
function vec(v1,v2,i) = k*((0.5+i)*v1+(0.5-i)*v2) + env(i)*(v1+v2)/mod(v1+v2);
// reduce number of vertexes near pointy end, in whole numbers
function rj(i,s) = round(s*env(i/s)/env(0)/4);
// vector modulus
function mod(v) = (sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]));
function cross(u,v) = [u[1]*v[2]-v[1]*u[2],-(u[0]*v[2]-v[0]*u[2]),u[0]*v[1]-v[0]*u[1]];
function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];
function anglev(u,v) = acos( dot(u,v) / (mod(u)*mod(v)) );
// Two vector orientate (v and v2 should be orthogonal)
module orientate(v,v2,vref=[0,0,1],vref2=[0,1,0]){
  raxis = cross(vref,v);
  ang = anglev(vref,v);
  raxis2 = cross(vref2,raxis);
  ang2 = anglev(vref2,raxis);
  raxis3 = cross(raxis,v2);
  ang3 = anglev(raxis,v2);
  rotate(a=ang3, v=raxis3)
    rotate(a=ang, v=raxis)
      rotate(a=ang2, v=raxis2)
        children();
}

// generate the envelope points
function envelope(v1,v2,v3,v4,s) = [for(i=[-s/2:1:s/2])[for(j=[-rj(i,s):1:rj(i,s)])
    vec(v2,v3,i/s)+(vec(v2,v3,i/s)
    -vec(v4,v1,j==0?0:j/2/rj(i,s)))/mod(vec(v4,v1,j==0?0:j/2/rj(i,s))
    -vec(v2,v3,i/s))*env(i/s)
]];
// rescale vector to lie on surface of (major) sphere
function sph(v4,i) = k*v4+width*(i-k*v4)/mod((i-k*v4));
o=[[0,0,0]]/1;
// generate face points (one third segment)
function fac(v1,v2,v3,v4,s) = concat([o],
    [for(j=[s:-2:0])[for(i=[-j:2:j])
        sph(v4,
        j/s*(vec(v2,v3,i==0?0:i/2/j)+
        (vec(v2,v3,i==0?0:i/2/j)-vec(v4,v1,1/2))/
        mod(vec(v4,v1,1/2)-vec(v2,v3,i==0?0:i/2/j))*env(i==0?0:i/2/j)))
    ]],[o]
);

function face(v1,v2,v3,v4,s)=concat(
    fac(v2,v1,v4,v3,s),
    fac(v1,v4,v2,v3,s),
    fac(v4,v2,v1,v3,s)
);

module teeth(v1,v2,v3,v4,s) {
        nub=envelope(v1,v2,v3,v4,s);
        m=(1+intscale)/4*width*(v1+v4); // centre direction (approx). we could use actual envelope opposite points
        for(i=[1:len(nub)-2]){
            c=nub[i][(len(nub[i])-1)/2];
            translate((1+intscale)/2*c)
                orientate(v1-v4,c-m)
                    scale([2,1,1])sphere(d=width*(1-intscale)/4,$fn=6);
        }
}

//complete Symmetric Spheroform Tetrahedron as a single polyhedron
module spheroformTetrahedron(s=segs){
    // generate envelope points using list comprehension
    ip=concat(
        envelope(v1,v3,v2,v4,s),
        envelope(v4,v1,v2,v3,s),
        envelope(v3,v1,v4,v2,s),
        envelope(v2,v3,v4,v1,s),
        envelope(v1,v2,v4,v3,s),
        envelope(v2,v1,v3,v4,s),
        face(v1,v2,v3,v4,s),
        face(v1,v4,v2,v3,s),
        face(v1,v3,v4,v2,s),
        face(v2,v3,v1,v4,s)
    );
    ipi=indx(ip); // structured index list
    cpi=[if(s%2)for(i=ipi)if(len(i)==2)i[0]]; // face segments not meeting to a point
    tp=[for(i=ip)for(j=i)j]; // flattened list of points
    tf=concat( // faces
        [for(i=[1:len(ipi)-1])if((len(ipi[i])>1)&&(ip[i+1]!=o))for(j=[0:len(ipi[i])-2])
            [ipi[i][j+1],ipi[i][j],ipi[i+1][round((j+0.5-AT)*(len(ipi[i+1])-1)/(len(ipi[i])-1))]]],
        [for(i=[1:len(ipi)-1])if((len(ipi[i])>1)&&(ip[i-1]!=o))for(j=[0:len(ipi[i])-2])
            [ipi[i][j],ipi[i][j+1],ipi[i-1][round((j+0.5+AT)*(len(ipi[i-1])-1)/(len(ipi[i])-1))]]],
        [if(len(cpi))for(i=[0:3])[for(j=[0:2])cpi[3*i+j]]] // face central triangles
    );
    polyhedron(points=tp,faces=tf,convexity=2);
}

if (part=="whole") {
    spheroformTetrahedron();
} else if (part=="altwhole") {
    rotate([90,0,0])spheroformTetrahedron();
} else if (part=="half") {
    intersection(){
        rotate([90,0,0])spheroformTetrahedron();
        translate([0,0,width])cube(2*width,center=true);
    }
} else if (part=="hollwhole") {
    difference(){
        s=5;
        spheroformTetrahedron();
        scale(intscale)spheroformTetrahedron(isegs);
    }
} else if (part=="hollhalf") {
    intersection(){
        rotate([90,0,0])difference(){
            spheroformTetrahedron();
            scale(intscale)spheroformTetrahedron(isegs);
        }
        translate([0,0,width])cube(2*width,center=true);
    }
} else if (part=="althalfm") {
    rotate([90,0,0]){
        difference(){
            spheroformTetrahedron();
            scale(intscale)spheroformTetrahedron(isegs);
            difference(){
                union(){
                    intersection(){
                        orientate(cross(v4,v1))translate([-width,-width,-AT])
                            cube([2*width,2*width,width]);
                        orientate(cross(v2,v4))translate([-width,-width,-AT])
                            cube([2*width,2*width,width]);
                        orientate(cross(v1,v2))translate([-width,-width,-AT])
                            cube([2*width,2*width,width]);
                    }
                    intersection(){
                        orientate(cross(v3,v1))translate([-width,-width,-AT])
                            cube([2*width,2*width,width]);
                        orientate(cross(v1,v4))translate([-width,-width,-AT])
                            cube([2*width,2*width,width]);
                        orientate(cross(v4,v3))translate([-width,-width,-AT])
                            cube([2*width,2*width,width]);
                    }
                }
                teeth(v1,v2,v4,v3,teeth);
                teeth(v3,v1,v2,v4,teeth);
                teeth(v1,v3,v4,v2,teeth);
                teeth(v2,v1,v3,v4,teeth);
            }
        }
    }
} else if (part=="althalff") {
    rotate([90,0,0]){
        difference(){
            spheroformTetrahedron();
            scale(intscale)spheroformTetrahedron(isegs);
            union(){
                intersection(){
                    orientate(cross(v4,v1))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v2,v4))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v1,v2))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                }
                intersection(){
                    orientate(cross(v3,v1))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v1,v4))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v4,v3))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                }
                teeth(v1,v3,v4,v2,teeth);
                teeth(v3,v1,v2,v4,teeth);
                teeth(v1,v2,v4,v3,teeth);
                teeth(v2,v1,v3,v4,teeth);
            }
        }
    }
} else if (part=="rim") {
    rotate([90,0,0]){
        difference(){
            spheroformTetrahedron();
            scale(intscale)spheroformTetrahedron(isegs);
            union(){
                intersection(){
                    orientate(cross(v4,v1))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v2,v4))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v1,v2))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                }
                intersection(){
                    orientate(cross(v3,v1))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v1,v4))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v4,v3))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                }
            }
        }
        difference(){
            scale((3+intscale)/4)spheroformTetrahedron(isegs);
            scale((1+3*intscale)/4)spheroformTetrahedron(isegs);
            union(){
                intersection(){
                    orientate(cross(v4,v1))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v2,v4))translate([-width,-width,width*(1-intscale)/8])
                        cube([2*width,2*width,width]);
                    orientate(cross(v1,v2))translate([-width,-width,width*(1-intscale)/8])
                        cube([2*width,2*width,width]);
                }
                intersection(){
                    orientate(cross(v3,v1))translate([-width,-width,width*(1-intscale)/8])
                        cube([2*width,2*width,width]);
                    orientate(cross(v1,v4))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v4,v3))translate([-width,-width,width*(1-intscale)/8])
                        cube([2*width,2*width,width]);
                }
            }
        }
    }
} else if (part=="rif") {
    rotate([90,0,0]){
        difference(){
            spheroformTetrahedron();
            scale(intscale)spheroformTetrahedron(isegs);
            union(){
                intersection(){
                    orientate(cross(v4,v1))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v2,v4))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v1,v2))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                }
                intersection(){
                    orientate(cross(v3,v1))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v1,v4))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                    orientate(cross(v4,v3))translate([-width,-width,-AT])
                        cube([2*width,2*width,width]);
                }
            }
            intersection(){
                difference(){
                    scale((3+intscale)/4)spheroformTetrahedron(isegs);
                    scale((1+3*intscale)/4)spheroformTetrahedron(isegs);
                }
                union(){
                    intersection(){
                        orientate(cross(v4,v1))translate([-width,-width,-AT])
                            cube([2*width,2*width,width]);
                        orientate(cross(v2,v4))translate([-width,-width,-width*(1-intscale)/8])
                            cube([2*width,2*width,width]);
                        orientate(cross(v1,v2))translate([-width,-width,-width*(1-intscale)/8])
                            cube([2*width,2*width,width]);
                    }
                    intersection(){
                        orientate(cross(v3,v1))translate([-width,-width,-width*(1-intscale)/8])
                            cube([2*width,2*width,width]);
                        orientate(cross(v1,v4))translate([-width,-width,-AT])
                            cube([2*width,2*width,width]);
                        orientate(cross(v4,v3))translate([-width,-width,-width*(1-intscale)/8])
                            cube([2*width,2*width,width]);
                    }
                }
            }
        }
    }
}