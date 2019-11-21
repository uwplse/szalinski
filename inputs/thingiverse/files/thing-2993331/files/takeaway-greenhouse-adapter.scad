/*

Customisable adapter to turn two takeaway containers into a mini greenhouse

(c) 2018 Matthias Liffers
Released with Creative Commons Attribution 4.0 International licence


*/

// Container X (in millimetres)
container_x = 172;
// Container Y (in millimetres)
container_y = 120;
// Radius of the container's corners (in millimetres)
container_corner_radius = 16;
// Thickness of container lip (in millimetres)
lip = 3.5;
/* [Hidden] */
smoothness = 72;

difference() {
    translate([container_corner_radius+lip, container_corner_radius+lip, 0])
        minkowski() {
            cube([container_x - 2*container_corner_radius, container_y - 2*container_corner_radius, lip*3]);
            cylinder(r = container_corner_radius + lip, h=0.01, $fn=smoothness);
        }

    translate([container_corner_radius + lip, container_corner_radius + lip, 0-lip/2])
        minkowski() {
            cube([container_x - 2*container_corner_radius, container_y - 2*container_corner_radius, lip*4]);
            cylinder(r = container_corner_radius-lip, h=0.01, $fn=smoothness);
        }
        
    translate([container_corner_radius + lip, container_corner_radius + lip, 0-lip/2])
        minkowski() {
            cube([container_x - 2*container_corner_radius, container_y - 2*container_corner_radius, lip*1.5]);
            cylinder(r = container_corner_radius, h=0.01, $fn=smoothness);
        }

    translate([container_corner_radius + lip, container_corner_radius + lip, lip*2])
        minkowski() {
            cube([container_x - 2*container_corner_radius, container_y - 2*container_corner_radius, lip*1.5]);
            cylinder(r = container_corner_radius, h=0.01, $fn=smoothness);
        }
}