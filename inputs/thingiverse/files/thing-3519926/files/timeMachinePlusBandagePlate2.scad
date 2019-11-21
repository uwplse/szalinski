text = "";
textSize = 3;
c = 1.48;

difference(){
rotate([90,0,0]){
    import("TimeMachinePlus.stl", convexity=100);
}

translate([7,4.9,-0.5])
rotate([0,0,-82])
linear_extrude(height=1)
    text(text, size = textSize);

translate([-1,-1,-11])
cube([20,10,10]);

}
translate([7,2.68178,-2])
cylinder(c, c, c, c, $fn = 500);

translate([11,3.1694,-2])
cylinder(c, c, c, c, $fn = 500);