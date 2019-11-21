/* [dimensions] */
// width of drawer
width = 54;
// height of drawer
height = 37;
// depth of drawer without grip
length = 139;
// depth of grip
grip_depth = 12;
// height of the overhanging part of the grip
grip_height = 12;
// height of the vertical front
grip_frontheight = 23;
// distance between upper rim and grip
grip_downshift = 1;
// diameter of the holes in the grip
griphole_diameter = 24;
// thickness of all walls
wall_thickness = 0.8;
// vert. dist. rim of drawer and rim of inlay
compartment_wall_topdistance = 1;
// width of holder on back-wall
backholder_width=44;
// height of holder on back-wall
backholder_height=4;
// space for moving parts
sfm = 0.75;

/* [organization] */
// number of rows (over length)
rows = 2;
// number of columns
columns = 3;
// number of shelves (including the drawer)
layers=3;

/* [printing] */
// distance between objects
print_distance = 5;
// layout for printing
print_layout=1;
// print the drawer
print_drawer=1; // [0:no, 1:yes]
// number of inlay-shelves to print
print_inlays=2; 

/* [Hidden] */
debug_flag=false;
tol = 0.1;

/* Raaco 150-0 Drawer:
width = 54;
height = 37;
length = 139;
grip_depth = 12;
grip_height = 12;
grip_frontheight = 23;
grip_downshift = 1;
griphole_diameter = 24;
*/

/* Powerfix Kleinteile-Magazin:
width = 68;
height = 36;
length = 118;
grip_depth = 8;
grip_height = 8;
grip_frontheight = 26;
grip_downshift = 1;
griphole_diameter = 16;
*/

//compartment_wall_height = 17.5;
compartment_wall_height = (height-compartment_wall_topdistance)/layers;
a = atan2(grip_depth,grip_height);
// echo(a);

rotate(0,0,-90)
{
    if (print_drawer)
    {
        Drawer();
    }
    if (print_inlays)
    {
        for (layer=[1:print_inlays])
        {
            translate(
            print_drawer ?
                print_layout
                ?
                    [(width+print_distance)*layer,0,0]
                :
                    [(wall_thickness+sfm),wall_thickness+sfm,(compartment_wall_height+sfm)*layer]
            :
                [0,0,0]
            )
                InnerBox();
        }
    }
}

module GripSidewall(ext,h)
{
    linear_extrude(height=h)
    {
        polygon(
        [
            [0,-ext*wall_thickness],
            [0,grip_depth],
            [grip_height+grip_frontheight,grip_depth],
            [grip_frontheight-ext*wall_thickness*tan(90-a),-ext*wall_thickness]
        ]);
    }
}

module LabelHolder()
{
    difference()
    {
        GripSidewall(2,width);
        translate([-tol,0,-tol])
            cube([grip_frontheight+grip_height,grip_depth+2*wall_thickness+tol,width+2*tol]);
        translate([-tol,-wall_thickness,wall_thickness])
            cube([grip_frontheight-2*wall_thickness+2*tol,grip_depth+2*wall_thickness+tol,width-2*wall_thickness]);
        translate([-tol,-2*wall_thickness-tol,3*wall_thickness])
            cube([grip_frontheight-4*wall_thickness,wall_thickness+2*tol,width-6*wall_thickness]);
    }
}

module Grip()
{
    ngripholes = round((width-2*wall_thickness)/(griphole_diameter+wall_thickness)-0.5);
    griphole_distance=width/ngripholes;
    difference()
    {
        linear_extrude(height=width)
        {
            polygon(
            [
                [0,0],
                [0,wall_thickness/cos(a)],
                [grip_frontheight,wall_thickness/cos(a)],
                [grip_height+grip_frontheight-wall_thickness/sin(a),grip_depth],
                [grip_height+grip_frontheight,grip_depth],
                [grip_frontheight,0]
            
            ]);
        }
        for (i=[0:ngripholes-1])
        {
            //x = griphole_diameter/2+wall_thickness + i * griphole_distance;
            x = griphole_distance/2 + i * griphole_distance;
            translate([grip_height+grip_frontheight,grip_depth,x])
                rotate([90,0,0])
                    translate([0,0,-tol])
                    cylinder(r=griphole_diameter/2, h=grip_depth+2*wall_thickness+tol, $fn=8);
                // sphere(r=griphole_diameter/2);
        }
    }
    /*
    */
    translate([0,0,0])
        LabelHolder();
    
    for (x=[0,,width-wall_thickness])
        translate([0,0,x])
            GripSidewall(2,wall_thickness);
    for (i=[0:ngripholes-2])
    {
        x = griphole_distance + i * griphole_distance;
        translate([0,0,x-wall_thickness/2])
            GripSidewall(0,wall_thickness);
    }
}

module Drawer()
{
    Box(width,length,height,wall_thickness);
    translate([(width-backholder_width)/2,length-wall_thickness,height-tol])
        cube([backholder_width,wall_thickness,backholder_height]);
    translate([0,-grip_depth,height-grip_downshift])
        rotate([0,90,0])
            Grip();
}

module InnerBox()
{
    Box(width-2*(sfm+wall_thickness),
        length-2*(sfm+wall_thickness),
        compartment_wall_height-sfm,
        wall_thickness);
}

module Box(width,length,height,wall_thickness)
{
    difference()
    {
        cube([width,length,height]);
        translate([wall_thickness,wall_thickness,wall_thickness])
            cube([width-(2*wall_thickness),length-(2*wall_thickness),height-wall_thickness+tol]);
    }
    compartment_depth = ((length-wall_thickness)/rows);
    compartment_width = ((width-wall_thickness)/columns);
    inner_compartment_depth = compartment_depth - wall_thickness;
    inner_compartment_width = compartment_width - wall_thickness;
    echo(str("inner compartment width: ", inner_compartment_width, 
            "; inner compartment length: ", inner_compartment_depth,
            "; inner compartment height: ", compartment_wall_height - wall_thickness
    ));
    if (debug_flag)
    {
        for (i=[0:rows-1])
        {
            for (j=[0:columns-1])
                translate([j*compartment_width+wall_thickness,i*compartment_depth+wall_thickness,compartment_wall_height])
                    #cube([inner_compartment_width,inner_compartment_depth,1]);
        }
    }
    
    if (rows > 1)
        for (i=[1:rows-1])
        {
            y = i * compartment_depth;
            translate([wall_thickness/2,y,wall_thickness/2])
                cube([width-wall_thickness,wall_thickness,compartment_wall_height-wall_thickness*1.5]);
        }
    if (columns > 1)
        for (i=[1:columns-1])
        {
            x = i * compartment_width;
            translate([x,wall_thickness/2,wall_thickness/2])
                cube([wall_thickness,length-wall_thickness,compartment_wall_height-wall_thickness*1.5]);
        }
}

