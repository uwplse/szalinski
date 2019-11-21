use <utils/build_plate.scad>

/* [general] */
// number of coils
coils = 35; // [1:1:100]
// Can be eighter a polygon, a star or a custom shape that can be drawn
shape_to_use = "custom"; // [polygon:polygon,star:star,custom:draw a shape]

shape = [[[13.674095, -32.972939], [-18.107155, -32.972939], [-17.939723, -30.221435], [-17.610298, -29.274941], [-17.010279, -28.572080], [-16.059577, -28.080947], [-14.678101, -27.769638], [-10.302467, -27.558876], [-11.794630, -24.130484], [-14.114459, -20.084308], [-16.716417, -16.710495], [-17.952714, -15.678895], [-19.054967, -15.299191], [-20.882213, -15.404968], [-22.571295, -16.046262], [-23.267125, -16.719586], [-23.812135, -17.709020], [-24.167565, -19.075308], [-24.294655, -20.879191], [-24.746973, -23.342369], [-25.960973, -25.951885], [-27.722224, -28.498647], [-29.816295, -30.773563], [-32.028755, -32.567542], [-34.145172, -33.671493], [-35.951116, -33.876322], [-36.670651, -33.576225], [-37.232155, -32.972939], [-38.034631, -31.022372], [-37.808983, -29.527890], [-36.839121, -28.203609], [-35.408953, -26.763643], [-33.802389, -24.922103], [-32.303337, -22.393106], [-31.195706, -18.890764], [-30.763405, -14.129191], [-31.265172, -7.624478], [-32.588014, -2.829841], [-34.458238, 0.687767], [-36.602154, 3.361395], [-38.746070, 5.624089], [-40.616295, 7.908900], [-41.939137, 10.648873], [-42.440904, 14.277059], [-42.198326, 17.710506], [-41.664654, 20.081356], [-41.130982, 22.151619], [-40.888404, 24.683309], [-41.087839, 26.432580], [-41.605855, 27.775916], [-43.115903, 29.729356], [-44.455091, 31.512779], [-44.759533, 32.643596], [-44.659964, 34.095340], [-43.816920, 38.439563], [-43.172154, 43.261560], [-42.965392, 45.204826], [-42.562193, 46.924946], [-41.699678, 48.134334], [-40.114967, 48.545403], [-39.001508, 48.260087], [-38.006340, 47.586354], [-36.102585, 45.574594], [-33.867131, 43.512052], [-32.457337, 42.774839], [-30.763405, 42.400653], [-28.946480, 42.465013], [-27.216271, 42.878774], [-24.089694, 44.272548], [-21.531066, 45.618070], [-20.510793, 45.971516], [-19.687780, 45.951435], [-19.089893, 45.507622], [-18.702614, 44.712541], [-18.467858, 42.349219], [-18.799469, 39.422747], [-19.513405, 36.494403], [-21.028771, 31.987310], [-22.110397, 27.590168], [-22.108458, 25.669260], [-21.541964, 24.059558], [-20.258876, 22.855633], [-18.107155, 22.152059], [-12.016334, 21.145711], [-8.506203, 20.337667], [-4.818092, 19.163778], [-1.050880, 17.502095], [2.696556, 15.230672], [6.325340, 12.227559], [9.736595, 8.370809], [12.607356, 3.974893], [14.780375, -0.475734], [16.405351, -4.848051], [17.631986, -9.009035], [19.489027, -16.164914], [20.418833, -18.893764], [21.549095, -20.879191], [25.837688, -25.292162], [30.011877, -28.283843], [33.930680, -30.291039], [37.453115, -31.750556], [40.438200, -33.099199], [42.744953, -34.773773], [43.599898, -35.869786], [44.232391, -37.211083], [44.624811, -38.852267], [44.759533, -40.847936], [44.375808, -42.734109], [43.352185, -44.435942], [41.879989, -45.906731], [40.150549, -47.099775], [38.355191, -47.968370], [36.685242, -48.465813], [35.332028, -48.545403], [34.486877, -48.160436], [34.567374, -47.375864], [35.527146, -46.306692], [36.861590, -44.981297], [38.066100, -43.428056], [38.636070, -41.675347], [38.525413, -40.733060], [38.066895, -39.751548], [37.197439, -38.734357], [35.853970, -37.685035], [31.492689, -35.504186], [23.872462, -32.465106], [19.262709, -30.994345], [17.664844, -30.863894], [16.313297, -31.145693], [15.039303, -31.846467]], [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129]]]; //[draw_polygon:150x150]

//scale the shape by this amount
shape_scale = 1; // [0.1:0.01:10]
//number of points for the polygon or star
point_number = 5; // [3:1:200]
//ratio of the outer and inner radius of the star
star_radius_ratio = 0.5; // [0.2:0.01:0.95]

/* [coil] */
// horizontal breadth of the coil
coil_breadth = 6; // [3:0.1:20]
// vertical thickness of the coil, relative to breadth
coil_thickness = 0.25; // [0.1:0.0001:1]
// separator between coils, set this to 0 if you do not want a separator
separator_thickness = 0.15; // [0:0.0001:1]
// part of the separator connected to the part
separator_breadth1 = 0.25; // [0.05:0.0001:0.5]
// part of the separator adjacent to the gap
separator_breadth2 = 0.075; // [0.05:0.0001:0.5]
// distance between two coils
coil_distance = 0.0375; // [0:0.0001:2]

/* [display] */
// for display only, doesn't contribute to final object
build_plate_selector = 0; // [0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
// when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; // [100:1:400]
// when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; // [100:1:400]

build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);

points = (shape_to_use == "star" ? star(point_number, star_radius_ratio) * 50 :
        (shape_to_use == "polygon" ? poly(point_number) * 40 : removeDoubles(shape[0]))
    ) * shape_scale;

y1 = coil_thickness / 2;
y2 = y1 + separator_thickness;
x1 = 0.5 - separator_breadth1;
x2 = 0.5 - (separator_breadth1 - separator_breadth2) / 2;
x3 = x2 - separator_breadth2;
shape2 = (separator_thickness == 0 ?
        [[[0.5, y1], [-0.5, y1], [-0.5, -y1], [0.5, -y1]]] :
        [[[0.5, y1], [x2, y2], [x3, y2], [x1, y1], [-x1, y1], [-x3, y2], [-x2, y2], [-0.5, y1], [-0.5, -y1], [-x2, -y2],[-x3, -y2],[-x1, -y1],[x1, -y1],[x3, -y2],[x2, -y2],[0.5, -y1]]]
    ) * coil_breadth;
distance = (coil_thickness + separator_thickness * 2 + coil_distance * 2) * coil_breadth;

shape_length = totalLength();

slinky = toPolyhedron();
translate([0, 0, (coil_thickness / 2 + separator_thickness) * coil_breadth]) polyhedron(points = slinky[0], faces = slinky[1]);

function poly(n) = let (d = 360 / n)
    [for (i = [0: 1: n - 1])
        let (a = d * i) [cos(a), sin(a)]
    ];

function star(n, r) = concatAll(let (d = 360 / n)
    [for (i = [0: 1: n - 1])
        let (a = d * i, b = d * (i + 0.5))
        [[cos(a), sin(a)], [cos(b) * r, sin(b) * r]]
    ], n - 1);

// duplicate points break the script, so remove them
function removeDoubles(points, i = 0) = (i >= len(points)) ? [] : 
    concat((points[i] == points[(i == len(points) - 1) ? 0 : (i + 1)]) ? [] :
        [points[i]], removeDoubles(points, i + 1));

function totalLength(i = 0) = (i >= (len(points) - 1)) ? norm(points[i] - points[0]): norm(points[i] - points[i + 1]) + totalLength(i + 1);

// recursively translates the points from the shape in the z-axis depending on the accumulated distance from the first point divided by the whole lenght of the shape
function coilPoints(i, l) =
    i == 0 ? concat([[points[i][0], points[i][1], 0]], coilPoints(1, 0)) :
        (i > len(points) ? [] :
            let (lnorm = (norm(points[i - 1] - points[(i == len(points)) ? 0 : i]) * distance) / shape_length + l)
            concat([[points[(i == len(points)) ? 0 : i][0],
                points[(i == len(points)) ? 0 : i][1], lnorm]
            ], coilPoints(i + 1, lnorm)));

// shape2 follows along the path of shape1
function follow() =
    let (coil = coilPoints(0, 0))
    [for (i = [1: len(coil)])
        let (p1 = (i == len(coil)) ? coil[1] : coil[i],
            p2 = coil[i - 1],
            d = [p2[0] - p1[0], p2[1] - p1[1]],
            n = d / norm(d),
            ps = rotateAlongNormal(shape2[0], n), [n[1], -n[0], 0])
        concat([n], addVectorToAll(ps, p2))
    ];

// each line of a segment is intersected with the same line of the last fragment to find the correct point for the edge
function intersectPoints() =
    let (raw = follow())
    [for (i = [0: len(raw) - 1])
        let (pnext = raw[i], plast = (i == 0) ? raw[len(raw) - 2] : raw[i - 1])
        [for (n = [1: len(raw[i]) - 1])
            let (p = intersect(pnext[n], plast[n], pnext[0], plast[0]))
            [p[0], p[1], pnext[n][2]]
        ]
    ];

function duplicateCoils() =
    let (intersected = intersectPoints(), l = len(intersected) - 1)
    concatAll(
        [for (i = [0: 1: coils - 1]) concatAll(
            [for (j = [0: 1: l])(j == 0 && i > 0) ? [] :
                [(addVectorToAll(intersected[j], [0, 0, distance * i]))]
            ], l)
        ]
    , coils - 1);

function toPolyhedron() =
    let (duplicated = duplicateCoils(), n = len(duplicated[0]), l = len(duplicated), pnum = len(shape2[0]))
    [concatAll(duplicated, l - 1), concat([
            [for (i = [0: 1: (pnum - 1)])(i)],
            [for (i = [0: 1: (pnum - 1)])(l * n - i - 1)]
        ], concatAll(
            [for (i = [0: 1: l * n])((((i + 2) % n == 0) || ((i + 1) % n == 0)) ?
                [[i, i + 1, i - n + 1], [i, i - n + 1, i - n]] :
                [[i + 1, i, i + pnum], [i + 1, i + pnum, i + pnum + 1]])
            ], l * n - 1)
       )
    ];

// intersects two lines in 2D space, when there is no solution return p1
function intersect(p1, p2, v1, v2) =
    let (c1 = p1[1] * v1[0] - p1[0] * v1[1],
        c2 = p2[1] * v2[0] - p2[0] * v2[1],
        d = v2[1] * v1[0] - v1[1] * v2[0])
    (d <= 0.00001 && d >= -0.00001) ? p1:
        [(c1 * v2[0] - c2 * v1[0]) / d, (v2[1] * c1 - v1[1] * c2) / d];

function addVectorToAll(vec, x) = [for (v = vec) v + x];

// only the x and y components are rotated
function rotateAlongNormal(v, n) = [for (p = v)[p[0] * n[1], -p[0] * n[0], p[1]]];

function concatAll(v, b, a = 0) = (a == b) ? v[a]:
    (a + 1 == b) ? concat(v[a], v[b]) : 
        let (h = floor((a + b) / 2))
        concat(concatAll(v, h, a), concatAll(v, b, h + 1));