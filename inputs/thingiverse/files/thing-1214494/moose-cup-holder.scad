// Customizable Moose Cup Holder 
// by edak

//CUSTOMIZER VARIABLES
/* [Basic Options] */
// Cup top diameter (mm)
cup_top=70;
// Cup bottom diameter (mm)
cup_bottom=55;
// Cup height (mm)
cup_height=85;
// Show cup holder/ring?
show_holder="yes";// [yes,no]
// Show antler?
show_antler1="yes";// [yes,no]
// Show antler?
show_antler2="yes";// [yes,no]


module tapered_extrude_children(scale1=10.0,scale2=1.0,height=10,twist=45,fn=32) {
  for(kid=[0:$children-1]) {
    for(i=[0:fn-1]) translate([0,0,height*i/fn]) {
      hull() {
        linear_extrude(height=height/fn/10) scale(scale1*(fn-i)/fn+scale2*i/fn) child(kid);
        translate([0,0,height/fn-height/fn/10])
          linear_extrude(height=height/fn/10) scale(scale1*(fn-i-1)/fn+scale2*(i+1)/fn) child(kid);
      } // hull
    } // for each slice
  } // for each child
} // module

module cup() {
   translate([0,0,-cup_height/2]) cylinder(cup_height, cup_bottom/2,cup_top/2,true, $fn=100);
} // visualise the cup so we can subtract it such that it fits snugly
    

module slot() {   
    translate([-(cup_top/2 + 3.5),0,-16.5]) rotate([0,atan(((cup_top - cup_bottom)/2)/cup_height),180]) difference(){  
        translate([-5,-6,0.1]) cube([7,12,14])   ;
        tapered_extrude_children(scale1=1,scale2=0.8,height=12,fn=3) {
            circle(5.5,$fn=3);
        }          
    }
} // needed some slots so made a box and took a tapered section out

module holder() {
    difference(){
        union(){
            intersection(){
                translate([0,0,-(cup_height/2)]) cylinder((cup_height-0.1), (cup_bottom+4)/2,(cup_top+4)/2,true, $fn=100);
                translate([0,0,-10]) cylinder(20.1,cup_top,cup_top,true);
            }
            slot();
            rotate([0,0,180]) slot();
        }
        cup();
    }
}

module antler() {
    difference(){
        translate([-((0.5*cup_top)+105),0,-13.8]) rotate([90,10,0]) scale([0.115,0.115,1]) linear_extrude(height = 8, center = true, convexity = 10) import("antler.dxf",convexity = 1);
        scale([1,0.95,1]) slot();
        holder(); //dont want to have the back end of the antler in the cup or holder!
        cup();
    }
}
   
   
if(show_antler1=="yes") antler();
if(show_antler2=="yes") rotate([0,0,180]) antler(); 
if(show_holder=="yes") holder();
//#cup();

   



