// hole diameter in mm
hole_diameter = 1;
// This is very fun to play with
// 50 is very round
roundness_of_the_edges = 10;
// diameter of the pearl (in mm)
diameter = 10;
/*[advanced]*/
// this cylinder cuts out the hole(no need to change!)in mm
length_of_cutting_cylinder = 500;
// Determines the roundness of your hole. (50 =round)
edges_of_hole = 50;
/*[Hidden]*/

difference() {
  {
    $fn=roundness_of_the_edges;    //set sides to roundness_of_the_edges
    sphere(r=10);
  }

  {
    $fn=edges_of_hole;    //set sides to edges_of_hole
    cylinder(r1=hole_diameter, r2=hole_diameter, h=length_of_cutting_cylinder, center=true);
  }
}