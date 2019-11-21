cylinderID = 30;
cylinderHeight=0.8;
//Set the threshold grey level to cut through (0-100%)
Threshold=-50; //[0:100]
//Invert grayscale image?
Inverted=false; //[True:Yes, False:No]
//Load an image to emboss. Simple, high contrast images like logos work best.
image_file = "image-surface.dat"; // [image_surface:100x100]
difference() {
    union() {
        linear_extrude (height=0.8) {
            difference() {
                circle(d=30.934);
                polygon(points = [[-40,40],[1.5,40],[1.5,1.5],[40,1.5],[40,-40],[-1.5,-40],[-1.5,-1.5],[-40,-1.5]]);
            }
        }
        cylinder(h=0.8, d=30);
    }
        scale ([0.18,0.18,10]) translate([0,0,Threshold]) surface(file = image_file , center = true, convexity = 1, invert=Inverted);
}