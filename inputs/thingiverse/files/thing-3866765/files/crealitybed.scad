
bed_height = 3;

bed_width = 240;
bed_depth = 240;
bed_radius = 3;

lip_width = 100;
lip_delta = 10;
lip_depth = 15;
lip_radius = 2;

$fn = 90;

bed = [ [  bed_width/2 - bed_radius,  bed_depth/2 - bed_radius, bed_radius ], 
        [  bed_width/2 - bed_radius, -bed_depth/2 + bed_radius, bed_radius ],
           
        [  lip_width/2 + lip_delta, -bed_depth/2 - lip_radius, -lip_radius ],
        
        [  lip_width/2            , -bed_depth/2 - lip_depth + lip_radius, lip_radius ],          
        [ -lip_width/2            , -bed_depth/2 - lip_depth + lip_radius, lip_radius ],
        
        [ -lip_width/2 - lip_delta, -bed_depth/2 - lip_radius, -lip_radius ],         
           
        [ -bed_width/2 + bed_radius, -bed_depth/2 + bed_radius, bed_radius ],
        [ -bed_width/2 + bed_radius,  bed_depth/2 - bed_radius, bed_radius ]
      ];

translate([0, 0, -bed_height]) linear_extrude (height = bed_height) rounded_polygon(bed);

// module below by nophead
// http://forum.openscad.org/Script-to-replicate-hull-and-minkoswki-for-CSG-export-import-into-FreeCAD-td16537.html#a16556

module rounded_polygon(points)
    difference() {
        len = len(points);
        union() {
            for(i = [0 : len - 1])
                if(points[i][2] > 0)
                    translate([points[i].x, points[i].y])
                        circle(points[i][2]);

            polygon([for(i  = [0 : len - 1])
                        let(ends = tangent(points[i], points[(i + 1) % len]))
                            for(end = [0, 1])
                                ends[end]]);
        }
        for(i = [0 : len - 1])
            if(points[i][2] < 0)
                translate([points[i].x, points[i].y])
                    circle(-points[i][2]);
     }

function tangent(p1, p2) =
    let(
        r1 = p1[2],
        r2 = p2[2],
        dx = p2.x - p1.x,
        dy = p2.y - p1.y,
        d = sqrt(dx * dx + dy * dy),
        theta = atan2(dy, dx) + acos((r1 - r2) / d),
        xa = p1.x +(cos(theta) * r1),
        ya = p1.y +(sin(theta) * r1),
        xb = p2.x +(cos(theta) * r2),
        yb = p2.y +(sin(theta) * r2)
    )[ [xa, ya], [xb, yb] ];
