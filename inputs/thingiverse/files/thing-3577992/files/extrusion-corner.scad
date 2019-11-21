// Designed by Nathaniel Stenzel April 21, 2019
// Thing 3577992

$fn=20;

  //////////////////////////
 // Customizer Settings: //
//////////////////////////

// All measurements are in mm.
// How big is the square tube or extrusion?
inner_size=19.5;
// How big do you want the mount to be around the square tube or extrusion?
outer_size=26;
// How much of the square tube or extrusion do you want inserted into this corner bracket?
insertion_depth=50;
// Do you want the vertical tube to have a bottom or do you want it to stick through?
have_bottom=1; // [1:Yes, 0:No]
// How big do you want the screw holes? (0 for none)
screw_size=3;
// How thick do you want the triangular braces? (0 for none)
fin_thickness=5; 
//Layer height which will be used to help add support
support_height=0.22;
//Should I add a thin support layer at the bottom of the horizontal holes?
hole_support=1; // [1:Yes, 0:No]

module fin(height,width,thickness) {
    linear_extrude(height = thickness)
        polygon(points=[[0,0],[0,width],[height,0]]);
}

module corner(inner=0,outer=0,depth=0,bottom=true,add_hole_support=true,layer_height=0,screws=5,fins=5) {
union(){
    //tubes
    difference(){
        
        union() {
            translate([-outer/2,-outer/2,0])cube([outer,outer,outer+depth]); //Z tube
            translate([-outer/2,outer/2,0])cube([outer,depth,outer]); //X tube
            translate([outer/2,-outer/2,0])cube([depth,outer,outer]); //Y tube
        }
        //Z tube void
        if(bottom)
        {
            translate([-inner/2,-inner/2,(outer-inner)/2])cube([inner,inner,outer+depth]); 
            }
        else
        { //cut out the bottom of the Z tube shaft too
            translate([-inner/2,-inner/2,-1])cube([inner,inner,outer+depth+3]);             
        }
        translate([-inner/2,inner/2-1,(outer-inner)/2])cube([inner,depth+outer-inner+4,inner]); //X tube void
        translate([inner/2-1,-inner/2,(outer-inner)/2])cube([depth+outer-inner+4,inner,inner]); //Y tube void

        //Z tube shaft screw holes
        translate([0,0,depth/3+outer])rotate([0,-90,0])cylinder(d=screws,h=outer+5,center=true);
        translate([0,0,depth*2/3+outer])rotate([0,-90,0])cylinder(d=screws,h=outer+5,center=true);
        translate([0,0,depth/3+outer])rotate([90,0,0])cylinder(d=screws,h=outer+5,center=true);
        translate([0,0,depth*2/3+outer])rotate([90,0,0])cylinder(d=screws,h=outer+5,center=true);
        
        difference() {
            union() {

        //X tube shaft screw holes
                translate([depth/3+outer/2,0,-1])cylinder(d=screws,h=outer+3);
                translate([depth*2/3+outer/2,0,-1])cylinder(d=screws,h=outer+3);
                translate([depth/3+outer/2,0,outer/2])rotate([90,0,0])cylinder(d=screws,h=outer+3,center=true);
                translate([depth*2/3+outer/2,0,outer/2])rotate([90,0,0])cylinder(d=screws,h=outer+3,center=true);

                //Y tube shaft screw holes
                translate([0,depth/3+outer/2,-1])cylinder(d=screws,h=outer+3);
                translate([0,depth*2/3+outer/2,-1])cylinder(d=screws,h=outer+3);
                translate([0,depth/3+outer/2,outer/2])rotate([0,90,0])cylinder(d=screws,h=outer+3,center=true);
                translate([0,depth*2/3+outer/2,outer/2])rotate([0,90,0])cylinder(d=screws,h=outer+3,center=true);
            }
            if (add_hole_support) {
                translate([depth/3+outer/2,0,inner+(outer-inner)/2-1])cylinder(d=screws,h=layer_height+1);
                translate([depth*2/3+outer/2,0,inner+(outer-inner)/2-1])cylinder(d=screws,h=layer_height+1);
                translate([0,depth/3+outer/2,inner+(outer-inner)/2-1])cylinder(d=screws,h=layer_height+1);
                translate([0,depth*2/3+outer/2,inner+(outer-inner)/2-1])cylinder(d=screws,layer_height+1);
            }
        }
 
  }
        
    
    //tube supports  
    translate([outer/2,outer/2,0])fin(depth,depth,fins);
    translate([outer/2,fins-outer/2,outer])rotate([90,0,0])fin(depth,depth,fins);
    translate([fins-outer/2,outer/2,outer])rotate([0,-90,0])fin(depth,depth,fins);
}

}

corner(inner=inner_size,outer=outer_size,depth=insertion_depth,bottom=have_bottom,add_hole_support=hole_support,layer_height=support_height,screws=screw_size,fins=fin_thickness);
