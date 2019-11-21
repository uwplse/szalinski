// Flexy-Form Insole v1.0 by Gyrobot
// http://www.gyrobot.co.uk
//
// Thanks to Swindon Hackspace member "Axford" http://axrap.blogspot.co.uk/
//
// preview[view:east, tilt:top]
// User Parameters

Length = 260 ;              // See Drawing
Heel_Radius = 35 ;          // See Drawing
Toe_Radius = 35 ;           // See Drawing
Inside_Width = 40;          // See Drawing
Inside_Length = 190;        // See Drawing
Outside_Width = 55;         // See Drawing
Outside_Length = 165;       // See Drawing
Instep_Offset = 25;         // See Drawing
Foot = "Right" ;            // [Left, Right] 
STL_Type = "Joined" ;       // [Joined, Upper, Lower]
Lattice = "On" ;            // [On, Off]
Number_of_Hinge_Lines = 3;  // Number of breaks in the rigid layers
Thickness = 5;              // Overall thickness of the insole
Rigid_Layer_Thickness = 2.5;// thickness of rigid thermoformable layer
Chamfer_Width = 7;          // determines the slope round the edges

// Start of Code

module sector2D(r, a, center = true) {
    intersection() {
            circle(r = r, center = true);
                polygon(points = [
                    [0, 0],
                    [2 * r * cos(0),  2 * r * sin(0)],
                    [2 * r * cos(a * 0.2),  2 * r * sin(a * 0.2)],
                    [2 * r * cos(a * 0.4),  2 * r * sin(a * 0.4)],
                    [2 * r * cos(a * 0.6),  2 * r * sin(a * 0.6)],
                    [2 * r * cos(a * 0.8),  2 * r * sin(a * 0.8)],
                    [2 * r * cos(a), 2 * r * sin(a)],
                ]);
        }
}


// pass u and v as vectors
function dotProduct(u,v) = u[0]*v[0] + u[1]*v[1];
function mag(u) = sqrt(pow(u[0],2) + pow(u[1],2));

// calculate the radius of a circle that is tangential to a circle at the origin or radius r, with a center offset by x,y
function tangentialCircleRadius(r,x,y) = ( pow(y,2) + pow(r,2) +pow(x,2) - 2*r*x ) / ( 2*x - 2*r) + r;

// calculate the intersection of two circles, returns a vector - support functions for intermediate calcs
function ccid(x1,y1,x2,y2) = mag([x1-x2, y1-y2]);
function ccil(r1,r2,d) = (pow(r1,2) - pow(r2,2) + pow(d,2)) / (2*d);
//function ccih(r1, l) = sqrt(pow(r1,2) - pow(l,2));
function ccih(r1, l) = 0;

function circleCircleIntersection(x1,y1,r1, x2,y2,r2) = [
    (ccil(r1,r2,ccid(x1,y1,x2,y2)) / ccid(x1,y1,x2,y2)) * (x2-x1) + (ccih(r1, ccil(r1,r2,ccid(x1,y1,x2,y2))) / ccid(x1,y1,x2,y2))*(y2-y1) + x1,
    (ccil(r1,r2,ccid(x1,y1,x2,y2)) / ccid(x1,y1,x2,y2)) * (y2-y1) + (ccih(r1, ccil(r1,r2,ccid(x1,y1,x2,y2))) / ccid(x1,y1,x2,y2))*(x2-x1) + y1
];


module pocket(w,r) {
    // pill shape, centred on the origin
    hull() {
        translate([w/2,0,0])
            circle(r);
        translate([-w/2,0,0])
            circle(r);
    }
}

// i,j are number of repetitions
// x,y are spacing
// pass child profile to be laid out
// always starts from origin and expands along x+, y+
module grid(i,j,x,y, stagger=false) {
    for (a=[0:i-1], b=[0:j-1])
        translate([a*(stagger ? x/2 : x), b*y + ((stagger && (a % 2 == 0)) ? y/2 : 0), 0])
        children();
}

module Profile (l, hr, tr, iw, il, ow, ol, io) {

    // calculate radii for inside/outside arcs that contact the toe
    ir = tangentialCircleRadius(tr, iw, l-il-tr);
    or = tangentialCircleRadius(tr, ow, l-ol-tr);

    // calculate the intersection points for associated arcs
    // first for the inside arc, first circle is the toe, second circle is the inside arc
    ii = circleCircleIntersection(0, l-tr, tr, -ir+iw, il, ir);
    xi = ii[0];
    yi = ii[1];

    // debug the intersection point
    *translate([xi,yi,1])
        circle(1);

    u1 = [xi- (-ir+iw), yi- il];
    v1 = [ u1[0], -u1[1]];
    ia2 = acos(dotProduct(u1,v1) / (mag(u1) * mag(v1)));   // angle of segment
    ia1 = atan2(yi - il, xi - (-ir+iw)) - ia2;  // angle from x-axis, CCW when viewed down Z


    // do the same for the outside arc
    ci = circleCircleIntersection(0, l-tr, tr, or-ow, ol, or);
    xo = ci[0];
    yo = ci[1];

    // debug the intersection point
    *translate([xo,yo,1])
        circle(1);

    u2 = [xo- (or-iw), yo- ol];
    v2 = [ u2[0], -u2[1]];
    oa2 = acos(dotProduct(u2,v2) / (mag(u2) * mag(v2)));   // angle of segment
    oa1 = atan2(yo - ol, xo - (or-ow));  // angle from x-axis, CCW when viewed down Z

    difference () {

        union() {

            // toe and ball of foot
            hull (){
                //Toe
                translate ([0,l-tr,0])
                     circle (tr);

                // inside
                difference() {
                    translate ([-ir+iw,il,0])
                        rotate([0,0,ia1])
                        sector2D(ir, ia2, $fn=100);

                    translate([-ir,il-ir,0])
                         square([ir, 2*ir]);
                }
                // outside
                difference() {
                    translate ([or-ow,ol,0])
                        rotate([0,0,oa1])
                        sector2D(or, oa2, $fn=100);

                    translate([0,ol-or,0])
                        square([or, 2*or]);
                }
                //Heel
                translate ([0,hr,0])
                    circle (hr, $fn=32);
            }
        }
        // cut away inside arc
        //
        // two tangency arcs solutions exist for each set of inputs, need to reject +h value and keep -h solution (hopefully)
        //
        // r3     = radius of bi-tangent arc
        // alt_r3 = alternate solution for r3
        // h      = height offset in y from bi-tangency arc centre point to centre of Heel_Radius
        // alt_h  = alternate solution for h
        //
        delx = ir-iw;
        dely = -il+hr;
        
        h = (dely*(hr - io) + sqrt(-(hr - io)*(delx + io - ir)*(pow(delx,2) + pow(dely,2) - pow(hr,2) + 2*hr*ir - pow(ir,2))))/(delx + hr - ir);
        
        r3 = (dely*(dely*(hr - io) + sqrt(-(hr - io)*(delx + io - ir)*(pow(delx,2) + pow(dely,2) - pow(hr,2) + 2*hr*ir - pow(ir,2)))) - (delx + hr - ir)*(pow(delx,2) + 2*delx*io + pow(dely,2) + pow(hr,2) - pow(ir,2))/2)/pow((delx + hr - ir),2);
        
        alt_h = (dely*(hr - io)*(delx + hr - ir) + sqrt(-(hr - io)*(delx + io - ir)*(pow(delx,2) + pow(dely,2) - pow(hr,2) + 2*hr*ir - pow(ir,2)))*(-delx - hr + ir))/pow((delx + hr - ir),2);
        
        alt_r3 = (dely*(dely*(hr - io)*(delx + hr - ir) + sqrt(-(hr - io)*(delx + io - ir)*(pow(delx,2) + pow(dely,2) - pow(hr,2) + 2*hr*ir - pow(ir,2)))*(-delx - hr + ir)) + pow((delx + hr - ir),2)*(pow(-delx,2) - 2*delx*io - pow(dely,2) - pow(hr,2) + pow(ir,2))/2)/pow((delx + hr - ir),3);
        
        //
        // solution [1]
        //
        translate ([r3+io,-h+hr,0])
        circle(r3,$fn=100);
        //
        // solution [2]
        //
*       translate ([alt_r3+io,-alt_h+hr,0])
*       circle(alt_r3,$fn=100);
        //
        // cut away outside arc
        //
        // calculate outstep radii (otr) for outstep arc that contacts the heel
        otr = (pow(or,2) - pow(hr - ol,2) - pow(hr + or - ow,2))/(2*(hr - ow));
        translate ([-otr-hr,hr,0])
        circle(otr,$fn=100);

        union() {
            // inside upper tangency tidy up
            difference(){
                polygon(points=[[iw-ir,il],[r3+io,-h+hr],[r3+io,l],[iw-ir,l]]);
                translate ([-ir+iw,il,0])
                circle(ir,$fn=100);
                translate ([r3+io,-h+hr,0])
                circle(r3,$fn=100);
            }
        }
        union() {
            // inside lower tangency tidy up
            difference(){
                polygon(points=[[0,0],[0,hr],[r3+io,-h+hr],[r3+io,0]]);
                translate ([0,hr,0])
                circle(hr,$fn=100);
                translate ([r3+io,-h+hr,0])
                circle(r3,$fn=100);
            }
        }
        union() {
            // outside upper tangency tidy up
            difference(){
                polygon(points=[[or-ow,ol],[-otr-hr,hr],[-otr-hr,l],[or-ow,l]]);
                translate ([or-ow,ol,0])
                circle(or,$fn=100);
                translate ([-otr-hr,hr,0])
                circle(otr,$fn=100);
            }
        }
    }
};

module bevel_extrude(height=20, length=5, width=100, cw=5)
{
    xscale = (width-(2*cw))/width;
    yscale = (length-(2*cw))/length;
    translate ([0,length/2,0])
		linear_extrude(height=height, convexity=5, scale=[xscale,yscale])
        translate ([0,-length/2,0])
		children();
}

// to be differenced away from the insole to produce a joint line
module joint(w=4, t=5, rlt=2.5, num_hl=3) {
    minhinge_dist = -5*(num_hl-1);
    maxhinge_dist = 5*(num_hl-1);
    translate([0,0,t-rlt])
        for (yoff=[minhinge_dist:10:maxhinge_dist]){
            linear_extrude(t+rlt)
            hull() {
                translate([Inside_Width, Inside_Length+yoff, 0])
                    circle(w/2);
    
                translate([-Outside_Width, Outside_Length+yoff, 0])
                    circle(w/2);
            }
        }
}

// to be differenced away from the insole
module gridPattern(gs, t, rlt, num_hl) {

    intersection() {
        // grid
        translate([-Outside_Width, -20, t-rlt])
            grid(2*round((Outside_Width + Inside_Width)/gs), round(Length/gs)+2, gs, gs, true)
            linear_extrude(t+rlt) {
                pocket(6,0.5);

                translate([0, gs/2, 0])
                    rotate([0,0,90])
                    pocket(6,0.5);
            }

        // inset sole, less joint
        difference() {
                bevel_extrude(height=t+0.3, length=Length, width=Inside_Width+Outside_Width, cw=Chamfer_Width, $fn=20)
                offset(delta = -3, join_type = "round")
                Profile (Length, Heel_Radius, Toe_Radius, Inside_Width, Inside_Length, Outside_Width, Outside_Length, Instep_Offset);
                joint(w=2 + 4, t=t, rlt=rlt, num_hl=num_hl);
        }


    }

}

module Shoe() {
    t = Thickness;
    rlt = Rigid_Layer_Thickness;
    num_hl = Number_of_Hinge_Lines;
    inset = Chamfer_Width;
    gs = 14;  // grid spacing

    if (STL_Type=="Joined")
        difference() {
            bevel_extrude(height=t, length=Length, width=Inside_Width+Outside_Width, cw=Chamfer_Width, $fn=20)
                Profile (Length, Heel_Radius, Toe_Radius, Inside_Width, Inside_Length, Outside_Width, Outside_Length, Instep_Offset);
    
            // joint line
            joint(2, t, rlt, num_hl);
    
            // grid
            if (Lattice == "On") gridPattern(gs, t, rlt, num_hl);
        }
    if (STL_Type=="Upper")
        difference() {
            bevel_extrude(height=t, length=Length,width=Inside_Width+Outside_Width, cw=Chamfer_Width, $fn=20)
                Profile (Length, Heel_Radius, Toe_Radius, Inside_Width, Inside_Length, Outside_Width, Outside_Length, Instep_Offset);
    
            // joint line
            joint(2, t, rlt+0.2, num_hl);
    
            // grid
            if (Lattice == "On")
                translate ([0,0,-0.2])
                gridPattern(gs, t, rlt, num_hl);
            
            // Remove Lower
            translate ([-Outside_Width-5,-5,-5])
            cube([Outside_Width+Inside_Width+10,Length+10,Rigid_Layer_Thickness+5]);
        }
    if (STL_Type=="Lower")
        difference() {
            bevel_extrude(height=t, length=Length,width=Inside_Width+Outside_Width, cw=Chamfer_Width, $fn=20)
                Profile (Length, Heel_Radius, Toe_Radius, Inside_Width, Inside_Length, Outside_Width, Outside_Length, Instep_Offset);
            
            // Remove Upper
            translate ([-Outside_Width-5,-5,Rigid_Layer_Thickness])
            cube([Outside_Width+Inside_Width+10,Length+10,Thickness]);
    }
}

if (Foot == "Right") Shoe();
if (Foot == "Left") mirror([1,0,0]) {Shoe();}
