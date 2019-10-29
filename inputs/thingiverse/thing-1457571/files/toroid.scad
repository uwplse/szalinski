$fn=50+0;   // +0 so it's ignored by customizer

// Select part
part = "first"; // [first:Mount,second:Mount cap]
screw_hole_diameter = 3.7;
transformer_height = 50;
transformer_inner_diameter = 28;
mount_wall_thickness = 2;
pedestal_diameter = 65;
pedestal_height = 3;
number_of_spokes = 3; // [2:16]
cap_thickness = 3;
cap_diameter = 37;

if(part=="first") {
    toroid_transformer_holder(
        spokes=number_of_spokes,
        h=transformer_height,
        ow=mount_wall_thickness,
        od=transformer_inner_diameter,
        base_h=pedestal_height,
        base_d=pedestal_diameter,
        hole_d=screw_hole_diameter
    );
} else if (part=="second") {
    toroid_cap(
        cd=cap_diameter,
        ch=cap_thickness,
        hd=screw_hole_diameter
    );
}

module toroid_cap(cd=37,ch=3,hd=4) {
    difference() {
        cylinder(d = cd, h=ch);
        translate([0,0,-.5])
            cylinder(d = hd, h=ch+1);
    }
}

module toroid_transformer_holder(h = 37, od = 31, ow = 1.5, iw=3, hole_d=3, spokes=3, base_h=3, base_d=70 )
{
    spoke_deg = 360/spokes;
    difference() {
        union() {
            cylinder(d = hole_d+iw*2, h = h+base_h);
            difference() {
                cylinder(d = od, h = h+base_h);
                translate([0,0,-.5]) cylinder(d = od-ow*2, h = h+base_h+1);  // +1 to make it look nicer on preview
            }
            intersection() {
                for(a=[0:spokes-1])
                {
                    rotate([0,0,a*spoke_deg]) translate([0,od/4,(h+base_h)/2]) cube([ow*2,od/2,h+base_h], true);
                }
                cylinder(d = od, h = h+base_h);
            }
        }
        translate([0,0,-.5]) cylinder(d = hole_d, h = h+base_h+1);
    }
    difference() {
        cylinder(h = base_h, d = base_d);
        cylinder(h = base_h, d = od);
    }

}