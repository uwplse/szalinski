/*
* @author Matt@Misbach.org
* @date 2017-03-21
*/
// Diameter of the dimples
dimple_diameter = 9;
// Corner radius on the cube
corner_radius = 73; //[50:100]

values = [
    [[50,50,100]],
    [[0,30,30], [0,70,70]],
    [[70,0,70], [30,0,30], [50,0,50]],
    [[30,100,30], [70,100,70], [30,100,70], [70,100,30]],
    [[100,50,50], [100,30,30], [100,70,70], [100,30,70], [100,70,30]],
    [[70,70,0], [30,30,0], [70,30,0], [30,70,0], [70,50,0], [30,50,0]]
];

// subtract dimples from cube
difference() {
    // Rounded corner cube
    intersection() {
        cube([100,100,100]);
        translate([50,50,50])
            sphere(corner_radius);
    }
    // Dimples
    for (num = [0:5]) {
        length = len(values[num]);
        for (set = [0:length-1]) {
            translate(values[num][set])
                sphere(dimple_diameter);
        }
    }    
}