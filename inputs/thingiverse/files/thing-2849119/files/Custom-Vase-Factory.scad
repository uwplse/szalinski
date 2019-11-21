/*
    Custom Vase Factory
    This is an extension of Ferjerez's "Rippled Vase Factory"
    https://www.thingiverse.com/thing:2537095

    Vase-wave generator/customizer
    
    Fernando Jerez 2017
    updated Sentamugo7 2018
    
    License: CC-NC (Non commercial)


*/
/* [Shape] */
// Use 'preview' for fast render
part = "preview"; // [preview:Low poly (fast render), print: High detail (slow render)]

// Style / Shape
shape = "barrel"; // [barrel: Penholder/Barrel, vase1:Vase, vase2:Vase 2, glass: Glass, bowl:Bowl, cup: Cup, cone: Cone, custom:Custom ]

// Custom shape for A+B*pow(sin(z*C+D),E)
custom_shape_A = 0.6; // [0:0.1:1]
custom_shape_B = 0.4; // [0:0.1:1]
custom_shape_C = 1.0; // [0:0.1:5]
custom_shape_D = 60; // [0:180]
custom_shape_E = 2.0; // [0:1:6]

// Dimensions 
height = 180; // [10:500]

bottom_radius = 60; // [40:100]
bottom_polygon = 0; // [0:Circle,1:Koch Snowflake,3:Triangle,4:Square,6:Hexagon,8:Octagon]
draw_bottom = "yes"; // [yes,no]

top_radius = 60; // [20:120]
top_polygon = 0; // [0:Circle,1:Koch Snowflake,3:Triangle,4:Square,6:Hexagon,8:Octagon]
draw_top = "yes"; // [yes,no]

/* [Decoration] */
decoration = "ripple"; // [none: None, bulge: Bulge, ripple: Ripple, line: Line, triangle: Triangle]
// Number of decorations
decorations  = 6; // [0:15]

// maximum of how "deep" the decoration goes beyond the base shape 
decoration_depth = 20; // [-30:30]

// start angle of the (vertical) decoration wave
decoration_start_angle = 0; // [0:180]
// end angle of the (vertical) decoration wave
decoration_end_angle = 180; // [0:180]

// Twisting factor (vertically)
twist = 0.5; // [-1:0.05:1]

// Waving of the decoration itself
wave = 10.0; // [-30:1:30]

/* [Voronoi] */
voronoi = "no"; // [no,yes]
voronoi_size = 4; // [2:4]
voronoi_radius = 1.5; // [0.5:0.5:4.0]
// seed random, 0 = unrepeatable, -1 = no random
random_seed = 1; // [-1:10]
voronoi_fn = 6; // [0:20]
/* [Hidden] */
ripple_width = (decorations == 0) ? 0 : 100/decorations;

altura = 180; // z-steps
is_voronoi = (voronoi == "yes");
step = (is_voronoi) ? (5 * voronoi_size) : (part=="preview") ? 10 : 1; // resolution in Z (1 is the best and slower)

base_twist = is_voronoi ? -0.7 : 0.0;

sides = 360; // Don't touch!

line_angle_width = 4;
line_angle = round(sides / decorations);
triangle_factor = 5;

shape_parms_const = [
    ["barrel",[1.0,0.0,1.0,0,1]],
    ["vase1",[0.7,0.4,2.0,0,1]],
    ["vase2",[0.6,0.4,1.0,60,2]],
    ["vase3",[0.6,0.4,0.7,-30,2]],
    ["glass",[0.6,0.4,0.7,-30,2]],
    ["cup",[0.65,0.4,2.0,90,1]],
    ["bowl",[0.6,0.4,0.5,0,1]],
    ["cone",[0.0,1.0,0.5,90,1]],
    ["custom",[custom_shape_A,custom_shape_B,custom_shape_C,custom_shape_D,custom_shape_E]]
];


VORONOI_MIN_RADIUS = 4;
VORONOI_RANDOM_DELTA = 0.4;
VORONOI_RANDOM_PERCISION = 1000;
VORONOI_RANDOM_PERCISION_DIVISOR = 1.0 / VORONOI_RANDOM_PERCISION;
VORONOI_RANDOM_AMOUNT = round(VORONOI_RANDOM_DELTA*1000);

///// koch snowflake, derived from hakalan

KOCH_SNOWFLAKE_SHAPE = 1;
koch_count = 192 / (is_voronoi ? 4 * voronoi_size : 1);
sides_koch = koch_count;

koch_angle = 60;
koch_start = [0,-60];
koch_step = 4;
koch_basis = 60;
koch_untwist = 48;

function vector_step(self, delta, a) =
    [self[0] + delta[0]*cos(a) - delta[1]*sin(a),
     self[1] + delta[1]*cos(a) + delta[0]*sin(a)
    ]
;

function turtle_step(turtle_array,turnstep,index,d,p) = 
    let (
        new_turtle_array = concat(turtle_array,[p]),
        next_step = (index + 1 == len(turnstep)) ? new_turtle_array :
            turtle_step(new_turtle_array,turnstep,index+1,d+turnstep[index][0],vector_step(p, [koch_step,0], d+turnstep[index][0]))
    )
    next_step
;

function turtle(turnstep) = 
    // Generate points from list of [turn,step].
    turtle_step([],turnstep,0,0,koch_start)
;

function kochify_step(kochify_array,turnstep,index) =
    let (
        new_kochify_array = concat(kochify_array,[turnstep[index],[-koch_angle,koch_step],[2.*koch_angle,koch_step],[-koch_angle,koch_step]]),
        next_step = (index + 1 == len(turnstep)) ? new_kochify_array :
            kochify_step(new_kochify_array,turnstep,index + 1)
    )
    next_step
;

function kochify(turnstep) =
    kochify_step([],turnstep,0)
;
    
function koch_twisted() =
    let (
        k = [[koch_angle,koch_step],
             [2*koch_angle,koch_step],
             [2*koch_angle,koch_step]],
        poly = turtle(kochify(kochify(kochify(k))))
    )
    poly
;
function koch() =
    let (
        koch_twisted_shape = koch_twisted()
    )
[
    for(index = [0:koch_count - 1])
        [koch_twisted_shape[(koch_untwist+index) % koch_count]][0]
]
;
///// end koch snowflake

// get random values for voronoi for sides, top and bottom (may be unused)
// 2 values for each point
bottom_step_count = ceil((bottom_radius-VORONOI_MIN_RADIUS)/step) * (sides_koch);
top_step_count = ceil((top_radius-VORONOI_MIN_RADIUS)/step) * (sides_koch);
random_count = ceil((altura/step) * (sides_koch-1));
total_random_count = 2*random_count + 2*bottom_step_count + 2*top_step_count;
random_values = (random_seed == -1) ? [for (i = [0:total_random_count]) 0] : (random_seed == 0) ? rands(-VORONOI_RANDOM_AMOUNT,+VORONOI_RANDOM_AMOUNT,total_random_count) : rands(-VORONOI_RANDOM_AMOUNT,+VORONOI_RANDOM_AMOUNT,total_random_count,random_seed);

function getRadius(z, angle) = 
    let (
        lower_radius = (bottom_polygon <= 1) ? bottom_radius : bottom_radius * cos(180/bottom_polygon) / cos(((angle) % (360/bottom_polygon)) - (180/bottom_polygon)),
        upper_radius = (top_polygon <= 1) ? top_radius : top_radius * cos(180/top_polygon) / cos(((angle) % (360/top_polygon)) - (180/top_polygon)),
        shape_radius     = (lower_radius + (z / altura) * (upper_radius - lower_radius)), 
        // radius with decoration applied
        decoration_angle = decoration_start_angle + (z / altura) * (decoration_end_angle - decoration_start_angle),
        line_angle_delta = min((angle % line_angle),(line_angle - angle % line_angle)),
        rad2  = sin(decoration_angle) * (
             (decoration == "none" || decorations == 0) ? 0 :
             (decoration == "line" && line_angle_delta > line_angle_width / 2) ? 0 :
             (decoration == "triangle") ? max(0,(triangle_factor - line_angle_delta) / triangle_factor) * decoration_depth :
              decoration_depth
        )
    )
    shape_radius + rad2*(cos(angle*decorations))
;

module joint(a, r) { 
    translate(a) sphere(r=r, $fn=voronoi_fn);
}

module rod(a, b, r) { 
    s1=b[0]>a[0]?b:a;
    s2=b[0]>a[0]?a:b;
    c=s1-s2;
    distance = norm(c);
    angle_z = atan(c[1]/c[0]);
    angle_y = acos(c[2]/distance);
    translate(s2+c/2) 
    rotate([0,angle_y,angle_z])
    cylinder(r=r, h=distance, $fn=voronoi_fn, center=true);
}

// top and bottom
module draw_voronoi_end(radius, end, random_values_1, random_values_2) {
    end_step_count = floor((radius-VORONOI_MIN_RADIUS)/step);
    // get points for end by copying end points inward by decreasing radius
    puntos_end =
        concat(
            [for(pct = [radius:-step:VORONOI_MIN_RADIUS]) // radial percent
                let (
                   pct_loop = -round((pct-radius)/step)
                )
                for(s = [0:sides_koch-1]) // angle
                    let (
                       end_radial_factor = pct/radius,
                       end_random_1 = (pct == radius) ? 0 : step * random_values_1[pct_loop*sides_koch+s] * VORONOI_RANDOM_PERCISION_DIVISOR,
                       end_random_2 = (pct == radius) ? 0 : step * random_values_2[pct_loop*sides_koch+s] * VORONOI_RANDOM_PERCISION_DIVISOR,
                       end_x = end[s][0]*end_radial_factor,
                       end_y = end[s][1]*end_radial_factor,
                       end_z = end[s][2]
                    )
                    [end_x + end_random_1, end_y + end_random_2, end_z]
            ],
            [[0,0,end[0][2]]] // center
        );
    puntos_count_end = len(puntos_end);
    for(r = [0:end_step_count]) {
        for(s = [0:sides_koch-1]) {
            f1 = s + sides_koch*r;
            f2 = (r == end_step_count) ? puntos_count_end - 1 : s + sides_koch*(r+1);
            f3 = (r == end_step_count) ? puntos_count_end - 1 : ((s+1) % sides_koch) + sides_koch*(r+1);
            f4 = ((s+1) % sides_koch) + sides_koch*r;
            joint(puntos_end[f1],voronoi_radius);
            for (index2 = [f2,f3,f4]) {
                joint(puntos_end[index2],voronoi_radius);
                rod(puntos_end[f1],puntos_end[index2],voronoi_radius);
            }
        }
    }
}
module draw_voronoi(puntos) {
    if (draw_bottom == "yes") {
        puntos_end_outer = [for (i = [0:sides_koch-1]) puntos[i]];
        random_1 = [for (i = [2*random_count:2*random_count + bottom_step_count]) random_values[i]];
        random_2 = [for (i = [2*random_count + bottom_step_count:2*random_count + 2*bottom_step_count]) random_values[i]];
        draw_voronoi_end(bottom_radius, puntos_end_outer, random_1, random_2);
    };
    if (draw_top == "yes") {
        puntos_end_outer = [for (i = [0:sides_koch-1]) puntos[(altura/step)*(sides_koch) + i]];
        random_1 = [for (i = [2*random_count + 2*bottom_step_count:2*random_count + 2*bottom_step_count + top_step_count]) random_values[i]];
        random_2 = [for (i = [2*random_count + 2*bottom_step_count + top_step_count:2*random_count + 2*bottom_step_count + 2*top_step_count]) random_values[i]];
        draw_voronoi_end(top_radius, puntos_end_outer, random_1, random_2);
    };
    z_top = altura / step;
    union() {
        for(z = [0:(altura-1) / step]) {
            for(s = [0:sides_koch-1]) {
                // clockwise from left-down corner
                f1 = s + sides_koch*z;
                f2 = s + sides_koch*(z+1);
                f3 = ((s+1) % sides_koch) + sides_koch*(z+1);
                f4 = ((s+1) % sides_koch) + sides_koch*z;
                joint(puntos[f1],voronoi_radius);
                for (index2 = [f2,f3,f4]) {
                    joint(puntos[index2],voronoi_radius);
                    rod(puntos[f1],puntos[index2],voronoi_radius);
                }
            }
        }
        for(s = [0:sides_koch-1]) {
            f1_ = s + sides_koch*z_top;
            f4_ = ((s+1) % sides_koch) + sides_koch*z_top;
            rod(puntos[f1_],puntos[f4_],voronoi_radius);
        }
    }
}
// get the shape parms for the selected shape
shape_index = search([shape],shape_parms_const)[0];
shape_parms = shape_parms_const[shape_index][1];

koch_shape = koch();
// Calculate....
//points...

puntos = [
    for(z_loop = [0:step:altura])
        for(i_koch = [0:sides_koch-1])
            let(
                rand_z_factor = (is_voronoi && z_loop > 0 && z_loop < altura) ? VORONOI_RANDOM_PERCISION_DIVISOR * random_values[z_loop/step+i_koch] : 0,
                rand_angle_factor = (is_voronoi && z_loop > 0 && z_loop < altura) ? VORONOI_RANDOM_PERCISION_DIVISOR * random_values[random_count+z_loop/step+i_koch] : 0,
                z = z_loop + step*rand_z_factor,
                rot2  = (twist + base_twist)*z + wave*sin(z*2),
                zrad  = shape_parms[0] + shape_parms[1]*pow(sin(z*shape_parms[2]+shape_parms[3]),shape_parms[4]),
                i = (i_koch + rand_angle_factor) * sides / sides_koch,
                // ripple angle adjustment
                giro  = (decoration == "ripple") ? ripple_width * sin(z) * sin(i*decorations*2) : 0.0,
                // actual angle to use
                calc_angle = i+giro+rot2,
                koch_factor = (bottom_polygon == KOCH_SNOWFLAKE_SHAPE && top_polygon == KOCH_SNOWFLAKE_SHAPE) ? 1 :
                     (bottom_polygon == KOCH_SNOWFLAKE_SHAPE) ? (1 - (z / altura)) :
                     (top_polygon == KOCH_SNOWFLAKE_SHAPE) ? (z / altura) :
                     0,
                other_factor = 1 - koch_factor,
                radius = zrad * getRadius(z, i),

                // calculate x,y
                px = koch_factor * koch_shape[i_koch][0] * radius / koch_basis + other_factor * radius*cos(calc_angle),
                py = koch_factor * koch_shape[i_koch][1] * radius / koch_basis + other_factor * radius*sin(calc_angle)
            )
            [px,py,z * height / altura]
];

// faces...  
caras = is_voronoi ? undef : concat(
    [
    // Triangle #1
    for(z = [0:(altura-1) / step])
        for(s = [0:sides_koch-1])
            let(
                // clockwise from left-down corner
                f1 = s + sides_koch*z,
                f2 = s + sides_koch*(z+1),
                f3 = ((s+1) % sides_koch) + sides_koch*(z+1),
                f4 = ((s+1) % sides_koch) + sides_koch*z
            )
        
            [f1,f2,f3]
 
    ],
    [
    // Triangle #2
    for(z = [0:(altura-1) / step])
        for(s = [0:sides_koch-1])
            let(
                // clockwise from left-down corner
                f1 = s + sides_koch*z,
                f2 = s + sides_koch*(z+1),
                f3 = ((s+1) % sides_koch) + sides_koch*(z+1),
                f4 = ((s+1) % sides_koch) + sides_koch*z
            )
        
            [f3,f4,f1]
 
    ],
    (draw_bottom == "yes") ? [[ for(s = [0:sides_koch-1]) s]] : [],  //bottom
    (draw_top == "yes") ? [[ for(s = [sides_koch-1:-1:0]) (altura/step)*(sides_koch) + s]] : [] //top
        
 );
 // Draws vase
if (is_voronoi) {
    draw_voronoi(puntos);
} else {
    zscale = (shape=="bowl")?0.5:1;
    scale([1,1,zscale]) polyhedron (points=puntos,faces = caras);
}
