
demo_rect();
translate([0, 20, 0]) demo_circle();
translate([0, 30, 0]) demo_bezier();
translate([0, 60, 0]) demo_polybezier();
translate([0, 120, 0]) scale([0.4, 0.4, 1]) demo_polybezier2();
translate([0, 80, 0]) demo_polybezier3();

module demo_circle() {
    polygon(circle_points(r=3));
    translate([10, 0]) polygon(circle_points(r=3, a1=45, a2=270));
    translate([20, 0]) polygon(circle_points(r=3, fn=8));
    translate([30, 0]) polygon(circle_points(r=3, a1=45, a2=270, fn=8));
}

module demo_rect() {
    polygon(rect_points([10, 15], center=true));
    translate([15, 0]) polygon(rect_points([10, 15]));
    translate([30, 0]) polygon(rect_points([10, 15], r=4));
    translate([45, 0]) polygon(rect_points([10, 15], r=4, r3=0, r4=2));
}

module demo_bezier() {
    seg1=[[0,0], [0, 10], [10, 10], [10, 0]];
    seg2=[[0,0], [-5, 10], [15, 10], [10, 0]];
    seg3=[[0,0], [-5, 5], [15, 15], [10, 0]];
    seg4=[[0,0], [0, 10], [5, 15], [10, 10], [10, 0]];
    
    color([0.9,0.4,0.9]) polygon(seg1);
    linear_extrude(height=2) polygon(bezier_points(seg1));
    
    translate([15, 0, 0]) {
        color([0.9,0.4,0.9]) polygon(seg1);
        linear_extrude(height=2) polygon(bezier_points(seg1, fn=5));
    }
    
    translate([35, 0, 0]) {
        color([0.9,0.4,0.9]) polygon(seg2);
        linear_extrude(height=2) polygon(bezier_points(seg2));
    }
    
    translate([60, 0, 0]) {
        color([0.9,0.4,0.9]) polygon(seg3);
        linear_extrude(height=2) polygon(bezier_points(seg3));
    }
    
    translate([80, 0, 0]) {
        color([0.9,0.4,0.9]) polygon(seg4);
        linear_extrude(height=2) polygon(bezier_points(seg4));
    }
}

module demo_polybezier() {
    segments=[
        [[0, 0], [0, 10], [10, 10], [10, 0]],
        [[10, 0], [5, -10], [20, -5], [20, 0]],
        [[20, 0], [15, 10], [35, 10], [30, 0]],
        [[30, 0], [20, -10], [35, -15], [45, -10], [40, 0]]
    ];
    
    color([0.4,0.9,0.9]) polygon(segments[0]);
    color([0.9,0.4,0.9]) polygon(segments[1]);
    color([0.9,0.9,0.4]) polygon(segments[2]);
    color([0.4,0.4,0.9]) polygon(segments[3]);
    linear_extrude(height=2)
        polygon(polybezier_points(segments, fn=100));
}

module demo_polybezier2() {
    segments=[
        [[24.5, 4.5], [27, 20]],
        [[27, 20], [35, 29.5]],
        [[35, 29.5], [44.5, 44], [42, 44], [41, 46]],
        [[41, 46], [29, 56], [16, 73] , [3, 85]], // затылок
        [[3, 85], [10, 93], [28, 98], [51, 102.5]],
        [[51, 102.5], [55.5, 95], [60, 88], [64, 77.5]],
        [[64, 77.5], [64, 76], [65, 73], [66.5, 70]],
        [[66.5, 70], [67, 67.5], [69, 65], [69.2, 63.3]], // лоб
        [[69.2, 63.3], [69, 61.7], [70.3, 59.6], [71.7, 57.7]], // переносица
        [[71.7, 57.7], [72.8, 56.1], [73.9, 54.6], [74.1, 54.1]], // переносица
        [[74.1, 54.1], [75, 52.7], [73.5, 50.9], [72.1, 50.8]], // нос
        [[72.1, 50.8], [71.9, 50.4], [72, 49.6], [72.5, 48.9]],  // верхняя губа
        [[72.5, 48.9], [72.5, 48.4], [72.3, 47.3], [71.5, 47.2]], // верхняя губа
        [[71.5, 47.2], [72, 46.9], [72.3, 46.8], [72.1, 45.5]], // нижняя губа
        [[72.1, 45.5], [71.4, 45.2], [71.1, 45], [71.4, 44.3]], // нижняя губа
        [[71.4, 44.3], [72.9, 39.8], [69.8, 39.2], [68.1, 39.6]], // подбородок
        [[68.1, 39.6], [66.2, 39.9], [65.2, 39.7], [64.7, 39.6]], // шея
        [[64.7, 39.6], [63.3, 39.5], [60.5, 40.2], [59.7, 36.5]], // шея
        [[59.7, 36.5], [58.8, 34.8], [58.3, 34.1], [57.5, 33]], // шея
        [[57.5, 33], [56.1, 30.2], [54.3, 26.9], [52.3, 24.4]], // шея
        [[52.3, 24.4], [51.3, 21.5], [52.6, 20.9], [53.1, 18.7]], // яремная ямка
        [[53.1, 18.7], [53.4, 17.7], [53.1, 16.9], [53.1, 16.3]], // грудь
        [[53.1, 16.3], [54.1, 15.4], [54.5, 12], [55.1, 9.5]], // грудь
        [[55.1, 9.5], [52, 5.5], [49.5, 5], [47, 2.5]],
        [[47, 2.5], [24.5, 4.5]]
    ];
    
    //for(seg=[0:len(segments)-1])
    //    color([0.4, 0.9, 0.9]) polygon(segments[seg]);
    linear_extrude(height=2)
        polygon(polybezier_points(segments));
    translate([80, 0, 0]) linear_extrude(height=2)
        polygon(polybezier_points(segments, fn=5));
    translate([160, 0, 0]) linear_extrude(height=2)
        polygon(polybezier_points(segments, fn=2));
}

module demo_polybezier3() {
    // point array generated with https://www.thingiverse.com/thing:2805184
    segments=[
        [[9.85, 32.61], [8.93, 32.78], [-7.73, 9.26], [33.94, 1.15]],
        [[33.94, 1.17], [34.94, 1.28], [36.78, 1.16], [38.40, 0.92]],
        [[38.40, 0.92], [40.48, 0.62], [42.02, 0.74], [43.46, 0.54]],
        [[43.46, 0.54], [44.95, 0.29], [45.50, 1.23], [45.33, 2.00]],
        [[45.33, 2.00], [44.28, 3.75], [41.93, 4.39], [39.91, 4.37]],
        [[39.91, 4.37], [10.75, 6.27], [4.60, 25.84], [15.62, 26.50]],
        [[15.62, 26.50], [16.70, 25.83], [17.50, 25.11], [19.31, 24.60]],
        [[19.31, 24.60], [18.18, 21.61], [16.94, 18.64], [17.65, 15.34]],
        [[17.65, 15.34], [17.65, 15.34], [18.36, 15.80], [18.36, 15.80]],
        [[18.36, 15.80], [20.54, 21.27], [22.37, 22.98], [24.20, 24.84]],
        [[24.20, 24.84], [26.20, 24.88], [28.24, 24.85], [29.32, 26.73]],
        [[29.32, 26.73], [33.60, 25.22], [31.10, 18.28], [40.93, 17.00]],
        [[40.93, 17.00], [41.46, 17.10], [41.16, 17.39], [41.16, 17.68]],
        [[41.16, 17.68], [36.73, 21.13], [38.02, 24.79], [33.74, 26.49]],
        [[33.74, 26.49], [33.15, 27.17], [33.54, 27.83], [33.72, 28.28]],
        [[33.72, 28.28], [36.52, 30.01], [37.34, 28.89], [42.83, 33.88]],
        [[42.83, 33.88], [45.50, 36.16], [47.66, 36.41], [49.45, 37.96]],
        [[49.45, 37.96], [49.81, 38.34], [49.44, 38.58], [48.58, 38.53]],
        [[48.58, 38.53], [39.95, 37.46], [37.64, 33.11], [28.30, 37.03]],
        [[28.30, 37.03], [29.32, 38.71], [30.79, 39.88], [32.62, 40.77]],
        [[32.62, 40.77], [32.60, 40.93], [32.82, 41.17], [32.20, 41.18]],
        [[32.20, 41.18], [29.24, 40.84], [26.37, 38.89], [24.85, 37.53]],
        [[24.85, 37.53], [19.21, 38.28], [15.80, 36.80], [12.83, 34.89]],
        [[12.83, 34.89], [9.24, 38.20], [5.35, 39.42], [0.99, 40.88]],
        [[0.99, 40.88], [0.36, 41.00], [0.65, 40.11], [0.71, 40.09]],
        [[0.71, 40.09], [1.88, 38.81], [2.73, 38.41], [4.14, 37.51]],
        [[4.14, 37.51], [5.88, 36.39], [7.95, 33.75], [9.85, 32.61]],
        [[9.85, 32.61], [9.85, 32.61], [9.85, 32.61], [9.85, 32.61]],
        [[9.85, 32.61], [9.85, 32.61], [9.85, 32.61], [9.85, 32.61]]
    ];
    
    //for(seg=[0:len(segments)-1])
    //    color([0.4, 0.9, 0.9]) polygon(segments[seg]);
    
    linear_extrude(height=2)
        polygon(polybezier_points(segments));
    
    translate([60, 0, 0]) linear_extrude(height=2)
        polygon(polybezier_points(segments, fn=6));
}

/**
 * Окружность или дуга.
 * 
 * Для полной окружности: a1=0, a2=360
 * 
 * @param r радиус окружности
 * @param a1 начальный угол дуги
 *     (по умолчанию: 360)
 * @param a2 конечный угол дуги
 *     (по умолчанию: 360)
* @param shift смещение по X и Y
 * @param fn количество сегментов на полной окружности
 *     (по умолчанию: 100)
 * @return массив точек [x,y] окружности или дуги
 */
function circle_points(r=1, a1=0, a2=360, shift=[0,0], fn=100) = 
    a2 > a1 ? 
        concat(
            circle_points(r=r, fn=fn, a1=a1, a2=a2-360/fn, shift=shift),
            [[r*cos(a2)+shift.x, r*sin(a2)+shift.y]]
        ) :
        [[r*cos(a1)+shift.x, r*sin(a1)+shift.y]];

/**
 * Прямоугольник со скругленными углами.
 * 
 * r2 r1
 * r3 r4
 * 
 * @param dim размеры прямоугольника: [x, y]
 * @param center центрировать прямоугольник
 * @param r радиус скругления всех углов
 * @param r1 радиус скругления угла 1 (право, верх)
 * @param r2 радиус скругления угла 2 (лево, верх)
 * @param r3 радиус скругления угла 3 (лево, низ)
 * @param r4 радиус скругления угла 4 (право, низ)
* @param shift смещение по X и Y
 * @param fn количество сегментов на скруглениях окружности
 *     (по умолчанию: 100)
 * @return массив точек [x,y] прямоугольника
 
 */
function rect_points(dim=[1,1], center=false,
        r=0, r1=-1, r2=-1, r3=-1, r4=-1,
        shift=[0,0], fn=100) =  
    concat(
        // право, верх
        (r == 0 && r1 < 0) || r1==0 ?
            [[dim.x - (center?dim.x/2:0) + shift.x, dim.y - (center?dim.y/2:0) + shift.y]] :
            circle_points(
                r=(r1>0?r1:r), a1=0, a2=90,
                shift=[
                    dim.x-(r1>0?r1:r) - (center?dim.x/2:0) + shift.x,
                    dim.y-(r1>0?r1:r) - (center?dim.y/2:0) + shift.y],
                fn=fn),
        // лево, верх
        (r == 0 && r2 < 0) || r2==0 ?
            [[0 - (center?dim.x/2:0) + shift.x, dim.y - (center?dim.y/2:0) + shift.y]] :
            circle_points(
                r=(r2>0?r2:r), a1=90, a2=180,
                shift=[
                    (r2>0?r2:r) - (center?dim.x/2:0) + shift.x,
                    dim.y-(r2>0?r2:r) - (center?dim.y/2:0) + shift.y],
                fn=fn),
        // лево, низ
        (r == 0 && r3 < 0) || r3==0 ?
            [[0 - (center?dim.x/2:0) + shift.x, 0 - (center?dim.y/2:0) + shift.y]] :
            circle_points(
                r=(r3>0?r3:r), a1=180, a2=270,
                shift=[
                    (r3>0?r3:r) - (center?dim.x/2:0) + shift.x,
                    (r3>0?r3:r) - (center?dim.y/2:0) + shift.y],
                fn=fn),
        // право, низ
        (r == 0 && r4 < 0) || r4==0 ?
            [[dim.x - (center?dim.x/2:0) + shift.x, 0 - (center?dim.y/2:0) + shift.y]] :
            circle_points(
                r=(r4>0?r4:r), a1=270, a2=360,
                shift=[
                    dim.x-(r4>0?r4:r) - (center?dim.x/2:0) + shift.x,
                    (r4>0?r4:r) - (center?dim.y/2:0) + shift.y],
                fn=fn)
    );

// Bezier curve by Christian Limberg
// http://climberg.de/page/openscad-implementation-of-bezier-curves-of-any-degrees/

function _bezier_choose(n, k)=
    k == 0 ? 1 : (n * _bezier_choose(n - 1, k - 1)) / k;

function _point_on_bezier_rec(points, t, i, c)=
    len(points) == i || len(points) == undef ? c :
        _point_on_bezier_rec(points, t, i+1, c+_bezier_choose(len(points)-1, i) *
            pow(t, i) * pow(1-t, len(points)-i-1) * points[i]);

function _point_on_bezier(points, t)=
    _point_on_bezier_rec(points, t, 0, [0,0]);

/**
 * A bezier curve with any number of control points.
 * 
 * @param points the control points of the bezier curve
 *     (number of points is variable)
 * @param fn fragment number - the sampling resolution of the bezier curve
 *     (number of segments on the curve, default: 100)
 * @return array of points for bezier curve
 */
function bezier_points(points, fn=100)=[
    // this looks like onenscad bug:
    // if you generate list with step=0.1: [0:0.1:1],
    // you will get [0, 0.1, 0.2, 0.3 ... 1]
    // but if you generate list with step=0.01 [0:0.01:1],
    // you will get [0, 0.01, 0.02, 0.03 ... 0.99] (no 1 at the end)
    // so add small delta which is less than step: delta=1/fn/2
    for (t =[0:1.0/fn:1+(1/fn/2)]) _point_on_bezier(points, t)
];

function _polybezier_points(segments, fn=100, seg_n)=
    seg_n == 0 ? bezier_points(segments[0], fn) :
        concat(
            _polybezier_points(segments, fn=fn, seg_n=seg_n-1),
            bezier_points(segments[seg_n], fn)
        );

/**
 * Composite bezier curve.
 *
 * @param segments array of segments, each segment is an array of
 *     control points for bezier curve
 * @param fn number of fragments per each segment
 * @return array of points for composite bezier curve
 */ 
function polybezier_points(segments, fn=100)=
    _polybezier_points(segments, fn=fn, seg_n=len(segments)-1);
