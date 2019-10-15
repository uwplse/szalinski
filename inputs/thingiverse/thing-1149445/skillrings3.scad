/*
* SKILL-RING copyright Thibaut Pral - november 2015
*/

// preview[view:south east, tilt:top diagonal]

//what will be rendered
what_to_show = 3; // [0:Stacked base and rings,1:Base only,2:Ring only,3:Base and ring]

//diameter of your figurine base
base_diameter = 25;

//(expluding spikes's height)
base_height = 2.5;

//thickness of the bottom part of the base
base_flat_thickness = 0.5;

ring_width = 2;
ring_height = 2;

number_of_spikes = 3; // [2,3,4,5,6,8,9,10,12]

//recommended clearance is about half your nozzle diameter
clearance = 0.15;
spikes_radial_offset = 0.1;
polygons_precision = 96; // [24,48,72,96,192]


/* [Hidden] */
baseDiam = base_diameter + clearance*2;
diamondsSize = 2*ring_height/sqrt(2);
partAngle = 360/number_of_spikes;
endAngle = 360-partAngle;
ringbase_heightDiff = base_height - ring_height;

//base build
module base() {
    baseBaseCylinder();
    for (a =[0:partAngle:endAngle])
        baseSpikeOut(a);
}
module baseBaseCylinder() {
    difference() {
        cylinder(d=baseDiam+ring_width*2,h=base_height,$fn=polygons_precision);
        translate([0,0,base_flat_thickness])
            cylinder(d=baseDiam,h=base_height,$fn=polygons_precision);
    }
}
module baseSpikeOut(angle) {
    rotate([0,0,angle])
        difference() {
            translate([(baseDiam+ring_width)/2-spikes_radial_offset,0,-1*clearance+ringbase_heightDiff])
                rotate([45,0,0])
                    cube([diamondsSize,diamondsSize,diamondsSize],center=false);
            union() {
                translate([0,0,-10]) externalCylinder();
                translate([0,0,-50]) cube([100,100,100],center=true);
            }
        }
        
}

//ring build
module ring() {
    difference() {
        union() {
            ringBaseTube();
            for (a =[0:partAngle:endAngle])
                ringSpikeOut(a);
        }
        union() {
            for (a =[0:partAngle:endAngle])
                ringSpikeIn(a);
        }
    }
}
module externalCylinder() {
    difference() {
        cylinder(d=baseDiam+40,h=base_height+40,$fn=polygons_precision);
        translate([0,0,-5])
            cylinder(d=baseDiam+ring_width*2,h=base_height+42,$fn=polygons_precision);
    }
}
module ringBaseTube() {
    difference() {
        cylinder(d=baseDiam+ring_width*2,h=ring_height,$fn=polygons_precision);
        translate([0,0,-1])
            cylinder(d=baseDiam,h=ring_height+2,$fn=polygons_precision);
    }
}
module ringSpikeIn(angle) {
    rotate([0,0,angle])
        translate([(baseDiam+ring_width)/2-spikes_radial_offset-clearance,0,-1*ring_height])
            rotate([45,0,0])
                cube([diamondsSize+100,diamondsSize,diamondsSize],center=false);
}
module ringSpikeOut(angle) {
    rotate([0,0,angle])
        difference() {
            translate([(baseDiam+ring_width)/2-spikes_radial_offset,0,-1*clearance])
                rotate([45,0,0])
                    cube([diamondsSize,diamondsSize,diamondsSize],center=false);
            externalCylinder();
        }
}






if(what_to_show==0) {
        base();
        translate([0,0,base_height+clearance/2])
            ring();
        translate([0,0,base_height+ring_height+clearance])
            ring();
        translate([0,0,base_height+ring_height*2+clearance*1.5])
            ring();
} else if(what_to_show==1) {
    base();
} else if(what_to_show==2) {
    ring();
} else if(what_to_show==3) {
    translate([(baseDiam+10)/2,0,0])
        base();
    translate([(baseDiam+10)/-2,0,0])
        ring();
}

