/*  tttttt20160630.scad

    Tunable Tolerance Tetrahedron Twist Timewasting Toy
    http://www.thingiverse.com/thing:1542564

    Inspired by http://www.thingiverse.com/thing:186372 and the
    unfortunate tolerancing of it (apparently zero clearance...
    and we don't like sanding PLA parts to fit), I wanted to
    create a parameterized-tolerance version.  Fortunately, an
    undergraduate student in my lab, Zachary Snyder, took it
    upon himself to do the math just before he graduated. I
    (Prof. Hank Dietz) then tweaked and repackaged it... also
    optionally sticking an (totally unofficial and for personal
    use only) University of Kentucky logo on it.  Actually, the
    logo makes the puzzle MUCH easier to solve because it
    provides a visual reference for how the two otherwise
    identical parts should intertwine.

    Perhaps the scariest thing is that this can just barely
    print assembled without supports!  In truth, a little
    support would be nice, but the sag is localized and small so
    that setting a larger gap can be good enough.  If that's not
    good enough for your printer, either enlarge the gap or use
    your slicer to separate the two intertwined pieces for
    separate printing.

    20160630 version fixes logo inset for solid center and
    exposes turns parameter with default of 1.2 rather than 1.0.
    The extra turn keeps the thickness of the parts more even,
    resulting in a print that doesn't break as easily.

    2016 by Zachary Snyder and Hank Dietz
    http://aggregate.org/hankd
*/

/*[Parameters]*/

// length of the tetrahedron edge (in microns, 75000 is 75.000mm)
micron_side = 75000;

// 10*turns for cut (originally 10, but 12 keeps thickness more even)
tenth_turns = 12;

// for assembly tolerance
micron_gap = 600;

// for making the center hollow, 0 for solid center
micron_wall_thickness = 0;

// radius for cavity edges, 0 is sharp
micron_internal_rounding = 4000;

// radius for outside edges, 0 is sharp
micron_external_rounding = 0;

// inset, 0 is no University of Kentucky logo
micron_uk_logo = 750;

/*[Hidden]*/

$fn = 0;
$fa = 5;
$fs = 0.1;

rounding_fn = 0;
rounding_fa = 5;
rounding_fs = 0.1;

side = micron_side / 1000;
gap = micron_gap / 1000;
wall_thickness = micron_wall_thickness / 1000;
internal_rounding = micron_internal_rounding / 1000;
external_rounding = micron_external_rounding / 1000;
uk_logo = micron_uk_logo / 1000;

size = side / sqrt(2);
inset = uk_logo; // ((uk_logo > wall_thickness) ? wall_thickness*2 : uk_logo);
theta = atan2(sqrt(2), 1);
cavity_difference = 2 * (wall_thickness + internal_rounding) / cos(theta);
size_difference = 2 * external_rounding / cos(theta);

function flipSin(x) = x < 90 ? sin(x) - 1 : 1 - sin(x);

function getFragmentsFromR(r) = $fn > 0 ? max(floor($fn), 3) : (ceil(max(min(360 / $fa, r * PI / $fs), 5)));

function zRotationMatrix(theta) = [
    [cos(theta), - sin(theta), 0],
    [sin(theta), cos(theta), 0],
    [0, 0, 1]
];

function width(radius, length, turns, gap) = gap / sin(atan2(length, 2 * PI * turns * radius)) / 2;

module tetrahedron()
{
    polyhedron(
points = [
    [1, 1, 1],
    [1, -1, -1],
    [-1, 1, -1],
    [-1, -1, 1]
],
faces = [
    [0, 1, 3],
    [0, 2, 1],
    [0, 3, 2],
    [1, 2, 3]
],
convexity = 2
    );
}

module helicut(radius=1, length=1, turns=1, center=false, gap=1)
{
    /* Basic Values */
    fragments = getFragmentsFromR (radius);
    angle_per_len = turns / length * 360;
    zh = length / fragments;
    z0 = (center ? - length / 2 : 0);
    rot_bottom = zRotationMatrix (z0 * angle_per_len);
    rot_top = zRotationMatrix ((z0 + length) * angle_per_len);

    /* Construct points */
    points =
        concat (
            [ /* Bottom Midpoints */
                for (i = [1:fragments])
                    let (r = radius * flipSin (((i - 0.5) / fragments) * 180))
                        rot_bottom * [r, 0, z0]
            ],
            [ /* Bottom Corners */
                for (i = [0:fragments])
                    let (
                        r = radius * flipSin ((i / fragments) * 180),
                        w = width (r, length, turns, gap)
                    )
                        for (p = [[r, w, z0], [r, - w, z0]])
                            rot_bottom * p
            ],
            [ /* Layers */
                for (i = [1:fragments])
                    let (
                        z = z0 + i * zh,
                        zmid = z - zh / 2,
                        angle = z * angle_per_len,
                        anglemid = zmid * angle_per_len,
                        rot = zRotationMatrix (angle),
                        rot_mid = zRotationMatrix (anglemid)
                    )
                        for (
                            p = concat (
                                [ /* Beginning Midpoint */
                                    rot_mid * [- radius, 0, zmid]
                                ],
                                [ /* Layer Midpoints */
                                    for (j = [1:fragments])
                                        let (
                                            r = radius * flipSin (((j - 0.5) / fragments) * 180),
                                            w = width (r, length, turns, gap)
                                        )
                                            for (q = [[r, w, zmid], [r, -w, zmid]])
                                                rot_mid * q
                                ],
                                [ /* End Midpoint */
                                    rot_mid * [radius, 0, zmid]
                                ],
                                [ /* Layer Corners */
                                    for (j = [0:fragments])
                                        let (
                                            r = radius * flipSin ((j / fragments) * 180),
                                            w = width (r, length, turns, gap)
                                        )
                                            for (q = [[r, w, z], [r, -w, z]])
                                                rot * q
                                ]
                            )
                        )
                            p
            ],
            [ /* Top Midpoints */
                for (i = [1:fragments])
                    let (r = radius * flipSin (((i - 0.5) / fragments) * 180))
                        rot_top * [r, 0, z0 + length]
            ]
        );

    /* Point Offsets */
    num_corners = 2 *(fragments + 1);
    bottom_mids = 0;
    bottom_corners = bottom_mids + fragments;
    layers = bottom_corners + num_corners;
    begin_mid = 0;
    layer_mids = begin_mid + 1;
    end_mid = layer_mids + 2 * fragments;
    layer_corners = end_mid + 1;
    layer_length = layer_corners + num_corners;
    top_mids = layers + fragments * layer_length;

    /* Faces */
    faces = concat(
        [ /* Bottom Faces */
            for (i = [0:fragments - 1])
                let (
                    coffset = bottom_corners + 2 * i,
                    c0 = coffset + 0,
                    c1 = coffset + 1,
                    c2 = coffset + 2,
                    c3 = coffset + 3,
                    m = bottom_mids + i
                )
                    for (p = [[m, c1, c3], [m, c3, c2], [m, c2, c0], [m, c0, c1]])
                        p
        ],
        [ /* Layers */
            for (i = [0:fragments - 1])
                let (
                    layer_offset = layers + layer_length * i,
                    bottom_corners = layer_offset - layer_length + layer_corners,
                    top_corners = layer_offset + layer_corners,
                    mids = layer_offset + layer_mids,
                    bc0 = bottom_corners + 0,
                    bc1 = bottom_corners + 1,
                    bc2 = top_corners + 0,
                    bc3 = top_corners + 1,
                    bm = layer_offset + begin_mid,
                    ec0 = bottom_corners + num_corners - 2,
                    ec1 = bottom_corners + num_corners - 1,
                    ec2 = top_corners + num_corners - 2,
                    ec3 = top_corners + num_corners - 1,
                    em = layer_offset + end_mid
                )
                    for (
                        p = concat(
                            [ /* Beginning Edge Faces */
                                [bm, bc3, bc1],
                                [bm, bc2, bc3],
                                [bm, bc0, bc2],
                                [bm, bc1, bc0]
                            ],
                            [ /* Planar Faces */
                                for (j = [0:fragments - 1])
                                    let (
                                        ioffset = 2 * j,
                                        pc0 = bottom_corners + ioffset + 0,
                                        pc1 = bottom_corners + ioffset + 2,
                                        pc2 = top_corners + ioffset + 0,
                                        pc3 = top_corners + ioffset + 2,
                                        pm = mids + ioffset + 0,
                                        nc0 = bottom_corners + ioffset + 1,
                                        nc1 = bottom_corners + ioffset + 3,
                                        nc2 = top_corners + ioffset + 1,
                                        nc3 = top_corners + ioffset + 3,
                                        nm = mids + ioffset + 1
                                    )
                                        for (
                                            q = [
                                                [pm, pc2, pc0],
                                                [pm, pc3, pc2],
                                                [pm, pc1, pc3],
                                                [pm, pc0, pc1],
                                                [nm, nc0, nc2],
                                                [nm, nc2, nc3],
                                                [nm, nc3, nc1],
                                                [nm, nc1, nc0]
                                            ]
                                        )
                                            q
                            ],
                            [ /* End Edge Faces */
                                [em, ec1, ec3],
                                [em, ec3, ec2],
                                [em, ec2, ec0],
                                [em, ec0, ec1]
                            ]
                        )
                    )
                        p
        ],
        [ /* Top Faces */
            for (i = [0:fragments - 1])
                let (
                    coffset = top_mids - layer_length + layer_corners + 2 * i,
                    c0 = coffset + 0,
                    c1 = coffset + 1,
                    c2 = coffset + 2,
                    c3 = coffset + 3,
                    m = top_mids + i
                )
                    for (p = [[m, c3, c1], [m, c2, c3], [m, c0, c2], [m, c1, c0]])
                        p
        ]
    );

    /* Polyhedron */
    polyhedron(points, faces, turns * 4);
}


module object()
{
    translate([0, 0, size/(2+sqrt(2))])
    rotate([0, 0, 45])
    rotate(a = theta, v = [1, -1, 0]) {
        /* Actual Part */
        difference() {
            /* Tetrahedron */
            if (external_rounding != 0) {
                minkowski() {
                    scale((size - size_difference) / 2) tetrahedron();
                    sphere(r = external_rounding, $fn = rounding_fn, $fa = rounding_fa, $fs = rounding_fs);

                }
            } else {
                scale(size / 2) tetrahedron();
            }

            /* Cavity */
            if (wall_thickness > 0) {
                if (internal_rounding != 0) {
                    minkowski() {
                        scale((size - cavity_difference) / 2) tetrahedron();
                        sphere(r = internal_rounding, $fn = rounding_fn, $fa = rounding_fa, $fs = rounding_fs);
                    }
                } else {
                    scale(size - cavity_difference / 2) tetrahedron();
                }
            }

            /* Helical Cut */
            rotate([0, 0, 90])
            helicut(radius = size * 2, length = size, turns = (tenth_turns/10), center = true, gap = gap);
        }
    }
}

module uk2016logo_1()
{
    /* Generated by trace2scad version 20150117
       http://aggregate.org/MAKE/TRACE2SCAD/
       Optimized model has 458/613 original points
    */
    minx=0; /* polygon minx=0 */
    miny=0; /* polygon miny=0 */
    maxx=20000; /* polygon maxx=20000 */
    maxy=15940; /* polygon maxy=15940 */
    dx=maxx-minx;
    dy=maxy-miny;
    maxd=((dx>dy)?dx:dy);
    color([0.48, 0.48, 0.48])
    scale([1/maxd, 1/maxd, 1])
    translate([-minx-dx/2, -miny-dy/2, 0])
    linear_extrude(height=1, convexity=458)
    union() {
        union() {
            polygon([[0,15423], [0,14905], [964,14905],
	    [968,14900], [971,14895], [1011,14895],
	    [1033,14880], [1056,14865], [1063,14865],
	    [1072,14855], [1082,14845], [1098,14845],
	    [1134,14809], [1170,14772], [1170,14761],
	    [1192,14733], [1220,14679], [1220,14652],
	    [1227,14642], [1235,14633], [1235,8252],
	    [1745,7743], [2255,7233], [2255,7222], [2419,7059],
	    [2583,6895], [5084,6895], [5087,6900], [5090,6904],
	    [5090,7922], [5082,7930], [4602,7932], [4123,7933],
	    [4105,7937], [4088,7941], [4052,7958], [4017,7975],
	    [4010,7982], [4004,7990], [3993,7990], [3956,8026],
	    [3920,8062], [3920,8073], [3910,8083], [3900,8092],
	    [3900,8109], [3895,8113], [3890,8116], [3890,8134],
	    [3883,8140], [3875,8146], [3875,8184], [3868,8190],
	    [3860,8196], [3860,14633], [3868,14642],
	    [3875,14652], [3875,14689], [3880,14692],
	    [3884,14695], [3900,14727], [3900,14738],
	    [3910,14748], [3920,14757], [3920,14772],
	    [3956,14809], [3992,14845], [4008,14845],
	    [4018,14855], [4027,14865], [4039,14865],
	    [4062,14880], [4084,14895], [4124,14895],
	    [4128,14900], [4131,14905], [5083,14905],
	    [5088,14910], [5093,14914], [5091,15427],
	    [5090,15940], [0,15940]], convexity=23);
            polygon([[9606,15424], [9608,14908], [10090,14906],
	    [10572,14905], [10582,14895], [10619,14895],
	    [10625,14888], [10631,14880], [10649,14880],
	    [10655,14873], [10661,14865], [10673,14865],
	    [10683,14855], [10692,14845], [10703,14845],
	    [10739,14809], [10775,14772], [10775,14762],
	    [10786,14752], [10796,14743], [10801,14733],
	    [10805,14723], [10809,14715], [10813,14708],
	    [10819,14696], [10825,14685], [10825,14651],
	    [10830,14648], [10835,14644], [10835,8191],
	    [10830,8188], [10825,8184], [10825,8145],
	    [10812,8121], [10799,8098], [10775,8072],
	    [10775,8062], [10739,8026], [10702,7990],
	    [10693,7990], [10680,7978], [10668,7966],
	    [10620,7940], [10582,7940], [10572,7930],
	    [9608,7928], [9608,6898], [10856,6896],
	    [12105,6895], [12278,7070], [12452,7245],
	    [12467,7245], [12969,7746], [13470,8247],
	    [13470,14644], [13475,14648], [13480,14651],
	    [13480,14685], [13486,14696], [13492,14708],
	    [13496,14715], [13500,14723], [13504,14733],
	    [13509,14743], [13519,14752], [13530,14762],
	    [13530,14772], [13566,14809], [13602,14845],
	    [13614,14845], [13620,14853], [13627,14861],
	    [13637,14866], [13648,14870], [13655,14874],
	    [13663,14879], [13678,14887], [13694,14895],
	    [13723,14895], [13733,14905], [14215,14906],
	    [14698,14908], [14700,15940], [9605,15940]],
	    convexity=23);
            polygon([[4808,9897], [4805,9893], [4805,8870],
	    [5763,8870], [5773,8863], [5783,8855], [5815,8855],
	    [5841,8843], [5868,8831], [5892,8805], [5903,8805],
	    [5939,8769], [5975,8732], [5975,8722], [5985,8713],
	    [5995,8703], [5995,8691], [6003,8685], [6010,8679],
	    [6010,8661], [6018,8655], [6025,8649], [6025,8611],
	    [6030,8608], [6035,8604], [6035,1296], [6030,1293],
	    [6025,1289], [6025,1258], [6015,1237], [6004,1215],
	    [6000,1212], [5995,1209], [5995,1192], [5985,1182],
	    [5975,1173], [5975,1162], [5939,1126], [5902,1090],
	    [5891,1090], [5885,1083], [5880,1076], [5843,1058],
	    [5807,1040], [5777,1040], [5767,1030], [5287,1029],
	    [4808,1028], [4806,514], [4805,0], [9900,0],
	    [9898,1028], [9415,1029], [8933,1030], [8923,1040],
	    [8884,1040], [8862,1055], [8839,1070], [8832,1070],
	    [8822,1080], [8813,1090], [8799,1090], [8765,1123],
	    [8730,1157], [8730,1173], [8718,1185], [8705,1197],
	    [8693,1222], [8680,1247], [8680,1284], [8673,1290],
	    [8665,1296], [8665,3799], [8672,3805], [8680,3811],
	    [8680,3848], [8693,3873], [8705,3898], [8718,3910],
	    [8730,3922], [8730,3938], [8765,3972], [8799,4005],
	    [8814,4005], [8820,4013], [8827,4021], [8837,4026],
	    [8848,4030], [8859,4037], [8871,4044], [8882,4055],
	    [8923,4055], [8933,4065], [10653,4063],
	    [12373,4062], [12390,4058], [12408,4054],
	    [12444,4037], [12480,4019], [12485,4012],
	    [12491,4005], [12503,4005], [13205,3302],
	    [13907,2600], [13918,2600], [14115,2403],
	    [14312,2205], [14323,2205], [14428,2100],
	    [14532,1995], [14548,1995], [14640,1903],
	    [14732,1810], [14748,1810], [14849,1709],
	    [14950,1607], [14950,1592], [14963,1580],
	    [14975,1568], [14975,1557], [14991,1525],
	    [14995,1522], [15000,1519], [15000,1483],
	    [15008,1473], [15015,1463], [15015,1303],
	    [15007,1293], [15000,1283], [15000,1246],
	    [14995,1243], [14991,1240], [14975,1208],
	    [14975,1197], [14963,1185], [14950,1173],
	    [14950,1157], [14916,1124], [14882,1090],
	    [14867,1090], [14858,1080], [14848,1070],
	    [14836,1070], [14813,1055], [14791,1040],
	    [14752,1040], [14742,1030], [14408,1028],
	    [14406,514], [14405,0], [20000,0], [20000,1030],
	    [18721,1030], [18718,1035], [18714,1040],
	    [18672,1040], [18661,1051], [18649,1058],
	    [18638,1065], [18627,1069], [18617,1074],
	    [18610,1082], [18604,1090], [18592,1090],
	    [16941,2741], [15290,4393], [15290,4403],
	    [15095,4598], [14900,4792], [14900,4803],
	    [14886,4817], [14871,4830], [14865,4851],
	    [14858,4873], [14854,4877], [14850,4882],
	    [14850,4913], [14842,4922], [14835,4932],
	    [14835,5103], [14843,5112], [14850,5122],
	    [14850,5153], [14858,5163], [14865,5184],
	    [14871,5205], [14886,5218], [14900,5232],
	    [14900,5243], [16681,7024], [18463,8805],
	    [18473,8805], [18497,8831], [18512,8837],
	    [18528,8844], [18541,8849], [18555,8855],
	    [18583,8855], [18592,8863], [18602,8870],
	    [20000,8870], [20000,9900], [14408,9898],
	    [14406,9395], [14405,8893], [14407,8881],
	    [14410,8870], [14633,8870], [14642,8862],
	    [14652,8855], [14684,8855], [14688,8850],
	    [14691,8845], [14720,8845], [14768,8819],
	    [14780,8807], [14793,8795], [14808,8795],
	    [14841,8761], [14875,8727], [14875,8712],
	    [14887,8700], [14900,8688], [14912,8663],
	    [14925,8638], [14925,8601], [14930,8597],
	    [14935,8594], [14935,8411], [14930,8408],
	    [14925,8404], [14925,8370], [14901,8318],
	    [14888,8305], [14875,8293], [14875,8282],
	    [14400,7808], [13925,7333], [13925,7317],
	    [13276,6669], [12627,6020], [12613,6020],
	    [12600,6008], [12588,5996], [12540,5970],
	    [12501,5970], [12498,5965], [12494,5960],
	    [8931,5960], [8928,5965], [8924,5970], [8887,5970],
	    [8859,5984], [8831,5999], [8817,6009], [8804,6020],
	    [8792,6020], [8761,6051], [8730,6083], [8730,6094],
	    [8718,6108], [8707,6123], [8693,6150], [8680,6177],
	    [8680,6214], [8673,6220], [8665,6226], [8665,8603],
	    [8673,8612], [8680,8622], [8680,8650], [8690,8668],
	    [8700,8685], [8700,8699], [8715,8714], [8730,8730],
	    [8730,8743], [8761,8774], [8793,8805], [8805,8805],
	    [8821,8820], [8836,8835], [8850,8835], [8868,8845],
	    [8885,8855], [8913,8855], [8923,8862], [8934,8870],
	    [9416,8871], [9898,8873], [9898,9898], [4812,9900]],
	    convexity=89);
        }
    }
}

module uk2016logo()
{
    /* all layers combined, scaled to within a 1mm cube */
    scale([1, 1, 1/1])
    difference() {
        union() {
            scale([1,1,2]) translate([0,0,-0.5]) uk2016logo_1();
        }
        translate([0,0,-2]) cube([2,2,4], center=true);
    }
}

module print_part()
{
    translate([0, -size/(1+sqrt(2)), 0])
    rotate([-acos(-1/3), 0, 0])
    translate([0, -size/(1+sqrt(2)), 0])
    difference() {
        object();
        if (inset > 0) {
            scale([size/1.75, size/1.75, inset*2+0.001])
            rotate([180, 0, 0])
            translate([0.07, 0.05, -0.5])
            uk2016logo();
        }
    }
}

print_part();

