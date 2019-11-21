$fn=18;

numOfEl=120;  // number of elements
radius=50;   // main radius
radius1=6;   // radius of linked spheres
radius2=5;   // radius of unlinked spheres
link_length=20;
link_radius=2; 
link_every=5;
twist=3;
flatten=0.8; // normal = 1

scale([1,1,flatten])
color("SteelBlue")
union(){
 
//// sphere in center
// translate([0,0,-4])
 //   sphere(12);  
 
//// base
// translate([0,0,-link_length/2-radius1])
 //  cylinder(h=2,r=radius+radius1, center=0);  

 for (i = [0:1:numOfEl-1]) {
   rotate( [0, 0, i*(360/numOfEl)]) 
    translate([radius,0,0]) 
      if((i/link_every-round(i/link_every))==0) {
        //color("red") 
         DNA_mod(roty= i*twist*(360/numOfEl), radius=radius1, link_radius=link_radius, link_length=link_length, link=true);
      } else {
        // color("blue")
         DNA_mod(roty= i*twist*(360/numOfEl), radius=radius2, link_radius=link_radius, link_length=link_length, link=false);
      }
 }

}

//=================================

module DNA_mod(radius=10, link_radius=3, link_length=50, rotx=0, roty=0, rotz=0, link=true){

 rotate( [rotx, roty, rotz]) 
  union() {

    translate([-1*link_length/2, 0, 0]) 
     sphere(radius);

    translate([link_length/2, 0, 0]) 
     sphere(radius);

    if (link) { 
       translate([-link_length/2, 0, 0]) rotate([0,90,0]) 
        cylinder(h=link_length,r=link_radius, center=0);
    }
  }
}
