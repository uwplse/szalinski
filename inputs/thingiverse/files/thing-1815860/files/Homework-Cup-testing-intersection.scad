///////////////////////////////////VARIABLES/////////////////////////////////


cup_r = 28;
fillet_r = 20;
wall_thick = (3);
inner_r = (cup_r-wall_thick);
rounding_r = 2;

top_h = 7;
bottom_h = 15;
bottom_pos = (cup_r-(bottom_h/2));

echo(bottom_pos);

alfa = acos(bottom_pos/cup_r);

bottom_r = sqrt((pow(cup_r,2))-(pow(bottom_pos,2)));


///////////////////////////////////ADDITATIVE/////////////////////////////////

//difference() {
//translate([cup_r,top_h,0]) 
//square([rounding_r*2, rounding_r*2], center=true);
//
//translate([cup_r-rounding_r,top_h-rounding_r,0]) 
//circle(r=rounding_r, $fn=100, center=true);
//}
rotate_extrude() {
difference() {
difference() {
    

union() {    

// Main cup circle
    
circle(r=cup_r, $fn=200, center=true);

// Top edge

translate([0,top_h/2,0]) {
square([2*cup_r, top_h], center=true);
}

// Bottom edge
       
translate([0,-(bottom_pos),0]) {
square([2.*bottom_r, bottom_h], center=true);
}


}    
///////////////////////////////////SUBTRACTIVE/////////////////////////////////

union() {
// Remove inner volume
 
circle(r=inner_r, center=true);


// Create fillet
  
translate([(bottom_r+(fillet_r*sin(alfa))),-((cup_r*cos(alfa))+(fillet_r*cos(alfa))),0]) {

circle(r=fillet_r, $fn=100, center=true);
}
// Remove inner top

translate([0,top_h/2,0]) {
square([2*inner_r, top_h], center=true);
}    
// Remove top of cup

translate([-cup_r,top_h,0]) {
square([2*cup_r, (cup_r-top_h)]); 
}

}
}
translate([-cup_r,-cup_r,0])
square([cup_r,2*cup_r]);
}
}
///* rotate_extrude()
//translate([10,0,0])
//circle(5); */

//translate([-cup_r,-cup_r,0])
//square([cup_r,2*cup_r]);