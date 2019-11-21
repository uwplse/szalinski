
w = 5;
merged_dino = false;
eye_spacing = 0.4;
base_x_blocks = 10;
base_y_blocks = 6;

part = "DEMO"; // [DINO, EYE, CACTUS, BASE, DEMO]

module chrome_dino(w, merged = false) {
    module body(w) {
        difference() {
            polygon([
                [0, 0],
                [0, w],
                [-3 * w, w],
                [-3 * w, 2 * w],
                [-4 * w, 2 * w],
                [-4 * w, 3 * w],
                [-5 * w, 3 * w],
                [-5 * w, 9 * w],
                [-4 * w, 9 * w],
                [-4 * w, 7 * w],
                [-3 * w, 7 * w],
                [-3 * w, 6 * w],
                [-2 * w, 6 * w],
                [-2 * w, 5 * w],
                [0, 5 * w],
                [0, 6 * w],
                [w, 6 * w],
                [w, 7 * w],
                [3 * w, 7 * w],
                [3 * w, 8 * w],
                [4 * w, 8 * w],
                [4 * w, 9 * w],
                [5 * w, 9 * w],
                [5 * w, 15 * w],
                [6 * w, 15 * w],
                [6 * w, 16 * w],
                [14 * w, 16 * w],
                [14 * w, 15 * w],
                [15 * w, 15 * w],
                [15 * w, 11 * w],
                [11 * w, 11 * w],
                [11 * w, 10 * w],
                [13 * w, 10 * w],
                [13 * w, 9 * w],
                [10 * w, 9 * w],
                [10 * w, 3 * w],
                [9 * w, 3 * w],
                [9 * w, 2 * w],
                [8 * w, 2 * w],
                [8 * w, w],
                [7 * w, w],
                [7 * w, 0],
            ]); 
        
          translate([7 * w, 14 * w]) square(w, center = true);
        }
    }

    module hand(w) {
        polygon([
            [10 * w, 7 * w],
            [12 * w, 7 * w],
            [12 * w, 5 * w],
            [11 * w, 5 * w],
            [11 * w, 6 * w],
            [10 * w, 6 * w]
        ]);
    }

    module leg_l(w) {
        polygon([
            [5 * w, 0],
            [5 * w, -w],
            [6 * w, -w],
            [6 * w, -4 * w],
            [8 * w, -4 * w],
            [8 * w, -3 * w],
            [7 * w, -3 * w],
            [7 * w, 0],
        ]);
    }

    module leg_r(w) {
        polygon([
            [w, 0],
            [w, -4 * w],
            [3 * w, -4 * w],
            [3 * w, -3 * w],
            [2 * w, -3 * w],
            [2 * w, -2 * w],
            [3 * w, -2 * w],
            [3 * w, -w],
            [4 * w, -w],
            [4 * w, 0]
        ]);
    }

    module dino_left(w) {      
        linear_extrude(w * 2.5) body(w);
        linear_extrude(w * 2) {
            hand(w);
            leg_l(w);
        }
    }

    module dino_right(w) {
        linear_extrude(w * 2.5) mirror([1, 0, 0]) body(w);
        linear_extrude(w * 2) mirror([1, 0, 0]) {
            hand(w);
            leg_r(w);
        }
    }
    
    if(merged) {
        dino_left(w);
        translate([0, 0, w * 5]) rotate([0, 180, 0]) dino_right(w);
    } else {
        translate([w * 6, 0, 0]) dino_left(w);
        translate([w * -6, 0, 0]) dino_right(w);
    }
}

module cactus(w) {
    linear_extrude(w * 3) {
        translate([2 * w, w * 7]) scale(w) 
        for(pt = px_polygon([
            [0, 2],
            [3, 2],
            [5, 4],
            [5, 10],
            [5, 10],
            [3, 10],
            [3, 6],
            [0, 4],
            
        ], filled = true)) {
            translate(pt) square(1);
        }
        translate([-2 * w, w * 5]) scale(w) 
        for(pt = px_polygon([
            [-1, 0],
            [-3, 0],
            [-6, 2],
            [-6, 6],
            [-6, 6],
            [-4, 6],
            [-4, 4],
            [-1, 2],
            
        ], filled = true)) {
            translate(pt) square(1);
        }
        scale(w) 
        for(pt = px_polygon([
            [-2, 0],
            [2, 0],
            [2, 20],
            [1, 22],
            [0, 22],
            [-1, 22],
            [-2, 20]
        ], filled = true)) {
            translate(pt) square(1);
        }
    }
}

module base(w, base_x_blocks, base_y_blocks) {
   linear_extrude(w) {
       translate([0, -w]) 
           square([base_x_blocks * w, base_y_blocks * w + 2 * w]);
       translate([0, base_y_blocks * w / 2]) scale(w)
       for(p = px_circle(base_y_blocks / 2, filled = true)) {
           translate(p)
               square(1, center = true);
       }
       translate([base_x_blocks * w, base_y_blocks * w / 2]) scale(w)
       for(p = px_circle(base_y_blocks / 2, filled = true)) {
           translate(p)
               square(1, center = true);
       }
   }   
}

module eye(w, eye_spacing) {
    translate([0, 0, -eye_spacing]) 
        rotate([0, -90, 0]) 
            linear_extrude(w * 5) 
                offset(delta = -eye_spacing) square(w);
}

if(part == "DINO") {
    chrome_dino(w, merged_dino);
}
else if(part == "EYE") {
    eye(w, eye_spacing);
}
else if(part == "CACTUS") {
    cactus(w);
}
else if(part == "BASE") { 
   base(w, base_x_blocks, base_y_blocks);
}
else if(part == "DEMO") {
    wd = 5;
    translate([0, wd * 5.5, wd * 5]) rotate([90, 0, 0])  {
        color("DimGray") chrome_dino(wd, true);
        color("white") 
            linear_extrude(wd * 5)
                translate([7 * wd, 14 * wd]) square(wd, center = true);
    }
    color("white") base(wd, 10, 6);
    
    translate([wd * 25, wd * 10, 0]) {
        translate([wd * 4.25, wd * 4.25, 0]) color("SlateGray") rotate([90, 0, 0])  
            cactus(wd);
        color("white") base(wd, 10, 6);
    }
    
    translate([-wd * 35, wd * 10, 0]) {
        color("SlateGray") {
            translate([wd * 4.25, wd * 4, 0]) rotate([90, 0, 0])  
                mirror([1, 0, 0]) cactus(wd);
                
             scale(0.75)
                 translate([wd * 30, wd * 5, 0]) rotate([90, 0, 0])  
                    cactus(wd);       
        }
         color("white") base(wd, 30, 6);                
    }
    
}

    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

/**
* in_shape.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-in_shape.html
*
**/


function _in_shape_in_line_equation(edge, pt) = 
    let(
        x1 = edge[0][0],
        y1 = edge[0][1],
        x2 = edge[1][0],
        y2 = edge[1][1],
        a = (y2 - y1) / (x2 - x1),
        b = y1 - a * x1
    )
    (pt[1] == a * pt[0] + b);

function _in_shape_in_any_edges(edges, pt, epsilon) = 
    let(
        leng = len(edges),
        maybe_last = [for(i = 0; i < leng && !__in_line(edges[i], pt, epsilon); i = i + 1) i][leng - 1] 
    )
    is_undef(maybe_last);

function _in_shape_interpolate_x(y, p1, p2) = 
    p1[1] == p2[1] ? p1[0] : (
        p1[0] + (p2[0] - p1[0]) * (y - p1[1]) / (p2[1] - p1[1])
    );
    
function _in_shape_does_pt_cross(pts, i, j, pt) = 
    ((pts[i][1] > pt[1]) != (pts[j][1] > pt[1])) &&
    (pt[0] < _in_shape_interpolate_x(pt[1], pts[i], pts[j]));
    

function _in_shape_sub(shapt_pts, leng, pt, cond, i, j) =
    j == leng ? cond : (
        _in_shape_does_pt_cross(shapt_pts, i, j, pt) ? 
            _in_shape_sub(shapt_pts, leng, pt, !cond, j, j + 1) :
            _in_shape_sub(shapt_pts, leng, pt, cond, j, j + 1)
    );
 
function in_shape(shapt_pts, pt, include_edge = false, epsilon = 0.0001) = 
    let(
        leng = len(shapt_pts),
        edges = __lines_from(shapt_pts, true)
    )
    _in_shape_in_any_edges(edges, pt, epsilon) ? include_edge : 
    _in_shape_sub(shapt_pts, leng, pt, false, leng - 1, 0);

/**
* px_polygon.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_polygon.html
*
**/ 

function px_polygon(points, filled = false) =
    filled ?
    let(
        xs = [for(pt = points) pt[0]],
        ys = [for(pt = points) pt[1]],
        max_x = max(xs),
        min_x = min(xs),
        max_y = max(ys),
        min_y = min(ys)
    )
    [
        for(y = min_y; y <= max_y; y = y + 1)
            for(x = min_x; x <= max_x; x = x + 1)
                let(pt = [x, y])
                if(in_shape(points, pt, true)) pt
    ]
    : 
    px_polyline(
        concat(points, [points[len(points) - 1], points[0]])
    );
    

function __in_line(line_pts, pt, epsilon = 0.0001) =
    let(
        pts = len(line_pts[0]) == 2 ? [for(p = line_pts) __to3d(p)] : line_pts,
        pt3d = len(pt) == 2 ? __to3d(pt) : pt,
        v1 = pts[0] - pt3d, 
        v2 = pts[1] - pt3d
    )
    (norm(cross(v1, v2)) < epsilon) && ((v1 * v2) <= epsilon);

/**
* px_polyline.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_polyline.html
*
**/ 


function px_polyline(points) =
    let(
        is_2d = len(points[0]) == 2,
        pts = is_2d ? [for(pt = points) __to3d(pt)] : points,
        polyline = [for(line =  __lines_from(pts)) each px_line(line[0], line[1])]
    )
    is_2d ? [for(pt = polyline) __to2d(pt)] : polyline;

/**
* px_line.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_line.html
*
**/ 


function _px_line_zsgn(a) = a == 0 ? a : a / abs(a);
    
// x-dominant
function _px_line_xdominant_y(y, yd, sy) = yd >= 0 ? y + sy : y;
function _px_line_xdominant_yd(yd, ax, ay) = (yd >= 0 ? yd - ax : yd) + ay;
function _px_line_xdominant_z(z, zd, sz) = zd >= 0 ? z + sz : z;
function _px_line_xdominant_zd(zd, ax, az) = (zd >= 0 ? zd - ax : zd) + az;

function _px_line_xdominant(start, end, a, s) = 
    let(
        x = start[0],
        y = start[1],
        z = start[2],
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2],        
        shrx = floor(ax / 2),
        yd = ay - shrx,
        zd = az - shrx,
        endx = end[0]
    )
    concat(
        [start], 
        _px_line_xdominant_sub(
            x + sx, 
            _px_line_xdominant_y(y, yd, sy), 
            _px_line_xdominant_z(z, zd, sz), 
            endx, 
            a, 
            s, 
            _px_line_xdominant_yd(yd, ax, ay), 
            _px_line_xdominant_zd(zd, ax, az)
        )
    );

function _px_line_xdominant_sub(x, y, z, endx, a, s, yd, zd) = 
    let(
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2]
    )
    x == endx ? [] : 
        concat([[x, y, z]], 
            _px_line_xdominant_sub(
                x + sx, 
                _px_line_xdominant_y(y, yd, sy), 
                _px_line_xdominant_z(z, zd, sz), 
                endx, 
                a, 
                s, 
                _px_line_xdominant_yd(yd, ax, ay), 
                _px_line_xdominant_zd(zd, ax, az)
            )
        );
        
// y-dominant
function _px_line_ydominant_x(x, xd, sx) = xd >= 0 ? x + sx : x;
function _px_line_ydominant_xd(xd, ax, ay) = (xd >= 0 ? xd - ay : xd) + ax;
function _px_line_ydominant_z(z, zd, sz) = zd >= 0 ? z + sz : z;
function _px_line_ydominant_zd(zd, ay, az) = (zd >= 0 ? zd - ay : zd) + az;
        
function _px_line_ydominant(start, end, a, s) = 
    let(
        x = start[0],
        y = start[1],
        z = start[2],
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2],        
        shry = floor(ay / 2),
        xd = ax - shry,
        zd = az - shry,
        endy = end[1]
    )
    concat(
        [start], 
        _px_line_ydominant_sub(
            _px_line_ydominant_x(x, xd, sx), 
            y + sy,
            _px_line_ydominant_z(z, zd, sz), 
            endy, 
            a, 
            s, 
            _px_line_ydominant_xd(xd, ax, ay), 
            _px_line_ydominant_zd(zd, ay, az)
        )
    );

function _px_line_ydominant_sub(x, y, z, endy, a, s, xd, zd) = 
    let(
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2]
    )
    y == endy ? [] : 
        concat([[x, y, z]], 
            _px_line_ydominant_sub(
                _px_line_ydominant_x(x, xd, sx), 
                y + sy,
                _px_line_ydominant_z(z, zd, sz), 
                endy, 
                a, 
                s, 
                _px_line_ydominant_xd(xd, ax, ay), 
                _px_line_ydominant_zd(zd, ay, az)
            )
        );

// z-dominant
function _px_line_zdominant_x(x, xd, sx) = xd >= 0 ? x + sx : x;
function _px_line_zdominant_xd(xd, ax, az) = (xd >= 0 ? xd - az : xd) + ax;

function _px_line_zdominant_y(y, yd, sy) = yd >= 0 ? y + sy : y;
function _px_line_zdominant_yd(yd, ay, az) = (yd >= 0 ? yd - az : yd) + ay;
        
function _px_line_zdominant(start, end, a, s) = 
    let(
        x = start[0],
        y = start[1],
        z = start[2],
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2],        
        shrz = floor(az / 2),
        xd = ax - shrz,
        yd = ay - shrz,
        endz = end[2]
    )
    concat(
        [start], 
        _px_line_zdominant_sub(
            _px_line_zdominant_x(x, xd, sx), 
            _px_line_zdominant_y(y, yd, sy), 
            z + sz,
            endz, 
            a, 
            s, 
            _px_line_zdominant_xd(xd, ax, az), 
            _px_line_zdominant_yd(yd, ay, az)
        )
    );

function _px_line_zdominant_sub(x, y, z, endz, a, s, xd, yd) = 
    let(
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2]
    )
    z == endz ? [] : 
        concat([[x, y, z]], 
            _px_line_zdominant_sub(
                _px_line_zdominant_x(x, xd, sx), 
                _px_line_zdominant_y(y, yd, sy), 
                z + sz,
                endz, 
                a, 
                s, 
                _px_line_zdominant_xd(xd, ax, az), 
                _px_line_zdominant_yd(yd, ay, az)
            )
        );
        
function px_line(p1, p2) = 
    let(
        is_2d = len(p1) == 2,
        start_pt = is_2d ? __to3d(p1) : p1,
        end_pt = is_2d ? __to3d(p2) : p2,
        dt = end_pt - start_pt,
        ax = floor(abs(dt[0]) * 2),
        ay = floor(abs(dt[1]) * 2),
        az = floor(abs(dt[2]) * 2),
        sx = _px_line_zsgn(dt[0]),
        sy = _px_line_zsgn(dt[1]),
        sz = _px_line_zsgn(dt[2]),
        points = ax >= max(ay, az) ? _px_line_xdominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz]) : (
            ay >= max(ax, az) ? _px_line_ydominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz]) :
                _px_line_zdominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz])
        )
    )   
    is_2d ? [for(pt = points) __to2d(pt)] : points;

/**
* px_circle.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_circle.html
*
**/ 

function _px_circle_y(f, y) = f >= 0 ? y - 1 : y;
function _px_circle_ddf_y(f, ddf_y) = f >= 0 ? ddf_y + 2 : ddf_y;
function _px_circle_f(f, ddf_y) = f >= 0 ? f + ddf_y : f;

function _px_circle(f, ddf_x, ddf_y, x, y, filled) = 
    x >= y ? [] : 
    let(
        ny = _px_circle_y(f, y),
        nddf_y = _px_circle_ddf_y(f, ddf_y),
        nx = x + 1,
        nddf_x = ddf_x + 2,
        nf = _px_circle_f(f, ddf_y) + nddf_x
    )
    concat(
        filled ? 
            concat(
               [for(xi = -nx; xi <= nx; xi = xi + 1) [xi, -ny]],
               [for(xi = -ny; xi <= ny; xi = xi + 1) [xi, -nx]],
               [for(xi = -ny; xi <= ny; xi = xi + 1) [xi, nx]],
               [for(xi = -nx; xi <= nx; xi = xi + 1) [xi, ny]]              
            )
            :
            [  
                [-nx, -ny], [nx, -ny],                 
                [-ny, -nx], [ny, -nx],
                [-ny, nx], [ny, nx],
                [-nx, ny], [nx, ny]
            ],
        _px_circle(nf, nddf_x, nddf_y, nx, ny, filled)
    );
    
function px_circle(radius, filled = false) =
    let(
        f = 1 - radius,
        ddf_x = 1,
        ddf_y = -2 * radius,
        x = 0,
        y = radius
    )
    concat(
        filled ? 
            concat(
                [[0, radius], [0, -radius]],
                [for(xi = -radius; xi <= radius; xi = xi + 1) [xi, 0]]
            )
            : 
            [
                [0, -radius],                
                [-radius, 0], 
                [radius, 0],
                [0, radius]
            ],
        _px_circle(f, ddf_x, ddf_y, x, y, filled)
    );

function __to3d(p) = [p[0], p[1], 0];

function __lines_from(pts, closed = false) = 
    let(
        leng = len(pts),
        endi = leng - 1
    )
    concat(
        [for(i = 0; i < endi; i = i + 1) [pts[i], pts[i + 1]]], 
        closed ? [[pts[len(pts) - 1], pts[0]]] : []
    );
    

function __to2d(p) = [p[0], p[1]];

