//Turbine/propeller/fan generator by DrLex
//Thingiverse thing:3874607
//v2.1, 2019-10-18
//Based on Thingiverse thing:2187837 by Denise Lee (aka CorrugatorSupercilii), 12March2017
//Released under Creative Commons - Attribution - Non-Commercial license

/*
//In RC hobby propeller nomenclature
//Propeller diameter X distance travelled per revolution (in silly inches!)
inch_mm = 25.4;
prop_dia = 6; //propeller diameter
prop_dist = 3.8; //propeller distance travelled
blade_radius = prop_dia*inch_mm/2;
pitch_angle = atan(prop_dist*inch_mm/blade_radius);
*/


// Turbine/propellor (flow towards motor) or fan (flow away from motor)
type = "turbine"; // [turbine, fan]
// Motor rotation (looking towards the axle)
rotation_dir = "counterclockwise"; // [counterclockwise, clockwise]

turbine_height = 15;
num_blades = 6;
blade_radius = 45;
pitch_angle = 25;

// Use large value for quick preview, use value near print layer height for final model export
printer_layer_height = 1.5;
// This determines the number of perimeters the blades will be printed with
blade_thickness = 1.11;

/* [Blade design] */
// Curved blades or straight edge
blade_shape = "curved"; // [curved, straight]
// Straightness of curved blades (lower is more curved)
curve_factor = 11; // [2:25]

taper = "convex"; // [convex, concave]
// Percent of turbine height at which to start tapering off blades towards their tips (100 for no taper)
percent_offset = 50;
// Taper curvature, 0 is linear
taper_base = 3.0; // [0:.1:50]

/* [Stem] */
// Radius of the centre cone at motor end
stem_bot_r = 11.875;
// Radius of the centre cone at outer end
stem_top_r = 5.50;

// Radius of pin connecting motor to turbine
shaft_fit_r = 1.09;
// Depth of the pin hole (larger than turbine_height for through hole)
shaft_fit_l = 7.5;

/* [Shroud] */
// A shroud adds safety and strength but may reduce efficiency. Set to percentage of turbine_height, 0 for no shroud.
shroud_height = 25;
// Wall thickness of the shroud (centred around blade_radius)
shroud_thickness = 0.76;


/* [Hidden] */
blade_arch = blade_radius/curve_factor; // Curvature of blades, selected straight edge or use ARC module

flip_it = type == "turbine" ? 1 : -1;
rotation = flip_it * (rotation_dir == "clockwise" ? 1 : -1);

pi = 3.14159265359;
blade_cirf = 2*pi*blade_radius;
//Converting pitch to twist angle for linear extrude
twist_angle = 360*turbine_height/(blade_cirf*tan(pitch_angle));

echo("Blade Radius", blade_radius);
echo("Pitch Angle", pitch_angle);
echo("Blade Arch", blade_arch); 
echo("Twist Angle: ", twist_angle);

slices = turbine_height / printer_layer_height; //equal printing slicing height

//offset_slicing must be greater or equal to slices
offset_slicing = round(slices*(1/((100-percent_offset)/100)));  

echo("Percent Offset:", percent_offset);
echo("Offset Slicing:", offset_slicing);

layer_h = turbine_height/offset_slicing;

bot_r = type == "turbine" ? stem_bot_r : stem_top_r; //Bottom blade radius
top_r = blade_radius;
delta_r = top_r - bot_r;


difference() {
    union() {
        translate([0,0,turbine_height]) rotate([180,0,0]) intersection() {

            //Blades
            linear_extrude(height=turbine_height, center = false, convexity = 10, twist = twist_angle*rotation, slices = slices) {
                for(i=[0:num_blades-1])
                rotate((360*i)/num_blades)
                  translate([0,-blade_thickness/2]) { 
                    if(blade_shape != "curved") {
                        square([blade_radius, blade_thickness]);
                    }
                    else {
                        if(rotation == -1) {
                            mirror([0,1,0])
                            arc(blade_radius, blade_thickness, blade_arch); 
                        }
                        else {
                            arc(blade_radius, blade_thickness, blade_arch);
                        }
                    }
                }
            }
             
              
            if (percent_offset < 100) {
                //Non-linear extrusion
                union() {
                    if(taper_base <= 0) {
                        rotate_extrude(angle=360, $fn=100)
                            polygon(points=[
                                [0, 0],
                                [bot_r, 0],
                                [top_r, slices*layer_h],
                                [0, slices*layer_h]
                            ]);
                    }
                    else if(taper == "convex") {
                        //y = 1 - 1/exp(x)
                        end_point = 1 - 1/exp(taper_base*1); 

                        //Normalised N
                        rotate_extrude(angle=360, $fn=100)
                            polygon(points=concat(
                                [[0, 0]],
                                [for(i = [0:slices+1]) 
                                    [bot_r + delta_r*((1-1/exp(taper_base*(i/slices)))/end_point), i*layer_h]],
                                [[0, slices*layer_h]])
                            );
                    }
                    else {
                        //Curve concave    
                        //y = base^x - 1
                        //base = exp(1);
                        end_point = pow(taper_base+1,1)-1;

                        rotate_extrude(angle=360, $fn=100)
                            polygon(points=concat(
                                [[0, 0]],
                                [for(i = [0:slices+1]) 
                                    [bot_r + delta_r*((pow(taper_base+1,i/slices)-1)/end_point), i*layer_h]],
                                [[0, slices*layer_h]])
                            );
                    }

                    remain_h = (offset_slicing - slices) * layer_h;
                    translate([0,0,slices*layer_h]) cylinder(remain_h, top_r, top_r, center=false, $fn=100);
                }
            }
        }

        //Centre stem
        if(type == "turbine") {
            cylinder(turbine_height, stem_top_r, stem_bot_r,center=false, $fn=100);
        } else {
            cylinder(turbine_height, stem_bot_r, stem_top_r,center=false, $fn=100);
        }

        if(shroud_height > 0 && shroud_thickness > 0) {
            shroud_h = shroud_height * turbine_height / 100;
            difference() {
                cylinder(shroud_h, r=blade_radius+shroud_thickness/2, $fn=100);
                translate([0,0,-1]) cylinder(shroud_h+2, r=blade_radius-shroud_thickness/2, $fn=100);
            }
        }

    }

    //Push fit cutout
    shaft_z = type == "turbine" ? turbine_height - shaft_fit_l : -1;
    translate([0,0,shaft_z]) cylinder(shaft_fit_l+1, shaft_fit_r, shaft_fit_r, center=false, $fs=.6, $fa=3.6);

}


//length and breath of inner arc
module arc(length, width, arch_height){
    //r = (l^2 + 4*b^2)/8*b 
    radius = (pow(length,2) + 4*pow(arch_height,2))/(8*arch_height);
    //echo(radius);
    translate([length/2,0,0])
    difference() {
        difference() {
            translate([0,-radius+arch_height,0])
                difference() {
                    circle(r=radius+width,$fn=100);
                    circle(r=(radius),$fn=100);
                }
            
            translate([-(radius+width),-(radius+width)*2,0,])
                square([(radius+width)*2,(radius+width)*2]);
        }
        union() {
            translate([-length,-arch_height]) 
                square([length/2,arch_height*2]);
            translate([length/2,-arch_height])     
                square([length/2,arch_height*2]);
        }
    } 
}

