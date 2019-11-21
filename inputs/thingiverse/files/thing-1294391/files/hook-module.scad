
// height of the object you want to clamp
hook_height = 20; // [1:100]
// length of the clamp/grip
hook_length = 20; // [5:50]

translate([-3,3,0]) hook(hook_height,hook_length);

module hook (height, length)
{
    color("red") translate([3,height-3,0]) cube([length,3,15]);
    
    color("green") cube([3,height,15]);

    translate([-15,-3,0]) difference()
    {
        translate([7.5,1.5,7.5])        rounded();
        translate([7.5,0,7.5]) rotate ([90,0,0]) cylinder (h=8, r=1.75, center = true, $fn=100);
    }
}
module rounded()
{
    rotate ([90,0,0]) cylinder (h=3, r=7.5, center = true, $fn=100);
    translate([0,-1.5,-7.50]) cube([10.5,3,15]);
 }
