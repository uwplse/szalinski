// The width of the lithophane (mm)
pic_width = 100;

// The height of the lithophane (mm)
pic_height = 75;

// The maximum depth of the lithophane (mm)
pic_depth = 3;

// Desired viewing angle (degrees)
angle = 75; //[40:90]

// extra depth to add to the frame (mm), measured from the top of the frame. Important for making sure there is enough room for lights/batteries
top_depth = 22;

rotate([90,0,0]) lightbox(pic_width, pic_height, pic_depth, angle);

module lightbox(w,h,d,angle) {
    base_len = adj_len(angle, h);
    base_height = opp_len(angle, h);
    echo(base_len);

    difference(){
        union(){
            scale([1.05, 1.05, 1.05]) {
                translate([0, -base_height * 0.05, (-w * 0.05)/2]) wedge(base_height, base_len, w, top_depth);
            }
        }
        union(){
            scale([.96,.96,.96]){
                translate([0,1,(w*0.04) / 2]) wedge(base_height, base_len, w, top_depth * 1.04);
            }
        }
        union(){
            translate([base_len - opp_len(angle,d),-adj_len(angle,d),-0.25]) rotate([0,0, 90-angle]) box([d+0.2,h+50,w+0.5]);
        }

    }
}

module wedge(tri_h, tri_w, extrude, extra_depth) {
    union(){
        union() {
            translate([-extra_depth, 0, 0]) box([extra_depth, tri_h, extrude]);
        }
        linear_extrude(height=extrude){
            polygon(points=[[0,0],[tri_w,0],[0,tri_h]]);
        }
    }
}

module box(args) {
    cube(args);
}

function adj_len (theta, hippo) = cos(theta) * hippo;
function opp_len (theta, hippo) = sin(theta) * hippo;


