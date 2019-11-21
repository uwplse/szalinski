//Procedural Project Box Screws Remix
//CudaTox, 2017
//Corrected issues when thickness is changed screw columns are not located correctly.
//Corrected issue whtn thickness is greater than 2 and lip_tol is used created offset in screw posts in lid.
//Added options for lid reinforcment and lid screw stud length
//Cleaned up code buy calculating global variables to use in place of formulas.
//Ron Shenk 2019
//Revision 1
//Added variables to allow generating each element seperate or together

generate_box = true;            // true generates box false skips generating the box
generate_lid = true;            // true generates lid, false skips generating the lid
inside_width = 70;
inside_length = 100;
inside_height = 50;
thickness = 3;                   //Wall thickness
radius =3;              		//Fillet radius. Should not be larger than thickness
screw_dia = 3;                  //Diameter of the screw you intend to use
screw_loose_dia = 3.5;
extra_lid_thickness = 0;        //Extra lid thickness above thickness. 
                                //You may want to tweak this to account for large chamfer radius.
lip_tol = .5;					//this tolerence helps the lid fit
lid_stud_height = 4;			//Length of studs on lid
lid_lip_height = 2;    			//Lid reinforcement lip height
lid_lip_width =4;				//Width of lid reinforcement lip

use_ic_studs = true;           //do you want ic studs in box value must be true or false
ic_stud_height = 7;             //IC stud height
ic_stud_id = 3;                 //Diameter of screw needed
ic_stud_od = ic_stud_id*2.5;    //you can set this manually to a fixed value in place of the formula
ic_stud_multiplier = .9;       //decreases stud id when using threaded fastners so they have purchase
ic_stud_start_x = 19;           //IC stud starting X position
ic_stud_start_y = 10;            //IC stud starting Y position
ic_stud_width = 33;             //Witdth between centers of ic studs
ic_stud_length = 43;            //Length between centers of ic studs

// Computation of variables used in box creation do not modify values below this line
od = screw_dia * 2.5;
outside_width = inside_width + (thickness * 2);
outside_length = inside_length + (thickness * 2);
outside_height = inside_height + (thickness * 2);
box_stud_height = inside_height - lid_stud_height;
column_offset = (od/2)+thickness;
column_radius = od/2;
lid_startpos = (outside_width*-1)-2;
lid_lengthoffset = inside_length - column_radius + thickness;
lid_widthoffset = inside_width - column_radius + thickness;
ic_stud_real_id = ic_stud_id * ic_stud_multiplier;

module box_ic_stud(height,id,od){
    difference(){
        cylinder(d=od, h=height, $fn=100);
        cylinder(d=id * ic_stud_multiplier, h=height, $fn=100);
    }
}

module box_screw(id, od, height){
    difference(){
        union(){
            cylinder(d=od, h=height, $fs=0.2);
            translate([-(od/2), -(od/2), 0])
                cube([(od/2),od,height], false);
            translate([-od/2, -(od/2), 0])
                cube([od,(od/2),height], false);
        }
        cylinder(d=id, h=height, $fn=6);
    }
}

module rounded_box(x,y,z,r){
    translate([r,r,r])
    minkowski(){
        cube([x-r*2,y-r*2,z-r*2]);
        sphere(r=r, $fs=0.1);
    }
}

module main_box(){
    difference()
    {
        //cube([outside_width, outside_length, outside_height]);
        difference(){
            rounded_box(outside_width, outside_length, outside_height, radius);
            translate([0,0,inside_height + thickness])
            cube([outside_width, outside_length, outside_height]);
        }
        translate([thickness, thickness, thickness])
        cube([inside_width, inside_length, inside_height + thickness]);
    }
    od = screw_dia * 2.5;
    
    translate(0,0,0)
	translate([column_offset,column_offset, thickness])
        box_screw(screw_dia, od, box_stud_height);
    
    translate(0,0,0)
	translate([outside_width - column_offset, column_offset, thickness])
        rotate([0,0,90])
            box_screw(screw_dia, od, box_stud_height);
    
    translate(0,0,0)
	translate([outside_width - column_offset, outside_length - column_offset, thickness])
        rotate([0,0,180])
            box_screw(screw_dia, od, box_stud_height);

    translate(0,0,0)
	translate([column_offset, outside_length - column_offset, thickness])
        rotate([0,0,270])
            box_screw(screw_dia, od, box_stud_height);

    if (use_ic_studs)
    {
        //IC Studs
        translate([ic_stud_start_x, ic_stud_start_y, thickness])
            box_ic_stud(ic_stud_height, ic_stud_real_id , ic_stud_od);
        translate([ic_stud_start_x,ic_stud_start_y + ic_stud_length, thickness])
            box_ic_stud(ic_stud_height, ic_stud_real_id , ic_stud_od);
        translate([ic_stud_start_x + ic_stud_width, ic_stud_start_y + ic_stud_length, thickness])
            box_ic_stud(ic_stud_height, ic_stud_real_id , ic_stud_od);
        translate([ic_stud_start_x + ic_stud_width, ic_stud_start_y, thickness])
            box_ic_stud(ic_stud_height, ic_stud_real_id , ic_stud_od);        
    }
}

module lid(){
    difference()
        {
        union()
        {
            //Lid.
            difference(){
                rounded_box(outside_width, outside_length, thickness * 4, radius);
                //move slightly to the right to get ride of abandoned surfaces
                translate([-1,0, thickness + extra_lid_thickness]) 
                    //increased width to remove abandoned surfaces
                    cube([outside_width+2, outside_length, inside_height + thickness * 4]);  
            }
            //Lip
            lip_width = inside_width - lip_tol;
            lip_length = inside_length - lip_tol;
            translate([(outside_width - lip_width)/2,(outside_length - lip_length)/2, thickness *.99])
                difference(){
                    cube([lip_width, lip_length, lid_lip_height]);
                    translate([lid_lip_width, lid_lip_width, 0])
                        //added extra z to ensure no remaining surfaces
                        cube([lip_width-(lid_lip_width*2), lip_length-(lid_lip_width*2), lid_lip_height+1]);  
            }
        
            //stud columns
            intersection(){
                union(){
                translate([column_offset, column_offset, thickness])
                    box_screw(screw_dia, od, lid_stud_height);
                translate([lid_widthoffset, column_offset, thickness])
                    rotate([0,0,90])
                        box_screw(screw_dia, od, lid_stud_height);
                translate([lid_widthoffset, lid_lengthoffset, thickness])
                    rotate([0,0,180])
                        box_screw(screw_dia, od, lid_stud_height);
                translate([column_offset, lid_lengthoffset, thickness])
                    rotate([0,0,270])
                        box_screw(screw_dia, od, lid_stud_height);
                }
                translate([thickness + (lip_tol/2), thickness + (lip_tol/2), 0])
                cube([lip_width , lip_length, 10]);
            }

        }

        //Holes
        union()
        {
            translate([column_offset, column_offset, thickness])
                cylinder(h = thickness + lid_stud_height + 2, d = screw_loose_dia, center=true, $fs=0.2);
            translate([lid_widthoffset, column_offset, thickness])
                cylinder(h = thickness + lid_stud_height + 2, d = screw_loose_dia, center=true, $fs=0.2);
            translate([lid_widthoffset, lid_lengthoffset, thickness])
                cylinder(h = thickness + lid_stud_height + 2, d = screw_loose_dia, center=true, $fs=0.2);
            translate([column_offset, lid_lengthoffset, thickness])
                cylinder(h = thickness + lid_stud_height + 2, d = screw_loose_dia, center=true, $fs=0.2);
        }

    }
}

if (generate_box)
{
    main_box();
}
if (generate_lid) 
{    
    translate([lid_startpos,0,0])
    lid();
}    


