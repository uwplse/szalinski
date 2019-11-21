echo("Built using Ultimate Box Generator v3.5.0");

// Parts to render. To do more complex opperations disable these and manually call make_box() and make_lid() instead.
show_box=true;	// Whether or not to render the box
show_lid=false;	// Whether or not to render the lid. To make open boxes with no lid set `show_lid=false` and `lid_type=5`.

// General Settings
comp_size_deep = 28; // Depth of compartments
comp_size_x = 21;	 // Size of compartments, X
comp_size_y = 110;	 // Size of compartments, Y
wall = 2;		    // Width of wall, see `internal_wall` below for alternate inner wall size.
repeat_x = 6;		// Number of compartments, X
repeat_y = 1;		// Number of compartments, Y
tolerance=.15;      // Tolerance around lid.  If it's too tight, increase this. If it's too loose, decrease it.

// Box Rounding
box_corner_radius=0; // Add a rounding affect to the corners of the box. Anything over `wall` will cause structure and lid problems.
box_corner_radius_axis=[true, true, true]; // Apply rounding on [X, Y, Z] Axis
internal_corner_radius=0; // Add a rounding affect to the inside.
mesh_corner_radius=0; // Leave a radius around each corner of the mesh. May hep with bridges.
corner_fn=30;

// Supress individual walls.
supress_walls_x=[]; // These are the walls running along the X axis. It should be an array of size [repeat_y-1][repeat_x].
supress_walls_y=[]; // These are the walls running along the Y axis. It should be an array of size [repeat_x-1][repeat_y].
// Example for repeat_x=4, repeat_y=3:
//supress_walls_x=[[1,0,1,1],[0,1,0,1]];
//supress_walls_y=[[1,0,1],[0,1,1],[1,1,1]];

// Mesh Settings
// To make rounded corners and no mesh use any `mesh_type` > 0 and set `strut_gap` to a high value.
// 0: No mesh, solid wall.
// 1: Single direction mesh.
// 2: Two direction cross mesh and 90 degree angle to eachother.
// 3: Two direction mesh but mirrored around 90 axsis instead or rotated 90 degrees.
// 4: Calculate angle across the diagonal of each opening. You will also want to change `strut_gap` to a large number and set `strut_count_min=1`.
// 5: No mesh, empty wall.
// 6: Honycomb. Also set `strut_width=wall/4` and `strut_gap=wall*2`. To big of a `strut_gap` may fail to print. Other shapes can be generated with `mesh_fn` and reducing `mesh_inset_padding` may help.
mesh_type=0; // Mesh type, see above.
mesh_rotation=0; // 0-90 degrees.
mesh_alt_rotation=mesh_rotation; // Alternate rotation for top and bottom faces.
mesh_do_sides=true; //[true, true, true, false] Include mesh on each side along axis. [X, Y, X, Y]
mesh_do_bottom=false; // Include mesh on bottom plate.
mesh_do_top=true; // Include mesh on top piece.
mesh_do_interior=false; // Include mesh on inner walls.
mesh_inset_padding=wall; // Leave some solid material before building strut frame. Anything less then wall/2 will likely fall apart.
mesh_fn=mesh_type == 6 ? 6 : 40; // Complexity of curves in mesh's, increese for smoother curves.
strut_width=wall*2; // Width of each strut, 0=hollow.
strut_gap=wall; // Width of the air gap between each strut. 0=fine air gaps.
strut_count_min=0; // Optinal minimum number of struts regardless of size calulations.
alt_strut_width=strut_width; // Width of struts going the other directions.
alt_strut_gap=strut_gap; // Width of gap going the other direction.
alt_strut_count_min=strut_count_min; // Optinal minimum number of struts regardless of size calulations.
mesh_overflow=0; // Extra rows to add to the mesh. For example in the Honeycomb partial hexegons will be created along the edges.

// Lid Settings
// 0: No Lid. top may be rounded and can cause other rendering changes.
// 1: Lid that slides off in the x direction.
// 2: Lid with a snapped in hinge that rotates open
// 3: Lid that snaps down onto the box. Also need to change lid_height to around 1.5mm.
// 4: Stackable version of cover 1 there boxes slide into one another. You will need one cover for the last box. (Not tested)
// 5: Oversized lid sits on top and has sides that extend down. (Needs snapp support)
lid_type=4; // Lid type, see above.
has_thumbhole=true; // Add gripping locations for easy opening.
has_coinslot=false; // Add slot in the top for dropping in components.
has_snap=true; // Add small ridges or snaps to lids to help keep them closed.
coinslot_x=20;	// Size in X direction
coinslot_y=2.5;	// Size in Y direction
z_tolerance=0;   // Z tolerance can be tweaked separately, to make the top of the sliding lid be flush with the top of the box itself.
extra_bottom=.15; // Extra bottm wall height to fit type 4 slider.
hinge_inset=.75; // Size of the hinge connection.
snap_inset=.25; // Amount of overhang for snaps to snap into place.
snap_tolerance=tolerance; // You may need to add tolerance around lid and snaps to let them move freely.
lid_offset=3;		// This is how far away from the box to print the lid
lid_height=wall*2;  // Height of lid. Must be greater than wall width for a `lid_type=5` lid to work. On Lid 3 is the depth of the inset snap.
lid_fn=40; // Increese if printing thicker walls.
lid_alt_offset=false; // Move lid in X instead of Y for printing.

//Internal Structure (You may need to turn off `mesh_do_sides` or `mesh_do_bottom` for good results.)
// You can also use `make_wall()` to manually add your own walls.
// 1: Rounded bottom frame.
// 2: Hexegon bottom frame. (To make this shape perfect set `comp_size_deep` to the width between to edges of the tile and set `comp_size_x` or `comp_size_y` to this this: `comp_size_deep / sqrt(3)*2`.
// 3: Rough bottom for make bits sit unevenly. (Partial)
// 4: Verical rounding on cordner. Set `internal_size_deep` to `comp_size_deep` and `internal_size_circle` to the shortest `comp_size` for a circle.
// 5: Vertical hexegon. Retulst may varry.
internal_type=0; // Internal structure, see above.
internal_rotate=false; // On lid axis or rotate to opposite.
internal_size_deep=comp_size_deep/2; // How far into the box to start the internal structure. Should be `comp_size_deep/2` for type 1-2, `wall` for 3, or comp_size_deep for type 4-5.
internal_size_circle=internal_type==1 ? internal_size_deep : internal_size_deep * 2 / sqrt(3); // Use this calculation, or the shorter comp_size for type 4-5.
internal_fn=internal_type==1 || internal_type==4 ? 60 : 6; // Complexity of internal curves, may need to increase for larger or smoother curves.
internal_wall=wall; // Custom size for internal walls.

// Text Settings
// 0: None.
// 1: Cutout. Remove material formt he wall.
// 2: Raised. If a mesh is ued part of it is filled in to hold the text. Lids 0 and 3 are printed upside down by default. With this option used they will require supports regardless of the orrientation printed.
text_type=1; // Text type, see above.
text_depth=wall/2; // Distance to cutout text or raise it. User `wall` to cut through.
text_size=5; // Font Size.
text_font="Courier New:style=Bold"; // Use Hepl -> Font List to see options.
text_message="Gold"; // Message Text, or use `["Line 1", "Line 2"]` for multiline.
text_message_compartments=false;//[["AA", "BB", "CC"], ["AB", "BC", "CD"]]; // Custom text for compartments in top or bottom. Also support multiline as `[[ ["A", "B"] ]]`.
text_sides=true;//[true, true, true, false]; // Sides to put text on, [X, Y, X, Y]
text_top=false; // Put Text on the top.
text_bottom=false; // Put Text on the bottom.
text_rotation=0; // Rotate the top and bottom text by X degrees. 90 will rotate from the X axis to the Y axis.
text_offset=0; // Text is verticaly centered in the wall. This may look "off" due to casing or hanging tails. You can manually adjust the vertical alignment with this setting.
text_fn=30; // Complexity of the letters, may need to increese with larger fonts.
text_backdrop_scale=[.9, 1.5]; // Font size scaleing used on the backdrop when `text_type=2` is used on sides with a mesh.

// Complex Structure
make_complex_box=false; // Use an array of objects from `complex_box` to create many smaller boxes within the larger box.
internal_grow_down=true; // If set compartments will be extruded into the larger box from the top to make a flush surface. (May make a model that uses a lot of material.
internal_empty_bottom=false; // If set the area blow each box will be empty. This will not be printable on a FDM printer unless supports are included internally but still may save material and print time.

// Main Program
if (show_box) {
    make_box();
    
    if(make_complex_box) {
        make_complex_box();
    }
    //make_wall(0, wall+15, false, internal_size_deep=comp_size_deep, internal_wall=internal_wall);
}

if (show_lid) {
    make_lid();
}

// Computations, Dont Edit.
oversize=.5;
thumbrad = min(20,repeat_y*(comp_size_y+wall)/3);
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left

function calc_number_struts(x, y, pivot, width, rotation) = ( rotation/90*(pivot?y:x) + (1-rotation/90)*(pivot?x:y)  - mesh_inset_padding*2) / width - 1;
function calc_size(repeat, comp_size) = repeat * (comp_size + internal_wall) - internal_wall + wall*2;
function calc_offset(repeat, comp_size) = repeat * (comp_size + internal_wall) + wall;
function calc_rotation(rotation, size_x, size_y) = rotation / 180 - floor(rotation / 180) >= .25 && rotation / 180 - floor(rotation / 180) < .75 ? size_y : size_x;
function make_object(x, y, z, offset_x, offset_y, repeat_x, repeat_y, color) = [
    [x, y, z],
    [offset_x, offset_y, 0],
    [repeat_x, repeat_y],
    [calc_size(repeat_x, x, wall=internal_wall, internal_wall=internal_wall), calc_size(repeat_y, y, wall=internal_wall, internal_wall=internal_wall)],
    [offset_x + calc_size(repeat_x, x, wall=internal_wall, internal_wall=internal_wall) - internal_wall, offset_y +calc_size(repeat_y, y, wall=internal_wall, internal_wall=internal_wall) - internal_wall],
    [color]
];

/*** More complex module that itterates through complex_box to create many boxes. ***/
module make_complex_box() {
    intersection() {     
        translate([wall, wall, wall])
        cube([comp_size_x, comp_size_y, comp_size_deep]);
        
        translate([wall-internal_wall, wall-internal_wall, wall-internal_wall])
        //for(row = complex_box) {
            for(area = complex_box) {
               translate(area[1])
               color(area[5][0])
               make_internal_box(area[0][0], area[0][1], area[0][2], wall=internal_wall, repeat_x=area[2][0], repeat_y=area[2][1]);
            }
        //}
    }
}

/*** Code to create a custom wall withing a bigger box. ***/
module make_wall(row, offset, rotate, internal_size_deep=internal_size_deep, internal_wall=internal_wall, wall=wall) {
    offset_row=calc_offset(row, rotate ? comp_size_x : comp_size_y, internal_wall=internal_wall, wall=wall);
    
    translate([rotate ? offset_row : offset, rotate ? offset : offset_row, wall])
    difference() {
        cube([rotate ? comp_size_x : internal_wall, rotate ? internal_wall : comp_size_y, internal_size_deep]);
        rotate([rotate ? 90 : 0, rotate ? 0 : -90, 0])
        translate([mesh_inset_padding, mesh_inset_padding, - .5-internal_wall])
        make_mesh(rotate ? comp_size_x : internal_size_deep - wall*(lid_type==5?1:0), rotate ? internal_size_deep - wall*(lid_type==5?1:0) : comp_size_y, mesh_rotation, !rotate);
    }
}

/*** Code used in make_mesh to create complex struts that may be reused elsewhere. ***/
module make_struts (x, y, thickness, number_of_struts, struts_width, angle) {
	angle2 = angle % 180;
	hypotenuse = sqrt(pow(x,2)+pow(y,2)); //lenght of the diagonal
	number_of_struts = mesh_type == 5 ? 0 : floor(number_of_struts);
    length = mesh_rotation/90*x+(1-mesh_rotation/90)*y;
    //length= angle%180 > 45 ? mesh_rotation/90*y+(1-mesh_rotation/90)*x : mesh_rotation/90*x+(1-mesh_rotation/90)*y;
    //
        if(number_of_struts > 0) {
            // Repating Mesh
            if(mesh_type == 6) {
                difference(){
                    square([x, y]);
                    no_x = (angle >= 90 ? y : x) / (sqrt(3)/2 * (strut_gap + struts_width)) - 1 + mesh_overflow;
                    off_x= (angle >= 90 ? y : x) - sqrt(3)/2 *(strut_gap + struts_width) * floor(no_x) - strut_gap;
                    no_y = (angle >= 90 ? x : y) / (strut_gap + struts_width) - 1 + mesh_overflow;
                    no_y_extra = no_y - floor(no_y);
                    off_y= (angle >= 90 ? x : y) - (strut_gap + struts_width) * floor(no_y) - strut_gap/2 - (no_y_extra <= .5 ? (strut_gap + struts_width)/2 : strut_gap + struts_width);
                    pos_x = sqrt(3)/2 * (strut_gap + struts_width);
                    pos_y = (strut_gap + struts_width) / 2;
                    
                    translate([angle >= 90 ? off_y/2 : off_x/2, angle >= 90 ? -off_x/2 : off_y/2, 0])
                    translate([strut_gap/2 , strut_gap/2 , 0])
                    // Correct for rotated Y sides
                    translate([0,angle >= 90 ? y - strut_gap : 0, 0])
                    rotate([0, 0, angle >= 90 ? -90 : 0])
             
                    for (i = [0 :  floor(no_x)]) {
                        translate([i * pos_x, (i % 2) * pos_y, 0])
                        for (r = [0 :  floor(no_y_extra <= .5 && i % 2 ? no_y - 1 : no_y )  ]) {
                            translate([0, r * (strut_gap + struts_width), 0])
                            rotate([0, 0, (angle >= 90 ? angle - 90 : angle) % 60])
                            circle(d = strut_gap, $fn = mesh_fn);
                        }
                    }
                }
            } else {
                // Line Mesh
                intersection(){
                    square([x,y]);
              
                    if (angle2 <= 90 && angle >=0) {
                        cosa = x/hypotenuse;
                        for ( i = [1 : number_of_struts] ) {
                            start = ((hypotenuse - number_of_struts* (struts_width/(cos(angle2-acos(cosa))))) / (number_of_struts + 1))*i + (struts_width/(cos(angle2-acos(cosa))))*(i-1);
                            rotate([0,0,acos(cosa)])
                            translate([start,0, 0])
                            rotate([0,0,angle2-acos(cosa)])
                            translate([0,-hypotenuse , 0]) //sin(angle2-acos(cosa))*start 
                            square([struts_width, 2*hypotenuse]);
                        }
                    }
                    else {
                        cosa = y/hypotenuse;
                        translate([x,0])
                        for ( i = [1 : number_of_struts] ) {
                            start = ((hypotenuse - number_of_struts* (struts_width/(sin(angle2-acos(cosa))))) / (number_of_struts + 1))*i + (struts_width/(sin(angle2-acos(cosa))))*(i-1);
                            rotate([0,0,acos(cosa)])
                            translate([0,start,0])
                            rotate([0,0,angle2-90-acos(cosa)])
                            translate([-hypotenuse,0, 0])
                            square([2*hypotenuse, struts_width]);
                            
                        }
                    }
                }
            }
    }
    // Corner Radius
    if(mesh_corner_radius > 0) {
        difference() {
            square([x, y]);
            
            minkowski() {
                mesh_corner_radius=mesh_corner_radius >= x/2 ? x/2 - .01 : (mesh_corner_radius >= y/2 ? y/2 - .01 : mesh_corner_radius);
                translate([mesh_corner_radius,mesh_corner_radius,0])
                square([x - mesh_corner_radius*2,y - mesh_corner_radius*2]);
                circle(mesh_corner_radius, $fn=corner_fn);
            }
        }
    }
        
        //}
}

/*** Code to create complex mesh and other cutouts in the box walls. ***/
module make_mesh(width, height, rotation, pivot=false, inverted=false) {
    if(mesh_type != 0) {
//        pivot = mesh_type == 6 ? false : pivot;
        num_strut=max(strut_count_min, calc_number_struts(width, height, !pivot, strut_width + strut_gap, rotation));
        alt_num_strut=max(alt_strut_count_min, calc_number_struts(width, height, pivot, alt_strut_width + alt_strut_gap, mesh_type==3 ? 90-rotation : rotation));
        rotation = mesh_type == 4 ? acos((pivot ? width: height) / sqrt(pow(width,2)+pow(height,2))) : rotation;
        
        linear_extrude(height=wall + oversize*2, convexity=2)
        if(!inverted)
            difference() {
                square([width - mesh_inset_padding*2, height - mesh_inset_padding*2]);
                make_struts(width - mesh_inset_padding*2, height - mesh_inset_padding*2, wall + oversize*2, num_strut, strut_width, rotation + (pivot ? 90: 0), mesh_type=mesh_type);
                if(mesh_type == 2)
                    make_struts(width - mesh_inset_padding*2, height - mesh_inset_padding*2, wall + oversize*2, alt_num_strut, alt_strut_width, rotation + (pivot ? 0: 90), mesh_type=mesh_type);
                if(mesh_type == 3 || mesh_type == 4)
                    make_struts(width - mesh_inset_padding*2, height - mesh_inset_padding*2, wall + oversize*2, alt_num_strut, alt_strut_width, 90-rotation + (!pivot ? 90: 0), mesh_type=mesh_type);
            }
        else
            union() {
                make_struts(width - mesh_inset_padding*2, height - mesh_inset_padding*2, wall + oversize*2, num_strut, strut_width, rotation + (pivot ? 90: 0), mesh_type=mesh_type);
                if(mesh_type == 2)
                    make_struts(width - mesh_inset_padding*2, height - mesh_inset_padding*2, wall + oversize*2, alt_num_strut, alt_strut_width, rotation + (pivot ? 0: 90), mesh_type=mesh_type);
                if(mesh_type == 3 || mesh_type == 4)
                    make_struts(width - mesh_inset_padding*2, height - mesh_inset_padding*2, wall + oversize*2, alt_num_strut, alt_strut_width, 90-rotation + (!pivot ? 90: 0), mesh_type=mesh_type);
            }
    }
    else if(inverted) {
        cube([width - mesh_inset_padding*2, height - mesh_inset_padding*2, wall + 1]);
    }
}

/*** The main code that created a simple box. ***/
module make_box() {
    totalheight = lid_type == 1 || lid_type == 2 ? comp_size_deep + wall : ( lid_type == 4 ? comp_size_deep + wall + extra_bottom : comp_size_deep);
    
    box_z = totalheight + wall;
    box_x = calc_size(repeat_x, comp_size_x, internal_wall=internal_wall, wall=wall);
    box_y = calc_size(repeat_y, comp_size_y, internal_wall=internal_wall, wall=wall);
    
    echo("Box created: ", box_x, box_y, box_z);

    difference() {
        intersection() {    
            cube ( size = [box_x, box_y, box_z], center = false);
            if(box_corner_radius > 0)
                minkowski() {
                    cube([
                        box_x - (box_corner_radius_axis == true || box_corner_radius_axis[1] || box_corner_radius_axis[2] ? box_corner_radius*2 : 0), 
                        box_y - (box_corner_radius_axis == true || box_corner_radius_axis[0] || box_corner_radius_axis[2] ? box_corner_radius*2 : 0), 
                        box_z - (box_corner_radius_axis == true || box_corner_radius_axis[0] || box_corner_radius_axis[1] ? box_corner_radius*2 : 0) + (lid_type==5 || lid_type==3 ? wall : 0)
                    ]);
                    translate([
                        box_corner_radius_axis == true || box_corner_radius_axis[1] || box_corner_radius_axis[2] ? box_corner_radius : 0, 
                        box_corner_radius_axis == true || box_corner_radius_axis[0] || box_corner_radius_axis[2] ? box_corner_radius : 0, 
                        box_corner_radius_axis == true || box_corner_radius_axis[0] || box_corner_radius_axis[1] ? box_corner_radius : 0
                    ])
                    sphere(box_corner_radius, $fn=corner_fn);
                }
        }

        for ( ybox = [ 0 : repeat_y - 1])
        {
            for( xbox = [ 0 : repeat_x - 1])
            {
                offset_x=calc_offset(xbox, comp_size_x, internal_wall=internal_wall, wall=wall);
                offset_y=calc_offset(ybox, comp_size_y, internal_wall=internal_wall, wall=wall);
                
                translate([0,0,lid_type == 4 ? extra_bottom : 0])
                difference() {
                    union() {
                        
                        translate([ offset_x, offset_y, wall])
                        cube ([ comp_size_x, comp_size_y, totalheight + .1 ]);
                        
                        if(supress_walls_x[ybox-1][xbox]) {
                            translate([ offset_x, offset_y - internal_wall - .01, wall])
                            cube ([comp_size_x, internal_wall+.02, totalheight + .1 ]);
                        }
                        if(supress_walls_y[xbox-1][ybox]) {
                            translate([ offset_x - internal_wall - .01, offset_y, wall])
                            cube ([internal_wall+.02, comp_size_y, totalheight + .1 ]);
                        }
                        if(supress_walls_x[ybox-1][xbox] && supress_walls_x[ybox-1][xbox-1] &&
                            supress_walls_y[xbox-1][ybox] && supress_walls_y[xbox-1][ybox-1]) {
                            translate([offset_x-internal_wall, offset_y-internal_wall, wall])
                            cube ([internal_wall, internal_wall, totalheight + .1]);
                        }
                        
                        if(mesh_do_sides || mesh_do_bottom) {
                        
                            translate([ offset_x, offset_y, wall])
                            union() {
                                if(mesh_do_bottom) {
                                    // bottom mesh
                                    translate([mesh_inset_padding, mesh_inset_padding , -wall - oversize])
                                    make_mesh(comp_size_x, comp_size_y, mesh_alt_rotation, mesh_type=mesh_type);
                                }
                                
                                if((mesh_do_sides == true || mesh_do_sides[0] == true)  && ybox == 0 || mesh_do_interior && ybox > 0) {
                                    //y- mesh
                                    rotate([90,0,0])
                                    translate([mesh_inset_padding, mesh_inset_padding , - oversize])
                                    make_mesh(comp_size_x, comp_size_deep-wall*(lid_type==5?1:0), mesh_rotation, mesh_type=mesh_type);
                                    
                                }
                                
                                if((mesh_do_sides == true || mesh_do_sides[2] == true) && ybox == repeat_y - 1) {
                                    //y+ mesh
                                    rotate([-90,0,0])
                                    translate([mesh_inset_padding, mesh_inset_padding - comp_size_deep +wall*(lid_type==5?1:0), comp_size_y-.5])
                                    make_mesh(comp_size_x, comp_size_deep-wall*(lid_type==5?1:0), mesh_rotation, mesh_type=mesh_type);
                                }
                                    
                                if((mesh_do_sides == true || mesh_do_sides[3] == true) && xbox == 0 || mesh_do_interior && xbox > 0) {
                                    //x- mesh
                                    rotate([0,-90, 0])
                                    translate([mesh_inset_padding, mesh_inset_padding, - oversize])
                                    make_mesh(comp_size_deep-wall*(lid_type==5?1:0), comp_size_y, mesh_rotation, true, mesh_type=mesh_type);
                                    
                                }
                                    
                                if((mesh_do_sides == true || mesh_do_sides[1] == true) && xbox == repeat_x - 1) {
                                    //x+ mesh
                                    rotate([0,90, 0])
                                    translate([mesh_inset_padding - comp_size_deep+wall*(lid_type==5?1:0), mesh_inset_padding, comp_size_x - oversize])
                                    make_mesh(comp_size_deep-wall*(lid_type==5?1:0), comp_size_y, mesh_rotation, true, mesh_type=mesh_type);
                                }
                            }
                        }
                    }
                    if(text_bottom == true && text_type == 2) {
                        if(text_message_compartments[ybox][xbox])
                            translate([ offset_x, offset_y, wall + (lid_type == 4 ? extra_bottom : 0)])
                            translate([comp_size_x/2, comp_size_y/2, 0])
                            make_text(comp_size_x, box_z, comp_size_y, -90, true, text_message=text_message_compartments[ybox][xbox]);
                    }
                }
            
                if(text_bottom == true && text_type == 1) {
                    if(text_message_compartments[ybox][xbox])
                        translate([ offset_x, offset_y, wall + (lid_type == 4 ? extra_bottom : 0)])
                        translate([comp_size_x/2, comp_size_y/2, -text_depth])
                        make_text(comp_size_x, box_z, comp_size_y, -90, true, text_message=text_message_compartments[ybox][xbox]);
                }
            }
        }
        if(lid_type==1 || lid_type == 4) {
            translate([-.05, wall/2, totalheight])
            rotate([90,0,90])
            linear_extrude(box_x-wall/2+.05)
            polygon([
                [box_y-wall,0],
                [0,0], 
                [wall/2,wall], 
                [box_y-wall*1.5,wall]		
            ]);
        
            translate ([0,wall/2,totalheight-z_tolerance])
            cube ([box_x-wall/2, box_y-wall,z_tolerance],center=false);
        }

        if(lid_type==2) {
            translate([0, wall, totalheight])
            union() {
                translate([-.1, 0, 0])
                cube([box_x - wall/2+.1, box_y - wall*2, wall+.01]);
                
                translate ([0, -wall/2, -z_tolerance])
                cube ([box_x - wall/2, box_y - wall*2, z_tolerance], center=false);
                
                //Hinges
                translate([box_x-wall-tolerance, hinge_inset-.2, wall/2])
                sphere(wall/2, $fn=lid_fn);
                
                translate([box_x-wall-tolerance, box_y - wall*2 - hinge_inset+.2, wall/2])
                mirror([0,1,0])
                sphere(wall/2, $fn=lid_fn);
                
                //Snaps
                if(has_snap) {
                    translate([wall/2, wall/2-snap_inset-snap_tolerance, wall/2])
                    sphere(wall/2, $fn=lid_fn);
                    //box_y - 2*tolerance - 2*wall +snap_inset
                    translate([wall/2, box_y - wall*2.5 + snap_inset + snap_tolerance, wall/2])
                    mirror([0,1,0])
                    sphere(wall/2, $fn=lid_fn);
                }
            }
        }
        
        if(lid_type==4) {
            difference() {
                cube([box_x, box_y, wall]);
            
                translate([0,wall/2+tolerance,0])
                union() {
                    //Slide
                    rotate([90,0,90])
                    linear_extrude(box_x - wall/2)
                    polygon([
                        [0, 0],
                        [box_y-wall-tolerance*2, 0],
                        [box_y-tolerance*2-wall*1.5,wall],
                        [wall/2,wall],
                    ]);
                    //Snaps
                    if(has_snap) {
                        polyhedron([
                            [0, -snap_inset, 0],
                            [0, box_y - wall + snap_inset - tolerance*2, 0],
                            [0, box_y - wall*1.5 + snap_inset - tolerance*2, wall],
                            [0, wall/2 - snap_inset, wall],
                            [1, -snap_inset/3, 0],
                            [1, box_y - wall + snap_inset/3 - tolerance*2, 0],
                            [1, box_y - wall*1.5 + snap_inset/3 - tolerance*2, wall],
                            [1, wall/2 - snap_inset/3, wall],
                        ], CubeFaces);
                    }
                }
            }
        }
        
        if(text_type == 1) {
            if(text_sides == true || text_sides[0] == true) 
                translate([box_x/2, text_depth, box_z/2])
                make_text(box_x, box_y, box_z, 0, false);
            if(text_sides == true || text_sides[1] == true)
                translate([box_x - text_depth, box_y/2, box_z/2])
                make_text(box_y, box_x, box_z, 90, false);
            if(text_sides == true || text_sides[2] == true)
                translate([box_x/2, box_y - text_depth, box_z/2])
                make_text(box_x, box_y, box_z, 180, false);
            if(text_sides == true || text_sides[3] == true)
                translate([text_depth, box_y/2, box_z/2])
                make_text(box_y, box_x, box_z, 270, false);
            
            if(text_bottom == true) {
                if(text_message_compartments == false || text_message_compartments == undef)
                    translate([box_x/2, box_y/2, wall - text_depth])
                    make_text(box_x, box_z, box_y, -90, true);
            }
        }
    }
    
    if(text_type == 2) {
        if(text_sides == true || text_sides[0] == true) 
            translate([box_x/2, 0, box_z/2])
            make_text(box_x, box_y, box_z, 0, false);
        if(text_sides == true || text_sides[1] == true)
            translate([box_x , box_y/2, box_z/2])
            make_text(box_y, box_x, box_z, 90, false);
        if(text_sides == true || text_sides[2] == true)
            translate([box_x/2, box_y, box_z/2])
            make_text(box_x, box_y, box_z, 180, false);
        if(text_sides == true || text_sides[3] == true)
            translate([0, box_y/2, box_z/2])
            make_text(box_y, box_x, box_z, 270, false);
        
        if(text_bottom == true) {
            if(text_message_compartments == false || text_message_compartments == undef)
                translate([box_x/2, box_y/2, wall])
                make_text(box_x, box_z, box_y, -90, true);
        }

    }
    
    make_box_internal(comp_size_x=comp_size_x, comp_size_y=comp_size_y, internal_size_deep=internal_size_deep, internal_type=internal_type, repeat_x=repeat_x, repeat_y=repeat_y, internal_fn=internal_fn, internal_rotate=internal_rotate, wall=wall, internal_wall=internal_wall);
}

/*** Code to add text to a box wall.  ***/
module make_text(box_x, box_y, box_z, base_rotation, rotate_z) {
    if(text_type == 1 || text_type == 2) {
        rotate([rotate_z ? base_rotation : 0, rotate_z ? 0 : text_rotation, rotate_z ? text_rotation : base_rotation])
        translate([0, 0, text_offset])
        rotate([90, 0, 0])
        union() {
            // Add a backdrop behind the raised text.
            if(text_type == 2 && mesh_type > 0) {
                translate([0, 0, rotate_z && (lid_type==3 || lid_type==5) ? text_depth : -wall])
                linear_extrude(wall)
                intersection() {
                    square([calc_rotation(text_rotation, box_x, box_z) - wall*2, calc_rotation(text_rotation, box_z, box_x) - wall*2], center=true);
                    
                    if(len(text_message[0]) > 1) {
                        translate([0,   (len(text_message) -1) * (text_size + 2) / 2])
                        hull(){
                            for (i = [0 : len(text_message) - 1])
                                translate([0 , -i * (text_size + 2) , 0 ])
                                translate([-text_size*len(text_message[i])*text_backdrop_scale[0]/2 +text_size/2, -text_size*text_backdrop_scale[1]/2 + text_size/2])
                                minkowski() {
                                    square([text_size*len(text_message[i])*text_backdrop_scale[0] - text_size, text_size*text_backdrop_scale[1] - text_size]);
                                    circle(text_size/2, $fn=20);
                                }
                          }
                    } else {
                        translate([-text_size*len(text_message)*text_backdrop_scale[0]/2 +text_size/2, -text_size*text_backdrop_scale[1]/2 + text_size/2])
                        minkowski() {
                            square([text_size*len(text_message)*text_backdrop_scale[0] - text_size, text_size*text_backdrop_scale[1] - text_size]);
                            circle(text_size/2, $fn=20);
                        }
                    }
                    
                }
            }
        
            linear_extrude(text_depth + (text_type == 1 ? .05 : 0), convexity=2)
            intersection() {
                square([calc_rotation(text_rotation, box_x, box_z) - wall*2, calc_rotation(text_rotation, box_z, box_x) - wall*2], center=true);
                
                if(len(text_message[0]) > 1) {
                    translate([0,   (len(text_message) -1) * (text_size + 2) / 2])
                    union(){
                        for (i = [0 : len(text_message) - 1])
                          translate([0 , -i * (text_size + 2) , 0 ]) text(text_message[i], font = text_font, size = text_size, valign = "center", halign = "center", $fn=text_fn);
                      }
                } else {
                    text(text = str(text_message), font = text_font, size = text_size, valign = "center", halign = "center", $fn=text_fn);
                }
            }
        }
    }
}

/*** The main code function to create an internal box. This causes slight changes in the wall, mesh, and lid generation. ***/
module make_internal_box(comp_size_x, comp_size_y, comp_size_z) {
    box_x = calc_size(repeat_x, comp_size_x, internal_wall=internal_wall, wall=internal_wall);
    box_y = calc_size(repeat_y, comp_size_y, internal_wall=internal_wall, wall=internal_wall);
    
    translate([wall-internal_wall, wall-internal_wall, wall-internal_wall])
    union() {
        translate([0, 0, internal_grow_down && comp_size_z < comp_size_deep ? comp_size_deep - comp_size_z : 0])
        make_box(comp_size_x=comp_size_x, comp_size_y=comp_size_y, comp_size_deep=comp_size_z, mesh_do_sides=mesh_do_interior, wall=internal_wall, internal_wall=internal_wall, repeat_x=repeat_x, repeat_y=repeat_y, mesh_type=mesh_type, internal_type=internal_type, internal_size_deep=internal_size_deep, internal_fn=internal_fn, internal_rotate=internal_rotate);
         
        if(internal_grow_down && comp_size_deep - comp_size_z > 0 && !internal_empty_bottom) {
            cube([box_x, box_y, comp_size_deep - comp_size_z]);
        }
    }
}

/*** Code used to create the internal structure of boxes. ***/
module make_box_internal() {
    for ( ybox = [ 0 : repeat_y - 1])
    {
        for( xbox = [ 0 : repeat_x - 1])
        {
            offset_x=calc_offset(xbox, comp_size_x, internal_wall=internal_wall, wall=wall);
            offset_y=calc_offset(ybox, comp_size_y, internal_wall=internal_wall, wall=wall);
            render() {
                if(internal_type == 1 || internal_type == 2) {
                    translate([offset_x - (internal_rotate ? 0 : internal_wall), offset_y + (internal_rotate ? comp_size_y + internal_wall : 0), wall + internal_size_deep])
                    rotate([internal_rotate ? 90 : 0,90,0])
                    linear_extrude(internal_rotate ? comp_size_y + internal_wall*2: comp_size_x + internal_wall*2)
                    difference() {
                        square([internal_size_deep, internal_rotate ? comp_size_x: comp_size_y]);
                        hull() {
                            translate([0, internal_size_circle, 0])
                            rotate([0,0,90])
                            
                            if(!internal_rotate && supress_walls_x[ybox-1][xbox] || internal_rotate && supress_walls_y[xbox-1][ybox])
                                square([internal_size_circle*2, internal_size_circle*2], center=true);
                            else
                                circle(r=internal_size_circle, $fn=internal_fn);
                            
                            if((internal_rotate ? comp_size_x : comp_size_y) != internal_size_circle*2)
                                translate([0, (internal_rotate ? comp_size_x : comp_size_y) - internal_size_circle, 0])
                                rotate([0,0,90])
                            if(!internal_rotate && supress_walls_x[ybox][xbox] || internal_rotate && supress_walls_y[xbox][ybox])
                                square([internal_size_circle*2, internal_size_circle*2], center=true);
                             else
                                 circle(r=internal_size_circle, $fn=internal_fn);
                        }
                    }
                }
                if(internal_type == 3) {
                    internal_width = sqrt(internal_size_deep*internal_size_deep*2);
                    internal_items = ((internal_rotate ? comp_size_y : comp_size_x) - wall*2) / (internal_width*1.5);
                    internal_offset = (internal_items - floor(internal_items)) * internal_width;
                    
                    rotate([0, 0, internal_rotate ? 90 : 0])
                    translate([offset_x, offset_y + (internal_rotate ? - comp_size_y - wall*2 : 0), internal_size_deep])
                    for(c=[0:internal_items]) {
                        translate([internal_offset + c * internal_width*1.5, 0, 0])
                        rotate([0,45,0])
                        cube([wall, comp_size_y + internal_wall, internal_size_deep]);
                    }
                }
            }
            if(internal_type == 4 || internal_type==5) {
                translate([offset_x, offset_y, wall])
                difference() {
                    cube([comp_size_x, comp_size_y, internal_size_deep]);
                    
                    linear_extrude(internal_size_deep + .01)
                    translate([internal_size_circle/2 ,internal_size_circle/2 , internal_size_circle/2 ])
                    hull() {
                        circle(d=internal_size_circle, $fn=internal_fn);
                        if(comp_size_x-internal_size_circle > 0) {
                            translate([comp_size_x-internal_size_circle, 0])
                            circle(d=internal_size_circle, $fn=internal_fn);
                        }
                        if(comp_size_y-internal_size_circle > 0) {
                            translate([0, comp_size_y-internal_size_circle])
                            circle(d=internal_size_circle, $fn=internal_fn);
                        }
                        if(comp_size_x-internal_size_circle > 0 && comp_size_y-internal_size_circle > 0) {
                            translate([comp_size_x-internal_size_circle, comp_size_y-internal_size_circle])
                            circle(d=internal_size_circle, $fn=internal_fn);
                        }
                        //#square([max(0, comp_size_x-internal_size_circle), max(0, comp_size_y-internal_size_circle), max(.01, comp_size_deep*1.5 - internal_corner_radius*2)]);
                        //echo(max(.01, comp_size_x-internal_size_circle), max(.01, comp_size_y-internal_size_circle*2), max(.01, comp_size_deep*1.5 - internal_size_circle*2));
                    }
                }
            }
            if(internal_corner_radius) {
                translate([offset_x, offset_y, wall])
                difference() {
                    cube([comp_size_x, comp_size_y, comp_size_deep]);
                    
                    translate([min(comp_size_x/2, internal_corner_radius), min(comp_size_y/2, internal_corner_radius), internal_corner_radius])
                    minkowski() {
                        sphere(r=internal_corner_radius, $fn=corner_fn);
                        cube([max(.01, comp_size_x-internal_corner_radius*2), max(.01, comp_size_y-internal_corner_radius*2), max(.01, comp_size_deep*1.5 - internal_corner_radius*2)]);
                    }
                }
            }
        }
    }
}

/*** The main code to create box lids. ***/
module make_lid() {
    box_x = calc_size(repeat_x, comp_size_x, internal_wall=internal_wall, wall=wall);
    box_y = calc_size(repeat_y, comp_size_y, internal_wall=internal_wall, wall=wall);
    
    totalheight = lid_type == 1 || lid_type == 2 ? comp_size_deep + wall : ( lid_type == 4 ? comp_size_deep + wall + extra_bottom : comp_size_deep);
    box_z = totalheight + wall;
    
    if(lid_type != 0) {
        echo("Lid created: ", box_x, box_y, lid_type == 5 || lid_type == 3 ? lid_height : wall);
        
        //translate([lid_type==5 ? -wall - tolerance : 0, lid_type==5 ? - wall - tolerance : wall/2+tolerance, lid_type == 5 ? 0 : ( comp_size_deep+wall + (lid_type == 4 ? extra_bottom : 0))])
        translate ([lid_alt_offset ? box_x+lid_offset : 0, lid_alt_offset ? 0 : box_y+lid_offset,0])
        intersection() {
            difference () {
                union () {	// for including coin slot
                    if (lid_type==1 || lid_type==2 || lid_type==4) { 
                        difference () {
                            if(lid_type==1 || lid_type==4) {
                                // Top 1
                                rotate([90,0,90])
                                linear_extrude(box_x - wall/2) // -tolerance
                                polygon([
                                    [0, 0],
                                    [box_y - 2*tolerance - wall, 0],
                                    [box_y - 2*tolerance - wall*1.5, wall],
                                    [wall/2,wall],
                                ]);
                                
                                //Snaps
                                if(has_snap) {
                                    polyhedron([
                                        [0, -snap_inset, 0],
                                        [0, box_y - wall + snap_inset - tolerance*2, 0],
                                        [0, box_y - wall*1.5 + snap_inset - tolerance*2, wall],
                                        [0, wall/2 - snap_inset, wall],
                                        [1, -snap_inset/3, 0],
                                        [1, box_y - wall + snap_inset/3 - tolerance*2, 0],
                                        [1, box_y - wall*1.5 + snap_inset/3 - tolerance*2, wall],
                                        [1, wall/2 - snap_inset/3, wall],
                                    ], CubeFaces);
                                }
                            }
                            
                            if(lid_type==2) {
                                union() {
                                    // Top 2
                                    rotate([90,0,90])
                                    linear_extrude(box_x - wall) // -tolerance
                                    polygon([
                                        [wall/2, 0],
                                        [box_y - 2*tolerance - wall*1.5, 0],
                                        [box_y - 2*tolerance - wall*1.5, wall],
                                        [wall/2, wall],
                                    ]);
                                    translate([box_x - wall, wall/2,wall/2])
                                    rotate([-90,0,0])
                                    cylinder(box_y - 2*tolerance - 2*wall , d=wall, $fn=40);
                                    
                                    //Hinges
                                    translate([box_x - wall, wall-hinge_inset, wall/2])
                                    sphere(wall/2, $fn=lid_fn);
                                    
                                    translate([box_x - wall, box_y - 2*tolerance - 2*wall + hinge_inset, wall/2])
                                    mirror([0,1,0])
                                    sphere(wall/2, $fn=lid_fn);
                                    
                                    //Snaps
                                    if(has_snap) {
                                        translate([wall/2, wall-snap_inset, wall/2])
                                        sphere(wall/2, $fn=lid_fn);
                                        
                                        translate([wall/2, box_y - 2*tolerance - 2*wall +snap_inset, wall/2])
                                        mirror([0,1,0])
                                        sphere(wall/2, $fn=lid_fn);
                                    }
                                }
                            }
                            
                            // Thumb hole
                            if (has_thumbhole) {
                                if(lid_type==1 || lid_type==4) {
                                    intersection () {
                                        translate ([min(8,repeat_x*(comp_size_x+wall)/8),(repeat_y*(comp_size_y+wall))/2,thumbrad+wall/2]) sphere (r=thumbrad+2, center=true, $fn=60);
                                        translate ([min(8,box_x/8),0,-.05])
                                        cube (size=[20,box_y,wall+.1], center=false);
                                    }
                                }
                     
                                if(lid_type==2) {
                                    rotate([0, 90, 0])
                                    translate([-wall, wall*2, -.01])
                                    polyhedron( [
                                            [ wall*2/3, wall*3,  0 ],  //0
                                            [ wall/3, wall*3,  0 ],  //1
                                            [ wall/3, 0,  0 ],  //2
                                            [ wall*2/3, 0,  0 ],  //3
                                            [ wall/2, wall*2+wall*.8,  wall/3],  //4
                                            [ wall/2, wall*2+wall*.8,  wall/3],  //5
                                            [ wall/2, wall*.2,  wall/3 ],  //6
                                            [ wall/2, wall*.2,  wall/3 ] //7
                                        ], CubeFaces );
                                    
                                    mirror([0,1,0])
                                    rotate([0, 90, 0])
                                    translate([-wall,-repeat_y*(comp_size_y+wall)+2*tolerance + wall*2, -.01])
                                    polyhedron( [
                                            [ wall*2/3, wall*3,  0 ],  //0
                                            [ wall/3, wall*3,  0 ],  //1
                                            [ wall/3, 0,  0 ],  //2
                                            [ wall*2/3, 0,  0 ],  //3
                                            [ wall/2, wall*2+wall*.8,  wall/3],  //4
                                            [ wall/2, wall*2+wall*.8,  wall/3],  //5
                                            [ wall/2, wall*.2,  wall/3 ],  //6
                                            [ wall/2, wall*.2,  wall/3 ] //7
                                        ], CubeFaces );
                                        
                                }
                            }
                        
                            make_lid_mesh(wall, wall/2, internal_wall=internal_wall, wall=wall, box_x=box_x, box_y=box_y, comp_size_x=comp_size_x, comp_size_y=comp_size_y, mesh_type=mesh_type);
                        }
                    }
                    if(lid_type == 5) {
                        difference() {
                            cube ([box_x + 2*wall + 2*tolerance, box_y + 2*wall + 2*tolerance, lid_height]);

                            translate ([wall, wall, wall])
                            linear_extrude(lid_height+1)
                            intersection() {    
                                square([box_x + tolerance*2, box_y + tolerance*2]);
                                // Add internal corner rounding to lid.
                                if(box_corner_radius > 0 && internal_corner_radius > 0 && (box_corner_radius_axis == true || box_corner_radius_axis[2]))
                                    minkowski() {
                                        square([box_x + tolerance*2 - internal_corner_radius*2, box_y + tolerance*2 - internal_corner_radius*2]);
                                        translate([internal_corner_radius, internal_corner_radius, internal_corner_radius])
                                        circle(internal_corner_radius, $fn=corner_fn);
                                    }
                            }
                            
                            make_lid_mesh(wall + tolerance + wall, wall*2 + tolerance, internal_wall=internal_wall, wall=wall, box_x=box_x, box_y=box_y, comp_size_x=comp_size_x, comp_size_y=comp_size_y, mesh_type=mesh_type);
                        }
                    } 
                    if(lid_type==3) {        
                        difference () {
                            cube([box_x + 2*tolerance, box_y + 2*tolerance, wall]);
                            make_lid_mesh(wall, wall, internal_wall=internal_wall, wall=wall, box_x=box_x, box_y=box_y, comp_size_x=comp_size_x, comp_size_y=comp_size_y, mesh_type=mesh_type);
                        }
                        lip = min(mesh_inset_padding, wall*2/3);
                        
                        for ( ybox = [ 0 : repeat_y - 1])
                        {
                            for( xbox = [ 0 : repeat_x - 1])
                            {
                                offset_x=calc_offset(xbox, comp_size_x, internal_wall=internal_wall, wall=wall);
                                offset_y=calc_offset(ybox, comp_size_y, internal_wall=internal_wall, wall=wall);
                                
                                translate([ offset_x + snap_tolerance, offset_y + snap_tolerance, wall])
                                difference() {
                                    cube([comp_size_x - snap_tolerance*2, comp_size_y - snap_tolerance*2, lid_height - wall]);
                                    translate([0, 0, -.05])
                                    polyhedron( [
                                        [  lip,  lip,  0 ],  //0
                                        [ comp_size_x - mesh_inset_padding,  lip,  0 ],  //1
                                        [ comp_size_x - mesh_inset_padding,  comp_size_y-lip,  0 ],  //2
                                        [  lip,  comp_size_y-lip,  0 ],  //3
                                        [  0,  0,  lid_height+.1 ],  //4
                                        [ comp_size_x,  0,  lid_height+.1 ],  //5
                                        [ comp_size_x,  comp_size_y,  lid_height+.1 ],  //6
                                        [  0,  comp_size_y,  lid_height+.1 ] //7
                                    ], CubeFaces );
                                }
                            }
                        }
                    }
                    if(text_top == true && text_type == 2) {
                        mirror([lid_type==3 || lid_type==5 ? 1 : 0, 0, 0])
                        translate([lid_type==3 || lid_type==5 ? -comp_size_x - wall*2 : 0, lid_type==3 || lid_type==5 ? wall/2 : 0, lid_type==3 || lid_type==5 ? -wall -text_depth*2 : -text_depth])
                        if(text_message_compartments == false || text_message_compartments == undef)
                            translate([lid_type == 5 ? -wall - tolerance : 0, lid_type == 5  ? wall + tolerance : 0, lid_type == 4 ? extra_bottom : 0])
                            translate([box_x/2, box_y/2 - wall/2, wall + text_depth])
                            make_text(box_x, box_z, box_y, -90, true);
                        else
                            for ( ybox = [ 0 : repeat_y - 1])
                            {
                                for( xbox = [ 0 : repeat_x - 1])
                                {
                                    offset_x=calc_offset(xbox, comp_size_x, internal_wall=internal_wall, wall=wall);
                                    offset_y=calc_offset(ybox, comp_size_y, internal_wall=internal_wall, wall=wall);
                                
                                    if(text_message_compartments[ybox][xbox])
                                        translate([lid_type == 5 ? -wall - tolerance : 0, lid_type == 5  ? wall/2 + tolerance : -wall/2, lid_type == 4 ? extra_bottom : 0])
                                        translate([comp_size_x/2 +  offset_x, comp_size_y/2 + offset_y, wall + text_depth])
                                        make_text(comp_size_x, box_z, comp_size_y, -90, true, text_message=text_message_compartments[ybox][xbox]);
                                }
                            }
                    }
                } // union
                
                if(text_top == true && text_type == 1) {
                    mirror([lid_type==3 || lid_type==5 ? 1 : 0, 0, 0])
                    translate([lid_type==3 || lid_type==5 ? -comp_size_x - wall*2 : 0, lid_type==3 || lid_type==5 ? wall/2 : 0, lid_type==3 || lid_type==5 ? -wall + text_depth - .025 : 0])
                    if(text_message_compartments == false || text_message_compartments == undef)
                        translate([lid_type == 5 ? -wall - tolerance : 0, lid_type == 5  ? wall + tolerance : 0, lid_type == 4 ? extra_bottom : 0])
                        translate([box_x/2, box_y/2 - wall/2, wall - text_depth])
                        make_text(box_x, box_z, box_y, -90, true);
                     else
                        for ( ybox = [ 0 : repeat_y - 1])
                        {
                            for( xbox = [ 0 : repeat_x - 1])
                            {
                                offset_x=calc_offset(xbox, comp_size_x, internal_wall=internal_wall, wall=wall);
                                offset_y=calc_offset(ybox, comp_size_y, internal_wall=internal_wall, wall=wall);
                            
                                if(text_message_compartments[ybox][xbox])
                                    translate([lid_type == 5 ? -wall - tolerance : 0,  lid_type == 5  ? wall/2 + tolerance : -wall/2, lid_type == 4 ? extra_bottom : 0])
                                    translate([comp_size_x/2 + offset_x, comp_size_y/2 + offset_y, wall - text_depth])
                                    make_text(comp_size_x, box_z, comp_size_y, -90, true, text_message=text_message_compartments[ybox][xbox]);
                            }
                        }
                }
            
                if (has_coinslot==true) {
                    for ( yslot = [ 0 : repeat_y - 1])
                    {
                        for( xslot = [ 0 : repeat_x - 1])
                        {
                            translate([ xslot * ( comp_size_x + wall ) + (2-(lid_type==5 ? 0 : 1))*wall + (comp_size_x-coinslot_x)/2, yslot * ( comp_size_y + wall ) + wall*(2-3*(lid_type==5?0:1)/2) + (comp_size_y-coinslot_y)/2, - oversize])
                            cube ( size = [ coinslot_x, coinslot_y, wall + oversize*2]);
                        }
                    }
                }
            } //difference
            
            
            if(box_corner_radius > 0)
                translate([0, 0, lid_type == 3 || lid_type == 5 ? 0 : -box_z + wall])
                minkowski() {
                    cube([
                        box_x - (box_corner_radius_axis == true || box_corner_radius_axis[1] || box_corner_radius_axis[2] ? box_corner_radius*2 : 0) + (lid_type==5 ? 2*wall + 2*tolerance : 0), 
                        box_y - (box_corner_radius_axis == true || box_corner_radius_axis[0] || box_corner_radius_axis[2] ? box_corner_radius*2 : 0) + (lid_type==5 ? 2*wall + 2*tolerance : 0), 
                        box_z - (box_corner_radius_axis == true || box_corner_radius_axis[0] || box_corner_radius_axis[1] ? box_corner_radius*2 : 0)
                    ]);
                    translate([
                        box_corner_radius_axis == true || box_corner_radius_axis[1] || box_corner_radius_axis[2] ? box_corner_radius : 0, 
                        (box_corner_radius_axis == true || box_corner_radius_axis[0] || box_corner_radius_axis[2] ? box_corner_radius : 0) - (lid_type==5 || lid_type==3 ? 0 : wall/2), 
                        box_corner_radius_axis == true || box_corner_radius_axis[0] || box_corner_radius_axis[1] ? box_corner_radius : 0
                    ])
                    sphere(box_corner_radius, $fn=50);
                }
        }
    }
}
/*** Mesh in the lid needs some custom logic. ***/
module make_lid_mesh(x, y) {
    //top mesh
    if(mesh_do_top) {
        mesh_x=box_x - wall*2  - tolerance - mesh_inset_padding*2;
        mesh_y=box_y - wall*2  - tolerance*2 - mesh_inset_padding*2;
    
        translate([mesh_inset_padding + x, mesh_inset_padding + y, -.01])
        difference(){
            cube([mesh_x, mesh_y, wall +.02]);
                
            for ( ybox = [ 0 : repeat_y - 1])
            {
                for( xbox = [ 0 : repeat_x - 1])
                {
                    offset_x=calc_offset(xbox, comp_size_x, internal_wall=internal_wall, wall=wall) - wall;
                    offset_y=calc_offset(ybox, comp_size_y, internal_wall=internal_wall, wall=wall) - wall;
                    
                    if(xbox > 0 && ybox == 0) {
                        translate([ offset_x - mesh_inset_padding*2 - internal_wall, 0, -.5])
                        cube([mesh_inset_padding*2 + internal_wall, mesh_y, wall+1]);
                    }
                    if(ybox > 0 && xbox == 0) {
                        translate([0, offset_y - mesh_inset_padding*2 - internal_wall, -.5])
                        cube([mesh_x, mesh_inset_padding*2 + internal_wall, wall+1]);
                    }
                    
                    translate([offset_x , offset_y, - oversize])
                    make_mesh(comp_size_x, comp_size_y, mesh_alt_rotation, inverted=true, mesh_type=mesh_type);
                            
                    if (has_coinslot==true) {        
                        translate([ xbox * ( comp_size_x + wall ) + (comp_size_x-coinslot_x)/2 -mesh_inset_padding -2.5, ybox * ( comp_size_y + wall ) + wall*(2-3/2) + (comp_size_y-coinslot_y)/2 -mesh_inset_padding -4, - oversize])
                        cube ( size = [ coinslot_x +5, coinslot_y +5, wall + oversize*2 ]);
                    }
                }
            }
            if (has_thumbhole==true && (lid_type==1 || lid_type==4)) {
                translate ([min(8,repeat_x*(comp_size_x+wall)/8) -mesh_inset_padding - wall, (repeat_y*(comp_size_y+wall))/2 -(mesh_inset_padding + wall/2),0]) 
                linear_extrude(wall + 1)
                circle (r=thumbrad/1.65, center=true, $fn=30);
            }
        }
	}
}
/*** Helper for making inserts that shows a contraints guide. ***/
module show_container(x,y,z) {
    color("Blue")
    difference() {
        translate([-.5,-.5,-.5])
        cube([x+1,y+1,z+1]);
        
        translate([0,0,-1])
        cube([x,y,z+2]);
    }
}
