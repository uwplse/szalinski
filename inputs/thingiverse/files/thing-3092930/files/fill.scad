//Size of a cavity
size=7; // [5:50]

//Wall thickness
thick = 0.5; //[0.5:0.1:2]

//Repetition
repeat = 2; // [1:50]

//Polyhedron type
poly=1; //[1:Truncated Octahedron=BCC, 2: Rhombohedron=FCC]

module rhombohedron(){
    render(){
        intersection(){
            cylinder(h=2,center=true,$fn=4);
            rotate([90,0,0])
                cylinder(h=2,center=true,$fn=4);
            rotate([0,90,0])
                cylinder(h=2,center=true,$fn=4);
        }
    }
}

module void_rhombo(size, thick, rep){
    thick0 = thick * sqrt(2);
    for(ix=[-rep[0]/2+0.25:rep[0]/2-0.75]){
        x = ix*size;
        for(iy=[-rep[1]/2+0.25:rep[1]/2-0.75]){
            y = iy*size;
            for(iz=[-rep[2]/2+0.25:rep[2]/2-0.75]){
                z = iz*size;
                translate([x,y,z]){
                    scale((size-thick0)/2){
                        rhombohedron();
                    }
                }
                translate([x,y+size/2,z+size/2]){
                    scale((size-thick0)/2){
                        rhombohedron();
                    }
                }
                translate([x+size/2,y,z+size/2]){
                    scale((size-thick0)/2){
                        rhombohedron();
                    }
                }
                translate([x+size/2,y+size/2,z]){
                    scale((size-thick0)/2){
                        rhombohedron();
                    }
                }
            }
        }
    }
}


        
module octahedron(){
    polyhedron(points=[[0,0,-1],[1,0,0],[0,1,0],[-1,0,0],[0,-1,0],[0,0,1]],faces=[[0,1,2],[0,2,3],[0,3,4],[0,4,1],[5,2,1],[5,3,2],[5,4,3],[5,1,4]]);
}


module truncocta(){
    render(){
        intersection(){
            scale(1.5)
                octahedron();
            scale(2)
                cube(center=true);
        }
    }
}


module void_truncocta(size, thick, rep=[1,1,1]){
    for(x=[-rep[0]/2+0.25:rep[0]/2-0.75]){
        for(y=[-rep[1]/2+0.25:rep[1]/2-0.75]){
            for(z=[-rep[2]/2+0.25:rep[2]/2-0.75]){
                translate([size*x,size*y,size*z])
                    scale((size-thick)/2)
                        truncocta();
                translate([size*(x+0.5),size*(y+0.5),size*(z+0.5)])
                    scale((size-thick)/2)
                        truncocta();
            }
        }
    }
}


if (poly==2)
    void_rhombo(size, thick, rep=[repeat,repeat,repeat]);
else   
    void_truncocta(size, thick, rep=[repeat,repeat,repeat]);

