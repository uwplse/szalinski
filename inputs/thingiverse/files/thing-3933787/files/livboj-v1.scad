/* [Stand] */
//Width of stand (Could be less than mobile)
stand_width = 70;
//Rotation in deg. of the stand
rotation = 35; //[0:50]
//Hight of shelf (buttom to lower side of shelf) => Depends on how big and stiff your cable is
shelf_height= 29;
//Height of stand (from the very button to top) 
stand_height=160;
//Length of ground plate (towards back)
stand_ground_plate_lenght=80;
//Have a little stiffener on the back of the livboj cutout
stiffener=1; //[1:on,0:off]

/* [Mobile] */
//Thickness of phone (inkl. case)
mobile_thickness= 12; //[6:20]
//Distance from shelf to center of charger
dist_shelf_ctr_charger = 65;

/* [QI Charger] */
//Select charger
qi_type = 1;//[1:LIVBOJ,0:manual]
//Lower diameter of qi charger (if manual selected)
qi_lower_dia_m = 91;
//Upper diameter of qi charger (if manual selected)
qi_upper_dia_m = 89.953;
//Height of qi charger (if manual selected)
qi_height_m = 10;

/* [Cutout for Home Button] */
//Cutout for home button required?
home_btn=0; //[1:on,0:off]
//Width of cutout
home_btn_width = 20;

/* [Upper Text] */
//Switch Text on/off
text_upper_switch=1; //[1:on,0:off]
//Enter Text
text_upper="UPPER TEXT";
//Distance vom top to text
text_upper_distance = 5;
//Font size
text_upper_size=5;
//Depth of text
text_extrude_upper=1;

/* [Lower Text] */
//Switch Text on/off
text_lower_switch=1; //[1:on,0:off]
//Enter Text
text_lower="LOWER TEXT";
//Distance vom bottom to text
text_lower_distance = 18;
//Font size
text_lower_size=5;
//Depth of text
text_extrude_lower=1;

/* [Misc] */
//Add or reduce some play to the livboj
tolerance=0.5;
//Width of USB Plug
width_plug=13;
//Wall thickness
stand_thickness = 5;
//Wall thickness behind qi charger
wall_back_side_thickness = 2;


/* [Hidden] */
$fn=200;
shelf_nose_thickness = 3;
radius1 = stand_thickness/2-0.01;
radius2 = shelf_nose_thickness/2-0.01;
radius3=2;  
qi_lower_dia = (qi_type==1) ? 91 : qi_lower_dia_m;    
qi_upper_dia = (qi_type==1) ? 89.953 : qi_upper_dia_m;
qi_height = (qi_type==1) ? 10 : qi_height_m;

qi_shell_lower = (qi_lower_dia-qi_upper_dia)/qi_height*(qi_height+wall_back_side_thickness) + qi_upper_dia+2*wall_back_side_thickness;
qi_shell_upper = qi_upper_dia + 2*wall_back_side_thickness;


module kreis(h=10,t=90,b=91) {
    cylinder(h,b/2,t/2);
}
   
module livboj(tolerance=0) {
color ("red") kreis(qi_height+0.01,qi_upper_dia+2*tolerance,qi_lower_dia+2*tolerance);     
}

module livboj_schale() {

difference() {
translate ([0,0,0]) color ("blue") kreis(qi_height+wall_back_side_thickness,qi_shell_upper,qi_shell_lower);
translate ([stand_width/2,-100,-50]) cube ([100,200,100]);
translate ([-stand_width/2-100,-100,-50]) cube ([100,200,100]);
}    
}


module inner_radius() {


hans=radius3/tan((90-rotation)/2);
    
hans2=radius3+sin(rotation)*radius3;

   translate ([-stand_thickness,0,0]) {

    
    
    difference() {
    
    color ("green") mirror ([1,0,0]) square([hans,10]);    
    color ("blue") translate ([-hans,radius3,0]) circle(radius3);    
    color ("red") translate([0,0,0]) rotate(rotation) square(15) ;
    color ("black") mirror ([1,0,0]) translate([0,hans2,0]) square(15);
    }
        
}
}








rotate ([90,0,270]) color("blue") {

translate ([-stand_thickness/2,stand_thickness/2,0]) rotate(rotation) translate([-stand_thickness/2,-stand_thickness/2,0]) { //Rotate the whole thing by x degrees


//Upperpart where the mobile rests on

difference () {//LIVBOJ Cutout

union () { //Put the stuff together befor livboj cutout

//Lower part
color ("blue") linear_extrude(height=stand_width) { //Extrude der 2D Skizze


//Lower Part of Stand
offset (radius1) offset (-radius1)square (size= [stand_thickness,shelf_height+stand_thickness]);

//SHELF
translate([stand_thickness,shelf_height,0]) square (size= [mobile_thickness+shelf_nose_thickness/2,stand_thickness]);

//shelf-nose
translate([stand_thickness+mobile_thickness,shelf_height,0]) offset (radius2) offset(-radius2) square (size= [shelf_nose_thickness,stand_thickness*2]);



}



//Upper Part of Stand
color ("red") translate ([stand_thickness,shelf_height-10,0]) rotate ([0,270,0]) linear_extrude(height=stand_thickness) 
 offset(6) offset(-6) square (size= [stand_width,stand_height-shelf_height+10]);

//LIVBOJ Hull
color ("black") translate([-qi_height-wall_back_side_thickness+stand_thickness,dist_shelf_ctr_charger+shelf_height+stand_thickness,stand_width/2])  rotate ([0,90,0]) livboj_schale();

if (stiffener == 1) {

//STIFFENER

translate ([-qi_height+stand_thickness,dist_shelf_ctr_charger+shelf_height+stand_thickness,stand_width/2]) rotate ([90,270,0]) linear_extrude(height=qi_lower_dia*.8,center=true) {



difference () {

translate ([0,-1,0]) rotate (45) offset(2) offset(-2) square(7,true);

translate ([0,-3,0]) square ([20,6],true);

}

}

}

}

//LIVBOJ incl. Tolerance
translate([-qi_height+stand_thickness,dist_shelf_ctr_charger+shelf_height+stand_thickness,stand_width/2])  rotate ([0,90,0]) livboj(tolerance);


//USB Plug Cutout above shelf
translate ([-qi_height+stand_thickness,shelf_height+stand_thickness,stand_width/2-width_plug/2]) cube ([qi_height+0.01,dist_shelf_ctr_charger,width_plug]);

if (shelf_height > 10) {

//USB Plug Cutout below shelf
translate ([-.01,8+stand_thickness,stand_width/2-width_plug/2]) cube ([stand_thickness-1,shelf_height-8+.01,width_plug]);

}

if (text_upper_switch==1) {

//Text
translate ([stand_thickness-text_extrude_upper,stand_height-text_upper_distance,stand_width/2]) rotate ([0,90,0]) linear_extrude(height=2)  text(text_upper,size=text_upper_size,halign = "center",valign="top");

}

if (text_lower_switch==1) {

//Text
translate ([stand_thickness-text_extrude_lower,text_lower_distance,stand_width/2]) rotate ([0,90,0]) linear_extrude(height=2)  text(text_lower,size=text_lower_size,halign = "center",valign="top");

}

if (home_btn==1) {
//HOME BUTTON CUTOUT
    color ("black") translate([30/2+stand_thickness+mobile_thickness,shelf_height+stand_thickness/2,stand_width/2]) cube ([30.01,20,home_btn_width],true);

}

}



} //Rotation End


//Ground Plate
linear_extrude(height=stand_width) translate([-stand_ground_plate_lenght,0,0]) offset (radius1) offset (-radius1) square (size= [stand_ground_plate_lenght,stand_thickness]);


//inner radius
translate ([-tan(rotation)*stand_thickness/2*(1+sin(rotation))+stand_thickness/2*(1-cos(rotation)),stand_thickness,0]) linear_extrude(height=stand_width) inner_radius();

}
