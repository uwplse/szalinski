/*
This box with dividers thingie is suitable for both 3d printing and laser cutting.
Was made by Alexander Mangaard (aka Quixotic @ Thingiverse) sometime 2018.
Please support my coffee addiction @ https://www.paypal.me/AlexanderMangaard
*/

/*[Settings]*/

// Change to see how it looks assembled
View_Mode = "ASSEMBLED";  // ["ASSEMBLED":Assembled, "DISASSEMBLED":Disassembled]

// Do you want a bottom on the design?
has_bottom = "yes"; // [no:No, yes:Yes]

// Do you want a box?
has_box = "yes"; // [no:No, yes:Yes]

// Do you want dividers?
has_dividers = "yes"; // [no:No, yes:Yes]

//// Do you want divider stabilizers? Recommended when no box or bottom, but unnecessary otherwise.
//has_divider_stabilizers = "yes"; // [no:No, yes:Yes]

//(mm)
drawer_L = 196;     // drawer length
//(mm)
drawer_W = 228;     // drawer width
//(mm)
drawer_D = 70;      // drawer depth
//(mm)
material_W = 4;     // material width

// ternary operator sets z height for dividers in case there's a bottom. Needs to be lifted material_W.
zh = (has_bottom == "yes")
        ? material_W
        : 0;

num_horizontal_compartments = 3;
num_horizontal_div = 2+num_horizontal_compartments-1; // sides + internal div
num_vertical_compartments = 2;
num_vertical_div = 2+num_vertical_compartments-1; // sides + internal div

drawer_L_minus_div = drawer_L-(num_horizontal_div*material_W);
horizontal_compartment_width = drawer_L_minus_div/num_horizontal_compartments;
bottom_x_hole_width = horizontal_compartment_width/2;

drawer_W_minus_div = drawer_W-(num_vertical_div*material_W);
vertical_compartment_width = drawer_W_minus_div/num_vertical_compartments;
bottom_y_hole_width = vertical_compartment_width/2;

lasercut_mode = true;
include_gaps = true;

if (View_Mode == "ASSEMBLED") {
    if      (has_box == "no" && has_bottom == "yes" && has_dividers == "no") {
        bottom();
    }
    else if (has_box == "no" && has_bottom == "yes" && has_dividers == "yes") {

// top translate function for moving dividers
    translate([0,0,0]) {

dividers();
    // insert finger joints
    translate([material_W+bottom_x_hole_width/2,0,0])    bottom_x_axis_fingerjoints();

    // insert finger joints
    translate([0,material_W+bottom_y_hole_width/2,0])    bottom_y_axis_fingerjoints();
}

    //insert bottom
    translate([0,0,0]) { bottom(); }

}
    else if (has_box == "no" && has_bottom == "no" && has_dividers == "yes") {
        dividers();}
    else if (has_box == "yes" && has_bottom == "no" && has_dividers == "no") {
        outer_box();
    }
    else if (has_box == "yes" && has_bottom == "yes" && has_dividers == "no") {
        outer_box();
        bottom();
    }
    else if (has_box == "yes" && has_bottom == "no" && has_dividers == "yes") {
        dividers();
        translate([0,0,0]) {
        difference(){
        outer_box();
        // making holes for dividers
        for (i = [0 : num_horizontal_compartments-2])
        {
            if (num_vertical_compartments >=2) { //vertical_lineup num-2 creates "sides" when comp # set below 2
                vertical_lineup(num_vertical_compartments, (drawer_W-material_W)/num_vertical_compartments)
                { cube([drawer_L,material_W,drawer_D/2]);}
            }
            if (num_horizontal_compartments >=2) { //horizontal_lineup num-2 creates "sides" when comp # set below 2
                horizontal_lineup(num_horizontal_compartments, (drawer_L-material_W)/num_horizontal_compartments)
                { cube([material_W,drawer_W,drawer_D/2]);}
            }
        }
    }
}
    }
    else if (has_box == "yes" && has_bottom == "yes" && has_dividers == "yes") {
        difference(){
        translate([0,0,0]) outer_box();
        for (i = [0 : num_horizontal_compartments-2])
        {
            if (num_vertical_compartments >=2) { //vertical_lineup num-2 creates "sides" when comp # set below 2
            vertical_lineup(num_vertical_compartments, (drawer_W-material_W)/num_vertical_compartments)
            { cube([drawer_L,material_W,drawer_D/2]);}
        }
            if (num_horizontal_compartments >=2) { //vertical_lineup num-2 creates "sides" when comp # set below 2
            horizontal_lineup(num_horizontal_compartments, (drawer_L-material_W)/num_horizontal_compartments)
            { cube([material_W,drawer_W,drawer_D/2]);}
        }
        }
    }

    translate([0,0,0]) bottom();
    dividers();

    // insert finger joints
    translate([material_W+bottom_x_hole_width/2,0,0])    bottom_x_axis_fingerjoints();

    // insert finger joints
    translate([0,material_W+bottom_y_hole_width/2,0])    bottom_y_axis_fingerjoints();


    }

}

if (View_Mode == "DISASSEMBLED") {
  if      (has_box == "no" && has_bottom == "yes" && has_dividers == "no") {
          bottom_prone();
          }
  else if (has_box == "no" && has_bottom == "yes" && has_dividers == "yes") {
      dividers_prone();

        //insert bottom
        translate([4+drawer_L+drawer_W,0,0]) bottom_prone();
  }
  else if (has_box == "no" && has_bottom == "no" && has_dividers == "yes") {
      dividers_prone();
  }
  else if (has_box == "yes" && has_bottom == "no" && has_dividers == "no") {
      outer_box_prone();
  }
  else if (has_box == "yes" && has_bottom == "yes" && has_dividers == "no") {
      bottom_prone();
      translate([drawer_L+2,0,0]) outer_box_prone();
  }
  else if (has_box == "yes" && has_bottom == "no" && has_dividers == "yes") {
      dividers_prone();
      translate([drawer_L+drawer_W+2*2,0,0]) outer_box_prone();     

  }
  else if (has_box == "yes" && has_bottom == "yes" && has_dividers == "yes") {

        dividers_prone();
        translate([drawer_L*2+drawer_W+6,0,0]) outer_box_prone();
        //insert bottom
        translate([4+drawer_L+drawer_W,0,0]) bottom_prone();
    }
    }

//////////////////// Modules for assembled

module dividers() {
    if (num_horizontal_compartments >=2) { //horizontal_lineup num-2 creates "sides" when comp # set below 2
    translate([0,0,zh]) {
    ////insert dividers along y-axis
    difference(){
        horizontal_lineup(num_horizontal_compartments, (drawer_L-material_W)/num_horizontal_compartments)
        { cube([material_W,drawer_W,drawer_D-zh]); }
         if (num_vertical_compartments >=2) { // if # comps below 0 creates unwanted holes
            for (i = [0 : num_horizontal_compartments-2]) {
                vertical_lineup(num_vertical_compartments, (drawer_W-material_W)/num_vertical_compartments)
                    { cube([drawer_L,material_W,drawer_D/2]);}
    }}

    //add hole for slotting into box sides
    if (has_box == "yes") {
        for (i = [0 : num_horizontal_compartments-2]) {
            translate([0,0,drawer_D/2]) horizontal_lineup(
                num_horizontal_compartments, (drawer_L-material_W)/num_horizontal_compartments)
                { cube([material_W,material_W,drawer_D/2]);
                    translate([0,drawer_W-material_W,0]) cube([material_W,material_W,drawer_D/2]);}
    }}

    } }}

    //insert dividers along x-axis
    if (num_vertical_compartments >=2) { //vertical_lineup num-2 creates "sides" when comp # set below 2
    translate([0,0,zh])
        difference(){
            vertical_lineup(num_vertical_compartments, (drawer_W-material_W)/num_vertical_compartments)
            { cube([drawer_L, material_W,drawer_D-zh]);}
            if (num_horizontal_compartments >=2) { // if # comps below 0 creates unwanted holes
                for (i = [0 : num_horizontal_compartments-2]) {
                translate([0,0,drawer_D/2]) horizontal_lineup(
                    num_horizontal_compartments, (drawer_L-material_W)/num_horizontal_compartments)
                    { cube([material_W,drawer_W,drawer_D/2]);}
    }}


    translate([0,0,drawer_D/2]){
    //add hole for slotting into box sides
        if (has_box == "yes" && include_gaps == true) {
            for (i = [0 : num_horizontal_compartments-2]) {
                vertical_lineup(num_vertical_compartments, (drawer_W-material_W)/num_vertical_compartments)
                    { cube([material_W,material_W,drawer_D/2]);
                        translate([drawer_L-material_W,0,0]) cube([material_W,material_W,drawer_D/2]);}
    }}}}
}
    
  }
module outer_box() {
    translate([0,0,0]){
    //box side along y
    difference(){
    translate([0,0,zh]) cube([material_W, drawer_W, drawer_D-zh]);
    z_axis_fingerjoints();
    }
    // finger joints for connecting with bottom
    translate([0,material_W+vertical_compartment_width/2/2,0]) bottom_side_y_axis_fingerjoints();
    }

    //opposite box side along y
    translate([0,0,0]){
    difference(){
        translate([drawer_L-material_W, 0, zh]) cube([material_W, drawer_W, drawer_D-zh]);
        translate([drawer_L-material_W, 0,0]) z_axis_fingerjoints();
    }
    // finger joints for connecting with bottom
    translate([drawer_L-material_W,material_W+vertical_compartment_width/2/2,0]) bottom_side_y_axis_fingerjoints();
    }

   //sides along x
    translate([0,0,0]) {
    difference() {
        //combine two shapes for easier difference function
        union() {
        //box side along x
        translate([material_W,0,zh]) cube([drawer_L-material_W*2, material_W, drawer_D-zh]);
        //opposite box side along x
        translate([material_W,drawer_W-material_W, zh]) cube([drawer_L-material_W*2, material_W, drawer_D-zh]);
            //add finger joints to sides for fitting into bottom
            if (has_bottom == "yes")    {
                translate([material_W+bottom_x_hole_width/2,0,0]) bottom_side_x_axis_fingerjoints();
                translate([material_W+bottom_x_hole_width/2,drawer_W-material_W,0]) bottom_side_x_axis_fingerjoints();
              }
        }

    }
    // add finger joints to sides along x
        translate([0,0,0]) z_axis_fingerjoints();
        translate([drawer_L-material_W,0,0]) z_axis_fingerjoints();
}
}
module horizontal_lineup(num, space) { //div along y-axis
   // num-2 because we don't want overlap with outside box
   for (i = [0 : num-2])
       difference(){    translate([space+space*i, 0, 0 ]) children();
       }
   }
   
module horizontal_lineup_new(num, space) { //div along y-axis
   // num-2 because we don't want overlap with outside box

    for (i = [0 : num-2])
       difference(){    translate([space+space*i, 0, 0 ]) children();
       
   }
  
   }
module vertical_lineup(num, space) { //div along x-axis
    // num-2 because we don't want overlap with outside box
   for (i = [0 : num-2])
       difference(){    translate([0, space+space*i, 0 ]) children();   }}
module z_axis_fingerjoints() {
        for (i = [0: 1]) {
    translate([0,(drawer_W-material_W)*i,drawer_D/4/2])
        z_lineup(
        2, drawer_D/2)
            { cube([material_W, material_W, drawer_D/4]); }
            }}
module x_axis_fingerjoints() {
        for (i = [0: num_horizontal_compartments-1]) {
    translate([(material_W+horizontal_compartment_width)*i,0,0])
        vertical_lineup_prone(
        num_vertical_compartments, drawer_D+2)
            { square([bottom_x_hole_width, material_W]); }
            }}
module y_axis_fingerjoints() {
        for (i = [0: num_vertical_compartments-1]) {
        translate([(material_W+vertical_compartment_width)*i,drawer_D-material_W,0])
        vertical_lineup_prone(
        num_horizontal_compartments, (drawer_D+2))
            { square([bottom_y_hole_width, material_W]); }}
          }
module bottom() {

    if (include_gaps == true && has_box == "no" && has_dividers == "no") {
        cube([drawer_L, drawer_W, material_W]);
        }
    else if (include_gaps == true && has_box == "yes"){
        difference(){
        cube([drawer_L, drawer_W, material_W]);

    translate([0,0,0]) {
        //holes along y for box side finger joints
    translate([0,material_W+vertical_compartment_width/2/2,0]) bottom_side_y_axis_fingerjoints();
       translate([drawer_L-material_W,material_W+vertical_compartment_width/2/2,0]) bottom_side_y_axis_fingerjoints(); }
        //holes along y for box side finger joints
    translate([material_W+horizontal_compartment_width/2/2,0,0]) bottom_side_x_axis_fingerjoints();
         translate([material_W+horizontal_compartment_width/2/2,drawer_W-material_W,0]) bottom_side_x_axis_fingerjoints();
            }
        }
    else if (include_gaps == true && has_box == "yes" && has_dividers == "yes"){
    //TODO fix has box holes
    //// insert divider holes in bottom along y-axis
    difference(){
    cube([drawer_L, drawer_W, material_W]);
    translate([material_W+bottom_x_hole_width/2,0,0])   { bottom_x_axis_fingerjoints(); }
    translate([0,material_W+bottom_y_hole_width/2,0])   { bottom_y_axis_fingerjoints(); }
                }}

    else if (include_gaps == true && has_box == "no" && has_dividers == "yes"){
    //// insert divider holes in bottom along y-axis
    difference(){
    cube([drawer_L, drawer_W, material_W]);
    translate([material_W+bottom_x_hole_width/2,0,0])   { bottom_x_axis_fingerjoints(); }
    translate([0,material_W+bottom_y_hole_width/2,0])   { bottom_y_axis_fingerjoints(); }
                }}
                }
module bottom_x_axis_fingerjoints() {
        for (i = [0: num_horizontal_compartments-1]) {
    translate([(material_W+horizontal_compartment_width)*i,0,0])
        vertical_lineup(
        num_vertical_compartments, (drawer_W-material_W)/num_vertical_compartments)
            { cube([bottom_x_hole_width,material_W,material_W]); }
            }}
module bottom_side_x_axis_fingerjoints() {
        for (i = [0: num_horizontal_compartments-1]) {
    translate([(material_W+horizontal_compartment_width)*i,0,0])
        vertical_lineup_prone(
        2, (drawer_W-material_W)/num_vertical_compartments)
            { cube([bottom_x_hole_width,material_W,material_W]); }
            }}
module bottom_y_axis_fingerjoints() {
    //TODO: FIX THIS ... replace what is in bottom()
        for (i = [0: num_vertical_compartments-1]) {
    translate([0,(material_W+vertical_compartment_width)*i,0])
        horizontal_lineup(
        num_horizontal_compartments, (drawer_L-material_W)/num_horizontal_compartments)
            { cube([material_W,bottom_y_hole_width,material_W]); }
            }}
module bottom_side_y_axis_fingerjoints() {
    module z_lineup(num, space) { //div along y-axis
    // num-2 because we don't want overlap with outside box
    for (i = [0 : num-1])
       difference(){    translate([0, 0, space*i ]) children();   }}
            for (i = [0: num_vertical_compartments-1]) {
    translate([0,(material_W+vertical_compartment_width)*i,0])
        vertical_lineup_prone(
        2, (drawer_W-material_W)/num_vertical_compartments)
            { cube([material_W,vertical_compartment_width/2,material_W]);
               }
            }}


module z_lineup(num, space) { //div along y-axis
   // num-2 because we don't want overlap with outside box
   for (i = [0 : num-1])
       difference(){    translate([0, 0, space*i ]) children();   }}
//////////////////// Modules for disassembled

module outer_box_prone() {

    translate([0,0,0]) {                         //box side along y
    difference(){
    translate([0,zh,0]) rotate([0,0,0]) square([drawer_W, drawer_D-zh]);
    z_axis_fingerjoints_prone();
    
    if (has_dividers == "yes")    {
        if (num_vertical_compartments >=2) { // if # comps below 0 creates unwanted holes
        // make holes for fitting box sides into dividers
        horizontal_lineup(num_vertical_compartments, (drawer_W-material_W)/num_vertical_compartments)
        {square([material_W, drawer_D/2]);}
    }
    }
    }
    if (has_bottom == "yes")    {
        // finger joints for connecting with bottom
        translate([material_W+vertical_compartment_width/2/2,0,0]) bottom_side_y_axis_fingerjoints_prone();
    }   
    }
    
    translate([0,drawer_D+2,0]) {          //opposite box side along y
    difference(){
    translate([0,zh,0]) rotate([0,0,0]) square([drawer_W, drawer_D-zh]);
    z_axis_fingerjoints_prone();
    
    if (has_dividers == "yes")    {
        if (num_vertical_compartments >=2) { // if # comps below 0 creates unwanted holes
        // make holes for fitting box sides into dividers
        horizontal_lineup(num_vertical_compartments, (drawer_W-material_W)/num_vertical_compartments)
        {square([material_W, drawer_D/2]);}
    }
    }
        }
    if (has_bottom == "yes")    {
        // finger joints for connecting with bottom
        translate([material_W+vertical_compartment_width/2/2,0,0]) bottom_side_y_axis_fingerjoints_prone();
    }}
    
    translate([drawer_W+2,zh,0]) {             //box side
    difference(){
    square([drawer_L, drawer_D-zh]);

            //make room for finger joints
            square([material_W,drawer_W]);
            translate([drawer_L-material_W,0,0]) square([material_W,drawer_W]);
    
            if (has_dividers == "yes")    {
            if (num_horizontal_compartments >=2) { // if # comps below 0 creates unwanted holes
            // make holes for fitting box sides into dividers
            horizontal_lineup(num_horizontal_compartments, (drawer_L-material_W)/num_horizontal_compartments)
            {square([material_W, drawer_D/2-material_W]);}
            }
            }
        }
      
            if (has_bottom == "yes")    {
            // finger joints for connecting with bottom
            translate([material_W+bottom_x_hole_width/2,-zh,0]) bottom_side_x_axis_fingerjoints_prone();
    }
    
            //add finger joints to side along y
            translate([0,-zh,0]) z_axis_fingerjoints_prone2();
    }
        
    translate([drawer_W+2,drawer_D+2+zh,0]) {  //opposite box side
        difference(){
        square([drawer_L, drawer_D-zh]);

                //make room for finger joints
                square([material_W,drawer_W]);
                translate([drawer_L-material_W,0,0]) square([material_W,drawer_W]);
        
            if (has_dividers == "yes")    {
            if (num_horizontal_compartments >=2) { // if # comps below 0 creates unwanted holes
            // make holes for fitting box sides into dividers
            horizontal_lineup(num_horizontal_compartments, (drawer_L-material_W)/num_horizontal_compartments)
            {square([material_W, drawer_D/2-material_W]);}
            }
            }
            }
        
                    if (has_bottom == "yes")    {
                translate([material_W+bottom_x_hole_width/2,-zh,0]) bottom_side_x_axis_fingerjoints_prone();
        }        
                //add finger joints to side along x
                translate([0,-zh,0]) z_axis_fingerjoints_prone2();
    }
    
 }
module dividers_prone() {
        //insert prone div along x-axis
     if (num_vertical_compartments >=2) { // if # comps below 0 creates unwanted holes
        difference(){
        vertical_lineup_prone(num_vertical_compartments, drawer_D+2){ square([drawer_L,drawer_D]);}

         if (num_horizontal_compartments >=2) { // if # comps below 0 creates unwanted holes
            //insert gaps
                vertical_lineup_prone(num_vertical_compartments, drawer_D+2)
                { horizontal_lineup_prone(num_horizontal_compartments, (drawer_L-material_W)/num_horizontal_compartments)
                    {square([material_W,drawer_D/2]);
                    }}
        }

        if (has_bottom == "yes") {
            //remove bottom to make room for finger joint
            vertical_lineup_prone(num_vertical_compartments, drawer_D+2){square([drawer_L,material_W]);}
            }
            
            vertical_lineup_prone(num_vertical_compartments, drawer_D+2){
            if (has_box == "yes") {
            // add holes for fitting into box sides
            translate([0,drawer_D/2,0]) square([material_W,drawer_D/2]);
            translate([drawer_L-material_W,drawer_D/2,0]) square([material_W,drawer_D/2]);
            }}
        }
    }                
        
        if (has_bottom == "yes") {
            if (num_vertical_compartments >=2) { //when comp # set below 2 creates negative finger joints
            // insert finger joints
            translate([material_W+bottom_x_hole_width/2,0,0]) x_axis_fingerjoints();
            }

            // insert finger joints
            if (num_horizontal_compartments >=2) { //when comp # set below 2 creates negative finger joints
            translate([drawer_L+2+material_W+bottom_y_hole_width/2,0,0]) y_axis_fingerjoints();
            }
        }

        //insert prone div along y-axis
        if (num_horizontal_compartments >=2) { //horizontal_lineup num-2 creates "sides" when comp # set below 2                
        translate([drawer_L+2,0,0]) difference(){
        vertical_lineup_prone(num_horizontal_compartments, drawer_D+2){ square([drawer_W,drawer_D-zh]);}

         if (num_vertical_compartments >=2) { // if # comps below 0 creates unwanted holes
            //insert gaps
                vertical_lineup_prone(num_horizontal_compartments, drawer_D+2){
                   horizontal_lineup_prone(num_vertical_compartments, (drawer_W-material_W)/num_vertical_compartments)
                        {square([material_W,drawer_D/2]);
                    }}
        }
                    
//                     if (num_vertical_compartments >=2) { // if # comps below 0 creates unwanted holes
                    translate([0,0,0])
                    vertical_lineup_prone(num_horizontal_compartments, drawer_D+2){
                        if (has_box == "yes") {
                        // add holes for fitting into box sides
                        translate([0,0,0]) square([material_W,drawer_D/2]);
                        translate([drawer_W-material_W,0,0]) square([material_W,drawer_D/2]);
                        }}
//                    }
                    
                    }}
                    
                    }
module bottom_prone() {
    difference(){
    square([drawer_L, drawer_W]);
        if (has_dividers == "yes")    {
        if (num_vertical_compartments >=2) { //         
        translate([material_W+bottom_x_hole_width/2,0,0])   { bottom_x_axis_fingerjoints_prone(); }
        }
        if (num_horizontal_compartments >=2) { // no need for dividers if comp # 
        translate([0,material_W+bottom_y_hole_width/2,0])   { bottom_y_axis_fingerjoints_prone(); }
        }
}
    
    //finger joint holes for sides along x    
    if (has_box == "yes")    {
    translate([material_W+bottom_x_hole_width/2,0,0]) bottom_side_x_axis_fingerjoints_prone();
    translate([material_W+bottom_x_hole_width/2,drawer_W-material_W,0]) bottom_side_x_axis_fingerjoints_prone();
    
    //holes along y for box side finger joints
    translate([0,0+material_W+vertical_compartment_width/2/2,0]) bottom_side_y_axis_fingerjoints_prone2();
    translate([drawer_L-material_W,0+material_W+vertical_compartment_width/2/2,0]) bottom_side_y_axis_fingerjoints_prone2();
        }
}
}
                
module vertical_lineup_prone(num, space) {
    // num-2 because we don't want overlap with outside box
   for (i = [0 : num-2])
       difference(){    translate([0, space*i, 0 ]) children();         }}
module horizontal_lineup_prone(num, space) { //div along y-axis
   // num-2 because we don't want overlap with outside box
   for (i = [0 : num-2])
       difference(){    translate([space+space*i, 0, 0 ]) children();   }}
module z_lineup_prone(num, space) { //div along y-axis
   // num-2 because we don't want overlap with outside box
   for (i = [0 : num-1])
       difference(){    translate([0, space*i, 0]) children();   }}
module bottom_x_axis_fingerjoints_prone() {
        for (i = [0: num_horizontal_compartments-1]) {
    translate([(material_W+horizontal_compartment_width)*i,0,0])
        vertical_lineup(
        num_vertical_compartments, (drawer_W-material_W)/num_vertical_compartments)
            { square([bottom_x_hole_width,material_W]); }
            }}
module bottom_side_x_axis_fingerjoints_prone() {
        for (i = [0: num_horizontal_compartments-1]) {
    translate([(material_W+horizontal_compartment_width)*i,0,0])
        vertical_lineup_prone(
        2, (drawer_W-material_W)/num_vertical_compartments)
            { square([bottom_x_hole_width, material_W]); }
            }}
module bottom_y_axis_fingerjoints_prone() {
        for (i = [0: num_vertical_compartments-1]) {
    translate([0,(material_W+vertical_compartment_width)*i,0])
        horizontal_lineup(
        num_horizontal_compartments, (drawer_L-material_W)/num_horizontal_compartments)
            { square([material_W,bottom_y_hole_width]); }
            }}
module bottom_side_y_axis_fingerjoints_prone() {
    module z_lineup(num, space) { //div along y-axis
    // num-2 because we don't want overlap with outside box
    for (i = [0 : num-1])
       difference(){    translate([space*i, 0, 0]) children();   }}
            for (i = [0: num_vertical_compartments-1]) {
    translate([(material_W+vertical_compartment_width)*i,0,0])
        vertical_lineup_prone(
        2, (drawer_W-material_W)/num_vertical_compartments)
            { square([vertical_compartment_width/2,material_W]);
               }
            }}
module bottom_side_y_axis_fingerjoints_prone2() { //TODO: two similar modules, once must go
    module z_lineup(num, space) { //div along y-axis
    // num-2 because we don't want overlap with outside box
    for (i = [0 : num-1])
       difference(){    translate([space*i, 0, 0]) children();   }}
            for (i = [0: num_vertical_compartments-1]) {
    translate([0,(material_W+vertical_compartment_width)*i,0])
        vertical_lineup_prone(
        2, (drawer_W-material_W)/num_vertical_compartments)
            { square([material_W,vertical_compartment_width/2]);
               }
            }}
module z_axis_fingerjoints_prone() {
        for (i = [0: 1]) {
    translate([(drawer_W-material_W)*i,drawer_D/4/2,0])
        z_lineup_prone(
        2, drawer_D/2)
            { square([material_W, drawer_D/4]); }
            }}
module z_axis_fingerjoints_prone2() {
        for (i = [0: 1]) {
    translate([(drawer_L-material_W)*i,drawer_D/4/2,0])
        z_lineup_prone(
        2, drawer_D/2)
            { square([material_W, drawer_D/4]); }
            }}