part = "demo"; // [rod:Double clip,twisted:Twisted double clip (may require support for printing),flap:Open clip with flap,cross_flap:Open clip with flap crossed,single:Single clip,demo:Demo]

thickness = 1.5; // [0.2:0.1:10]
// Clip inner diameter
cable_diameter = 5.5; // [2:0.5:100]
opening_angle = 110; // [0:179]
// Second clip inner diameter for Double clips, set to 0 to disable
rod_diameter = 7.5; // [0:0.5:100]
screw_diameter = 4; // [0:0.5:20]
// This is set to 0 by default for faster preview. Set to e.g. 0.25 before rendering for smooth edges.
chamfer = 0; // [0:0.05:2]
// Twist angle for Twisted double clip
twist_angle = 90; // [-90:90]

/* [More settings] */

// Clip height, 0 for auto
height = 0; // [0:100]
// Position of the screw hole in the flap from cable center, 0 for auto
screw_position = 0; // [0:100]
// Length of the flap from cable center, 0 for auto
flap_length = 0; // [0:100]
// 0 for auto
opening_rounding_radius = 0; // [0:0.2:50]
// Cut the ledges of the twisted clip so it adheres to the platform
twisted_clip_cut = "auto"; // [auto,no]

/* [Hidden] */

$fn=32;

real_opening_rounding_radius = (opening_rounding_radius==0?thickness:max(opening_rounding_radius,thickness/2));
real_height = (part=="flap"?max(height,screw_diameter*2,cable_diameter+2*thickness):(height==0?(part=="cross_flap"?cable_diameter:max(cable_diameter,rod_diameter))+2*thickness:height));
real_screw_position = part=="cross_flap"?max(screw_position,cable_diameter/2+thickness+screw_diameter):max(screw_position,cable_diameter/2+real_opening_rounding_radius*2+screw_diameter);
real_flap_length = part=="cross_flap"?max(flap_length,real_screw_position+cable_diameter/2+thickness):max(flap_length,real_screw_position+real_height/2);

echo(str("Rounding radius: ",real_opening_rounding_radius));
echo(str("Height: ",real_height));
echo(str("Screw position: ",real_screw_position));
echo(str("Flap length: ",real_flap_length));

module ring(dia,thickness,angle,chamfer)
{
    difference() {
        circle(d=dia+2*thickness-2*chamfer);
        if (dia>0)
            circle(d=dia+2*chamfer);
        l=dia/2+thickness+1;
        if (angle < 180) {
            polygon([[0,0],[0,l],[-l,l],[-l,0],[-l,-l*tan(angle-90)]]);
        } else {
            polygon([[0,0],[0,l],[-l,l],[-l,0],[-l,-l],[l,-l],[l,l*tan(angle-90)]]);
        }
    }
}

module flap_clip()
{
    module section()
    {
        ring(cable_diameter,thickness,opening_angle,chamfer);
    
        dist=cable_diameter/2+real_opening_rounding_radius;
        translate([.001,-.001])
            rotate(opening_angle)
                translate([0,dist])
                    circle(r=real_opening_rounding_radius-chamfer);
    
        translate([-real_flap_length+chamfer,cable_diameter/2+chamfer])
            square([real_flap_length-chamfer,thickness-2*chamfer]);
    }

    difference() {
        translate([0,0,chamfer])
            linear_extrude(real_height-2*chamfer)
                section();

        translate([-real_screw_position,cable_diameter/2-1,real_height/2])
            rotate([-90])
                cylinder(d=screw_diameter+2*chamfer,h=thickness+2);
    }
}

module cross_flap_clip()
{
    module section()
    {
        rotate(-90-opening_angle/2)
            ring(cable_diameter,thickness,opening_angle,chamfer);
    
        dist=cable_diameter/2+real_opening_rounding_radius;
        for (mm=[0,1]) {
            mirror([0,mm,0])
                translate([-.001,-.001])
                    rotate(-opening_angle/2)
                        translate([dist,0])
                            circle(r=real_opening_rounding_radius-chamfer);
        }
    }

    translate([0,0,chamfer]) {
        linear_extrude(real_height-2*chamfer)
            section();
            
        linear_extrude(thickness) {
            difference() {
                translate([-(real_flap_length-cable_diameter/2-thickness-chamfer),0]) {
                    difference() {
                        union() {
                            translate([0,-cable_diameter/2-thickness+chamfer])
                                square([real_flap_length-cable_diameter/2-thickness-chamfer,cable_diameter+2*thickness-2*chamfer]);
                            circle(d=cable_diameter+2*thickness-2*chamfer);
                        }

                        circle(d=screw_diameter+2*chamfer);
                    }
                }

                circle(d=cable_diameter+2*chamfer);
            }
        }
    }
}

module single_clip()
{
    module section()
    {
        rotate(-90-opening_angle/2)
            ring(cable_diameter,thickness,opening_angle,chamfer);

        dist=cable_diameter/2+real_opening_rounding_radius;
        for (mm=[0,1]) {
            mirror([0,mm,0])
                translate([-.001,-.001])
                    rotate(-opening_angle/2)
                        translate([dist,0])
                            circle(r=real_opening_rounding_radius-chamfer);
        }
    }

    translate([0,0,chamfer])
        linear_extrude(real_height-2*chamfer)
            section();
}

module twisted_clip(angle=twist_angle)
{
    real_twisted_clip_cut = twisted_clip_cut=="auto"?(angle>45?false:true):false;

    module section(dia)
    {
        rotate(-90-opening_angle/2)
            ring(dia,thickness,opening_angle,chamfer);
    
        dist=dia/2+real_opening_rounding_radius;
        for (mm=[0,1]) {
            mirror([0,mm,0])
                translate([-.001,-.001])
                    rotate(-opening_angle/2)
                        translate([dist,0])
                            circle(r=real_opening_rounding_radius-chamfer);
        }
    }

    intersection() {
        union() {
            dist=cable_diameter/2+thickness+rod_diameter/2;
            
            linear_extrude(real_height)
                section(rod_diameter>cable_diameter?rod_diameter:cable_diameter);
            if (rod_diameter && cable_diameter)
                translate([0,0,real_height/2])
                    rotate([angle,0,0])
                        linear_extrude(real_height,center=true)
                            rotate(180)
                                translate([dist,0])
                                    section(rod_diameter>cable_diameter?cable_diameter:rod_diameter);
        }
        if (real_twisted_clip_cut)
            cylinder(d=4*rod_diameter+4*cable_diameter,h=real_height);
    }
}

module rod_clip()
{
    module section()
    {
        dist=cable_diameter/2+thickness+rod_diameter/2;
        
        rotate(90-opening_angle) {
            ring(cable_diameter,thickness,opening_angle,chamfer);
            translate([.001,cable_diameter/2+real_opening_rounding_radius-.001])
                circle(r=real_opening_rounding_radius-chamfer);
        }
        if (rod_diameter) {
            translate([-dist,-.001]) {
                rotate(270-opening_angle) {
                    ring(rod_diameter,thickness,opening_angle,chamfer);
                    translate([.001,rod_diameter/2+real_opening_rounding_radius-.001])
                        circle(r=real_opening_rounding_radius-chamfer);
                }
            }
        } else {
            translate([-cable_diameter/2-real_opening_rounding_radius,0])
                circle(r=real_opening_rounding_radius-chamfer);
        }
    }
    
    translate([0,0,chamfer])
        linear_extrude(real_height-2*chamfer)
            section();
}

module chamfer_chisel()
{
    cylinder(r1=chamfer,r2=0,h=chamfer,$fn=8);
    mirror([0,0,1])
        cylinder(r1=chamfer,r2=0,h=chamfer,$fn=8);
}

module part(part,arg1)
{
    module unchamfered() {
        if (part == "flap")
            flap_clip();
        else if (part == "rod")
            rod_clip();
        else if (part == "cross_flap")
            cross_flap_clip();
        else if (part == "single")
            single_clip();
        else
            twisted_clip(arg1?arg1:twist_angle);
    }

    if (chamfer > 0) {
        minkowski() {
            unchamfered();
            chamfer_chisel();            
        }
    } else {
        // Avoid minkowski() for speedup
        unchamfered();
    }
}

module demo()
{
    dist = (max(rod_diameter,cable_diameter)/2+thickness+2.5)*5/6;
    color([90/255,150/255,200/255])
        render()
            translate([dist,dist,0])
                rotate(180)
                    part("twisted",-30);
    color([70/255,130/255,180/255]) // steelblue
        render()
            translate([dist,-dist*4/3,0])
                mirror([1,0,0])
                    part("flap");
    color([255/255,140/255,0/255]) // darkorange
        render()
            translate([-dist,-2*dist,0])
                part("rod");
    color([255/255,160/255,20/255])
        render()
            translate([-dist,dist/3,0])
                part("cross_flap");
}

if (part == "demo") {
    demo();
} else if (part == "hires") {
    $fn=256;
    demo();
} else {
    part(part);
}
