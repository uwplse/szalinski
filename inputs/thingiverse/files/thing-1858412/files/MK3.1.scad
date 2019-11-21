/* [Main body] */
Main_body_lenght=50; // lenght of the part
Main_body_width=50; //width of the part
Main_body_height=20; //heigth of the part

/* [Element options] */
//Your element diameter
Element_diameter=8; //element diameter
//Set to 0 to disable
Element_window_spacing=16; //size of the window from ellement

Element_hole_position=-10; //position of the el hole from boom center
Boom_diameter=25.5; //boom diameter


/* [Screw options] */
//screw hole diameter for tensioning the antenna elements
Element_Screw_hole_diameter=3  /2; //element screw hole diameter
Screw_hole_length=32; //screw hole lenght
//Screw hole diameter for tensioning the holder onto the boom
Screw_hole_diameter=2.75  /2; // screw hole radius
//Hole diameter for easier screw tensioning
Screw_hole_tension_diameter=4  /2; //screw rotate radius
//Distance from center to the hole
Screw_hole_spacing=18; //screw hole distance from center
//set to 0 to disable, use this for self tapping screws
Screw_head_radius=4; //screw head radius


/* [Polygon count] */
//Set this to 4 for square boom
Polygon_count_in_boom=100; //num of polygon in boom hole
Polygon_count_for_holes=100; //num of polygons in other holes



/* [Split options] */
Add_split=true; //add split
Split_spacing=3; //split lenght

/* [Text options] */
Your_text= "LY3EU"; //text
//could't get the text to align properly, so used this instead
Text_align = -10.5; //text align thing
Text_size = 5; //[0:0.1:10]


 difference() {
cube([Main_body_lenght,Main_body_width,Main_body_height],true); //part itself
translate([5,0,0]) { rotate([0,0,45]) {cylinder(Main_body_height+0.1, Boom_diameter/2, Boom_diameter/2,true, $fn=Polygon_count_in_boom);}} //boom hole
$fn=Polygon_count_for_holes;

rotate([90,0,0]){
    
        translate([Element_hole_position-5,0,0]) { 
            
        cylinder(Main_body_width+0.1, Element_diameter/2+.25, Element_diameter/2+  .25,true);} //el hole

    translate([Element_hole_position-10,0,0]) {cube([Element_window_spacing,Main_body_height+.1,Element_window_spacing],true);} //el window

}
if(Add_split==true) { //check if split is enabled
    rotate([0,90,0]){
        
        translate([0,Screw_hole_spacing*-1,0]){
            cylinder(Screw_hole_length, Screw_hole_diameter, Screw_hole_diameter); //screw hole 1
           translate([0,0,5]){cylinder(Screw_hole_length, Screw_hole_tension_diameter, Screw_hole_tension_diameter);}//screw tension hole
            translate([0,0,23.1]) {cylinder(4, 0, Screw_head_radius,true);} //screw head 
            } 
            
        translate([0,Screw_hole_spacing,0]){
            cylinder(Screw_hole_length, Screw_hole_diameter, Screw_hole_diameter);//screw hole 2
            translate([0,0,5]){cylinder(Screw_hole_length, Screw_hole_tension_diameter, Screw_hole_tension_diameter);}//screw tension hole 
                   translate([0,0,23.1]) {cylinder(4, 0, Screw_head_radius,true);} //screw head
            
            } 
            
    }
    translate([5,0,0]) {cube([Split_spacing, Main_body_width+.1, Main_body_height+.1], true);} //split itself
}//if split end



//start of chamfers

translate([-Main_body_lenght/2-2,0,Main_body_height/2+6]) {rotate([0,360-30,0]) {cube([20,Main_body_width+1,20],true);}}

translate([-Main_body_lenght/2-2,0,(Main_body_height/2+6)*-1]) {rotate([0,30,0]) {cube([20,Main_body_width+1,20],true);}}

//end of chamfers

translate([-13,-13]){cylinder(Main_body_height+0.1, Element_Screw_hole_diameter, Element_Screw_hole_diameter, true, $fn=100);} //el screw hole1

translate([-13,13]){cylinder(Main_body_height+0.1, Element_Screw_hole_diameter, Element_Screw_hole_diameter, true, $fn=100);} //el screw hole2


translate([24.5,Text_align,-2]) {rotate([90,0,90]) {linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text(Your_text, font="Liberation Sans:style=Bold", size=Text_size);}} //TEXT

}


