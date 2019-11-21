/* main */
word_text = "englische Literatur";
// adjust that after adjusting the text
width = 93;

union(){
    translate ([2, 3.5, 0]) linear_extrude(1.2) text(word_text, size = 8);
    xy_extrude([[0, 14],[0, 0],[width, 0],[width, 14]], 1.5);
    xz_extrude([[0, 0],[0, -50], [1.5, -50],[width, 0]], 1.5, false);
    yz_extrude([[0, 0],[0, -50], [1.5, -50],[40, -35],[40, -15], [13, 0]], 1.5, false);
};

module xy_extrude(points, height, center = true) {
    linear_extrude(height = height, center = center) 
        polygon(points = points); 
};

module xz_extrude(points , height , center = true){
    rotate([90, 0, 0])
        mirror([0, 0, 1])        
            xy_extrude(points, height, center);            
};

module yz_extrude(points , height , center = true){
    rotate([90, 0, 90])
        xy_extrude(points, height, center);
};