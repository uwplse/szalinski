// Label Clip for Small Parts bin

face_width = 30;
face_height = 12;
face_thick=1.2;
fit_wall = 2;
tab_width = 2.5;
tab_depth = 6;
tab_position = 5;
/* [Hidden] */
tab_pts_left = [[tab_position-tab_width-fit_wall/2,0],[tab_position-fit_wall/2,0],[tab_position-fit_wall/2,tab_depth],[tab_position-tab_width,tab_depth]];
tab_pts_right = [[tab_position+fit_wall/2,0],[tab_position+tab_width+fit_wall/2,0],[tab_position+tab_width,tab_depth],[tab_position+fit_wall/2,tab_depth]];

rotate([-180,0,0])
difference(){
linear_extrude(height = face_thick)
            square([face_width, face_height]);
linear_extrude(height = face_thick/2)
translate([tab_position-fit_wall/2,-0.010,0])
            square([fit_wall,face_height+0.01]);
}
rotate([90,0,0]) difference(){linear_extrude(height = face_height/1.2) translate([0,0,face_height]) polygon(points=tab_pts_left);
    linear_extrude(height = face_height - face_height/1.2) translate([0,0,face_height]) polygon(points=tab_pts_left);
    }
rotate([90,0,0]) difference(){linear_extrude(height = face_height/1.2) polygon(points=tab_pts_right);linear_extrude(height = face_height-face_height/1.2) polygon(points=tab_pts_right);
}

//translate([tab_position-tab_width-fit_wall/2, 0, 0])
//        linear_extrude(height = tab_depth)
//            square([tab_width, height]);
//translate([tab_position+fit_wall/2, 0, 0])
//        linear_extrude(height = tab_depth)
//            square([tab_width, height]);
