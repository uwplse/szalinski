/*[ Properties of main cylinder ] */
// Measure the outer diameter of the main cylinder
outer_diameter_main_cylinder=8;
// Measure the length of main cylinder (until the cone starts)
length_main_cylinder=10;

/*[ Overall dimension(s) ]*/
// Measure the overall length (including top sphere)
total_length=30;

/*[ Centerbore ]*/
// Measure the diameter of the center bore
diameter_center_bore=3;
// Measure the depth of the center bore
depth_center_bore=8;

/*[ Auxiliary Bore ]*/
// Where is the auxiliary bore's center located (seen from the end with the main bore)?
position_auxlilary_bore = 14;
// what's the diameter of the auxiliary bore?
diameter_auxiliary_bore = 3;

/*[ Top Sphere] */
// Measure the diameter of the top sphere
diameter_top_sphere=12;

// Consistency checks
// Does bore diameter of center bore fit to diameter of main cylinder?
if (diameter_center_bore+1 > outer_diameter_main_cylinder) {
      echo("Center bore diameter too large, consider reducing it.");
    }
// Is auxiliary bore small enough?
if (diameter_auxiliary_bore+1>outer_diameter_main_cylinder){
      echo("Auxiliary bore diameter too large, consider reducing it.");
    }

max_diameter = max(diameter_top_sphere, outer_diameter_main_cylinder);


difference() { // subtract the auxiliary bore
union() {  // unify main cylinder, cone and sphere
    difference(){
        $fn=360;
        cylinder(length_main_cylinder,r=outer_diameter_main_cylinder/2);
        union() {  // this is the union of the main bore and the cone on top (which allows for printing without support)
           translate([0,0,-1]) {
           $fn=360;
           cylinder(depth_center_bore+1,r=diameter_center_bore/2);}  // center bore
           translate([0,0,depth_center_bore-0.01]) {
           $fn=360;
           cylinder(diameter_center_bore/2,diameter_center_bore/2,0); // cone on top of center bore
           }
       }
    }
    translate([0,0,total_length-diameter_top_sphere/2]) {
    $fn=360;
    sphere(diameter_top_sphere/2); }
    translate([0,0,length_main_cylinder]) {
    $fn=360;
    cylinder(total_length-(length_main_cylinder + diameter_top_sphere/2),outer_diameter_main_cylinder/2,diameter_top_sphere/5);}

}
// drill the auxiliary bore
translate([-max_diameter,0,position_auxlilary_bore])
rotate([0,90,0]) {
$fn=360;
cylinder(max_diameter*2,r=diameter_auxiliary_bore/2);}
}

// Johann Schuster, 22 October 2019, version 1.0
