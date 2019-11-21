
// An array of single digit numbers, number of elements determines number of uprights, values are (optionally) printed on uprights
sizes = [1,2,3,4,6,8];

// Spacing between uprights, 20 is OK for combs #1-#4, try 25 if including #6 & #8
spacing = 25; //[20:30] 

// Show text, true or false
showText = true; 

// Upright Width
w = 45;
// Upright Depth
d = 3;
// Upright Height
h = 28;

// Text Depthtext parameters
textDepth = 1;
// Text Size
textSize = 18;
// Horizontal Offset, use to center text
textHOffset = 15;
// Vertical Offste, use to center text
textVOffset = 6;


count=len(sizes);

structure();

module structure() {
    // back
    translate([0,count*spacing*sin(45)+d,0]) 
    rotate([90,0,0])
    linear_extrude(d)square([w,count*spacing*sin(45)+d]); 
    // base
    linear_extrude(d) square([w,count*spacing*sin(45)+d]);

    // Joint reinforcing (back to base)
    translate([0,count*spacing*sin(45),0]) 
    rotate([45,0,0]) 
    linear_extrude(d) square([w,d]);

    translate([0,sin(45)*d,d-sin(45)*d]) 
    rotate([45,0,0]) 
    union() {
        for (i=[0:1:count-1]) {
            // uprights
            translate ([0,i*spacing,0]) stand(i+1);
            // Joint reinforcing (uprights to structure)
            if (i < count) translate([0,i*spacing+d*(sin(45)+1),0]) rotate([45,0,0]) linear_extrude(d) square([w,d]);
        }
        // base for uprights
        linear_extrude(d) square([w,count*spacing]);
    }
}

module stand(i) {
    translate([0,d*(sin(45)-1),sin(45)*d])
    rotate ([-45,0,0])
    union() {
        difference()
        {
            linear_extrude(h) square([w,d]);
            if (i <= count && showText) 
                translate ([textHOffset,textDepth,textVOffset])
                rotate([90,0,0])
                linear_extrude(textDepth) text(str(sizes[i-1]), size=textSize);
        }
        translate ([(w+d)/2,d,d/sin(45)])
        rotate ([0,-90,0])
        linear_extrude(d)
        polygon([[0,0],[spacing*sin(45)-d,0],[spacing*sin(45)-d,spacing*sin(45)-d]]);
    }
}