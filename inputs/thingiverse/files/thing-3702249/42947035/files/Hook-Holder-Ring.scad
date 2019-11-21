// preview[view:north east, tilt:top]

$fn=100;

function sqr(x) = pow(x,2);
function sqrt(x) = pow(x, 1/2);

function getx(c, r, sc, s=1) =	let (cx=c[0], cy=c[1], px=sc[0], py=sc[1]) ((sqr(r)*(px-cx)+(s*r*(py-cy)*sqrt(sqr(px-cx)+sqr(py-cy)-sqr(r)))) /
			(sqr(px-cx)+sqr(py-cy)))
			+cx;

function gety(c, r, sc, s=1) =	let (cx=c[0], cy=c[1], px=sc[0], py=sc[1]) ((sqr(r)*(py-cy)+(s*r*(px-cx)*sqrt(sqr(px-cx)+sqr(py-cy)-sqr(r)))) /
			(sqr(px-cx)+sqr(py-cy)))
			+cy;
			
// Get center of similitude, either internal or external		
// s=-1 for external and 1 for internal
function GetSimCentre (c0, r0, c1, r1, s=-1) = let (a=c0[0], b=c0[1], c=c1[0], d=c1[1]) [(c*r0+s*a*r1)/(r0+s*r1), (d*r0+s*b*r1)/(r0+s*r1)];

// c=centre of circle, r=radius, sc=center of similitude
// s selects which tangent point on circle depending on whether 1 or -1
function GetTangent (c, r, sc, s=1) = [getx(c, r, sc, s), gety(c, r, sc, s=-s)];

Ring_Size = 19.6;//[12.4:0.5 <12.4mm>,12.8:1 <12.8mm>,13.2:1.5 <13.2mm>,13.6:2 <13.6mm>,14:2.5 <14mm>,14.4:3 <14.4mm>,14.8:3.5 <14.8mm>,15.2:4 <15.2mm>,15.6:4.5 <15.6mm>,16:5 <16mm>,16.4:5.5 <16.4mm>,16.8:6 <16.8mm>,17.2:6.5 <17.2mm>,17.6:7 <17.6mm>,18:7.5 <18mm>,18.4:8 <18.4mm>,18.8:8.5 <18.8mm>,19.2:9 <19.2mm>,19.6:9.5 <19.6mm>,20:10 <20mm>,20.4:10.5 <20.4mm>,20.8:11 <20.8mm>,21.2:11.5 <21.2mm>,21.6:12 <21.6mm>,22:12.5 <22mm>,22.4:13 <22.4mm>,22.8:13.5 <22.8mm>,23.2:14 <23.2mm>,23.6:14.5 <23.6mm>,24:15 <24mm>,24.4:15.5 <24.4mm>,24.8:16 <24.8mm>]

//mm
Ring_Width = 9;//[8:12]

//mm
Ring_Thickness = 2;//[.8,1.2,1.6,2,2.4,2.8,3.2,3.6,4]

//mm
Holder_Size = 4;//[3,4,5]

//mm
Hole_Size = 4;//[3,4,5]

Outer_Radius = (Ring_Size+Ring_Thickness*2)/2;

hook_holder_ring();

module hook_holder_ring(){

difference()
{
  
    difference()
    {
        union()
        {
            // outer ring
            cylinder(r=Outer_Radius, h=Ring_Width);
                
            // hook holder standoff
            c0 = [0, 0];
            r0 = Outer_Radius;
            c1 = [0, Outer_Radius + Hole_Size];
            r1 = Holder_Size;

            // Get center of similitude, either internal or external		
            // s=-1 for external and 1 for internal
            sc = GetSimCentre(c0, r0, c1, r1, s=-1); 

            // Points on C0
            t0 = GetTangent(c0, r0, sc, s=1);
            t1 = GetTangent(c0, r0, sc, s=-1);

            // Points on C1
            t2 = GetTangent(c1, r1, sc, s=1);
            t3 = GetTangent(c1, r1, sc, s=-1);

            linear_extrude (height=Ring_Width)
            polygon ([t0, t2, t3, t1]);
        }

        // hook hole
        translate([-Hole_Size/2,Outer_Radius,0])
        cube([Hole_Size,Hole_Size,Ring_Width]); 

        // finger hole
        cylinder(r=Ring_Size/2, h=Ring_Width);
    }

    // chamfers
    translate([0,0,Ring_Width/2])
    {
        // top chamfer
        translate([0,Outer_Radius+Holder_Size/2,Ring_Width])
        rotate([-30,0,0])
        cube([50,20,10], center=true);

        // bottom chamfer
        translate([0,Outer_Radius+Holder_Size/2,-Ring_Width])
        rotate([30,0,0])
        cube([50,20,10], center=true);
    }

    // lower inner bevel
    translate([0,0,-Ring_Thickness/2])
    cylinder(r1=Outer_Radius, r2=0, h=Ring_Width);

    // upper inner bevel
    translate([0,0,Ring_Thickness/2])
    cylinder(r2=Outer_Radius, r1=0, h=Ring_Width);
}

}
