/***********************************************************************/
/*************** Handle for heavy duty cylindrical magnet **************/
/**************  JFRocchini    23/07/2017                  *************/
/**************  jfrocchini@yahoo.fr                        **************/
/**************** Enjoy !                                   **************/
/***********************************************************************/
// max diametre = 28 
magnet_diametre=20;
// width max =17
magnet_width=10;
$fn=100;

module upper(diam,width){
 union(){
  difference(){
   cylinder(d=30,h=30);
   translate([0,0,16]) rotate_extrude(convexity = 10) translate([25, 0, 0]) circle(r = 15, $fn = 100);
  
   };
    translate([0,0,30]) cylinder(d=diam,h=18-width); 
   }
}

module lower(diam,width){
    difference(){
      cylinder(d=30,h=20);
      translate([0,0,2]) cylinder(d=diam,h=19);
};
}
module holder(){
    difference(){
      cylinder(d=33,h=10);
      translate([0,0,2]) cylinder(d=30.5,h=19);
      translate([0,0,-0.1]) cylinder(d1=3,d2=6, h=3);  
};
}
lower(magnet_diametre,magnet_width);
translate([40,0,0]) upper(magnet_diametre,magnet_width);
translate([-40,0,]) holder();