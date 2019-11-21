// smaller values are better
taiwan_fineness = 5;  

// smaller values are better
wave_fineness = 0.05;  

model_type = "Wave";  // [Both, Taiwan, Wave]

// Common-based private API

function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);

function __to2d(p) = [p[0], p[1]];

function __to3d(p) = [p[0], p[1], 0];

function __is_vector(value) = !(value >= "") && len(value) != undef;

/**
* shape_taiwan.scad
*
* Returns shape points of Taiwan.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_taiwan.html
*
**/

function shape_taiwan(h) = [[3.857235,6.240775],[3.790195,6.257785],[3.735955,6.262885],[3.628068,6.245875],[3.595808,6.260195],[3.554288,6.323865],[3.516978,6.457102],[3.507678,6.536102],[3.511878,6.582842],[3.539168,6.637082],[3.489808,6.669342],[2.782860,6.839047],[2.721800,6.861117],[2.697210,6.888317],[2.684410,6.902717],[2.628400,6.942717],[2.610630,6.962087],[2.610630,6.996957],[2.625870,7.021547],[2.642880,7.043527],[2.642880,7.055487],[2.610620,7.065677],[2.563960,7.060577],[2.522270,7.048787],[2.502810,7.041087],[2.448490,7.156471],[2.293188,7.371234],[2.224378,7.425554],[2.056442,7.442484],[1.886737,7.405094],[1.739014,7.328794],[1.637949,7.238004],[1.588680,7.149744],[1.556592,7.070744],[1.544632,7.055504],[1.514903,7.041104],[1.485258,7.018954],[1.536576,6.972504],[1.588252,6.929094],[1.630956,6.862814],[1.665236,6.770334],[1.630956,6.862814],[1.613483,6.803874],[1.577574,6.837214],[1.539493,6.891164],[1.485255,6.873934],[1.438512,6.873934],[1.403813,6.866234],[1.374084,6.851744],[1.280683,6.772824],[1.206821,6.745704],[0.723984,6.656594],[0.586451,6.607414],[0.515200,6.570944],[0.458435,6.521674],[0.393838,6.479224],[0.108666,6.388434],[-0.002506,6.292504],[-0.110307,6.166930],[-0.278327,5.897845],[-0.312266,5.804525],[-0.322462,5.760475],[-0.319942,5.740765],[-0.359780,5.728045],[-0.398773,5.694105],[-0.431113,5.649215],[-0.443073,5.605085],[-0.453170,5.545625],[-0.477762,5.514295],[-0.504966,5.481955],[-0.527025,5.437905],[-0.511698,5.403035],[-0.499737,5.375915],[-0.499737,5.348715],[-0.511683,5.324125],[-0.544022,5.280075],[-0.630518,5.105233],[-0.652506,5.021183],[-0.709523,4.994063],[-0.721317,4.965173],[-0.751047,4.878513],[-0.807895,4.819223],[-0.849502,4.763133],[-0.835106,4.679163],[-0.945350,4.701233],[-1.031930,4.676643],[-1.103181,4.624763],[-1.166852,4.558563],[-1.187240,4.521253],[-1.206789,4.479813],[-1.236433,4.447553],[-1.339268,4.417823],[-1.364617,4.376213],[-1.388443,4.280373],[-1.477465,4.119932],[-1.514775,4.034192],[-1.526736,3.933212],[-1.556382,3.871222],[-1.873894,3.521621],[-1.923078,3.437571],[-1.967211,3.284795],[-2.110553,3.038618],[-2.152244,2.849458],[-2.187028,2.750918],[-2.238738,2.708638],[-2.248098,2.656758],[-2.433130,2.442837],[-2.474820,2.403927],[-2.489980,2.361477],[-2.496810,2.206174],[-2.517270,2.159514],[-2.595258,2.098284],[-2.613115,2.055834],[-2.622375,2.009260],[-2.647053,1.987280],[-2.681835,1.972793],[-2.719147,1.945587],[-2.765889,1.901371],[-2.807410,1.827678],[-2.895759,1.580743],[-2.960103,1.462665],[-3.001707,1.342230],[-3.033963,1.299783],[-3.142610,1.194507],[-3.162234,1.149449],[-3.186829,1.041731],[-3.211421,0.994987],[-3.297915,0.928032],[-3.309876,0.906048],[-3.325036,0.864443],[-3.421048,0.738702],[-3.437974,0.692212],[-3.474525,0.558807],[-3.544093,0.411083],[-3.625533,0.283068],[-3.694342,0.142925],[-3.724072,-0.047077],[-3.716342,-0.135425],[-3.674737,-0.317847],[-3.659482,-0.475761],[-3.623015,-0.539348],[-3.610290,-0.588533],[-3.625545,-0.628538],[-3.649371,-0.659782],[-3.657031,-0.687068],[-3.610289,-0.709975],[-3.610289,-0.738780],[-3.640019,-0.795629],[-3.575422,-0.918676],[-3.640019,-1.128469],[-3.654343,-1.140261],[-3.679021,-1.147841],[-3.679021,-1.147841],[-3.625532,-1.189442],[-3.595888,-1.204600],[-3.583163,-1.251343],[-3.605151,-1.243763],[-3.647598,-1.287811],[-3.684065,-1.344743],[-3.681625,-1.371861],[-3.721377,-1.382049],[-3.745972,-1.409251],[-3.797852,-1.544257],[-3.804582,-1.581567],[-3.817307,-1.611212],[-3.849563,-1.655259],[-3.876767,-1.709581],[-3.866501,-1.758935],[-3.847139,-1.808119],[-3.834343,-1.866652],[-3.853967,-1.906657],[-3.896328,-1.918449],[-3.935323,-1.940517],[-3.945517,-2.002504],[-3.903153,-2.051688],[-3.836870,-2.108458],[-3.836870,-2.108458],[-3.914521,-2.125253],[-3.924856,-2.167465],[-3.802098,-2.217177],[-3.780039,-2.241687],[-3.795366,-2.285987],[-3.841941,-2.302917],[-3.901401,-2.310517],[-3.945534,-2.332497],[-3.945534,-2.332497],[-3.909015,-2.389842],[-3.812282,-2.425988],[-3.748697,-2.453108],[-3.735901,-2.490418],[-3.610322,-2.512488],[-3.514395,-2.526978],[-3.497373,-2.605978],[-3.536452,-2.699208],[-3.610312,-2.751008],[-3.550853,-2.812998],[-3.521966,-2.867318],[-3.474548,-3.171944],[-3.462683,-3.201754],[-3.421078,-3.278054],[-3.410884,-3.312924],[-3.391356,-3.332374],[-3.371827,-3.347614],[-3.361728,-3.367234],[-3.366698,-3.403534],[-3.391374,-3.458024],[-3.391374,-3.504684],[-3.376047,-3.573324],[-3.304796,-3.728795],[-3.228491,-3.847546],[-3.186887,-3.933196],[-3.164732,-4.022386],[-3.181754,-4.086056],[-3.214010,-4.157226],[-3.189418,-4.228476],[-3.137705,-4.293156],[-2.997562,-4.423698],[-2.916122,-4.514578],[-2.856746,-4.625749],[-2.834591,-4.738605],[-2.834591,-4.738605],[-2.844781,-4.765724],[-2.642820,-4.921195],[-2.608122,-4.921195],[-2.580835,-4.911005],[-2.556243,-4.908305],[-2.512194,-4.928765],[-2.477327,-4.950745],[-2.403550,-5.014415],[-2.332216,-5.061155],[-2.176913,-5.134845],[-2.110630,-5.179905],[-2.100531,-5.199445],[-2.086040,-5.258065],[-2.068183,-5.268085],[-2.051256,-5.273285],[-2.001988,-5.302935],[-1.876413,-5.401475],[-1.844157,-5.445525],[-1.778044,-5.595775],[-1.693992,-5.701809],[-1.666872,-5.746109],[-1.359635,-6.536942],[-1.368995,-6.583512],[-1.406305,-6.638002],[-1.415565,-6.684662],[-1.415565,-6.849145],[-1.423225,-6.901025],[-1.423225,-6.930755],[-1.415565,-6.969915],[-1.329997,-7.110732],[-1.349454,-7.218450],[-1.346924,-7.253150],[-1.289990,-7.299890],[-1.239206,-7.315220],[-1.201810,-7.277830],[-1.196750,-7.176849],[-1.073620,-7.206579],[-0.953101,-7.260899],[-0.849593,-7.339819],[-0.778259,-7.442484],[-0.775729,-7.354134],[-0.795186,-7.214159],[-0.797786,-7.086059],[-0.736641,-7.029129],[-0.685014,-6.990139],[-0.645009,-6.898509],[-0.620417,-6.785653],[-0.637343,-5.770625],[-0.612751,-5.521921],[-0.590692,-5.435341],[-0.443136,-5.179899],[-0.371802,-4.923616],[-0.341989,-4.733445],[-0.290360,-4.642825],[-0.167230,-4.487353],[-0.128151,-4.411053],[-0.046711,-4.203955],[-0.014539,-4.162345],[0.027066,-4.142975],[0.191803,-3.960385],[0.441265,-3.795649],[0.515127,-3.726079],[0.588904,-3.632849],[0.620320,-3.581049],[0.640788,-3.531699],[0.643228,-3.487569],[0.633124,-3.391729],[0.640794,-3.351889],[0.689979,-3.293359],[0.903900,-3.113378],[0.923353,-3.070928],[1.083626,-2.845217],[1.116050,-2.753417],[1.162624,-2.554067],[1.233959,-2.423440],[1.261161,-2.335180],[1.278091,-2.300310],[1.310347,-2.266370],[1.384209,-2.212130],[1.416381,-2.179870],[1.490243,-2.027009],[1.504640,-1.879352],[1.502120,-1.724049],[1.526711,-1.549375],[1.558967,-1.455890],[1.598972,-1.379418],[1.706690,-1.236159],[1.741473,-1.160444],[1.982428,0.226167],[2.056374,0.376416],[2.181947,0.989965],[2.277877,1.253155],[2.329587,1.501858],[2.334687,1.601070],[2.347407,1.654466],[2.401727,1.743656],[2.421177,1.797978],[2.418777,1.847247],[2.406057,1.869143],[2.383907,1.883630],[2.361757,1.918497],[2.334727,1.999938],[2.332127,2.071360],[2.354197,2.137470],[2.467980,2.304731],[2.512030,2.492208],[2.556250,2.585528],[2.593560,2.622838],[2.699678,2.699228],[2.711468,2.721378],[2.699678,2.753638],[2.721748,2.784968],[2.792998,2.841898],[2.891448,2.975135],[2.980638,3.060784],[3.000088,3.098174],[3.000088,3.115185],[2.987368,3.137164],[2.972968,3.159234],[2.960248,3.174564],[2.945758,3.201684],[2.953458,3.221135],[2.967858,3.240755],[2.978048,3.267785],[2.984848,3.363795],[2.997568,3.412974],[3.017018,3.447754],[3.034118,3.489355],[3.027318,3.595473],[3.031518,3.644743],[3.140079,3.767706],[3.233479,3.824636],[3.273319,3.861105],[3.265719,3.903556],[3.238519,3.945166],[3.226729,3.989295],[3.233429,4.029045],[3.325149,4.080845],[3.339549,4.166585],[3.317479,4.267581],[3.278399,4.344051],[3.305599,4.363502],[3.347119,4.376222],[3.375256,4.386492],[3.411090,4.397932],[3.398688,4.425132],[3.325137,4.425408],[3.226687,4.487398],[3.172367,4.583238],[3.169767,4.706357],[3.191917,4.767497],[3.194317,4.829397],[3.142607,5.066241],[3.140007,5.179086],[3.147807,5.297090],[3.172397,5.415827],[3.206337,5.519432],[3.253837,5.593292],[3.541528,5.940365],[3.625578,6.014315],[3.945534,6.172153],[3.913274,6.211063],[3.857235,6.240775]] / 15 * h;

/**
* circle_path.scad
*
* Sometimes you need all points on the path of a circle. Here's 
* the function. Its $fa, $fs and $fn parameters are consistent 
* with the circle module.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-circle_path.html
*
**/

function circle_path(radius, n) =
    let(
        _frags = __frags(radius),
        step_a = 360 / _frags,
        end_a = 360 - step_a * ((n == undef || n > _frags) ? 1 : _frags - n + 1)
    )
    [
        for(a = [0 : step_a : end_a]) 
            [radius * cos(a), radius * sin(a)]
    ];

/**
* rotate_p.scad
*
* Rotates a point 'a' degrees around an arbitrary axis. 
* The rotation is applied in the following order: x, y, z. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rotate_p.html
*
**/ 

function _rotx(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0], 
        pt[1] * cosa - pt[2] * sina,
        pt[1] * sina + pt[2] * cosa
    ];

function _roty(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa + pt[2] * sina, 
        pt[1],
        -pt[0] * sina + pt[2] * cosa, 
    ];

function _rotz(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa - pt[1] * sina,
        pt[0] * sina + pt[1] * cosa,
        pt[2]
    ];

function _rotate_p_3d(point, a) =
    _rotz(_roty(_rotx(point, a[0]), a[1]), a[2]);

function to_avect(a) =
     len(a) == 3 ? a : (
         len(a) == 2 ? [a[0], a[1], 0] : (
             len(a) == 1 ? [a[0], 0, 0] : [0, 0, a]
         ) 
     );

function rotate_p(point, a) =
    let(angle = to_avect(a))
    len(point) == 3 ? 
        _rotate_p_3d(point, angle) :
        __to2d(
            _rotate_p_3d(__to3d(point), angle)
        );

    
/**
* golden_spiral.scad
*
*  Gets all points and angles on the path of a golden spiral. The distance between two  points is almost constant. 
* 
*  It returns a vector of [[x, y], angle]. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-golden_spiral.html
*
**/ 

function _fast_fibonacci_sub(nth) = 
    let(
        _f = _fast_fibonacci_2_elems(floor(nth / 2)),
        a = _f[0],
        b = _f[1],
        c = a * (b * 2 - a),
        d = a * a + b * b
    ) 
    nth % 2 == 0 ? [c, d] : [d, c + d];

function _fast_fibonacci_2_elems(nth) =
    nth == 0 ? [0, 1] : _fast_fibonacci_sub(nth);
    
function _fast_fibonacci(nth) =
    _fast_fibonacci_2_elems(nth)[0];
    
function _remove_same_pts(pts1, pts2) = 
    pts1[len(pts1) - 1] == pts2[0] ? 
        concat(pts1, [for(i = [1:len(pts2) - 1]) pts2[i]]) : 
        concat(pts1, pts2);    

function _golden_spiral_from_ls_or_eql_to(from, to, point_distance, rt_dir) = 
    let(
        f1 = _fast_fibonacci(from),
        f2 = _fast_fibonacci(from + 1),
        fn = floor(f1 * 6.28312 / point_distance), 
        $fn = fn + 4 - (fn % 4),
        circle_pts = circle_path(radius = f1, n = $fn / 4 + 1),
        len_pts = len(circle_pts),
        a_step = 360 / $fn * rt_dir,
        arc_points_angles = (rt_dir == 1 ? [
            for(i = [0:len_pts - 1])
                [circle_pts[i], a_step * i] 
        ] : [
            for(i = [0:len_pts - 1]) let(idx = len_pts - i - 1)
                [circle_pts[idx], a_step * i] 
        ]),
        offset = f2 - f1
    ) _remove_same_pts(
        arc_points_angles, 
        [
            for(pt_a = _golden_spiral(from + 1, to, point_distance, rt_dir)) 
                [ 
                    rotate_p(pt_a[0], [0, 0, 90 * rt_dir]) + 
                    (rt_dir == 1 ? [0, -offset, 0] : [-offset, 0, 0]), 
                    pt_a[1] + 90 * rt_dir
                ]
        ] 
    ); 

function _golden_spiral(from, to, point_distance, rt_dir) = 
    from <= to ? 
        _golden_spiral_from_ls_or_eql_to(from, to, point_distance, rt_dir) : [];

function golden_spiral(from, to, point_distance, rt_dir = "CT_CLK") =    
    _golden_spiral(from, to, point_distance, (rt_dir == "CT_CLK" ? 1 : -1));
    
/**
* cross_sections.scad
*
* Given a starting cross-section, points and angles along the path, this function
* will return all cross-sections.
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-cross_sections.html
*
**/

function cross_sections(shape_pts, path_pts, angles, twist = 0, scale = 1.0) =
    let(
        len_path_pts_minus_one = len(path_pts) - 1,
        sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)],
        pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)],
        scale_step_vt = __is_vector(scale) ? 
            [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one] :
            [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one],
        scale_step_x = scale_step_vt[0],
        scale_step_y = scale_step_vt[1],
        twist_step = twist / len_path_pts_minus_one
    )
    [
        for(i = [0:len_path_pts_minus_one])
            [
                for(p = sh_pts) 
                let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                    rotate_p(
                        rotate_p(scaled_p, twist_step * i)
                        , angles[i]
                    ) + pth_pts[i]
            ]
    ];

    
/**
* polysections.scad
*
* Crosscutting a tube-like shape at different points gets several cross-sections.
* This module can operate reversely. It uses cross-sections to construct a tube-like shape.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polysections.html
*
**/

module polysections(sections, triangles = "SOLID") {
    function side_indexes(sects, begin_idx = 0) = 
        let(       
            leng_sects = len(sects),
            leng_pts_sect = len(sects[0])
        ) 
        [
            for(j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect])
                for(i = [0:leng_pts_sect - 1]) 
                    [
                        j + i, 
                        j + (i + 1) % leng_pts_sect, 
                        j + (i + 1) % leng_pts_sect + leng_pts_sect , 
                        j + i + leng_pts_sect
                    ]
        ];

    module solid_sections(sects) {
        leng_pts_sect = len(sects[0]);

        first_idxes = [for(i = [0:leng_pts_sect - 1]) i];   
        last_idxes = [
            for(i = [0:leng_pts_sect - 1]) 
                i + leng_pts_sect * (len(sects) - 1)
        ];    
        
        v_pts = [
            for(sect = sects) 
                for(pt = sect) 
                    pt
        ];
        
       polyhedron(
           v_pts, 
           concat([first_idxes], side_indexes(sects), [last_idxes])
       );    
    }

    module hollow_sections(sects) {
        leng_sects = len(sects);
        leng_sect = len(sects[0]);
        half_leng_sect = leng_sect / 2;
        half_leng_v_pts = leng_sects * half_leng_sect;

        function strip_sects(begin_idx, end_idx) = 
            [
                for(i = [0:leng_sects - 1]) 
                    [
                        for(j = [begin_idx:end_idx])
                            sects[i][j]
                    ]
            ]; 

        function end_idxes(begin_idx) = 
            [
                for(i =  [0:half_leng_sect - 1]) 
                    [
                        begin_idx + i, 
                        begin_idx + (i + 1) % half_leng_sect, 
                        begin_idx + (i + 1) % half_leng_sect + half_leng_v_pts, 
                        begin_idx + i + half_leng_v_pts
                    ]
            ];

        outer_sects = strip_sects(0, half_leng_sect - 1);
        inner_sects = strip_sects(half_leng_sect, leng_sect - 1);

        function to_v_pts(sects) = 
             [
                for(sect = sects) 
                    for(pt = sect) 
                        pt
             ];

        outer_v_pts =  to_v_pts(outer_sects);
        inner_v_pts = to_v_pts(inner_sects);

        outer_idxes = side_indexes(outer_sects);
        inner_idxes = side_indexes(inner_sects, half_leng_v_pts);
        first_idxes = end_idxes(0);
        last_idxes = end_idxes(half_leng_v_pts - half_leng_sect);

        polyhedron(
              concat(outer_v_pts, inner_v_pts),
              concat(first_idxes, outer_idxes, inner_idxes, last_idxes)
        ); 
    }
    
    module triangles_defined_sections() {
        module tri_sections(tri1, tri2) {
            polyhedron(
                points = concat(tri1, tri2),
                faces = [
                    [0, 1, 2], 
                    [3, 4, 5], 
                    [0, 1, 4], [1, 2, 5], [2, 0, 3], 
                    [0, 3, 4], [1, 4, 5], [2, 5, 3]
                ]
            );  
        }

        module two_sections(section1, section2) {
            for(idx = triangles) {
                // hull is for preventing from WARNING: Object may not be a valid 2-manifold
                hull() tri_sections(
                    [
                        section1[idx[0]], 
                        section1[idx[1]], 
                        section1[idx[2]]
                    ], 
                    [
                        section2[idx[0]], 
                        section2[idx[1]], 
                        section2[idx[2]]
                    ]
                );
            }
        }
        
        for(i = [0:len(sections) - 2]) {
             two_sections(
                 sections[i], 
                 sections[i + 1]
             );
        }
    }
    
    if(triangles == "SOLID") {
        solid_sections(sections);
    } else if(triangles == "HOLLOW") {
        hollow_sections(sections);
    }
    else {
        triangles_defined_sections();
    }
}

/**
* golden_spiral_extrude.scad
*
* Extrudes a 2D shape along the path of a golden spiral.
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-golden_spiral_extrude.html
*
**/

module golden_spiral_extrude(shape_pts, from, to, point_distance, 
                             rt_dir = "CT_CLK", twist = 0, scale = 1.0, triangles = "SOLID") {

    pts_angles = golden_spiral(
        from = from, 
        to = to, 
        point_distance = point_distance,
        rt_dir = rt_dir
    );

    pts = [for(pt_angle = pts_angles) pt_angle[0]];
    angles = [
        for(pt_angle = pts_angles) 
            [90, 0, pt_angle[1] + (rt_dir == "CT_CLK" ? 0 : 90)]
    ];

    polysections(
        cross_sections(
            shape_pts, 
            pts, angles, 
            twist = twist, 
            scale = scale
        ),
        triangles = triangles
    );
}

/**
* bezier_curve.scad
*
* Given a set of control points, the bezier_curve function returns points of the Bézier path. 
* Combined with the polyline, polyline3d or hull_polyline3d module defined in my lib-openscad, 
* you can create a Bézier curve.
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
    concat([
        for(t = [0: t_step: 1]) 
            _bezier_curve_point(t, points)
    ], [_bezier_curve_point(1, points)]);
    
/**
* bezier_surface.scad
*
* Given a set of control points, the bezier_surface function returns points of the Bézier surface. 
* Combined with the function_grapher module defined in my lib-openscad, 
* you can create a Bézier surface.
*
* It depends on the bezier_curve function so remember to include bezier_curve.scad.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier_surface.html
*
**/ 

function bezier_surface(t_step, ctrl_pts) =
    let(pts =  [
        for(i = [0:len(ctrl_pts) - 1]) 
            bezier_curve(t_step, ctrl_pts[i])
    ]) 
    [for(x = [0:len(pts[0]) - 1]) 
        bezier_curve(t_step,  
                [for(y = [0:len(pts) - 1]) pts[y][x]]
        ) 
    ];
    
/**
* function_grapher.scad
*
* 
* Given a set of points `[x, y, f(x, y)]` where `f(x, y)` is a 
* mathematics function, the `function_grapher` module can 
* create the graph of `f(x, y)`.
* It depends on the line3d and polyline3d modules so you have 
* to include "line3d.scad" and "polyline3d.scad".
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-function_grapher.html
*
**/ 

module function_grapher(points, thickness, style = "FACES", slicing = "SLASH") {
    // Increasing $fn will be slow when you use "LINES" or "HULL_FACES".
     
    function tri_shell_points(top) =
        let(
            z_offset = [0, 0, -thickness],
            bottom = [
                top[0] + z_offset, 
                top[1] + z_offset, 
                top[2] + z_offset
            ],
            faces = [
                [0, 1, 2],
                [3, 4, 5],
                [0, 1, 4, 3],
                [1, 2, 5, 4],
                [2, 0, 3, 5]
            ]
        )
        [
            concat(top, bottom), 
            faces
        ];
        
        
    module tri_to_faces(top_tri1, top_tri2) {
        pts_faces1 = tri_shell_points(top_tri1);
        pts_faces2 = tri_shell_points(top_tri2);
        
        // hull is for preventing from WARNING: Object may not be a valid 2-manifold
        hull() polyhedron(
                points = pts_faces1[0], 
                faces = pts_faces1[1]
            );

        hull() polyhedron(
                points = pts_faces2[0],
                faces = pts_faces2[1]
            );
    }

    module tri_to_lines(tri1, tri2) {
       polyline3d(concat(tri1, [tri1[0]]), thickness);
       polyline3d(concat(tri2, [tri2[0]]), thickness);
    }
    
    module hull_pts(tri) {
       half_thickness = thickness / 2;
       hull() {
           translate(tri[0]) sphere(half_thickness);
           translate(tri[1]) sphere(half_thickness);
           translate(tri[2]) sphere(half_thickness);
       }    
    }
    
    module tri_to_hull_faces(tri1, tri2) {
       hull_pts(tri1);
       hull_pts(tri2);
    }    

    module tri_to_graph(tri1, tri2) {
        if(style == "FACES") {
            tri_to_faces(tri1, tri2);
        } else if(style == "LINES") {
            tri_to_lines(tri1, tri2);
        } else {  // Warning: May be very slow!!
            tri_to_hull_faces(tri1, tri2);
        }
    }

    for(yi = [0:len(points) - 2]) {
        for(xi = [0:len(points[yi]) - 2]) {
            if(slicing == "SLASH") {
                tri_to_graph([
                    points[yi][xi], 
                    points[yi][xi + 1], 
                    points[yi + 1][xi + 1]
                ], [
                    points[yi][xi], 
                    points[yi + 1][xi + 1], 
                    points[yi + 1][xi]
                ]);
            } else {                
                tri_to_graph([
                    points[yi][xi], 
                    points[yi][xi + 1], 
                    points[yi + 1][xi]
                ], [
                    points[yi + 1][xi], 
                    points[yi][xi + 1], 
                    points[yi + 1][xi + 1]
                ]);                    
            }        
        }
    }
}

module golden_taiwan(
            taiwan_fineness, 
            wave_fineness, model_type) {
    
    module taiwan() {
        mirror_taiwan = [for(pt = shape_taiwan(15)) [pt[0] * -1, pt[1]]];

        translate([127.5, 42.5, 83]) golden_spiral_extrude(
            mirror_taiwan, 
            from = 1,  
            to = 10, 
            point_distance = taiwan_fineness,
            scale = 10
        );    
    }

    module wave() {
        t_step = wave_fineness;
        thickness = 100;

        ctrl_pts = [
            [[0, 0, 20],  [60, 0, -35],   [90, 0, 60],    [200, 0, 5]],
            [[0, 50, 30], [100, 60, -25], [120, 50, 120], [200, 50, 5]],
            [[0, 100, 0], [60, 120, 35],  [90, 100, 60],  [200, 100, 45]],
            [[0, 123, 0], [60, 123, -35], [90, 123, 60],  [200, 123, 45]]
        ];

        g = bezier_surface(t_step, ctrl_pts);

        difference() {
            function_grapher(g, thickness);
            translate([-1, -1, -120]) cube([220, 130, 110]);
        }    
    }

    if(model_type == "Both" || model_type == "Taiwan") {
        taiwan();
    }
    if(model_type == "Both" || model_type == "Wave") {
        wave();
    }
}

golden_taiwan(
   taiwan_fineness, 
   wave_fineness, 
   model_type
);