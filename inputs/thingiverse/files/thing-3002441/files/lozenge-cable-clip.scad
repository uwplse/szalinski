// length to width (<1 stretches along cable)
aspectratio=0.6; // [0.3:.1:2]
// diameter of cable (with some extra room)
holesize=5.5; // [2.5:1:10.5]
// radius of smoothing sphere
sharpness=1; // [0:0.1:1]

intersection(){
    scale([2*sqrt(aspectratio),2/sqrt(aspectratio),1])cylinder(r=holesize+2,h=holesize*2);
    minkowski(){
        difference(){
            scale([sqrt(aspectratio),1/sqrt(aspectratio),0.45])sphere(r=holesize*2);
            translate([0,0,holesize/2])rotate([90,270,0]){
                cylinder(d=holesize, h=100, center=true);
                translate([holesize/3,0,0])rotate([0,0,45])cube([holesize/2,holesize/2,100],center=true);}
        }
    sphere(r=sharpness);}
}
    