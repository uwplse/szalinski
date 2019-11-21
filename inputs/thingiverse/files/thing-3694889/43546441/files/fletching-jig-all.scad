part = 0; //[0:All, 1:Base only, 2:Arm only, 3:Lid only]

/* [Jig settings] */

arrow_diameter = 6;//[2:0.1:30] 

//distance between the bottom of the base and arrow
arrow_offset = 3;//[0:0.1:100] 

base_height = 20;//[0:0.1:100]

hinge_width = 6.5;//[0:0.1:30]  

//thickness of the hinge extension attached to the bottom of the arm
hinge_thickness = 1.5;

//diameter of the hinge's circular part
hinge_diameter = 5.1;

//how deep into base is the hinge cutout
hinge_depth = 10.1;

//diameter of the sphere that connects two halves of the hinge together 
hinge_pin = 3.1;

//gap for the vane foot
arm_gap = 0.5;     

//distance between the top of the base and bottom of the arm
arm_offset = 1.5;

/* [Fletching] */

vane_length = 72;//[0:0.1:200] 

vane_width = 1;//[0:0.1:10] 

//how far from the end of arrow will the vane be
vane_offset = 25;//[0:0.1:200] 

//sets offset fletching in degrees
vane_turn = 0;// [-30:0.1:30]

//if true, helical fletching will be used
helical = 0;//[1:yes, 0:no]

//horizontal distance between the bottom and top corner of the helical vane
helical_adjust = 3.5; //[0:0.1:30]

helical_direction = 1;//[1:left, -1:right]

//taken from MCAD library
module ellipse(width, height) {
  scale([1, height/width, 1]) circle(r=width/2);
}

//
//Check out following video made by Eric Buijs
//for more information about bezier curves
//https://www.youtube.com/watch?v=jVPJetq0BZg
//

module bezier (p0, p1, p2, w)
{
    deltat = 0.02;
    points = [for (t=[0:deltat:1+deltat]) pow(1-t,2)*p0+2*(1-t)*t*p1+pow(t,2)*p2];

    for (i = [1 : len(points) - 1])
    {
        hull() 
        {
            translate(points[i-1]) circle(d=w);
            translate(points[i]) circle(d=w);
        }
    }
}

//
//Module that can create both parts of the hinge by changing holer value
//# hinge_diameter - diameter of the cylinder that forms a joint; also depth of the hinge
//# hinge_pin - diameter of the sphere that connects two parts of the hinge together 
//# holer - if true, outline of the joint will be created and can be later subtracted from another solid, creating opening for hinge itself
//## hole_lip - adds extra depth to the holer, only useful for preview
//
module hinge (hinge_width = 7, hinge_thickness = 1.5, hinge_diameter = 5, hinge_height = 8, hinge_pin = 2.4, holer = true)
{
    hole_lip = 1;
    translate([0,hinge_width/2,0]) rotate([90,-90,0]) mirror([0,1,0])
        difference()
        {
            union()
            {
                translate([0,0,hinge_width]) sphere(d=hinge_pin);
                sphere(d=hinge_pin);
                cylinder(hinge_width,d=hinge_diameter, true);     
                translate([hinge_height/2,0,hinge_width/2]) cube([hinge_height,hinge_diameter,hinge_width], true);
                if (holer)
                {
                    translate([-hinge_diameter/2,0,0]) 
                        cube([hinge_height + hinge_diameter/2, hinge_diameter/2 + hole_lip, hinge_width]);
                }
            }
            if (!holer)
            {
                translate([hinge_height/2 - hole_lip,0, hinge_width/2]) 
                    cube([hinge_height + hinge_diameter, hinge_diameter + hole_lip, hinge_width - 2*hinge_thickness], true);
            }
        }
}

//Functions that create console messages
module error_treshold (value_name, treshold_name, value, treshold)
{
    if (value == treshold) 
        echo(str("<font color='red'>", value_name," treshold (", treshold_name, " = ", treshold, ") reached!</font>"));
}
module info_treshold (value_name, treshold_name, treshold)
{
    echo(str("<font color='blue'>Current ", treshold_name, " for ", value_name, " is ", treshold, "</font>"));
}

//
//Creates helical vane
//# height - extrusion height
//# spread - horizontal distance between edges of the vane
//# direction - sign of the value determines left or right spin (+ left; - right)
//
module helical_vane (width = 1, length = 75, height = 10, spread = 4, direction = 1)
{
    direction = sign(direction);
    length = length - width;
    rotate([0,90,0])
        linear_extrude(height, center = false, twist = -direction*15, scale = 1)
            translate([-length/2,0,0])
                bezier([0,-direction*spread],[0.5*length,-direction*spread],[length,direction*spread],width);
}

//
//Creates basic shape of the jig's base
//
module base_mold (a = 8, radius = 15, height = 20)
{
    hull()
    { 
        for (i = [0:2]) 
        {
            rotate(a=[0,0,i*120]) translate([0,-a/2,0]) 
                cube([radius, a, height], false);
        }
    }
}

//
//All three main components of the jig are created here - arm, base and clamping lid
//# arrow_diameter - slightly bigger than the arrow itself (may vary depending on your printer)
//# arrow_offset - distance between the bottom of the base and arrow
//# base_height - height of the base
//# hinge_width - width of the hinge cutout on the base
//# hinge_thickness - thickness of the hinge extension attached to the bottom of the arm
//# hinge_diameter - diameter of the circular part of the hinge that forms a joint
//# hinge_depth - how deep into the base is the hinge cutout
//# hinge_pin - diameter of the sphere that connects two halves of the hinge together 
//# arm_gap - gap for the vane foot, so that tension during clamping is distributed evenly
//# arm_offset - distance between the top of the base and bottom of the arm
//# vane_length - length of the vane
//# vane_width - width of the vane
//# vane_offset - how far from the end of the arrow will the vane be
//# vane_turn - sets OFFSET fletching in degrees
//# helical - if true, HELICAL fletching will be used
//# helical_adjust - horizontal distance between the bottom and top corner of the HELICAL vane
//# helical_direction - sign of the value determines left or right spin (+ left; - right)
//
module jig (    part_select = 0,
                arrow_diameter = 6,
                arrow_offset = 3,
                base_height = 20,
                hinge_width = 6.5,
                hinge_thickness = 1.5, 
                hinge_diameter = 5,
                hinge_depth = 10,
                hinge_pin = 3,
                arm_gap = 0.5,         
                arm_offset = 1.5,
                vane_length = 75, 
                vane_width = 1.1, 
                vane_offset = 25,
                vane_turn = 0,
                helical = false,
                helical_adjust = 3.5,
                helical_direction = 1
             ) 
{
    //independent internal variables
    hinge_gap = 0.1;
    flag_showAll = part_select == 0 ? 0 : 1; 

    //input corrections and tresholds
    min_arrow_diameter = 2;
    arrow_diameter = abs(arrow_diameter) >= min_arrow_diameter ? abs(arrow_diameter) : min_arrow_diameter;

    min_base_height = 5;
    base_height = base_height >= min_base_height ? base_height : min_base_height;

    hinge_depth = abs(hinge_depth) <= base_height 
                    ? (abs(hinge_depth) >= min_base_height ? abs(hinge_depth) : min_base_height)
                    : base_height;
    
    min_hinge_diameter = 2;
    hinge_diameter = abs(hinge_diameter) <= hinge_depth 
                        ? (abs(hinge_diameter) >= min_hinge_diameter ? abs(hinge_diameter) : min_hinge_diameter)
                        : hinge_depth;

    min_hinge_thickness = 1;
    min_hinge_width = 2*min_hinge_thickness + hinge_gap;
    max_hinge_width = (3*arrow_diameter)/sqrt(3); //inscribed circle in equilateral triangle formula
    hinge_width     = abs(hinge_width) >= min_hinge_width 
                        ? (abs(hinge_width) <= max_hinge_width ? abs(hinge_width) : max_hinge_width) 
                        : min_hinge_width;

    max_hinge_thickness = (hinge_width-hinge_gap)/2;
    hinge_thickness = abs(hinge_thickness) >= min_hinge_thickness
                        ? (abs(hinge_thickness) <= max_hinge_thickness ? abs(hinge_thickness) : max_hinge_thickness) 
                        : min_hinge_thickness;

    max_hinge_pin = min(hinge_diameter, hinge_width - hinge_gap - 2*hinge_thickness);
    hinge_pin = abs(hinge_pin) <= max_hinge_pin ? abs(hinge_pin) : max_hinge_pin;

    arrow_offset = abs(arrow_offset) <= base_height ? abs(arrow_offset) : base_height;

    max_arm_gap = 1.5;
    arm_gap = abs(arm_gap) <= max_arm_gap ? arm_gap : max_arm_gap;

    vane_width = abs(vane_width);

    vane_length = abs(vane_length);

    arm_offset = abs(arm_offset);

    min_vane_offset = (base_height - arrow_offset) + arm_offset + 4;  
    vane_offset = vane_offset >= min_vane_offset ? vane_offset : min_vane_offset;

    //dependent internal variables
    base_diameter = arrow_diameter + 2*hinge_diameter + 2;
    base_radius = base_diameter/2;
    arrow_radius = arrow_diameter/2;
    hinge_radius = hinge_diameter/2;
    arm_height = vane_length + 2*(vane_offset-arm_offset-(base_height - arrow_offset));
    arm_width = hinge_width + hinge_pin + 3;

    //max vane turn limit calculation
    max_vane_turn = atan((((arrow_radius+arm_gap)*sqrt(3))/2 - vane_width/2)/(vane_length/2));
    vane_turn = abs(vane_turn) <= max_vane_turn ? vane_turn : sign(vane_turn)*max_vane_turn;


    //base
    if (part_select == 1 || part_select == 0)
    difference()
    {
        base_mold(a = arm_width, radius = base_radius, height = base_height);
        translate([0,0,arrow_offset]) cylinder(base_height,d=arrow_diameter, true);
        //hinge holer
        for (i = [0:2]) 
        {
            rotate(a=[0,0,i*120]) 
                translate([(base_radius) - hinge_radius, 0, base_height - hinge_depth + hinge_radius]) 
                        hinge (hinge_width, hinge_thickness, hinge_diameter, hinge_depth + arm_offset - hinge_radius, hinge_pin, true);
        }
    }

    //arm
    if (part_select == 2 || part_select == 0)
        rotate(flag_showAll*[0,90,0]) 
            translate(-flag_showAll*[base_radius,0,arm_height/2 + base_height + arm_offset])
    union()
    {
        difference()
        {
            translate([0,-arm_width/2,base_height + arm_offset])  
                cube([base_radius, arm_width, arm_height], false);
            //intersections with two remaining arms
            rotate(a = 120) translate([ -arm_width,0,base_height + arm_offset]) 
                cube([arm_width*2, arrow_diameter, arm_height], false);
            rotate(a = -120) mirror([0,1,0]) translate([ -arm_width,0,base_height + arm_offset]) 
                cube([arm_width*2, arrow_diameter, arm_height], false);
            //shaft hole
            translate([0,0,base_height]) 
                cylinder(arm_height + base_height,d=arrow_diameter, true);
            //vane
            if (helical)
            {
                //r - radius of arrow + gap for vane foot - correction
                //t - values from 0 to maximum spread (side of equilateral triangle in circumscribed cirle)
                //x - distance from center to arm based on t
                r = arrow_radius+arm_gap-0.35;
                t = helical_adjust < (r * sqrt(3)) ? helical_adjust : (r * sqrt(3));
                x = sqrt(pow(r,2) - pow(t,2)/4);
                
                translate([x,0, vane_length/2 + arrow_offset + vane_offset])
                    helical_vane(width = vane_width, 
                                    length = vane_length, 
                                    height = base_diameter, 
                                    spread = t/2 - vane_width/2,                            
                                    direction = helical_direction);
            }
            else
            {
                translate([base_radius/2,0, vane_length/2 + arrow_offset + vane_offset])
                    rotate([vane_turn,0,0])
                        cube([base_radius, vane_width, vane_length], true);
            }
            //vane foot cutout
            translate([0,0,arrow_offset + vane_offset]) cylinder(vane_length,r=arrow_radius + arm_gap, true);
            minkowski()
            {
                translate([0,0,arrow_offset + vane_offset]) cylinder(vane_length,r=arrow_radius, true);
                rotate_extrude(angle = 360, convexity = 2) 
                difference()
                {
                    rotate([0,0,90]) ellipse(4*arm_gap, 2*arm_gap);
                    translate([0,-2*arm_gap]) square(4*arm_gap, false);
                }
            }
        }
        translate([base_radius - hinge_radius, 0, base_height - hinge_depth + hinge_radius]) 
                            hinge(hinge_width - hinge_gap, hinge_thickness, hinge_diameter - hinge_gap, hinge_depth + arm_offset - hinge_radius, hinge_pin - hinge_gap, false);
    }

    //lid

    lid_thickness = 1;
    lid_lip = 2;
    lid_gap = 0.25;

    if (part_select == 3 || part_select == 0)
        translate((flag_showAll-1)*[3*base_radius,0,0]) 
    difference()
    {
        h = vane_offset-arm_offset-(base_height - arrow_offset) + lid_thickness;
        w = arm_width + lid_gap;
        r = base_radius + lid_gap;
        base_mold(a = w + lid_thickness, radius = r + lid_thickness, height = h);
        translate([0,0,lid_thickness] )base_mold(a = w, radius = r, height = h);
        base_mold(a = w - lid_lip, radius = r - lid_lip, height = h);
    }
}

print_part();

module print_part() {
	if (part == 0) {
		jig (
        part,
        arrow_diameter,
        arrow_offset,
        base_height,
        hinge_width,
        hinge_thickness,  
        hinge_diameter,
        hinge_depth,
        hinge_pin,
        arm_gap,         
        arm_offset,
        vane_length, 
        vane_width, 
        vane_offset,
        vane_turn,
        helical,
        helical_adjust,
        helical_direction
    );
	} else if (part == 1) {
		jig (
        part,
        arrow_diameter,
        arrow_offset,
        base_height,
        hinge_width,
        hinge_thickness,  
        hinge_diameter,
        hinge_depth,
        hinge_pin,
        arm_gap,         
        arm_offset,
        vane_length, 
        vane_width, 
        vane_offset,
        vane_turn,
        helical,
        helical_adjust,
        helical_direction
    );
	} else if (part == 2) {
		jig (
        part,
        arrow_diameter,
        arrow_offset,
        base_height,
        hinge_width,
        hinge_thickness,  
        hinge_diameter,
        hinge_depth,
        hinge_pin,
        arm_gap,         
        arm_offset,
        vane_length, 
        vane_width, 
        vane_offset,
        vane_turn,
        helical,
        helical_adjust,
        helical_direction
    );
	} else if (part == 3) {
		jig (
        part,
        arrow_diameter,
        arrow_offset,
        base_height,
        hinge_width,
        hinge_thickness,  
        hinge_diameter,
        hinge_depth,
        hinge_pin,
        arm_gap,         
        arm_offset,
        vane_length, 
        vane_width, 
        vane_offset,
        vane_turn,
        helical,
        helical_adjust,
        helical_direction
    );
	} else {
		jig (
        part,
        arrow_diameter,
        arrow_offset,
        base_height,
        hinge_width,
        hinge_thickness,  
        hinge_diameter,
        hinge_depth,
        hinge_pin,
        arm_gap,         
        arm_offset,
        vane_length, 
        vane_width, 
        vane_offset,
        vane_turn,
        helical,
        helical_adjust,
        helical_direction
    );
	}
}

