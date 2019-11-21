// Holder height, in mm
height=35;
// Frame tube diameter, in mm
frame_diameter=32;
// Pump diameter, in mm
pump_diameter=30;

// Velcro strap width, in mm
strap_width=20;
// Velcro strap slot width, in mm. Set to 0 to disable strap slot
strap_slot=3;

// Pump insertion opening as percentage of the pump diameter, in %
opening = 86;

// Central screws length, in mm
screw_length=30;

// Minimum pump to frame distance, in mm
minimum_frame_distance=5;

/* [Advanced] */

// Wall thickness, in mm
wall=3;
// Frame clamping ring shrinkin, in mm
frame_pressure=0.5;
// Small holes tolerance, in mm
tolerance=0.2;
// Frame clamping slot width, in mm
clamp_slot=4;
// Nut height, in mm
nut_height=2.4;
// Nut wrench size, in mm
nut_size=5.5;
// Screw diameter in mm
screw_diameter=3;

/* [Hidden] */

$fn=64;

opening_angle=2*asin(opening/100);
nut_dia=nut_size*2/sqrt(3)+2*tolerance;

module reflect(v)
{
    children();
    mirror(v)
        children();
}


module part()
{
    // Add compensation for holes
    frame_diameter=frame_diameter+2*tolerance;
    // Add some pressure
    pump_diameter=pump_diameter-frame_pressure+2*tolerance;
    screw_diameter=screw_diameter+2*tolerance;
    strap_width=((strap_slot&&strap_width)?strap_width+1:0);
    actual_frame_distance=max(((strap_slot&&strap_width)?wall+strap_slot:0)+wall,minimum_frame_distance,screw_diameter+2);
    axis_distance=frame_diameter/2+actual_frame_distance+pump_diameter/2;

    difference() {
        hull() {
            cylinder(d=frame_diameter+2*wall,h=height,center=true);
            translate([axis_distance,0,0])
                cylinder(d=pump_diameter+2*wall,h=height,center=true);
        
            translate([-(frame_diameter/2+nut_dia/2+wall/2),0,0])
                rotate([90,0,0])
                    cylinder(d=nut_dia+2*wall,h=4*wall+clamp_slot,center=true);
        }

        cylinder(d=frame_diameter,h=height+2,center=true);
        translate([axis_distance,0,0])
            cylinder(d=pump_diameter,h=height+2,center=true);
        mirror([1,0,0])
            translate([0,-clamp_slot/2,-height/2-1])
                cube([frame_diameter/2+wall+nut_dia+wall+1,clamp_slot,height+2]);
    
        rr=pump_diameter/2+wall;
        dd=rr*tan(opening_angle/2);
        translate([axis_distance,0,0])
            linear_extrude(height=height+2,center=true)
                polygon([[0,0],[rr,-dd],[rr,dd]]);
        
        translate([axis_distance,0,0]) {
            difference() {
                cylinder(d=pump_diameter+2*wall+2*strap_slot,h=strap_width,center=true);
                cylinder(d=pump_diameter+2*wall,h=strap_width+2,center=true);
            }
        }
        
        translate([-(frame_diameter/2+nut_dia/2+wall/2),0,0]) {
            rotate([90,0,0]) {
                cylinder(d=screw_diameter,h=max(frame_diameter,pump_diameter)+2*wall+2,center=true);
                translate([0,0,clamp_slot/2+2*wall])
                    cylinder(d=nut_dia,h=max(frame_diameter,pump_diameter)/2+wall+1,$fn=6);
                mirror([0,0,1])
                    translate([0,0,clamp_slot/2+2*wall])
                        cylinder(d=nut_dia,h=max(frame_diameter,pump_diameter)/2+wall+1);
            }
        }
        
        reflect([0,0,1]) {
            d2=max(strap_width/2+screw_diameter/2+1,height/2-nut_dia/2-1);
            translate([frame_diameter/2+actual_frame_distance/2,0,d2]) {
                rotate([90,0,0]) {
                    cylinder(d=screw_diameter,h=max(frame_diameter,pump_diameter)+2*wall+2,center=true);
                    //dist=min(frame_diameter,pump_diameter)/2;
                    dist=(screw_length-nut_height-1)/2;
                    translate([0,0,dist])
                        cylinder(d=nut_dia,h=nut_height+10,$fn=6);
                    mirror([0,0,1])
                        translate([0,0,dist])
                            cylinder(d=nut_dia,h=nut_height+10);
                }
            }
        }
    }
}

module print() {
    translate([0,-2.5,0]) {
        intersection() {
            part();
            rotate([90,0,0])
                cylinder(r=100,h=50);
        }
    }
    translate([0,2.5,0]) {
        intersection() {
            part();
            rotate([-90,0,0])
                cylinder(r=100,h=50);
        }
    }
}

print();