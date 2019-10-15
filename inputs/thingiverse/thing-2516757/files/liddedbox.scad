//  length
x = 75;
//  width
y = 50;
//  height
z = 20;
//  width wall
w = 2.5;
//  inner rim height
irim = 0;
//  outer rim height
orim = 1.5;
//  radius corners (must be >0)
r = 2;
   
module case();

union()
{

difference()
{
$fn=50;
    
    hull()
    {
        translate([x-r,y-r])cylinder(r=r,h=z);
        translate([r,y-r])cylinder(r=r,h=z);
        translate([x-r,r])cylinder(r=r,h=z);
        translate([r,r])cylinder(r=r,h=z);
    }

    translate([w,w,w])cube([x-2*w,y-2*w,z]);
} 

difference()
{
$fn=50;
    
    hull()
    {
        translate([x-r,y-r])cylinder(r=r,h=z+orim);
        translate([r,y-r])cylinder(r=r,h=z+orim);
        translate([x-r,r])cylinder(r=r,h=z+orim);
        translate([r,r])cylinder(r=r,h=z+orim);
    }

    translate([w/2,w/2,w])cube([x-w,y-w,z+orim]);
}
  
difference()
{
$fn=50;
    
    hull()
    {
        translate([x-(r+w/2),y-(r+w/2)])cylinder(r=r,h=z+irim);
        translate([r+w/2,y-(r+w/2)])cylinder(r=r,h=z+irim);
        translate([x-(r+w/2),r+w/2])cylinder(r=r,h=z+irim);
        translate([r+w/2,r+w/2])cylinder(r=r,h=z+irim);
    }

    translate([w,w,w])cube([x-2*w,y-2*w,z+irim]);
}

}


