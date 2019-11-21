// Baratza Vario portafilter
// Design by Marius Gheorghescu, Dec 2016


// portafilter diameter (58mm typical)
portafilter_dia = 58;

// portafilter mount diameter (example: 78.4mm for Breville)
portafilter_mount_dia = 78.4;

// portafilter flange height (example: 10mm for Breville)
portafilter_mount_height = 10.0;

// portafilter flage depth (example: 4mm for Breville)
portafilter_mount_deep = 4.0;

// how tall the funnel is (20mm typical)
funnel_height = 20;

// thickness of the walls (2.4mm gives good results for 0.4mm extrusion width)
wall_thick = 2.4;


/* [Hidden] */

// holder specs
holder_height = 119.50;
holder_nub_offset = 9.5;
holder_nub_dia = 4.5;

portafilter_offset = 10;

leg_width = 29.3;


// top stop/lock
stop_width = 11.75;
stop_depth = 2.0;

$fn=100;

epsilon = 0.01;


// funnel
module funnel()
{
    notch_distance = 56.5;
    peg_distance = 80.5;
    
    front_brace_size = 70;//peg_distance + 2*wall_thick;
    brace_width = 10;
    
    translate([0,0,funnel_height/2])
    difference() {
        union() {
            hull() {
                cylinder(r=portafilter_dia/2+wall_thick, h=funnel_height, center=true);
                
                translate([0, portafilter_dia/2 + wall_thick/2 + portafilter_offset,0])
                    cube([leg_width, wall_thick, funnel_height], center=true);

                // back brace
                translate([0,portafilter_dia/2 + portafilter_offset - brace_width/2 + wall_thick, -funnel_height/2 + wall_thick/2])
                    cube([portafilter_dia, brace_width,wall_thick], center=true);                            
                
                //notch brace
                translate([0,-portafilter_dia/2 + 2, -funnel_height/2 + wall_thick/2])
                    cube([front_brace_size,brace_width,wall_thick], center=true);                            
            }
            
            // front brace
            translate([0,-portafilter_dia/2 + 2, -funnel_height/2 + wall_thick/2 - 1.5])
                cube([front_brace_size,brace_width,wall_thick], center=true);                            
            
        
            // top notches
            translate([notch_distance/2, -portafilter_dia/2 + wall_thick + 2, -funnel_height/2 - 1.5])
                //cylinder(r=0.75, h=2, center=true);
                sphere(r=2.5/2, center=true);

            translate([-notch_distance/2, -portafilter_dia/2 + wall_thick + 2, -funnel_height/2 - 1.5])
                sphere(r=2.5/2, center=true);

            /*
            // top pegs
            translate([peg_distance/2, -portafilter_dia/2 + wall_thick, -funnel_height/2 - 1.5])
                cube([1.5, 1.75, 2], center=true);

            translate([-peg_distance/2, -portafilter_dia/2 + wall_thick, -funnel_height/2 - 1.5])
                cube([1.5, 1.75, 2], center=true);
            */
        }

        
        // portafilter/inside funnel 
        cylinder(r=portafilter_dia/2, h=2*funnel_height + epsilon, center=true);
        
        // clearance 
        translate([0,portafilter_dia/2, -funnel_height/2 + stop_depth/2 - epsilon])
            cube([stop_width, portafilter_dia, stop_depth], center=true);
    }
    
}

// portafilter support

module portafilter_mount()
{
    pf_heigt = portafilter_mount_height + 2*wall_thick;
    
    translate([0,0, pf_heigt/2 + funnel_height - wall_thick])
    difference() {
        hull() {
            cube([portafilter_mount_dia + 2*wall_thick, portafilter_dia/2, pf_heigt], center=true);
            
            translate([0, portafilter_dia/2 + wall_thick/2 + portafilter_offset, -pf_heigt/2 + holder_height/6])
                cube([leg_width, wall_thick, holder_height/3], center=true);
            
        }
        
        // flaps clearance
        cube([portafilter_mount_dia, portafilter_dia/2 + epsilon + wall_thick, portafilter_mount_height], center=true);
        
        hull() {
            // portafilter slide-in clearance
            translate([0,0,wall_thick])
                cube([portafilter_mount_dia - 2*portafilter_mount_deep, portafilter_dia/2 + epsilon, pf_heigt], center=true);
            
            // portafilter clearance
            translate([0,0,holder_height/2 - portafilter_mount_height/2])
                cylinder(r=portafilter_mount_dia/2 - portafilter_mount_deep, h=holder_height, center=true);
        }
        
        cylinder(r=portafilter_mount_dia/2, h=portafilter_mount_height + epsilon, center=true);
        
        // funnel clearance
        cylinder(r=portafilter_dia/2, h=pf_heigt + epsilon, center=true);
    }
}

module leg()
{
    // leg
    hull() {
        translate([0, portafilter_dia/2 + wall_thick/2 + portafilter_offset,(holder_height-funnel_height)/2 + funnel_height])
            cube([leg_width, wall_thick, holder_height - funnel_height], center=true);
        
        translate([0, portafilter_dia/2 + wall_thick/2 + portafilter_offset,  wall_thick*1.5])
            cube([portafilter_dia - wall_thick, wall_thick, wall_thick], center=true);
    }

    // foot
    difference() {
        union() {
            
            // strength brace right
            translate([-(leg_width-wall_thick)/2,0,0])
                hull() {
                    translate([-portafilter_dia/4, portafilter_dia/2 + wall_thick/2 + portafilter_offset, wall_thick/2])
                        cube([wall_thick, wall_thick,wall_thick], center=true);

                    translate([0, portafilter_dia/2 + wall_thick/2 + portafilter_offset - leg_width/2 + wall_thick/2, holder_height - wall_thick/2])
                        cube([wall_thick, leg_width, wall_thick], center=true);
                }
                
            // strength brace left
            translate([(leg_width-wall_thick)/2,0,0])
                hull() {
                    translate([portafilter_dia/4, portafilter_dia/2 + wall_thick/2 + portafilter_offset, wall_thick/2])
                        cube([wall_thick, wall_thick,wall_thick], center=true);

                    translate([0, portafilter_dia/2 + wall_thick/2 + portafilter_offset - leg_width/2 + wall_thick/2, holder_height - wall_thick/2])
                        cube([wall_thick, leg_width, wall_thick], center=true);
                }
            
            translate([0, portafilter_dia/2 + wall_thick + portafilter_offset - leg_width/2 , holder_height - wall_thick/2])
                hull() {
                    translate([0,leg_width/2 - wall_thick/2,0])
                        cube([leg_width, wall_thick, wall_thick], center=true);
                    //cylinder(r=leg_width/2, h=wall_thick, center=true);
                    #cube([leg_width, leg_width, wall_thick], center=true);
                }
        }
        
        // nub
        #translate([0, portafilter_dia/2 + wall_thick + portafilter_offset - holder_nub_offset, holder_height])
            sphere(r=holder_nub_dia/2, center=true);
     }
 }
 

// make printable ideally without supports
rotate([-90,0,-90])
{
    funnel();

    portafilter_mount();

    leg();
}
