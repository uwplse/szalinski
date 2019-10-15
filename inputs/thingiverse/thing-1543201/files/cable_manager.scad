// model variables
$fa=0.5*1; // default minimum facet angle is now 0.5 deg
$fs=0.5*1; // default minimum facet size is now 0.5 mm
tolx=0.25*1; // tolerance for mating parts.

// global variables for 19 inch rack
// thickness of walls
wall=2; // [0:5]
// diameter of cable, cat 6 is 6 mm
cable_diameter=6; // [5:cat 5 riser wire, 6:cat 6 plenum or stranded 5e, 7:cat 6A plenum]
// diameter of your printer filament
filament_diameter= 3; // [1.75,3]
filament_radius=filament_diameter/2+tolx;  // using diameter of your printer filament
unit_width=cable_diameter+wall;
// number of cables to manage in one row
ncable=7; // [1:20]
// number of cable stacks
nstack=2; // [1:10]

module base(ncable){
    difference(){
        hull(){
            cylinder(r=unit_width/2,h=wall);
            translate([0,(ncable+1)*unit_width,0])
                cylinder(r=unit_width/2,h=wall);}
        
        union(){
            translate([0,0,-tolx])
                cylinder(r=filament_radius,h=wall+2*tolx);
            translate([0,(ncable+1)*unit_width,-tolx])
                cylinder(r=filament_radius,h=wall+2*tolx);}
            translate([0,0.5*unit_width,-tolx])
                cylinder(r=1,h=wall+2*tolx);
            translate([0,(ncable+0.5)*(unit_width),-tolx])
                cylinder(r=1,h=wall+2*tolx);
        }
}

module stack(ncable,nstack){
    difference(){
        hull(){
            cylinder(r=unit_width/2,h=wall+cable_diameter);
            translate([0,(ncable+1)*(unit_width),0])
                cylinder(r=unit_width/2,h=wall+cable_diameter);}
        
        union(){
            translate([0,0,-tolx])
                cylinder(r=filament_radius,h=wall+cable_diameter+2*tolx);
            translate([0,(ncable+1)*unit_width,-tolx])
                cylinder(r=filament_radius,h=wall+cable_diameter+2*tolx);}
            for (ndx=[1:ncable]){
                translate([-unit_width/2-tolx,(ndx)*unit_width,cable_diameter/2+wall])
                rotate([0,90,0]){
                    cylinder(r=cable_diameter/2+tolx,h=unit_width+2*tolx);
                    translate([-cable_diameter,-0.75*(cable_diameter)/2-tolx,0])
                    cube([cable_diameter,0.75*cable_diameter+2*tolx,unit_width+2*tolx]);}
            }

        }
}

module cable_retainer(ncable,nstack){
    base(ncable);
    for(ndx=[1:nstack]){
        translate([ndx*(unit_width+1),0,0])
        stack(ncable,nstack);
    }
}


cable_retainer(ncable,nstack);