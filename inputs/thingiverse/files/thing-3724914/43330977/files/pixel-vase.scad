
x1 = 5;
x2 = 20;
x3 = 8;
thickness = 1;

module pixel_vase(x1, x2, x3, thickness) {
    p0 = [x1, 0, 0];
    p1 = [10, 0, 4];
    p2 = [x2, 0, 8];
    p3 = [3, 0, 20];
    p4 = [x3, 0, 30];

    rounded_points = [for(pt = bezier_curve(0.1, 
        [p0, p1, p2, p3, p4]
    )) [round(pt[0]), round(pt[1]), round(pt[2])]];

    px_path = px_polyline(rounded_points);
    leng = len(px_path);

    for(p = px_cylinder(px_path[0][0], 1, true)) { 
        linear_extrude(1) union() {
            translate([p[0], p[1]])
                square(1.1, center = true);
        }
    }

    for(i = [0:leng - 1]) {
        r = px_path[i][0];
        for(p = px_cylinder(r, 1, thickness = thickness)) { 
            translate([0, 0, i]) 
                linear_extrude(1) union() {
                    translate([p[0], p[1]])
                        square(1.1, center = true);
                }
        }
    }  
}    

pixel_vase(x1, x2, x3, thickness);
    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

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

function __to2d(p) = [p[0], p[1]];

/**
* bezier_curve.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier_curve.html
*
**/ 


function _combi(n, k) =
    let(  
        bi_coef = [      
               [1],     // n = 0: for padding
              [1,1],    // n = 1: for Linear curves, how about drawing a line directly?
             [1,2,1],   // n = 2: for Quadratic curves
            [1,3,3,1]   // n = 3: for Cubic Bézier curves
        ]  
    )
    n < len(bi_coef) ? bi_coef[n][k] : (
        k == 0 ? 1 : (_combi(n, k - 1) * (n - k + 1) / k)
    );
        
function bezier_curve_coordinate(t, pn, n, i = 0) = 
    i == n + 1 ? 0 : 
        (_combi(n, i) * pn[i] * pow(1 - t, n - i) * pow(t, i) + 
            bezier_curve_coordinate(t, pn, n, i + 1));
        
function _bezier_curve_point(t, points) = 
    let(n = len(points) - 1) 
    [
        bezier_curve_coordinate(
            t, 
            [for(p = points) p[0]], 
            n
        ),
        bezier_curve_coordinate(
            t,  
            [for(p = points) p[1]], 
            n
        ),
        bezier_curve_coordinate(
            t, 
            [for(p = points) p[2]], 
            n
        )
    ];

function bezier_curve(t_step, points) = 
    let(
        pts = concat([
            for(t = 0; t < ceil(1 / t_step); t = t + 1)
                _bezier_curve_point(t * t_step, points)
        ], [_bezier_curve_point(1, points)])
    ) 
    len(points[0]) == 3 ? pts : [for(pt = pts) __to2d(pt)];


function __to3d(p) = [p[0], p[1], 0];

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
* px_cylinder.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_cylinder.html
*
**/ 

function _px_cylinder_px_circle(radius, filled, thickness) = 
    let(range = [-radius: radius - 1])
    filled ? [
        for(y = range)        
           for(x = range)
               let(v = [x, y])
               if(norm(v) < radius) v
    ] :
    let(ishell = radius * radius - 2 * thickness * radius)
    [
        for(y = range)        
           for(x = range)
               let(
                   v = [x, y],
                   leng = norm(v)
               )
               if(leng < radius && (leng * leng) > ishell) v    
    ];

function _px_cylinder_diff_r(r, h, filled, thickness) =
    let(
        r1 = r[0],
        r2 = r[1]
    )
    r1 == r2 ? _px_cylinder_same_r(r1, h, filled, thickness) :
    let(dr = (r2 - r1) / (h - 1))
    [
        for(i = 0; i < h; i = i + 1)
        let(r = round(r1 + dr * i))
        each [
            for(pt = _px_cylinder_px_circle(r, filled, thickness))
            [pt[0], pt[1], i]
        ]
    ]; 

function _px_cylinder_same_r(r, h, filled, thickness) =
    let(c = _px_cylinder_px_circle(r, filled, thickness))
    [
        for(i = 0; i < h; i = i + 1)
        each [
            for(pt = c)
            [pt[0], pt[1], i]
        ]
    ]; 

function px_cylinder(r, h, filled = false, thickness = 1) =
    is_num(r) ? 
        _px_cylinder_same_r(r, h, filled, thickness) :
        _px_cylinder_diff_r(r, h, filled, thickness); 

function __lines_from(pts, closed = false) = 
    let(
        leng = len(pts),
        endi = leng - 1
    )
    concat(
        [for(i = 0; i < endi; i = i + 1) [pts[i], pts[i + 1]]], 
        closed ? [[pts[len(pts) - 1], pts[0]]] : []
    );
    

