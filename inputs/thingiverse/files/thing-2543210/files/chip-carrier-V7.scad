
/* MEMSFACTORY on Thingiverse Copyright 2017  
    all units in mm
    */

/* [Hidden] */
$fn=20;
fudge=.1; //fudge factor for openscad boolean operations
tray_thickness=4;  //tray thickness

/* [The Chip] */
chip_sz_X=18;  // x direction
chip_sz_Y=18;   //y direction
//sets vertical gap for the chip, max value 1.7mm or less
chip_thickness=.5;   
corner_radius_cut_out=1.5;

//leave a little slop all around the chip
chip_padding=1; 

/* [Tray (Bottom carrier) ] */
rows=1; 
cols=1;
//the wall thickness of chip carrier around the chip
outer_wall_thk=3;  
// percent of chip_sz_Y direction
tweezer_slot_pct=35;
//tweezer slot depth downward under the chip z direction
twzr_slot_depth=1;
//tweezer slot length going towards the chip center
twzr_slot_length=2;  

twzr_slot_w=tweezer_slot_pct*chip_sz_Y/100;  //width of the slot for the tweezer


//frame around the lid, this is the area that might touch the top of the chip
lid_frame=2.5; 
lid_thickness=1;

frame=outer_wall_thk*2;  //the actual frame is HALF this number


/* [3d printer dependent] */
//more padding makes the lid fit looser, around .75 or less you start getting a snap fit
fit_padding=.75; 

//*********************MAIN module ******************************
Unit_Sz_X=chip_sz_X+frame;
Unit_Sz_Y=chip_sz_Y+frame;


//bottom carrier
difference () {
for (x=[0:cols-1]) { //array copy
   
    for (y=[0:rows-1]) {  translate([x * Unit_Sz_X, y * Unit_Sz_Y,0]) SINGLE_carrier();}
  } 
  //divot cut out on the corner
color("red")translate ([(-chip_sz_X-frame)/2,(-chip_sz_Y-frame)/2,0])rotate([0,0,45])cube(size=[frame/2, frame/2, frame*3], center=true);   }

// lid part

 
{
translate([0,Unit_Sz_Y*(rows)+3,0])  
    for (x=[0:cols-1]) { //array copy
        Unit_Sz_X=chip_sz_X+frame;  
        for (y=[0:rows-1]) { Unit_Sz_Y=chip_sz_Y+frame; translate([x * Unit_Sz_X, y * Unit_Sz_Y,0]) lid();}
      } 
// adding the triangular divot on the lid corner
triangle();  }
  

if ((chip_sz_X > 6) && (chip_sz_Y >5)) {  // if chip size if greater than value then put write my thingiverse user name
      translate([Unit_Sz_X*(cols-1), Unit_Sz_Y*rows+3,0])translate([-chip_sz_X/3.5,chip_sz_Y/20,-tray_thickness/4-fudge]){
   linear_extrude(height=.35)text("mems", size=chip_sz_X/8, font = "Liberation Sans:style=Bold Italic");
   linear_extrude(height=.35)translate ([0,-chip_sz_X/6,0])text("factory", size=chip_sz_X/8, font = "Liberation Sans:style=Bold Italic");
 }
 }
    
   //lid();
      
//corner cut out

   
      

//***********************************end MAIN 
  
  
module SINGLE_carrier () {
  //carrier bottom code
 difference(){
    cube (size=[chip_sz_X+frame, chip_sz_Y+frame, tray_thickness], center=true);
    chip();
    sideopenings();
    cylinders();}
}



module chip() //chip bounds
{    
   translate ([0,0,tray_thickness/4])  
   cube(size=[chip_sz_X+chip_padding,chip_sz_Y+chip_padding,tray_thickness/2+fudge], center=true);
}
    



module cylinders(){
    translate ([0,0,tray_thickness/4])
    {
    translate([chip_sz_X/2+corner_radius_cut_out/3,chip_sz_Y/2+corner_radius_cut_out/3]) cylinder(h=tray_thickness/2+fudge, r=corner_radius_cut_out, center=true);
    translate([-(chip_sz_X/2+corner_radius_cut_out/3),chip_sz_Y/2+corner_radius_cut_out/3]) 
cylinder(h=tray_thickness/2+fudge, r=corner_radius_cut_out, center=true); 
      
      translate([chip_sz_X/2+corner_radius_cut_out/3,-(chip_sz_Y/2+corner_radius_cut_out/3)]) 
cylinder(h=tray_thickness/2+fudge, r=corner_radius_cut_out, center=true);
       translate([-(chip_sz_X/2+corner_radius_cut_out/3),-(chip_sz_Y/2+corner_radius_cut_out/3)]) 
cylinder(h=tray_thickness/2+fudge, r=corner_radius_cut_out, center=true);
   
    }   
}
module sideopenings(){
    Y_bounds=(chip_sz_Y+frame)/2; X_bounds=(chip_sz_X+frame)/2;
    
    translate([-twzr_slot_w/2,Y_bounds-twzr_slot_length-frame/2+fudge,-twzr_slot_depth]) cube (size=[twzr_slot_w,frame/2+twzr_slot_length,tray_thickness],center=false);
    translate([X_bounds-twzr_slot_length-frame/2+fudge,-twzr_slot_w/2,,-twzr_slot_depth]) cube (size=[frame/2+twzr_slot_length, twzr_slot_w,tray_thickness],center=false);
    rotate([0,0,180]) translate([-twzr_slot_w/2,Y_bounds-twzr_slot_length-frame/2+fudge,-twzr_slot_depth]) cube (size=[twzr_slot_w,frame/2+twzr_slot_length,tray_thickness],center=false);
     rotate([0,0,180])translate([X_bounds-twzr_slot_length-frame/2+fudge,-twzr_slot_w/2,,-twzr_slot_depth]) cube (size=[frame/2+twzr_slot_length,twzr_slot_w,tray_thickness],center=false);
    
    //rotate([0,0,90]) translate([0,0,tray_thickness/3]) cube (size=[twzr_slot_w,chip_sz_Y+frame+fudge,tray_thickness],center=true);
}
module lid() //using the SAME chip bounds
{ 
    //translate ([0 ,0,(tray_thickness/4)+tray_thickness/8]) 
    
    translate ([0,0,-tray_thickness/2])
    {
        //lid square ring
    translate ([0,0,(tray_thickness/2-chip_thickness)/2+lid_thickness ])
        difference() {
        cube(size=[chip_sz_X+chip_padding-fit_padding,chip_sz_Y+chip_padding-fit_padding,tray_thickness/2-chip_thickness+fudge], center=true);
        cube(size=[chip_sz_X-lid_frame,chip_sz_Y-lid_frame,tray_thickness/2-chip_thickness+fudge*2], center=true);}
                
      //lid top or the larger part          
    color("royalblue")translate ([0,0,lid_thickness/2]) cube(size=[chip_sz_X+frame,chip_sz_Y+frame, lid_thickness], center=true); }
}


module triangle() 
    difference(){
        color("blue") translate ([cols * Unit_Sz_X+fit_padding/3, rows * Unit_Sz_Y-fit_padding/3+3,0])translate ([(-chip_sz_X-frame)/2,(-chip_sz_Y-frame)/2,0])rotate([0,0,45])cube(size=[frame/2, frame/2, tray_thickness/1.5], center=true);   
        translate ([cols * Unit_Sz_X-Unit_Sz_X/2, rows * Unit_Sz_Y+3-Unit_Sz_Y/2-frame/4,0])color("blue")cube(size=[Unit_Sz_X,frame/2,frame*3],center=true);
        translate ([cols * Unit_Sz_X-Unit_Sz_X/2+frame/4, rows * Unit_Sz_Y+3-Unit_Sz_Y/2-frame/4,0])color("blue")rotate([0,0,90])cube(size=[Unit_Sz_X,frame/2,frame*3],center=true);
        
    }
    