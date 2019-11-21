/* [Main] */
// Number of cylinders
n=10;
// Lower Diameter of the Tower
d=60;
// Height of the Tower
h=140;
// Twist
twist=150;
// Shrinkage
shrinkage=0.6;
// Resolution
res=100;



module twist_tower(n,d,h,twist,scale)
{
 r=(d*PI)/(2*n);
 linear_extrude(height=h,center=false,twist=twist,slices=50, scale=scale)
 for(j=[0:360/n:360])
 rotate([0,0,j])
 translate([r*n/PI,0,0])
 circle(r=r, $fn=res);
}

twist_tower(n=n, d=d-2*(d*PI)/(2*n), h=h, twist=twist, scale=shrinkage);