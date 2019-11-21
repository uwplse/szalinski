text = "9";
textSize = 8;
c = 1.48;

difference(){
    union(){
        import("TMPlateEmpty.stl", convexity=100);
        translate([-0.5,-3.5,0])
        rotate([0,0,-15])
            import("TMPlateEmpty.stl", convexity=100);
        translate([7.65,0,-0.5])
        cube([11.5,2,1], center = true);
    }

translate([4,3.35,-0.5])
rotate([0,0,-90])
linear_extrude(height=1)
    text(text, size = textSize);



}
