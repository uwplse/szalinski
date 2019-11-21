  rotate([90,0,0])
  difference() {
    // Extrudes the body of the model from the polygon shape
    linear_extrude(height = 55, center = true, convexity = 10,  slices = 20, scale = 1.0) {polygon(points=[[0,0],[55,0],[61,20],[27,20],[30,30], [25,30],[19,10], [8,10], [11,20], [6,20]]);}
    // Imprints text 'AB' on the top surface of the model
    rotate([0,90,90]) translate([-20,-53,19])
    linear_extrude(height = 3,   convexity = 10,  slices = 20, scale = 1.0) {text("AB", font = "Liberation Sans:style=Bold Italic", size = 20);}  
}
