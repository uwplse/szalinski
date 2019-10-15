//Part size in mm
cubesize = 25; // [10:50]

//Gap in mm
gap = 0.6;     // [0.3:0.1:1.0]

// Pin diameter in mm
Dpin = 1.0;  //  [0.5:0.1:2.5]

// Division (steps, mesh)
Ndiv = 9; // [3:2:31]

// Type
type = 2; // [0:filled, 1:sphere, 2:steps, 3:cage, 4:original]

// Style
style = 3; // [1:decomposed, 2:combined, 3:integrated]

/* [Hidden] */
bdiv=5;
$fn=40;
bsize = cubesize/bdiv-gap;
binterval = bsize+gap;
jointgap = gap;  // gap at the joint
Rpin = Dpin/2;
rad = Rpin*5;

module quarter(r,h,gap){
    translate([gap/2,gap/2,0]){
        cube([r,r,h]);
    }
}

module end(r,h,gap){
    difference(){
        union(){
            quarter(r=rad+gap,h=h,gap=gap);
            cylinder(r=rad,h=h);
        }
        translate([0,0,h-rad]){
            cylinder(r1=0,r2=rad+0.1,h=rad+0.1);
        }
    }
}

module middle(r,h,gap){
    quarter(r=rad+gap,h=h,gap=gap);
    cylinder(r=rad,h=h);
    translate([0,0,h]){
        cylinder(r2=0,r1=rad,h=rad);
    }
    translate([0,0,-rad]){
        cylinder(r1=0,r2=rad,h=rad);
    }
}



//joint x-positive regions
module butterfly1(rad,height,jointgap,gap){
    for(z=[0:2:bdiv-1]){
        translate([0,0,z*binterval]){
            difference(){
                union(){
                    translate([gap/2,gap/2,0])
                        cube([rad*2,rad*sqrt(3)/2-gap/2,bsize]);
                    cylinder(r=rad,h=bsize, $fn=6);
                }
                translate([0,0,-0.1])
                    cylinder(r=Rpin,h=bsize+0.2);
            }
        }
    }
}

module butterfly2(rad,height,jointgap,gap){
    for(z=[1:2:bdiv-1]){
        translate([0,0,z*binterval]){
            difference(){
                union(){
                    translate([gap/2,gap/2,0])
                        cube([rad*2,rad*sqrt(3)/2-gap/2,bsize]);
                    cylinder(r=rad,h=bsize, $fn=6);
                }
                translate([0,0,-0.1])
                    cylinder(r=Rpin*1.2,h=bsize+0.2);
            }
        }
    }
}



module zerocube(cubesize,gap){
                translate([
                    gap/2,
                    gap/2,
                    gap/2
                ]){
                    cube([cubesize-gap,cubesize-gap,cubesize-gap]);
                }
}

module shell(L,t){
    difference(){
        cube([L,L,L]);
        translate([-0.1,-0.1,-0.1])
        cube([L-t+0.1,L-t+0.1,L-t+0.1]);
    }
}

module network(L,t,i,N){
    difference(){
        union(){
            for(x=[i:2:N]){
                for(y=[i:2:N]){
                    translate([x*t,y*t,i*t])
                        cube([t,t,L-i*t]);
                }
            }
            for(x=[i:2:N]){
                for(z=[i:2:N]){
                    translate([x*t,i*t,z*t])
                        cube([t,L-i*t,t]);
                }
            }
            for(y=[i:2:N]){
                for(z=[i:2:N]){
                    translate([i*t,y*t,z*t])
                        cube([L-i*t,t,t]);
                }
            }
        }
        translate([-1,-1,-1])
            cube([L-t*(i+1)+1,L-t*(i+1)+1,L-t*(i+1)+1]);
    }    
}


module yoshimoto(){
    vv = [[0,0,0], [0,0,1], [0,1,0], [0,1,1], [1,0,0], [1,0,1], [1,1,0], [1,1,1], [0.5, 0.5, 0.5]];
    ff = [[7,6,4,5],[7,3,2,6],[7,5,1,3],[8,5,4],[8,4,6],[8,6,2],[8,2,3],[8,3,1],[8,1,5]];
    polyhedron(points=vv, faces=ff);
}



module onecube(cubesize,gap,type){
    if ( type == 0 ){
        zerocube(cubesize,gap);
    }
    else if (type == 1){
        difference(){
            zerocube(cubesize,gap);
            sphere(r=cubesize*0.85);
        }
    }
    else if ( type == 2 ){
        L0 = cubesize-gap;
        t  = L0/Ndiv;
        for(i=[0:(Ndiv-1)/2]){
            translate([t*i+gap/2,t*i+gap/2,t*i+gap/2])
            shell(L0-t*i,t*(i+1));
        }
    }
    else if ( type == 3 ){
        L0 = cubesize-gap;
        t  = L0/Ndiv;
        for(i=[0:2:0]){
            translate([gap/2,gap/2,gap/2])
                network(L0,t,i,Ndiv);
        }
    }
    else if (type==4){
        //original yoshimoto cube
        L0 = cubesize - gap;
        translate([gap/2,gap/2,gap/2])
            scale([L0,L0,L0])
                yoshimoto();
    }
}



module dig(cubesize,rad,gap){
    L = cubesize;
            translate([0,gap/2,L]){
                rotate([-90,0,0]){
                    cylinder(r=rad+gap,h=cubesize-gap);
                }
            }
            translate([L,0,gap/2]){
                    cylinder(r=rad+gap,h=cubesize-gap);
            }
}


module add(cubesize,rad,gap){
    L = cubesize;
            translate([0,gap/2,L]){
                rotate([-90,0,0]){
                    butterfly1(rad,cubesize-gap,jointgap,gap);
                }
            }
            translate([L,0,gap/2]){
                rotate([0,0,90])
                    butterfly2(rad,cubesize-gap,jointgap,gap);
            }
}


module dig2(cubesize,rad,gap){
    L = cubesize;
            translate([gap/2,L,0]){
                rotate([0,90,0]){
                    cylinder(r=rad+gap,h=cubesize-gap);
                }
            }
            translate([L,0,gap/2]){
                    cylinder(r=rad+gap,h=cubesize-gap);
            }
}


module add2(cubesize,rad,gap){
    L = cubesize;
            translate([gap/2,L,0]){
                rotate([0,90,0]){
                rotate([0,0,180])
                    butterfly1(rad,cubesize-gap,jointgap,gap);
                }
            }
            translate([L,0,gap/2]){
                rotate([0,0,90])
                    butterfly2(rad,cubesize-gap,jointgap,gap);
            }
}


module magiccube(cubesize,rad,gap,type){
    difference(){
        onecube(cubesize,gap,type);
        dig(cubesize,rad,gap);
    }
    add(cubesize,rad,gap);
}

module magiccube2(cubesize,rad,gap,type){
    difference(){
        onecube(cubesize,gap,type);
        dig2(cubesize,rad,gap);
    }
    add2(cubesize,rad,gap);
}


module half(type){
magiccube(cubesize,rad,gap,type);
    translate([cubesize,-cubesize,0])
rotate([-90,0,0])
mirror([0,1,0])
magiccube(cubesize,rad,gap,type);
translate([cubesize,-cubesize,0])
rotate([0,90,0])
rotate([90,0,90])
magiccube2(cubesize,rad,gap,type);
rotate([0,-90,-90])
mirror([1,0,0])
magiccube2(cubesize,rad,gap,type);
}


module half2(type){
    translate([-cubesize,-cubesize,-cubesize])
        magiccube(cubesize,rad,gap,type);
    translate([cubesize,-cubesize,-cubesize])
    rotate([-90,0,90])
    mirror([0,1,0])
        magiccube(cubesize,rad,gap,type);
    translate([-cubesize,cubesize,-cubesize])
    rotate([0,-90,90])
    mirror([0,1,0])
    magiccube2(cubesize,rad,gap,type);
    translate([cubesize,cubesize,-cubesize])
    rotate([0,0,180])
    magiccube2(cubesize,rad,gap,type);
}

if(style==2){
    half(type);
    rotate([0,180,0])
        half(type);
}
else if (style==1){
    //rotate([45,-(180-109.5)/2,0])
        translate([rad/2,cubesize,0])
            rotate([-90,0,-90])
            magiccube(cubesize,rad,gap,type);
    translate([rad/2,-rad*1.5,0])
        rotate([-180,0,0])
            magiccube2(cubesize,rad,gap,type);
    mirror([1,0,0]){
        translate([rad/2,cubesize,0])
            rotate([-90,0,-90])
                magiccube(cubesize,rad,gap,type);
        translate([rad/2,-rad*1.5,0])
            rotate([-180,0,0])
                magiccube2(cubesize,rad,gap,type);
    }
}
else if (style==3){
    //combined, for display
    half2(type);
    rotate([180,0,0])
        half2(type);
}

