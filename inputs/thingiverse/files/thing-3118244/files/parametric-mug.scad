// Parametric cup by carlgval

// Exercise of OpenSCAD. A parametric mug with a char (unicode) stamped on it

echo(version=version());

height = 130;
radius = 50;
width = 1;

handle_width1 = 20;
handle_width2 = 10;
handle_radius = 40;

char = "\u2665";
font = "Cardo";
char_size = 80;
char_depth = 2;
type = "out"; // [in, out, very-out]

if (type == "in"){
    radius = radius-char_depth;
}
color("pink")
difference(){
    union(){
        translate([0, 0, 0])
        cylinder(r=radius,h=height, $fn = 100);
        
        translate([radius * 1.2, 0, height/2])
        scale([0.8, 1, 1])
        rotate([90,0,0])
        rotate_extrude(convexity = 10, $fn = 100)
        translate([handle_radius, 0, 0])
        resize([handle_width2, handle_width1])
        circle(r = 1, $fn = 100);
        
        if (type == "in"){
            difference(){
                cylinder(r=radius+char_depth,h=height, $fn = 100);
                cylinder(r=radius,h=height, $fn = 100);
                translate([0, -radius-char_depth, height/2])
                rotate([90,0,180])
                linear_extrude(radius,scale = [0,1])
                rotate([0,180,0])
                text(char, size = char_size, font = font, halign = "center", valign = "center", $fn = 16);
            }
        } else if (type == "very-out"){
                translate([0, -radius-char_depth, height/2])
                rotate([90,0,180])

                linear_extrude(radius+char_depth)
                rotate([0,180,0])
                text(char, size = char_size, font = font, halign = "center", valign = "center", $fn = 16);
            }else{
            intersection(){
                cylinder(r=radius+char_depth,h=height, $fn = 100);
                translate([0, -radius-char_depth, height/2])
                rotate([90,0,180])
                linear_extrude(radius+char_depth,scale = [0,1])
                rotate([0,180,0])
                text(char, size = char_size, font = font, halign = "center", valign = "center", $fn = 16);
            };}
    }
    translate([0, 0, width])
    cylinder(r=radius - 2 * width, h = height, $fn = 100);
};

