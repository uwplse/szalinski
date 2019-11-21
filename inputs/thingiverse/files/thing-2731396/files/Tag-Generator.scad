length = 85; // Length of the carrier bar
text = "From Mom & Dad"; // Text 

translate([3,0,0]) linear_extrude(height=3) text(text, size=10);

translate([0,5,0]) 
    rotate([0,90,0])
        linear_extrude(height=length) {
                polygon([[0,-1],[-2,0],[0,1]]);
        }

translate([-4,5,0]) difference() {
    cylinder(h=2, r=5);
    translate([0,0,-1]) cylinder(h=4, r=4);
}
