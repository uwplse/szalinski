// Ammount of sides the object has
s=3; // [3,5,7,9]
// Distance between two verticies (mm) NOTE: Two different sided figures with the same distance between verticies will NOT work together. I will make it work together soon.
r=30; // [1:150]
// Height (mm)
h=5; // [1:30]
linear_extrude(height=h) {
    intersection_for(i = [1:s]) {
        rotate([0,0,i * 360/s]) {
            translate([r/2,0,0]) {
                circle(r, $fn = 200);
            }
        }
    }
}