/* [Presets] */

// Bearing preset
bp = "R188"; // [None, 608zz, R

// Weight preset
wp = "M8"; // [None:None, M8:8mm nut, M5:5mm nut, 608:608 bearing]

/* [Body parameters] */

// Ray count
c = 3; 

// Ray length
l1 = 30; 

// Cut length
l2 = 0; 

// Height
h = 7; 

// Fillet radius
f = h/2; 

// Tolerance
u = 0.2; 

// Weight ray d
d = 25; 

// Bearing dia
bd = 13;

// Weight hole dia
wd = 14.9;

// Faces of weight hole
wf = 6; 

/* [Handle parameters] */

// Internal bearing dia
ibd = 6; 

// Internal bearing ring thickness
ibt = 0.8; 

// External bearing ring thickness
ebt = 1.2;

// Bearing handle thickness
bht = 1.2; 

// Bearing handle height
bhh = 0.4;

// Bearing height
bh = 5; 

// Bearing handle dia
bhd = 25; 

/* [Part and Quality] */

// Parts
part = "a"; // [a:All parts, tc:Top cap, bc:Bottom cap, bd:Spinner body, c:Caps, demo:Demo]

$fa = 1; 
$fs = 0.25;


function compute_steps(r, a) = 
    $fn > 0 ? ($fn >= 3 ? $fn : 3) : ceil(max(min(a/$fa, r*(PI/180)*a / $fs), 5));
  
function arc(s, e, n = 0, d = 0, r = 0, p = [0,0], c = true) = 
let(
    er = r > 0 ? r : d > 0 ? d/2 : 1, 
    en = n > 0 ? n : compute_steps(er, abs(e - s))
) [ 
    for (i = [0:en - (c ? 0 : 1)]) 
        let (a = s + i * (e - s) / en) 
            [cos(a), sin(a)] * er + p 
];
    
function unit(v) = v / norm(v);
function offset_line(l, off) = let(v = l[1] - l[0], ov = unit([v[1], -v[0]]) * off) [ l[0] + ov, l[1] + ov ];

function line_intersection(lines) = let(
    l1 = lines[0], 
    l2 = lines[1], 
    v1 = l1[0] - l1[1],
    v2 = l2[0] - l2[1],
    q1 = l1[0].x*l1[1].y - l1[0].y*l1[1].x,
    q2 = l2[0].x*l2[1].y - l2[0].y*l2[1].x,
    d = v1.x*v2.y - v1.y*v2.x
) abs(d) < 0.0001 ? undef : [ 
(q1*v2.x - v1.x*q2) / d, 
(q1*v2.y - v1.y*q2) / d
];

function offset_poly(poly, off) = let(n = len(poly)) [ for (i = [0:n-1]) let(
    p1 = poly[i > 0 ? i - 1 : n - 1],
    p2 = poly[i],
    p3 = poly[(i + 1) % n],
    l1 = offset_line([p1, p2], off),
    l2 = offset_line([p2, p3], off),
    pi = line_intersection([l1, l2]),
    pt = pi == undef ? l1[1] : pi
) pt ];

function to_3d(points, z = 0) = [ for (p = points) [p[0], p[1], z] ];

function fillet_profiles(p, f, h, n = 0) = let(mef = h/2, ef = min(mef, f), en = n > 0 ? n : compute_steps(f, 90))  
    concat(
        [ for (i = [0:en - (f >= mef ? 1 : 0)]) let(a = i * (90/en)) to_3d(offset_poly(p, (sin(a) - 1)*ef), (1 - cos(a))*ef)  ],
        [ for (i = [0:en]) let(a = i * (90/en)) to_3d(offset_poly(p, (cos(a) - 1)*ef), sin(a)*ef + (h - ef)) ]
    );

function pp(k, p, def = undef) = let(r = search([k], p)[0]) r == [] ? def : p[r][1];


module skin(profiles) {
    
    n = len(profiles);
    c = len(profiles[0]);
    
    points = [ for (prof = profiles) for (p = prof) p ];
    faces = concat(
        [[ for (i = [0:c - 1]) i ]],
        [ for (i = [0:n-2], j = [0:c-1]) [i*c+j, (i+1)*c+j, (i+1)*c+(j+1)%c/*, i*c+(j+1)%c*/] ],
        [ for (i = [0:n-2], j = [0:c-1]) [i*c+j, (i+1)*c+(j+1)%c, i*c+(j+1)%c ] ],
        [[ for (i = [0:c-1]) n*c-i-1 ]]
    );

    polyhedron(points, faces);
    
}

p_bp = [
    ["608zz", [
        ["bd", 22.2],
        ["ibd", 8],
        ["ibt", 1.5],
        ["ebt", 1.5],
        ["bh", 7]
    ]],
    ["R188", [
        ["bd", 13],
        ["ibd", 6.3],
        ["ibt", 0.96],
        ["ebt", 0.96],
        ["bh", 4.75]
    ]],
];

p_wp = [
    ["M8", [
        ["h", 7],
        ["d", 25],
        ["wd", 15],
        ["wf", 6]
    ]],
    ["M5", [
        ["h", 5],
        ["d", 15],
        ["wd", 9],
        ["wf", 6]
    ]],
    ["608", [
        ["h", 7],
        ["d", 30],
        ["wd", 22.2],
        ["wf", 64]
    ]],
];


p = concat(pp(bp, p_bp, []), pp(wp, p_wp, []), [
    ["c", c],
    ["d", d],
    ["l1", l1],
    ["l2", l2],
    ["h", h],
    ["f", f],
    ["bd", bd],
    ["wd", wd],
    ["wf", wf],
    ["ibd", ibd],
    ["bh", bh],
    ["bhd", bhd],
    ["ibt", ibt],
    ["bht", bht],
    ["bhh", bhh],
    ["u", u],
]);


module body(p) {
 
    c = pp("c", p);
    d = pp("d", p);
    l1 = pp("l1", p);
    l2_inp = pp("l2", p);
    h = pp("h", p);
    f = pp("f", p);
    bd = pp("bd", p);
    wd = pp("wd", p);
    wf = pp("wf", p);
    u = pp("u", p);
    bh = pp("bh", p);

    a = 360/c;
    r1 = d/2;

    k = bd/2 + h/2 - r1;
    l2_min = (l1*l1 - k*k) / (2*(cos(a/2)*l1 - k));
    
    // sqrt(x*x + x*x - 2*x*x*cos(a)) - 2*(sqrt(x*x + l*l - 2*x*l*cos(a/2)) - r1) = h
    // sqrt(2*x*x + 2*x*x*cos(a)) - 2*r2 = h
    // sqrt(2*x*x*(1 - cos(a))) - 2*r2 = h
    // sqrt(2*x*x*(1 - cos(a))) - 2*(sqrt(x*x + l*l - 2*x*l*cos(a/2)) - r1) = h
    // sqrt(2*x*x*(1 - cos(a))) - 2*sqrt(x*x + l*l - 2*x*l*cos(a/2)) + 2*r1 = h
    // sqrt(2*x*x*(1 - cos(a))) - 2*sqrt(x*x + l*l - 2*x*l*cos(a/2)) = h - 2*r

    l2 = max(l2_inp, l2_min);
    r2 = sqrt(l2*l2 + l1*l1 - 2*l2*l1*cos(a/2)) - r1;
    
    b = asin((l2 * sin(a/2)) / (r1 + r2));

    arcs = concat(
        arc(r = r1, -180+b, 180-b, p = [1,0] * l1, c = false),
        arc(r = r2, -b, a + b - 360, p = [cos(a/2),sin(a/2)] * l2, c = false)
    );

    shape = [ 
        for (i = [0:c-1]) 
            let(rot = i*a, c = cos(rot), s = sin(rot)) 
                for (p = arcs) 
                    [ p[0] * c - p[1] * s, p[0] * s + p[1] * c ] 
    ];

    profiles = fillet_profiles(shape, f, h);
    difference() {
        skin(profiles);
        
        if (bh < h) {
            hbh = (h - bh) / 2;
            translate([0,0,hbh])
                cylinder(d = bd, h = h - hbh + u);
            translate([0,0,-u])
                cylinder(d = bd - ebt, h = hbh + u*2);
        } else {
            translate([0,0,-u])
                cylinder(d = bd, h = h + u * 2);
        }
        
        for (i = [0:c-1])
            rotate([0,0,i*360/c])
                translate([l1, 0, -u])
                    linear_extrude(h + u * 2)
                        polygon(arc(d = wd, 0, 360, c = false, n = wf));
    }
}

module cap_lock(ibd) {
    difference() {
        circle(d = ibd);
    
        translate([ibd * 3 / 4 - ibd / 2, -ibd/2-1])
            square([ibd, ibd + 2]);
    }
}

module top_cap(p) {
    
    h = pp("h", p);
    ibd = pp("ibd", p);
    bh = pp("bh", p);
    bhd = pp("bhd", p);
    ibt = pp("ibt", p);
    bht = pp("bht", p);
    bhh = pp("bhh", p);
    u = pp("u", p);

    hbh = (h - bh) / 2;
    
    translate([0,0,h-hbh]) {
        difference() {
            union() {
                cylinder(d = ibd + ibt*2, h = bhh+hbh + u);
                translate([0,0,bhh+hbh])
                    cylinder(d = bhd, h = bht);
            }

            translate([0,0,-u])
            linear_extrude(bht + bhh + hbh + u*2)
                offset(u)
                    cap_lock(ibd);
        }
    }
}

module bottom_cap(p) {
    
    h = pp("h", p);
    ibd = pp("ibd", p);
    bh = pp("bh", p);
    bhd = pp("bhd", p);
    ibt = pp("ibt", p);
    bht = pp("bht", p);
    bhh = pp("bhh", p);
    u = pp("u", p);
    hbh = (h - bh) / 2;

    cylinder(d = ibd, h = h - hbh);
    translate([0,0,h - hbh])
    linear_extrude(bhh + bht + hbh)
        cap_lock(ibd);
    
    translate([0,0,-bhh - bht])
        cylinder(d = bhd, h = bht);
    
    translate([0,0,-bhh - u])
        cylinder(d = ibd + ibt*2, h = bhh + hbh + u);

}


module all_parts(p) {
    top_cap(p);
    body(p);
    bottom_cap(p);
}

*translate([0,0,(pp("h", p) - pp("bh", p)) / 2])
cylinder(d = bd, h = pp("bh", p));


if (part == "tc") {
    rotate([180,0,0])
        top_cap(p);
} else if (part == "bc") {
    bottom_cap(p);
} else if (part == "bd") {
    body(p);
} else if (part == "c") {
    top_cap(p);
    bottom_cap(p);
} else if (part == "demo") {

    rotate($t * 360)
    body(p);

} else {
    all_parts(p);
}
