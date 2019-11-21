$fencelength=25;
$fenceheight=5;
$snugness_factor=0.95;

rotate([180,0,0]) makeedgefence();

module makeedgefence()
{
  union()
  {
    scale([1,$snugness_factor,$snugness_factor])
    {
      difference() // Was 4.3mm high
      {
        cube([$fencelength,10.5,3],center=true);
        translate([0,(10.5/2)+((4/1.414)/2),-((4.3/2)+((4/1.414)/2)-2.3)])
          rotate([-45,0,0])
            cube([$fencelength+10,4,10],center=true);
        translate([0,-((10.5/2)+((4/1.414)/2)),-((4.3/2)+((4/1.414)/2)-2.3)])
          rotate([45,0,0])
            cube([$fencelength+10,4,10],center=true);
      }
    }
    translate([0,0,(4.3/2)+1])
      cube([$fencelength,2.5,7],center=true);
    translate([0,$fenceheight/2,(4.3/2)+3.25])
      cube([$fencelength,$fenceheight+20,2.5],center=true);
  }
}

