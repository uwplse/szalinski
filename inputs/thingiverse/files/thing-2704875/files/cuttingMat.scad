width=100;
length=100;
height=2;
/* [HIDDEN] */
$fn=150;
actualHeight=(height-1);
minkowski()
{
  cube([width,length,ActualHeight]);
  cylinder(r=2,h=1);
}