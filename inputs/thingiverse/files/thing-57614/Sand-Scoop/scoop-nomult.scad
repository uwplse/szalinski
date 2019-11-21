// Customizable Parametric sand scoop
// Daniel M. Taub March 8 2013

include<write/Write.scad>
//use<write.scad>


// Length of the handle
handle = 80; // [20:200]

// Radius of the handle
hrad = 20; // [10:30]

// Radius of the scoop
srad =60; // [20:60]

// Length of scoop
scoop = 60; // [60:200]

// Scoop wall thickness
wall = 2; // [2:10]

// point on spade
//walltaper = 5; // [1:5]

// truncate back and sides? 
bpt = "yes" ; //[yes,no]
		
//grade on spade
grade =35; // [35:light,45:medium,55:hard,65:steep]

//rotational skew
skew = 0; // [0:10]

// text for handle
text = "This is a handle";

// font size
asize=5; //[1:32]

tsize=asize/4;

istaper = bpt == "yes" ? 2 : 1; 

rotate([0,90,0]){
  cylinder(h=handle,r=hrad);
  writecylinder(text,[0,0,0],hrad,handle,rotate=-90,west=90,h=5*tsize,t=tsize);
}
translate([handle,0,0])sphere(r=hrad);

translate([-scoop/2,0,srad-hrad])
  rotate([0,90,0])
    difference(){
      cylinder(h=scoop,r=srad,center=true);
      translate([-wall,0,-wall])
        union(){
          cylinder(h=scoop,r=srad-wall,center=true);
          translate([-srad/2,0,0])cube([srad,2*istaper*(srad-wall),scoop*istaper],true);
        }
     translate([sin(grade)*(srad+scoop)/2,0,wall*2-scoop]){
        rotate([0,-grade,0])cube([scoop/2+srad/2,scoop*2+srad*2,scoop*4],true);

      }

    }