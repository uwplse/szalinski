/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
*
* Milwaukee Drill and Tap Holders
* Benjamen Johnson <workshop.electronsmith.com>
* 20191003
* Version 3
* openSCAD Version: 2019.05
*******************************************************************************/
/*[Drill and Tap Parameters]*/

//dummy parameter doesn't do anything but fix a bug in customizer
dummy = 1;

//Show text labels
show_labels = 1; //[0:no,1:yes]

//Number of drill and tap sets
num_sets = 5; //[3:6]

// First Drill and Tap
label1 = " M7";
tap1 = 6.4;
drill1 = 6;

// Second Drill and Tap
label2 = " M6";
tap2 = 6.4;
drill2 = 5;

// Third Drill and Tap 
label3 = "M5";
tap3 = 4.9;
drill3 = 4.2;

// Forth Drill and Tap
label4 = "M4";
tap4 =  4.3;
drill4 =  3.3;

// Fifth Drill and Tap
label5 = "M3"; 
tap5 = 3.6;
drill5 = 2.5;

// Sixth Drill and Tap
label6 = "";
tap6 = 0;
drill6 = 0;

//adjustment for tap and drill fit
fudge = 1.05;

// distance between holes
min_spacing = 2.9;

/*[Hidden]*/
// array of drill and tap sizes
slots = [tap1,drill1, tap2,drill2, tap3,drill3, tap4,drill4, tap5,drill5, tap6, drill6];
num_keys = num_sets*2;
labels = [str(label1),str(label2),str(label3),str(label4),str(label5),str(label6)];
num_labels = num_sets;

/*[Holder Parameters]*/
/*******************************************************************************
*    /\ /\ /\ /\ /\ /\ /\ /\ /\ /\  < ---- bits
*   -------------------------------  --
*  |                               |  body_height 
*  |                               |
*   -------------------------------  --
*  |< ------- body_width --------->|
*   -------------------------------  --
*  | X  X  X  X  X  X  X  X  X  X  |  body_depth
*   -------------------------------  --
*
*  || <- min_spacing
*   -----------
*  | --- | --- | --
*  ||   |||   ||  slot_width
*  | --- | --- | --
*   -----------
*         |   | <- slot_length (I know these seem backward in 2D)
*  
*******************************************************************************/

// width of the holder body
body_width = 82.5; // 82.5

// depth of holder 
body_depth = 11; // 11

// height of holder
body_height = 30;

// width of the bit slot (front to back)
slot_width = slots*fudge;

// length of the bit slot (side to side)
slot_length= slot_width;

// how much material to leave at the bottom of the bit slots
bottom_thickness = 12;

// how much to chamfer the ends
bottom_chamfer = 5;

/*[Case Connector Parameters]*/
/*******************************************************************************
*     -------------------------------
*   -| X  X  X  X  X  X  X  X  X  X  |-
*     -------------------------------
*  | <------ total_pin_length -------->|
*
*             -------
*        --  |---O---|  o <- pin_dia (diamter of pivot pin)
* pin_height |   |   | 
*            |   |   |    <- catch_dia (diameter of the semicircular catches)
*        --   -------
******************************************************************************/
// Length of cylinder passing through the holder that it rotates on 
total_pin_length = 88; // 88

// diameter of the above cylinder
pin_dia = 4.5; // 4.5

// diameter of the semicircular catches
catch_dia = 2.5;

// pin distance from the bottom of holder;
pin_height = 10; 

// add a slight offset to cuts to make model render properly
render_offset = 0.01; //0.005


/*[Font Options]*/
// which font do you want to use
font = "REGISTRATION PLATE UK:style=Bold";

// How big you want the text
font_size = 6;

// how much to indent the text at each set
indent = 1;
                        
/*[Hidden]*/
window_depth = 2.5;
front_window_height = 10;
rear_window_height = 10;

spring_width = 5;
spring_thickness = 2;
spring_length = rear_window_height;
spring_z_pos = -(body_height-spring_length)/2+bottom_thickness+0.5;

detent_dia = 4;
detent_pos = -(spring_length-detent_dia)/2;


pin_pos = - body_height/2+pin_height; 

rotate([-90,0,0])
color("red")union(){
    difference(){
        // make the basic holder
        MilwaukeeHolder();
        
        // cut the slots for the bits
        for(x=[0:1:num_keys-1]){
            translate([-(body_width-(slot_length[x]))/2+spacing(x)+1,0,1])cube([slot_length[x],slot_width[x],body_height], center=true);
                    
            translate([-(body_width-(slot_length[x]))/2+spacing(x)+1,-(body_depth)/2,-(body_height-front_window_height)/2-render_offset+bottom_thickness])cube([slot_length[x]+min_spacing+render_offset,(body_depth-slot_width[x])+render_offset,front_window_height],center=true);
            
            translate([-(body_width-(slot_length[x]))/2+spacing(x)+1,(body_depth)/2,-(body_height-front_window_height)/2-render_offset+bottom_thickness])cube([slot_length[x]+ min_spacing+render_offset,(body_depth-slot_width[x])+render_offset,front_window_height],center=true);
        } // end for
    
    }//end difference
            for(x=[0:1:num_keys-1])
            translate([-(body_width-(slot_length[x]))/2+spacing(x)+1 ,(slot_width[x]+spring_thickness)/2,spring_z_pos])spring(x);
          
}// end union

if(show_labels){
    for(x=[0:1:num_labels-1]){
        color("white")
        translate([-body_width/2+indent+spacing(x*2),8,body_depth/2])
        linear_extrude(height = 0.6)
            text(text = str(labels[x]), font = font, size = font_size);
    }//end for
} //end if
function spacing(n) = (n==0) ? min_spacing : spacing(n-1)+slot_length[n-1]+min_spacing;

module spring(x=1){
    cube([slot_width[x],spring_thickness,spring_length], center=true);
    translate([0,-spring_thickness/2+slot_width[x]/8,-spring_length/2+slot_width[x]/4])
    difference(){
        sphere(d=slot_width[x]/2, center=true,$fn=50);
        translate([0,slot_width[x]/4 ,0])cube(slot_width[x]/2,center = true);
    }
}

module MilwaukeeHolder(){
   
    // calculate where to put the pin
    pin_pos = - body_height/2+pin_height;

    difference(){
        union(){
            // Form the main body
            cube([body_width,body_depth,body_height],center = true);
                    
            // form the pivot pins
            translate([0,0,pin_pos])rotate([0,90,0])cylinder(d=pin_dia,h=total_pin_length,center=true,$fn=50);
            
            //form the horizontal catches
            translate([body_width/2,0,pin_pos])rotate([90,0,0])cylinder(d=catch_dia,h=body_depth,center=true,$fn=50);
            translate([-body_width/2,0,pin_pos])rotate([90,0,0])cylinder(d=catch_dia,h=body_depth,center=true,$fn=50);
            
            //form the vertical catches
            translate([body_width/2,0,0])rotate([0,0,0])cylinder(d=catch_dia,h=body_height,center=true,$fn=50);
            translate([-body_width/2,0,0])rotate([0,0,0])cylinder(d=catch_dia,h=body_height,center=true,$fn=50);
        } // end union
        
        //cut off bottom corners
        translate([(body_width+catch_dia)/2,0,-body_height/2])rotate([0,45,0])cube([bottom_chamfer,body_depth+render_offset,bottom_chamfer],center=true);
        translate([-(body_width+catch_dia)/2,0,-body_height/2])rotate([0,45,0])cube([bottom_chamfer,body_depth+render_offset,bottom_chamfer],center=true);
        translate([0,-body_depth/2,-body_height/2])rotate([45,0,0])cube([body_width+render_offset, bottom_chamfer ,bottom_chamfer],center=true);
        translate([0,body_depth/2,-body_height/2])rotate([45,0,0])cube([body_width+render_offset, bottom_chamfer ,bottom_chamfer],center=true);     
    
    }//end difference
} // end module