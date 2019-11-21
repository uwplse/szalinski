/* [Main] */
// overall quality -> higher values produce smoother surface, but will increase rendering time and file size considerably
quality=100; // [10:10:100]

// the desired speed ratio x:1
speed_ratio=10; // [3:1:50]

// height of the gearbox (without motor shaft)
gearbox_height=10; // [5:0.5:50]
// diameter of the gearbox
gearbox_diameter=50; // [10:1:200]

// which part to show, use one at a time to create printable parts
SHOW_PART=0; // [0:All,2:drive disc,3:outer ring,4:Rotor,5:Shaft]

/* [Advanced] */
CLEARANCE_INPLACE=0.2; // [0:0.025:1]
CLEARANCE_MOVE=0.175; // [0:0.025:1]
CLEARANCE_MOVE_BRIDGING=0.4; // [0:0.025:1]
CLEARANCE_FIT=0.1; // [0:0.025:1]
layer_resolution=0.25; // [0.05:0.05:0.4]
outside_perimeter_width=1; // [-5:0.1:6]
drive_shaft_diameter=9; // [1:0.1:20]
drive_shaft_diameter_hollow=7; // [0:0.1:20]
// 0 = circle
drive_shaft_sides=200; // [3:1:200]
// 0 = circle
drive_shaft_sides_hollow=6; // [3:1:200]
drive_shaft_length=18; // [0:0.5:50]
number_rotor_holes=7; // [2:1:20]
driven_disc_height=1; // [0.5:0.25:8]
driven_disc_shaft_diameter=13; // [0.5:0.25:25]
driven_disc_shaft_sides=6; // [3:1:200]
top_thickness=1;
top_struts=5;
top_strut_width=3.6;
top_wall_thickness_contstraining_driven_disc=0.96;
chamfer=0.6;

/* [Experimental] */
// number of disc segments - use >= 2 for vibration cancelling; 0 = automatic; MUST be printed seperately
conf_rotor_segments=1; // [0:1:100]
twisted_tooth_interpolation_enabled=0; // [1:Yes,0:No]

/* [Hidden] */
PI=3.141592;
OVERLAP=0.01;
$fn=quality;
tooth_diameter=(gearbox_diameter-2*outside_perimeter_width-2*clearance_outline_to_rotor())/(2*(speed_ratio+2));
tooth_radius=tooth_diameter/2;
eccentric_offset=2*tooth_diameter;
eccentric_cylinder_diameter=drive_shaft_diameter+eccentric_offset;
rotor_height=rotor_height();

nozzle_diameter = 0.48;
max_overhang = max_overhang();
rotor_diameter = rotor_diameter();
rotor_diameter_inner=rotor_diameter-4*tooth_diameter-OVERLAP;
rotor_segments = num_rotor_segments();


driven_disc_diameter=gearbox_diameter-2*outside_perimeter_width-2*CLEARANCE_MOVE;
drive_pin_wall_thickness=2*nozzle_diameter+0.1;

available_space_for_rotor_holes = rotor_diameter/2-1*tooth_diameter-drive_shaft_diameter/2-eccentric_offset-chamfer/2-clearance_outline_to_rotor();
rotor_hole_wall_thickness=2*nozzle_diameter;

rotor_hole_diameter = tooth_diameter*4;
drive_pin_diameter_nominal = rotor_hole_diameter/2;

degrees_tooth_outer = 360/(speed_ratio+1);
degrees_tooth_inner = 360/speed_ratio;

xOffset=available_space_for_rotor_holes/2+drive_shaft_diameter/2+eccentric_offset/2+chamfer+clearance_shaft_to_rotor();

rotate = $t*360*speed_ratio;

if(showpart(0)){
//translate([-gearbox_diameter-2,0,0])
color([1,0,0,0.99])
rotate([180,0,0])
translate([0,0,-gearbox_height+driven_disc_height+top_thickness])
//outer_perimeter_with_tooth();
outer_perimeter();
}


if(showpart(4)){
rotors_V2(rotor_segments);
}


if(showpart(5) || showpart(4)){
rotate([0,0,-$t*360*speed_ratio])
color([0,1,0])
eccentric_with_motor_shaft();
}

if(showpart(2)){
color([0,0,1])
//translate([gearbox_diameter+1,0,0])
translate([0,0,-2])
rotate([0,0,$t*360])
    driven_disc();
}

if(SHOW_PART == 3){
color([1,0,0,1])
    outer_perimeter();
    //top_cover_legacy();
}


module cyclogearprofile(rtooth,nteeth,quality,hollow=false){
  function hypo_cyclo(r1,r2,phi) = 
   [(r1-r2)*cos(phi)+r2*cos(r1/r2*phi-phi),(r1-r2)*sin(phi)+r2*sin(-(r1/r2*phi-phi))];
  function epi_cyclo(r1,r2,phi) = 
   [(r1+r2)*cos(phi)-r2*cos(r1/r2*phi+phi),(r1+r2)*sin(phi)-r2*sin(r1/r2*phi+phi)];
  // alternating hypo- and epicycloids
  function epihypo(r1,r2,phi) = 
    pow(-1, 1+floor( (phi/360*(r1/r2)) )) <0 ? epi_cyclo(r1,r2,phi) : hypo_cyclo(r1,r2,phi);

  rrollcircle = rtooth*(2*nteeth);
  npoints = nteeth*quality;

  list1ToN  = [ for (i = [0 : npoints]) i ];
  pointlist = [ for (i = list1ToN) epihypo(rrollcircle,rtooth,360/npoints*i) ];
      difference(){
  polygon(points = pointlist, paths = [list1ToN],convexity = 6);
          if(hollow){
            circle(d=rotor_diameter_inner);
          }
      }
}

module rotors(segments){
    height = rotor_height/segments;
    degrees_per_segment = 360/segments;
    for (i = [0:segments-1]){
        degrees=i*degrees_per_segment;
        tooth_overlap = degrees/360;
        tooth_rotate_to_avoid_overlap=degrees_tooth_inner*tooth_overlap;
            
        translate([-cos(rotate+degrees)*eccentric_offset/2,sin(rotate+degrees)*eccentric_offset/2,0])
rotate([0,0,$t*360])
        translate([0,0,i*height])
        linear_extrude(height,twist=twisted_tooth_interpolation_enabled*degrees_per_segment/speed_ratio)
            rotor_2d(degrees,tooth_rotate_to_avoid_overlap);
    }
}

module rotors_V2(segments){
    height = rotor_height/segments;
    degrees_per_segment = 360/segments;
    for (i = [0:segments-1]){
        degrees=i*degrees_per_segment;
        tooth_overlap = degrees/360;
        tooth_rotate_to_avoid_overlap=degrees_tooth_inner*tooth_overlap;
            
        translate([-cos(rotate+degrees)*eccentric_offset/2,sin(rotate+degrees)*eccentric_offset/2,0])
        rotate([0,0,$t*360])
        translate([0,0,i*height])
        linear_extrude(height,twist=twisted_tooth_interpolation_enabled*degrees_per_segment/speed_ratio)
            rotor_2d(degrees,tooth_rotate_to_avoid_overlap,true);
        
        translate([-cos(rotate+degrees)*eccentric_offset/2,sin(rotate+degrees)*eccentric_offset/2,0])
        translate([0,0,i*height])
        {
            rotate([0,0,$t*360])
            difference(){
                cylinder(d=rotor_diameter_inner,h=height);

                cylinder(d=eccentric_cylinder_diameter+2*clearance_shaft_to_rotor());
                for(i=[0:number_rotor_holes-1]){
                    rotate([0,0,i*360/number_rotor_holes])
                    translate([xOffset,0,-OVERLAP/2])
                    cylinder(d=rotor_hole_diameter,h=height+OVERLAP);
                }
                dia=drive_shaft_diameter+eccentric_offset+2*CLEARANCE_MOVE;
                translate([0,0,-OVERLAP/2])
                chamfered_bi_cylinders(dia,chamfer,height+OVERLAP);
            }
        }
    }
}
module rotor_2d(degrees,rotate_degrees,hollow){
    difference(){
        rotate([0,0,rotate_degrees])
        cyclogearprofile(tooth_radius,speed_ratio,quality,hollow);
        circle(d=eccentric_cylinder_diameter+2*clearance_shaft_to_rotor());
        for(i=[0:number_rotor_holes-1]){
            rotate([0,0,i*360/number_rotor_holes])
            translate([xOffset,0,0])
            circle(d=rotor_hole_diameter);
        }
    }
}

module outer_perimeter_with_tooth(height=rotor_height){
    linear_extrude(height)
    rotate([0,0,degrees_tooth_outer/2])
    difference()
        {
            circle(d=gearbox_diameter);
            cyclogearprofile(tooth_radius,speed_ratio+1,quality);
          offset(delta = clearance_outline_to_rotor())
            cyclogearprofile(tooth_radius,speed_ratio+1,quality);
        }
}

module eccentric_with_motor_shaft(){
    difference(){
        union(){
            motor_shaft(drive_shaft_diameter,drive_shaft_sides);
            
            eccentric(rotor_height, eccentric_offset, eccentric_cylinder_diameter);
        }
        translate([0,0,-OVERLAP/2])
            motor_shaft(drive_shaft_diameter_hollow,drive_shaft_sides_hollow,OVERLAP);
    }
}

module motor_shaft(diameter,side_count_indication,height_offset=0){
    cylinder(d = diameter, h = rotor_height+drive_shaft_length+height_offset, $fn=circle_sides(side_count_indication));
}

module eccentric(discs_thickness, eccentric_offset, rotor_gear_outer_radius){
    degrees_per_segment = 360/rotor_segments;
    height_per_segment = discs_thickness/rotor_segments;
    for (i=[0:rotor_segments-1]){
        translate([-cos(i*degrees_per_segment)*eccentric_offset/2, sin(i*degrees_per_segment)*eccentric_offset/2, i*height_per_segment])
            //cylinder(d = rotor_gear_outer_radius, h = height_per_segment);
        chamfered_bi_cylinders(rotor_gear_outer_radius,chamfer,height_per_segment);
    }
}

module chamfered_bi_cylinders(dia,chamfer,height){
    overlap_height = height + OVERLAP;
    cylinder(d1=dia+chamfer,d2=dia,h=overlap_height/2); 
    translate([0,0,overlap_height/2-OVERLAP/2])   
    cylinder(d1=dia,d2=dia+2*chamfer,h=overlap_height/2);
}

module driven_disc(){
    difference(){
        cylinder(d=driven_disc_diameter,h=driven_disc_height);
        
        translate([0,0,-OVERLAP/2])
        cylinder(d=driven_disc_shaft_diameter,h=driven_disc_height+OVERLAP,$fn=circle_sides(driven_disc_shaft_sides));
    }
    for(i=[0:number_rotor_holes]){
        translate([-eccentric_offset/2+rotor_hole_diameter/2-drive_pin_diameter_nominal/2,0,driven_disc_height])    
            rotate([0,0,i*360/number_rotor_holes])
            translate([xOffset,0,0])
            difference(){
                cylinder(d=drive_pin_diameter_nominal-2*CLEARANCE_MOVE,h=rotor_height);
                
                cylinder(d=drive_pin_diameter_nominal-2*drive_pin_wall_thickness,h=rotor_height);
                // fixes rendering preview issue:
                translate([0,0,rotor_height-OVERLAP/2])
                
                cylinder(d=drive_pin_diameter_nominal-2*drive_pin_wall_thickness-2*CLEARANCE_MOVE,h=OVERLAP);
            }
        }
}

module outer_perimeter(){
    xxx = rotor_diameter-3*tooth_diameter;
    
    union(){
        union(){
            rotate([0,0,degrees_tooth_outer/2]) // to allign artefacts with outer_perimeter_with_tooth()
            translate([0,0,-top_thickness+OVERLAP])
            difference(){
                cylinder(d=gearbox_diameter,h=rotor_height+driven_disc_height+top_thickness+CLEARANCE_MOVE);
                translate([0,0,top_thickness-OVERLAP/2])
                cylinder(d=gearbox_diameter,h=rotor_height+driven_disc_height+top_thickness+CLEARANCE_MOVE+OVERLAP);
                translate([0,0,-OVERLAP/2])
                difference(){
                    cylinder(d=xxx,h=top_thickness+OVERLAP);
                    difference(){
                        cylinder(d=drive_shaft_diameter+CLEARANCE_MOVE+2*top_strut_width,h=top_thickness);
                        cylinder(d=drive_shaft_diameter+CLEARANCE_MOVE,h=top_thickness+OVERLAP);
                    }
                }
            }
            
            strut_length=xxx/2-drive_shaft_diameter/2;
            
            translate([0,0,-top_thickness/2])
            for (i=[0:top_struts]){
                rotate([0,0,i*360/top_struts])
                translate([strut_length/2+drive_shaft_diameter/2+top_strut_width/2,0,0])
                cube([strut_length,top_strut_width,top_thickness],center=true);
            }
        }
    
        outer_perimeter_with_tooth(rotor_height+CLEARANCE_MOVE);
        
        // we cannot make chamfer much arger than clearance, or the driven disc cannot be inserted. We will use a 45 degree chamfer angle.
        special_chamfer = CLEARANCE_MOVE+0.1;
        
        translate([0,0,rotor_height+CLEARANCE_MOVE-OVERLAP/2])
        difference(){
            h = driven_disc_height+2*CLEARANCE_MOVE;
            rotate([0,0,degrees_tooth_outer/2]) // to allign artefacts with outer_perimeter_with_tooth()
            cylinder(d=gearbox_diameter,h=h+special_chamfer+layer_resolution);
            
            translate([0,0,-OVERLAP/2])
            cylinder(d=driven_disc_diameter+2*CLEARANCE_MOVE, h=h);

            translate([0,0,h-OVERLAP])
            cylinder(d1=driven_disc_diameter+2*CLEARANCE_MOVE,d2=driven_disc_diameter+2*CLEARANCE_MOVE-2*special_chamfer, h=special_chamfer+2*OVERLAP);
            
            translate([0,0,h+special_chamfer])
            cylinder(d=driven_disc_diameter+2*CLEARANCE_MOVE-2*special_chamfer, h=h);
        }
    }
}

module top_cover_legacy(){
    extra = 2; // TODO
    difference(){
        cylinder(d=gearbox_diameter+extra,h=top_thickness);
        translate([0,0,-5])
        cylinder(d=drive_shaft_diameter+2*CLEARANCE_MOVE,h=15);
    }
    translate([0,0,top_thickness])
    difference(){
        cylinder(d=gearbox_diameter+extra,h=rotor_height+driven_disc_height+top_thickness+CLEARANCE_MOVE);
        translate([0,0,-OVERLAP/extra])
        cylinder(d=gearbox_diameter+tolerance,h=rotor_height+driven_disc_height+top_thickness+CLEARANCE_MOVE+OVERLAP);
    }
}

/*********** functions ***********/
function clearance_outline_to_rotor() = showpart(1) && showpart(4) ? CLEARANCE_INPLACE : CLEARANCE_MOVE;

function clearance_shaft_to_rotor() = showpart(5) && showpart(4) ? CLEARANCE_INPLACE : CLEARANCE_MOVE;

function max_overhang() = (1-(quality/100))*2*nozzle_diameter;

function rotor_diameter() = gearbox_diameter-2*tooth_diameter-2*outside_perimeter_width-2*clearance_outline_to_rotor();

function num_rotor_segments() = 
    max(1,conf_rotor_segments > 0 ? conf_rotor_segments : rotor_height/layer_resolution);
    
function showpart(partId) = SHOW_PART==0 ||  SHOW_PART==partId;

function rotor_height() = gearbox_height-2*CLEARANCE_MOVE-top_thickness-driven_disc_height;

function circle_sides(value) = value <= 0 ? $fn : min($fn,value);