// Inner diameter of the bearing
inner_diameter = 8.001;
// Outer diameter of the bearing
outer_diameter = 14.499;
// Lenght of the bearing
length = 30.01;

/*[Advanced]*/
// How round should the circles be
resolution = 50;

// Number of nodules around interior of bearing
num_nodules = 6;
// The ratio of nodule diamter to inner diameter
nod_ratio = 0.951;

// Tolerance on the inner diameter 
tolerance = 0.001;

ID = inner_diameter + tolerance;
OD = outer_diameter;
res = resolution;
numNod = num_nodules;
nodRat = nod_ratio;
_rad=ID*(.5+(nodRat*.5));



union(){
    intersection(){
        for(i = [0 : 360/numNod : 390*(1-(1/numNod))]){
            translate([cos(i)*_rad, sin(i)*_rad, 0])
                difference(){
                    cylinder(h=length,d=ID*nodRat,center=true,$fn=res);
                    cylinder(h=length+1,d=ID*nodRat-.8,center=true,$fn=res);
                }
        }
        cylinder(h=length,d=OD,center=true,$fn=res);
    }
    difference(){
        cylinder(h=length,d=OD,center=true,$fn=res);
        cylinder(h=length+1,r=(_rad/2)*sqrt(3),center=true,$fn=res);
    }
}