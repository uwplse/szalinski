// $fs = 0.01;
//$fn = 360;
$fn = 120;

rotate([0,90,0])
{

//difference()
{
    union()
    {

      {
      cylinder(34,1.8,1.8);
      }
      
      sphere(r=1.8);
      
      translate([0,0,28.1])
      {    
        sphere(r=2.75);
      }
      
      translate([0,0,36])
      {    
        sphere(r=4.35);
      }
    }
/*
    translate([2.8,-25,-5])
    { 
      cube(50,22,50);
    }
    */
}

}