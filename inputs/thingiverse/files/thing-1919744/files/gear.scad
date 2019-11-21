/*
Copyright (c) 2016 Cem Kalyoncu
modification for hexagonal heat Mathieu Maura

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/



// Number of teeth on the gear
teeth = 16;

// Metric size of the gear. To find this value for a gear that you know the
// diameter of, simply divide the diameter to the (numberofteeth+2). Meshing gears
// should have same mod. in mm.
mod = 2;

// Thickness of the gear. You may want to change the reinforce thickness if you change
// this setting. in mm.
thickness = 5;



/* [Additional] */

//Maximum distance between two curve segments. Controls the quality. in mm.
details = 0.5; //[0.25:2]

// Skips the teeth after the given amount
skip_after = 0;



/* [Inner section] */

// Enables the innersection
enable_inner_section = 1; //[1:Yes,0:No]

// The distance of the inner section from the inner radius of the teeth. This value
// can be used even if the inner section is disabled. in mm.
inner_section = 3;

// Thickness of the inner section of the gear. Currently this should be less than 
// gear thickness. in mm. 
inner_thickness = 4;


/* [Mounting hole] */

//Radius in mm.
hole = 3;

// The number of dents on a semi circular hole, 0 for o shaped hole
// 1 for D shaped and 2 for Û shaped hole
hole_shape = 0; //[0:o shape,1:D shape,2:0 shape]

// For semi circular hole, similar to the one on step motors. This is the diameter of 
// the minor axis. in mm
minor_hole_radius = 5.5;

// If set, hole would be open on both ends
auto_hole_height = 0; //[1:Yes,0:No]

// Thickness of the hole. Only used if not set to automatic. in mm
hole_height = 6;

// Generate a screw hole, if set to yes, you should change hole height and disable
// auto hole height.
generate_screw_hole = 1; //[1:Yes,0:No]

// Generate a hexagonal head ?
generate_screw_hexagonal = 1; //[1:Yes,0:No]

// Radius of the body of the screw. in mm.
screw_hole_radius = 3;

// Thickness of the support that is under the screw. Thicker support
// means stronger connection but will shorten the length of the screw. in mm
screw_support = 0;

//Radius of the screw head. in mm.
screw_head = 5;


/* [Reinforced sections] */

// The width of reinforced sections. The area around the hole is reinforced. If the gear
// is semi gear (skip after is set), the region around the cut is also reinforced, creating
// a uniform look. in mm.
reinforce = 8;

// The thickness of the reinforced shaft. in mm.
reinforce_thickness = 8;


/* [Spacer] */
spacer_style = 3; //[0:none,1:polar,2:circles,3:linear,4:polar ovals]

//Number of spacers, this value will be ignored for none and circles.
spacers = 8; //[2:8]

//The ratio of provided angular spacing, spacing ratios are not precise. in percentage.
angular_spacing = 75; //[0:100]

//The ratio of radial spacing provided, spacing ratios are not precise. in percentage.
radial_spacing = 75; //[0:100]

//Radial shift of spacers. in mm.
spacing_radial_shift = 0;


/* [Handle] */

// Generate a handle for hand rotation, useful as a teaching tool
generate_handle = 0; //[1:Yes,0:No]


//Total height of the handle. in mm
handle_height      = 20;

//radius of the handle. in mm
handle_radius = 1.5;


/* [Meshing properties] */

// Pressure angle controls how well the force transferred between meshing gears.
// Higher pressure angle increases the limit of the applied force but also increases the 
// pushing force that forces meshing gear apart. Also increased pressure angle increases
// the noise. in degrees.
pressure_angle = 20; //[0:45]

// Builds a helix gear with the given helix angle. Helix gears can handle higher speed
// but has a force pushing gear up or down, unless double helix is set to true. Helix 
// angle of gear to mesh with another should be the negative of the other gear, like 
// one being 30 and other being -30. I would recommend increasing number of teeth for
// helix gear as it would be more efficient to do so. in degrees.
helix_angle = 0; //[0:45]

// If helix angle is set, builds a herring bone style double helix gear.
double_helix = 1; //[1:Yes,0:No]

// Clearance at the base of the teeth. in mm.
clearance = 0.5;

// Backlash is the rotational clearance. It will cause a gear set to take some 
// additional rotation to start moving right after a reversal in direction. 
// A small backlash is necessary as lack of it might cause jamming. Default
// value assumes that you would sand paper the gear to smooth the teeth. in mm.
backlash = 0.1;


/* [Hidden] */


gear(
    teeth        = teeth, 
    mod          = mod,
    thickness    = thickness,
    details      = details,
    skip_after   = skip_after,
    angle        = pressure_angle,
    helix_angle  = helix_angle,
    double_helix = double_helix,
    clearance    = clearance,
    backlash     = backlash,
    inner_thickness = enable_inner_section ? inner_thickness : undef,
    inner_section= inner_section,
    reinforce    = reinforce,
    reinforce_thickness = reinforce_thickness,
    hole = hole,
    hole_dents = hole_shape,
    hole_minor = minor_hole_radius,
    hole_height = auto_hole_height ? undef : hole_height,
    screw_hole = generate_screw_hole ? screw_hole_radius : undef,
    screw_support=screw_support,
    screw_head = screw_head,
    handle_height = generate_handle ? handle_height : undef,
    handle_radius = handle_radius,
    spacer_style = spacer_style,
    spacers=spacers,
    angular_spacing=angular_spacing/100,
    radial_spacing=radial_spacing/100,
    spacing_radial_shift=spacing_radial_shift,
    generate_screw_hexagonal=generate_screw_hexagonal
);


/*
 * INTERNAL USE
 */
pi = 3.14159;
s2 = 1.41421;
//
//trigonometric functions that would run in radians
function sn(ang) = sin(ang*180/pi);
function cs(ang) = cos(ang*180/pi);
function tn(ang) = tan(ang*180/pi);
function atn(rat) = atan(rat)/180*pi;
function asn(rat) = asin(rat)/180*pi;

//calculates involute angle
function involute_ang(r, rb) = 
    pow(pow(r, 2)-pow(rb, 2), 0.5)/rb - 
    atn(pow(pow(r, 2)-pow(rb, 2), 0.5)/rb)
;
//polar to cartesian
function polar(r, a) = [
    r*cs(a),
    r*sn(a)
];

function rotate(v, a) = [
    v[0]*cs(a)-v[1]*sn(a),
    v[0]*sn(a)+v[1]*cs(a),
];


//This module generates cutoff sections
module cutoff(
    mod    = 2,
    angle = 10,
    helix_angle = 0,
    double_helix=false,
    teeth = 12,
    details=default_details,
    backlash=default_backlash,    
    thickness = default_thickness,
) {
    
    //tooth width
    tw = mod * pi;
    
    //pitch diameter
    pd = mod * teeth;
    
    pr=pd/2;
    
    apt=2*pi/teeth;

    //skewness
    sk = mod * tan(angle);
    
    //angle per tooth width
    aptw = apt/tw;
    
    //calculated backlash
    cb=backlash/4/cos(angle);

    //skewness
    sk = mod * tan(angle);
    
    //limits of drawing, actual limit is performed by if statement, a better estimate can save
    // alot of rendering time
    lim = pr*2;
    
    //steps, 1.2 is for curvature
    tws = max(round(lim*1.2/details),2);
    
    //steps per toothwidth
    twd = lim/tws-0.001;
    
    //slice count
    sc = helix_angle == 0 ? 1 : max(round(thickness*abs(tan(helix_angle))/details),2);

    for(t=[0:teeth-1]) {
        translate([0,0,-0.05])
        linear_extrude(
            height=double_helix ? thickness/2+0.1 : thickness+0.1,
            twist = 360*(tan(helix_angle)*thickness/(double_helix?4:2)/pi/pr), 
            slices=sc
        )
        polygon([
        for(op=[0:1])
        for(i=op ? [0:twd:lim] : [-lim:twd:0])
            if(op ? 
               atn((i+(op?1:-1)*(tw/4-sk+cb))/(pr-mod))+(-i*aptw)>0 : 
               atn((i+(op?1:-1)*(tw/4-sk+cb))/(pr-mod))+(-i*aptw)<0)
            rotate(polar(
                pow(pow(i+(op?1:-1)*(tw/4-sk+cb),2)+pow(pr-mod,2),0.5), 
                atn((i+(op?1:-1)*(tw/4-sk+cb))/(pr-mod))+(-i*aptw))
            , t*apt)
        ]);
        
        if(double_helix) {
            translate([0,0,thickness/2-0.05])
            linear_extrude(
                height=double_helix ? thickness/2+0.1 : thickness+0.1,
                twist = 360*(tan(-helix_angle)*thickness/(double_helix?4:2)/pi/pr), 
                slices=sc
            )
            rotate([0,0,-360*(tan(helix_angle)*thickness/(double_helix?4:2)/pi/pr)])
            polygon([
            for(op=[0:1])
            for(i=op ? [0:twd:lim] : [-lim:twd:0])
                if(op ? 
                   atn((i+(op?1:-1)*(tw/4-sk+cb))/(pr-mod))+(-i*aptw)>0 : 
                   atn((i+(op?1:-1)*(tw/4-sk+cb))/(pr-mod))+(-i*aptw)<0)
                rotate(polar(
                    pow(pow(i+(op?1:-1)*(tw/4-sk+cb),2)+pow(pr-mod,2),0.5), 
                    atn((i+(op?1:-1)*(tw/4-sk+cb))/(pr-mod))+(-i*aptw))
                , t*apt)
            ]);
        }
    }    
}

//Places spacing within the gears
module radialspacer(
    outer_radius,
    inner_radius,
    total_angle = 2*pi,
    thickness,
    details = default_details,
    spacer_style = spacer_linear,
    spacers = 4,
    angular_spacing = 0.7,
    radial_spacing = 0.7
 ) {
 
 //Generates holes for gears and wheels
     
    sor=outer_radius;
    sir=inner_radius;
    tang=total_angle;
    h=thickness;
     
    //central radius
    smr = (sor-sir)/2+sir;

    if(spacer_style==spacer_polar) {
     //calculated spacers
     sps = total_angle != pi*2 ? max(round(spacers*total_angle/pi/2), 1) :
           spacers;
     
     //angle between spacers
     angbs = tang / sps;
     
     //angle per spacers
     angps = tang / sps * angular_spacing;
     
     //outer steps
     osteps = max(round(angps*sor/details),2);
     
     //outer angle per step
     oaps = angps / osteps - 0.001;
     
     //inner
     isteps = max(round(angps*sir/details),2);
     
     iaps = angps / isteps - 0.001;
     
     //create spacers
     for(i=[0:sps-1]) {
         translate([0,0,-0.05])
         linear_extrude(h+0.01)
         polygon([
            for(op=[0:1])
                for(ang = 
                    op==0 ? [0:oaps:angps]
                    :       [angps:-iaps:0])
                    op==0 ?
                        polar(sor, i*angbs+ang+(angbs-angps)/2)
                    :
                        polar(sir, i*angbs+ang+(angbs-angps)/2)
         ]);
     }
    }
    if(spacer_style==spacer_circles) {
     
     //circle diameter
     cd = (sor-sir);
     
     //circle radius
     cr = cd/2;
     
     //number of spacers
     sps = max(round(tang*smr/cd*angular_spacing),2);
     
     //angle between spacers
     angbs = tang / sps;
     
     //angle per spacers
     angps = tang / sps * angular_spacing;
     
     steps = round(cd*pi/details);
     
     //create spacers
     for(i=[0:sps-1]) {
         translate([0,0,-0.05])
         translate(polar(smr,i*angbs+angbs/2))
         cylinder(r=cr, h=thickness+0.1, $fn=steps);
     }
    }
    if(spacer_style==spacer_linear) {
     //calculated spacers
     sps = total_angle != pi*2 ? max(round(spacers*total_angle/pi/2), 1) :
           spacers;
     
     //angle between spacers
     angbs = tang / sps;
     
     //outer angle per spacers
     oangps = tang / sps * angular_spacing;
     
     //outer steps
     osteps = max(round(oangps*sor/details),2);
     
     //outer angle per step
     oaps = oangps / osteps - 0.001;
     
     //outer distance
     od = 2 * sor * sn((angbs-oangps)/2);
     
     //inner angle per spacer
     riangps = angbs-2*asn(od/(2*sir))>0 ? 1 : -1;
     iangps = angbs-2*asn(od/(2*sir))>0 ? max(angbs-2*asn(od/(2*sir)),0) : 0;
     
     //new inner radius, if angle at the inner radius is negative
     //find a new inner radius where angle is 0
     nsir = riangps<0 ? od/(2*sn(angbs/2)) : sir;
     
     //inner
     isteps = max(round(iangps*sir/details),2);
     
     iaps = iangps / isteps - 0.001;
     
     //create spacers
     for(i=[0:sps-1]) {
         translate([0,0,-0.05])
         linear_extrude(h+0.1)
         polygon([
            for(op=[0:1])
                for(ang = 
                    op==0 ? [0:oaps:oangps]
                    :       [iangps:-iaps:0])
                    op==0 ?
                        polar(sor, i*angbs+ang+(angbs-oangps)/2)
                    :
                        polar(nsir, i*angbs+ang+(angbs-iangps)/2)
         ]);
     }
    }
    if(spacer_style==spacer_polar_ovals) {
     
     //circle diameter
     cd = (sor-sir);
     
     //circle radius
     cr = cd/2;
     
     //number of spacers
     sps = total_angle != pi*2 ? max(round(spacers*total_angle/pi/2), 1) :
           spacers;
     
     //angle between spacers
     angbs = tang / sps;
     
     //angle per spacers
     angps = tang / sps * angular_spacing;
     
     steps = round((cd+angbs*smr)/2*pi/details);
     
     //create spacers
     for(i=[0:sps-1]) {
         translate([0,0,-0.05])
         linear_extrude(h+0.01)
         polygon([
            for(ang = [0:2*pi/steps-0.001:2*pi])
                polar(sn(ang)*cr+smr, cs(ang)*angps/2+i*angbs+angps/2+(angbs-angps)/2)
         ]);
     }
    }
 };
 
 module generatehole(     
    //Hole radius
    hole = 2.5,
    
    //Thickness of the hole.
    //Use undef to make it automatic
    hole_height = undef,
    
    //Radius of the screw hole. When setting this value,
    // consider setting hole thickness.
    screw_hole = undef,
    
    //Thickness of the screw support
    screw_support = 1,
    
    //Radius of the screw head
    screw_head = 2.5,
 
    details = default_details,
 
    //The number of dents on a semi circular hole, 0 for o shaped hole
    // 1 for D shaped and 2 for Û shaped hole
    hole_dents = 0,
    
    //For semi circular hole, similar to the one on step motors. This
    // is the diameter of the minor axis
    hole_minor = 3,
    
    generate_screw_hexagonal = 1,
 
    thickness
 ) {
      //mounting hole
     if(hole!=undef) {
        hh=(hole_height == undef ? 
            thickness - 
            (screw_hole!=undef ? screw_support : 0) : 
            hole_height
        );
         
        steps = max(round(hole*2*pi/details), 12);
        
        difference() {
            translate([0,0,-0.05])
            cylinder(r=hole, h=hh+0.1, $fn=steps);
            
            if(hole_dents==1) {
                translate([-hole,-hole+hole_minor,-0.05])
                cube([hole*2,hole*2,hh+0.1]);
            }
            
            if(hole_dents==2) {
                translate([-hole,hole_minor/2,-0.05])
                cube([hole*2,hole*2,hh+0.1]);
                rotate([0,0,180])
                translate([-hole,hole_minor/2,-0.05])
                cube([hole*2,hole*2,hh+0.1]);
            }
        }
     }
     
     if(screw_hole!=undef) {
        steps = max(round(screw_hole*2*pi/details), 12);
        translate([0,0,-0.005])
        cylinder(r=screw_hole, 
            h=thickness+0.01, 
            $fn=steps
        );
         
        if(screw_head!=undef) {
            hh=(hole_height == undef ? 
                thickness - 
                (screw_hole!=undef ? screw_support : 0) : 
                hole_height
            );
            
            if(generate_screw_hexagonal==1){
                steps=6;
                translate([0,0,hh+screw_support])
                cylinder(
                    r=screw_head, 
                    h=thickness, 
                    $fn=steps
                );
            }
            else{
                steps = max(round(screw_hole*2*pi/details), 12);
                translate([0,0,hh+screw_support])
                cylinder(
                    r=screw_head, 
                    h=thickness, 
                    $fn=steps
                );
            }
        }
     }
};
 
/*
 * PUBLIC FUNCTIONS
 */

//Finds the pitch radius of a gear. Sum of pitch
//radii of two gears will give the distance that
//should be between two gears
function pitch_radius(
    //number of teeth
    teeth  = 20,
    
    //ratio of the pitch diameter to the number of teeth
    //you may use size_to_mod function to determine mod
    mod    = 2
) = teeth*mod/2;

function tooth_width(mod = 3) = mod*pi;

//calculates the mod of a known sized gear
function size_to_mod(outer_diameter, teeth) 
    = outer_diameter/(teeth+2);

//spacer modes
spacer_none   = 0;
spacer_polar  = 1;
spacer_circles= 2;
spacer_linear = 3;
spacer_polar_ovals = 4;

//use these variables to set default settings
default_details  = 0.33;
default_backlash = 0.1;
default_angle    = 20;
default_clearance= 0.5;
default_thickness=3;


function smootherstep(x) = x*x*x*(x*(x*6 - 15) + 10);
function smootherstep_q(x) = smootherstep(x/4)*9.66038;
function smootherstep_h(x) = smootherstep(x/2)*2;
function rn(x)=round(x*1000)/1000;

//Creates a pole with a sphere at the top. Creates a smoothish structure that does not have
// any overhangs. To be replaced by something better
module pole(
    //Radius of the rod
    rod_radius  = 2,
    
    //radius of the top pole
    pole_radius = 5,
    
    //Total height of the pole
    height      = 20,
    
    //Maximum segment distance in mm
    details=default_details,
    
    //Maximum overhang angle
    overhang_angle = 45,
) {
    
    //cosine of overhang angle
    cva = cos(overhang_angle);

    //pole rod difference
    prd = pole_radius - rod_radius;

    //pole steps
    poles = max(round(pole_radius*2*pi/details),24);

    if(pole_radius<rod_radius) {
        echo("Pole radius should be larger than rod radius");
    }
    else if(pole_radius*cva<rod_radius) {
        //meeting angle
        mang=acos(rod_radius/pole_radius);
        
        //radius of the bottom half of the sphere
        bhr = sin(mang)*pole_radius;
        
        rh = height - bhr - pole_radius;
        
        if(rh==0)
            echo("Rod height is zero or negative");
        
        cylinder(r=rod_radius, h=rh, $fn=poles);
        translate([0,0,rh+bhr])
        sphere(r=pole_radius, $fn=poles);
    }
    else {

        //half angle steps
        hangsc = max(round(pole_radius*2*pi/360*(90+overhang_angle)/details),round((90+overhang_angle)/10));
        hangs = (90+overhang_angle)/hangsc-0.01;

        //bridge height
        bh = prd/cva;
        
        //radius of the bottom half of the sphere
        bhr = pole_radius*sin(overhang_angle);
        
        //radius of the bottom circle
        bcr = pole_radius*cva;

        //bridge steps, 1.2 is for extra curving
        bridges = 1/max(round(bh*1.2/details),5);
        
        //remaining rod height
        rh  = (height - pole_radius - bhr - bh)>0 ? height - pole_radius - bhr - bh : 0;
        
        if(rh==0)
            echo("Rod height is zero or negative");

        rotate_extrude($fn=poles)
            polygon([
                for(op=[0:3])
                    for(i = 
                          op == 0 ? 
                            [0:bridges:1] 
                        : op == 1 ? 
                            [-overhang_angle:hangs:90-hangs] 
                        : op == 2 ?  
                            [0:0] 
                        : [0:1]
                    )
                      op == 0 ? 
                        [rn((bcr-rod_radius)*smootherstep_q(i)+rod_radius), 
                         rn(bh*i+rh)]
                    : op == 1 ?
                        [rn(cos(i)*pole_radius), 
                         rn(sin(i)*pole_radius+rh+bh+bhr)]
                    : op == 2 ?
                         [0, rn(rh+bh+bhr+pole_radius)]
                    :
                        [i*rod_radius, 0]
            ]);
    }
 }


//Generates a gear from the given parameters
module gear(
    //Number of teeth
    teeth  = 12, 
    
    //Ratio of the pitch diameter to the number of teeth
    // you may use size_to_mod function to determine mod
    mod    = 2,
    
    //Thickness of the gear
    thickness = default_thickness,
 
    //Pressure angle
    angle = default_angle,
    
    generate_screw_hexagonal = 0,
 
    //Helix angle to produce helix gear. One of the meshing gears should have
    // negative value as the helix angle.
    helix_angle = 0,
 
    //Whether to generate double helix, herring bone style gears
    double_helix = true,
    
    //Maximum segment distance in mm
    details = default_details,
    
    //Clearance of the gear base
    clearance = default_clearance,
    
    //Backlash is the rotational clearance. It will cause a gear set 
    // to take some additional rotation to start moving right after a
    // reverse in direction. A small backlash is necessary
    // as lack of it might cause jamming.
    backlash = default_backlash,
    
    //Skips the teeth after the given value
    skip_after = undef,
    
    //Thickness of the inner section of the gear.
    //Set to undef or thickness to disable
    inner_thickness = 2,
    
    //The distance of the inner section between the
    //inner radius of the teeth
    inner_section = 1.5,
    
    //Reinforced shaft radius. Set 0 or undef to remove
    reinforce = 4,
    
    //Thickness of the reinforced shaft
    reinforce_thickness = 3,
    
    //Hole radius
    hole = 2.5,
    
    //The number of dents on a semi circular hole, 0 for o shaped hole
    // 1 for D shaped and 2 for Û shaped hole
    hole_dents = 0,
    
    //For semi circular hole, similar to the one on step motors. This
    // is the diameter of the minor axis
    hole_minor = 3,
    
    //Thickness of the hole.
    //Use undef to make it automatic
    hole_height = undef,
    
    //Radius of the screw hole. When setting this value,
    // consider setting hole thickness.
    screw_hole = undef,
    
    //Thickness of the support that is under the screw. Thicker support
    // means stronger connection but will shorten the length of the screw
    screw_support = 1,
    
    //Radius of the screw head
    screw_head = 2.5,
    
    //Total height of the handle
    handle_height      = undef,
    
    //radius of the handle
    handle_radius = 1,
    
    //Maximum overhang angle
    overhang_angle = 45,   
    
    //Type of spacers. Currently supported values are:
    // spacer_none: spacers are disabled,
    // spacer_polar: linear spacers in polar coordinates, prefer linear
    //               as the spacing is not uniform
    // spacer_circles: circles placed for spacing, prefer polar_ovals
    //                 as the spacing is not uniform
    // spacer_linear: supportive shafts have the same width
    //                along the radial axis
    // spacer_polar_ovals: ovals represented in polar 
    //                     coordinates
    spacer_style = spacer_linear,
    
    //Number of spacers, this value will be ignored for 
    // spacer_none, and spacer_circles
    spacers = 4,
    
    //The ratio of provided angular spacing, spacing ratios are not precise
    angular_spacing = 0.75,
    
    //The ratio of radial spacing provided, spacing ratios are not precise
    radial_spacing = 0.75,
    
    //Radial shift of spacers
    spacing_radial_shift = 0,
) {
    //pitch diameter
    pd = mod * teeth;
    
    //pitch radius
    pr = pd / 2;
    
    //base radius
    br = pr * cos(angle);
    
    //outer radius
    or = pr + mod;
    
    //diameter pitch (teeth/inch)
    dp = 25.4 / (mod*pi);
    
    //width of each tooth
    w = mod*pi - backlash;
    
    //whole height
    h = 2 *mod + clearance;
    
    //inner radius
    ir = or - ((h>or-br) ? h : or-br);
    
    //angle per tooth, including pits
    apt = 2*pi / teeth;
    
    //number of divisions along involute string
    inv_steps = max(round((or - br)/details),3);
    
    //distance of each involute orbit
    inv_dist  = (or - br) / inv_steps-0.001;
                                 //to ward off fp errors
    
    //whether this gear is incomplete semi-circle
    semi_gear = skip_after!=undef && skip_after>0 && skip_after<teeth;
    
    //the last teeth to draw
    final_teeth = (semi_gear ? skip_after : teeth)-1;
    
    //starting angle
    st=-apt/4-involute_ang(pr,br)+backlash/pd;
    
    //the number of points on the circle elements
    circ_steps = max(round((ir*(apt/2+st))/details),2);
    
    //angle per circle step
    aps = (apt/2+st)/circ_steps-0.001;
                                 //to ward off fp errors
    
    //total angle
    tang=semi_gear ? 2*pi/(teeth/skip_after) : 2*pi;

    //whether to lower the inner section
    lower_inner=inner_section!=undef && inner_section!=0 &&
                inner_thickness!=undef && inner_thickness<thickness;
                
    //slice count
    sc = helix_angle == 0 ? 1 : max(round(thickness*abs(tan(helix_angle))/details),2);
    
    do_reinforce = reinforce!=undef && reinforce!=0;
    
    difference() { 
     union() {
      difference() {
          union() {
            linear_extrude(
              double_helix ? thickness / 2 : thickness, 
              twist = 360*(tan(helix_angle)*thickness/(double_helix?4:2)/pi/pr), 
              slices=sc, 
              convexity=10
            )
            polygon([
              //if there, op 1 binds polygon to center
              for(op=[0:semi_gear ? 1 : 0]) 
                for(tooth=op ? [0:0] : [0:final_teeth])
                    for(phase=op ? [0:0] : [0:3]) //0: arc, 1: up string, 
                                                  //2: down string, 3: arc
                        for(i= 
                               op == 1 ? [0:0]
                            : phase==0 ? [0:aps:st+apt/2]
                            : phase==1 ? [br:inv_dist:or]
                            : phase==2 ? [or:-inv_dist:br]
                            :            [apt/2-st:aps:apt])
                        
                              op == 1 ?
                                [0,0]
                            : phase == 0 ?
                                polar(ir, i+apt*tooth)
                            : phase == 1 ? 
                                polar(i, apt/2+(involute_ang(i, br)+st)+apt*tooth)
                            : phase == 2 ? 
                                polar(i, apt/2+(-involute_ang(i, br)-st)+apt*tooth)
                            : //phase==3
                                polar(ir, i+apt*tooth)
                            
            ], convexity=10);
            
            if(double_helix) {
                
                 translate([0,0,thickness/2])
                 linear_extrude(
                  thickness / 2, 
                  twist = -360*(tan(helix_angle)*thickness/4/pi/pr), 
                  slices=sc, 
                  convexity=10
                )
              rotate([0,0,-360*(tan(helix_angle)*thickness/4/pi/pr)])
                polygon([
                  //if there, op 1 binds polygon to center
                  for(op=[0:semi_gear ? 1 : 0]) 
                    for(tooth=op ? [0:0] : [0:final_teeth])
                        for(phase=op ? [0:0] : [0:3]) //0: arc, 1: up string, 
                                                      //2: down string, 3: arc
                            for(i= 
                                   op == 1 ? [0:0]
                                : phase==0 ? [0:aps:st+apt/2]
                                : phase==1 ? [br:inv_dist:or]
                                : phase==2 ? [or:-inv_dist:br]
                                :            [apt/2-st:aps:apt])
                            
                                  op == 1 ?
                                    [0,0]
                                : phase == 0 ?
                                    polar(ir, i+apt*tooth)
                                : phase == 1 ? 
                                    polar(i, apt/2+(involute_ang(i, br)+st)+apt*tooth)
                                : phase == 2 ? 
                                    polar(i, apt/2+(-involute_ang(i, br)-st)+apt*tooth)
                                : //phase==3
                                    polar(ir, i+apt*tooth)
                                
                ], convexity=10);
           }
        }
                    
        cutoff(
            teeth=teeth, 
            mod=mod, 
            details=details, 
            angle=angle, 
            helix_angle=helix_angle,
            double_helix=double_helix,
            thickness=thickness,
            backlash=backlash);
        
        if(lower_inner) {
            //inner section radius
            isr=ir-inner_section;
            steps = max(round(isr*2*pi/details), 12);
            translate([0,0,inner_thickness])
            linear_extrude(h=thickness)
            circle(r=isr, $fn=steps);
        }
             
        //spacers
        if(spacer_style!=spacer_none) {             
            //min radius
            mn  = do_reinforce ? reinforce : (hole != undef ? hole : 0);
             
            //inner
            sir = 
              (ir - mn - (inner_section!=undef ? inner_section : 0)) * 
              (1-radial_spacing)/2 + mn + spacing_radial_shift;

            //outer
            sor = 
              (ir - mn - (inner_section!=undef ? inner_section : 0)) * 
              (1-(1-radial_spacing)/2) + mn + spacing_radial_shift;

            radialspacer(
                sor, sir, tang, thickness+0.1, details,
                spacer_style, spacers,
                angular_spacing, radial_spacing,
                spacing_radial_shift
            );
        } //spacer!=none

      } //difference
      
      //reinforced shaft
      if(do_reinforce) {
         rfr = reinforce>ir ? ir : reinforce;
         
         if(rfr<hole)
             echo("Reinforced shaft radius is smaller than hole radius");
         
         steps = max(round(rfr*2*pi/details), 12);
         cylinder(r=rfr, h=reinforce_thickness, $fn=steps);
         
         //build supportive material
         if( lower_inner && semi_gear ) {  
             translate([0,-inner_section/2,0])
             linear_extrude(height=reinforce_thickness /(double_helix ? 2 : 1), 
                twist = 360*(tan(helix_angle)*reinforce_thickness/(double_helix?4:2)/pi/pr), 
                slices=sc
             )
             square([ir, inner_section]);
             
             rotate([0,0,apt*skip_after*180/pi])
             translate([0,-inner_section/2,0])
             linear_extrude(height=reinforce_thickness /(double_helix ? 2 : 1),
                twist = 360*(tan(helix_angle)*reinforce_thickness/(double_helix?4:2)/pi/pr), 
                slices=sc
             )
             square([ir, inner_section]);
             
             if(double_helix) {
                 rotate([0,0,360*(tan(-helix_angle)*reinforce_thickness/(double_helix?4:2)/pi/pr)])
                 translate([0,-inner_section/2,reinforce_thickness/2])
                 linear_extrude(height=reinforce_thickness /(double_helix ? 2 : 1), 
                    twist = 360*(tan(-helix_angle)*reinforce_thickness/(double_helix?4:2)/pi/pr), 
                    slices=sc
                 )
                 square([ir, inner_section]);
                 
                 rotate([0,0,apt*skip_after*180/pi+360*(tan(-helix_angle)*thickness/(double_helix?4:2)/pi/pr)])
                 translate([0,-inner_section/2,reinforce_thickness/2])
                 linear_extrude(height=reinforce_thickness /(double_helix ? 2 : 1),
                    twist = 360*(tan(-helix_angle)*reinforce_thickness/(double_helix?4:2)/pi/pr), 
                    slices=sc
                 )
                 square([ir, inner_section]);
             }
         }
       }
       
       if(handle_height != undef) {
           pos=ir-(inner_section!=undef ? inner_section : 0)-handle_radius*2;
           
           ang = semi_gear ? asn(handle_radius/pos) : 0;
           
           translate(polar(pos, ang))
           translate([0,0,inner_thickness == undef ? thickness : inner_thickness])
           pole(
                rod_radius=handle_radius, 
                pole_radius=handle_radius*2, 
                height=handle_height, 
                details=details
          );
       }
     }
     
     generatehole(
        hole=hole, hole_height=hole_height,
        hole_dents=hole_dents, hole_minor=hole_minor,
        screw_hole=screw_hole, screw_support=screw_support, 
        screw_head=screw_head, details=details, 
        thickness=reinforce_thickness>thickness ? reinforce_thickness : thickness,
        generate_screw_hexagonal=generate_screw_hexagonal
     );
    } //difference
};




