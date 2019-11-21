x_length = 2;
y_length = 2;
x_divisions = 0;
y_divisions = 1;
height = 29.33; //[91:Full Height,59.66:2/3 Height,44.5:1/2 Height,29.33:1/3 Height,21.75:1/4 Height,14.166:1/6 Height,6.5833:1/12 Height]

// So long as the dividers line up with a compartment size (x - 1 or x/2 -1, same for y), leave 0.  Otherwise set to something like 2.
divider_height_subtract = 0;

// ignore variable values
divider_height = height - divider_height_subtract;

module stanley_container(x, y, x_div, y_div, height=29, divider_height=divider_height) {
    difference() {
        hull() {
            translate([3,3,0]) cylinder(height,3,3,$fn=25);
            translate([39*x-3,3,0]) cylinder(height,3,3,$fn=25);
            translate([3,53.5*y-3,0]) cylinder(height,3,3,$fn=25);
            translate([39*x-3,53.5*y-3,0]) cylinder(height,3,3,$fn=25);
        }
        hull() {
            translate([5,5,2]) cylinder(height,3,3,$fn=25);
            translate([39*x-5,5,2]) cylinder(height,3,3,$fn=25);
            translate([5,53.5*y-5,2]) cylinder(height,3,3,$fn=25);
            translate([39*x-5,53.5*y-5,2]) cylinder(height,3,3,$fn=25);
        }
    }
    if (x_div > 0) {
        for(i = [1:x_div]) {
            compartment = (39*x)/(x_div + 1);
            translate([compartment * i - 1,0,0]) cube([2, 53.5*y, divider_height]);
        }
    }
    if (y_div > 0) {
        for(i = [1:y_div]) {
            compartment = (53.5*y)/(y_div + 1);
            translate([0,compartment * i - 1,0]) cube([39*x, 2, divider_height]);
        }
    }
}

// 1/12 = 6.5833 * 12 + 12 = 91
// 1/6 = 14.166 * 6 + 6 = 91
// 1/4 = 21.75 * 4 + 4 = 91
// 1/3 = 29.33 * 3 + 3 = 91
// 5/12 = 37.92 + (29.33 + 1) + (21.75 + 1) = 90
// 1/2 = 44.5 * 2 + 2 = 91
// 2/3 = 59.66 + 1 + 29.33 + 1 = 90
// 1 = 91
stanley_container(x_length,y_length,x_divisions,y_divisions,height);
//translate([0,53.5-1,0]) cube([39*2, 2, 36.5]);
//translate([39-1,0,0]) cube([2, 53.5*2, 36.5]);
