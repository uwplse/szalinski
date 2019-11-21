// Length of a cube side
side = 20;

module c()
{
  cube(size=side, center=true);
}


$fn = 100;

module c1()
{
  union()
  {
    c();
    translate([side,0,0]) c();
    translate([side,side,0]) c();
    translate([side,0,side]) c();
  }
}


module c2()
{
  union()
  {
    c();
    translate([side,0,0]) c();
    translate([side,side,0]) c();
  }
}


module c3()
{
  union()
  {
    c();
    translate([side,0,0]) c();
    translate([side,side,0]) c();
    translate([2 * side,side,0]) c();
  }
}


module c4()
{
  union()
  {
    c();
    translate([side,0,0]) c();
    translate([side,side,0]) c();
    translate([2 * side,0,0]) c();
  }
}


module c5()
{
  union()
  {
    c();
    translate([side,0,0]) c();
    translate([side,side,0]) c();
    translate([side,side,side]) c();
  }
}


module c6()
{
  union()
  {
    c();
    translate([side,0,0]) c();
    translate([side,side,0]) c();
    translate([0,0,side]) c();
  }
}


module c7()
{
  union()
  {
    c();
    translate([side,0,0]) c();
    translate([2 * side,side,0]) c();
    translate([2 * side,0,0]) c();
  }
}

translate([3 * side,0,0]) c1();
translate([4 * side,6 * side,0]) c2();
translate([0,3 * side,0]) c3();
translate([4 * side,3 * side,0]) c4();
translate([6 * side,0,0]) c5();
translate([0,0,0]) c6();
translate([0,6 * side,0]) c7();



