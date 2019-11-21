// NOTE: Please refer to the picture with drawing to get all the variables explained in details
/* [Outer Size] */
//Diameter of the pipe
pipe_diameter=28;
//Diameter of the base
base_diameter=70;
//Height of the base, before the loft will start
base_height=10;
// Height of the part with loft from base to to pipe diameter
loft_height=30;
// Note: Total height of part = loft_height + base_height
// Please refer to picture with drawing to better understand the variables, if in doubt
/* [Inner space] */
//Difference of the inner space's diameter to inner space's diameter at base level 
base_inner_diameter_decrease=20;
// Difference of top diameter to pipe's diameter
top_add_diameter=5;


/* [ Split into two halves?]*/
split=0; // [1:Yes, 0:No]
// Space between two halves 
space=30;
/* [Hidden]*/

if (split) {
// draw base as circle
difference(){
    draw_cap();
//subtract half of cap
translate([-base_diameter/2,0,0]) {
    cube([base_diameter,base_diameter/2,base_height+loft_height],center=false);
}
}
translate ([0,space,0]) {
    rotate ([0,0,180]){
    mirror ([1,0,0]){
difference(){
    draw_cap();
//subtract half of cap
translate([-base_diameter/2,0,0]) {
    cube([base_diameter,base_diameter/2,base_height+loft_height],center=false);
}
}
 }   
}
}
}else{
    draw_cap();
}



// make two halfs


module draw_cap(){
     difference(){ 
    union(){
        //draw the base
        cylinder(h=base_height, r=base_diameter/2, center=false);
        //draw the loft
        translate ([0,0,base_height]){
            cylinder(h=loft_height, r1=base_diameter/2, r2=(top_add_diameter+pipe_diameter)/2, center=false);
        }
    }
    //subtract the inner space
    translate ([0,0,0]){
          cylinder(h=loft_height, r1=(base_diameter-base_inner_diameter_decrease)/2, r2=pipe_diameter/2, center=false);
    }
    translate ([0,0,loft_height]) {
          cylinder(h=base_height, r=pipe_diameter/2, center=false);
    }}

}
