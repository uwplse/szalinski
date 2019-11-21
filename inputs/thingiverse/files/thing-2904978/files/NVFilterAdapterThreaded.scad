// Copyright © 2019, Moshen Chan
// Creative Commons License. Attribution-NonCommercial-ShareAlike 4.0 International
// Non-commercial only. https://creativecommons.org/licenses/by-nc-sa/4.0/

// CUSTOMIZER VARIABLES

// Inner diameter of adapter. Adjust for friction fit.
inner_diameter = 36.32;
// Adjust for filter threading. Filter thread diameter is 1.125"
filter_inner_diameter = 28.48;
// Thickness of front filter attachment.
filter_front_lip_thickness = 1.7;
// Thickness of outer adapter.
outer_thickness = 4.0;
// Length of adapter.
length = 12.0;

//http://www.lumicon.com/FAQs_Filters 
//Q: What are the thread sizes on Lumicon filters?
//A: The 1.25" filters employ industry-standard 1.125" x 42 tpi threads (except for Questar/Brandon, which use a thread pattern unique to Questar). The 48 mm filters employ industry-standard 48 x 0.75 mm threading, which thread into 2" eyepieces. All larger filters use the given size with 0.75 mm pitch (e.g. a 72 mm Minus Violet filter has 72 x 0.75 mm threads).
//
// While 1.25" works out to 31.7mm, the actual thread has a nominal diameter of 28.5mm and a pitch of 0.6mm. When you choose a filter for a 1.25" eyepiece, you will almost certainly find it has a male M28.5x0.6 thread.

// 1.25" filter thread diameter is 1.125" but tweak here via trial & error for your printer. 
thread_diameter_inches = 1.13;

// CUSTOMIZER VARIABLES END

outer_diameter = inner_diameter + outer_thickness;

$fn = 100;

// Configurable spines
module radial_spines(number_of_spines, thickness, width, height, diameter) {
    for(i = [1 : number_of_spines]) {
        angle = i*360/number_of_spines ;
        rotate([0, 0, angle]) translate([diameter/2, 0, -2]) cube(size = [ thickness, width, height], center = true);
    }
}

// Threading
function _numSections(numTurns) = 1+numTurns*$fn;

extrusionNudge = 0.001;

function threadPoints(section,radius,numTurns,lead) =
    let (n=len(section),
        m=_numSections(numTurns)
        ) 
        [ for (i=[0:m-1]) for (j=[0:n-1]) 
            let (z=i/$fn*lead,
                angle=(i%$fn)/$fn*360,
                v=section[j])
            [ (radius+v[0])*cos(angle), (radius+v[0])*sin(angle),z+v[1]] ];
        
function mod(m,n) = let(mm = m%n) mm<0 ? n+mm : mm;
        
function extrusionPointIndex(pointsPerSection,sectionNumber,pointInSection) = pointsPerSection*sectionNumber + mod(pointInSection,pointsPerSection);
        
function _extrusionStartFace(pointsPerSection) = 
    [for (i=[0:pointsPerSection-1]) extrusionPointIndex(pointsPerSection,0,i)];
            
function _extrusionEndFace(pointsPerSection, numSections) = 
    [for (i=[pointsPerSection-1:-1:0]) extrusionPointIndex(pointsPerSection,numSections-1,i)];
                
function extrusionTubeFaces(pointsPerSection, numSections) =
            [for (i=[0:numSections-2]) for (j=[0:pointsPerSection-1]) for(tri=[0:1])
                tri==0 ? 
                    [extrusionPointIndex(pointsPerSection,i,j),extrusionPointIndex(pointsPerSection,i+1,j),extrusionPointIndex(pointsPerSection,i,j+1)] :
                    [extrusionPointIndex(pointsPerSection,i,j+1), extrusionPointIndex(pointsPerSection,i+1,j),
            extrusionPointIndex(pointsPerSection,i+1,j+1)]];
                
function extrusionFaces(pointsPerSection, numSections) = concat([_extrusionStartFace(pointsPerSection),_extrusionEndFace(pointsPerSection,numSections)],extrusionTubeFaces(pointsPerSection, numSections));

                    
module rawThread(profile, d=undef, h=10, lead=undef, $fn=72, adjustRadius=false, clip=true, includeCylinder=true) {
    radius = d/2;
    vSize = max([for(v1=profile) for(v2=profile) v2[1]-v1[1]]);
    vMin = min([for(v=profile) v[0]]);
    radiusAdjustment = adjustRadius ? vMin : 0;
    _lead = lead==undef ? vSize : lead;
    profileScale = vSize <= _lead-extrusionNudge ? 1 : (_lead-extrusionNudge)/vSize;
    adjProfile = [for(v=profile) [v[0]-radiusAdjustment,v[1]*profileScale]];
    adjRadius = radius + radiusAdjustment;
    hSize = 1+2*adjRadius + 2*max([for (v=adjProfile) v[0]]);
    numTurns = 2+ceil(h/_lead);
    render(convexity=10)
    union() {
        intersection() {
            if (clip)
                translate([-hSize/2,-hSize/2,0]) cube([hSize,hSize,h]);
            translate([0,0,-_lead]) polyhedron(faces=extrusionFaces(len(adjProfile), _numSections(numTurns)), points=threadPoints(
            adjProfile,adjRadius,numTurns,_lead));
        }
        if (includeCylinder) 
            cylinder(r=adjRadius+extrusionNudge,$fn=$fn,h=h);
    }
}

function inch_to_mm(x) = x * 25.4;

// internal = female
module isoThread(d=undef, dInch=undef, pitch=1, tpi=undef, h=1, hInch=undef, lead=undef, leadInch=undef, angle=30, internal=false, starts=1, $fn=72) {

    P = (tpi==undef) ? pitch : inch_to_mm(1/tpi);

    radius = dInch != undef ? inch_to_mm(dInch)/2 : d/2;    
    height = hInch != undef ? inch_to_mm(hInch) : h;
     
    Dmaj = 2*radius;
    H = P * cos(angle);
    
    _lead = leadInch != undef ? inch_to_mm(leadInch) : lead != undef ? lead : P;
    
    externalExtra=0.03;
    internalExtra=0.057;
    profile = !internal ? 
        [ [-H*externalExtra,(-3/8-externalExtra)*P], 
          [(5/8)*H,-P/16],[(5/8)*H,P/16], 
          [-H*externalExtra,(3/8+externalExtra)*pitch] ] :
        [ [0,-(3/8)*P], 
        [(5/8)*H,-P/16],[(5/8+internalExtra)*H,0],
        [(5/8)*H,P/16],[0,(3/8)*P] ];
    Dmin = Dmaj-2*5*H/8;
    myFN=$fn;
    for (i=[0:starts-1]) {
        rotate([0,0,360/starts*i]) rawThread(profile,d=Dmin,h=height,lead=_lead,$fn=myFN,adjustRadius=true);        
    }
}

// Main body Attaches to PVS-14 / Envis
translate ([0, 0, (length / 2)]) difference () 
{
    // Outer
    cylinder(r = (outer_diameter) / 2, h = length, center = true);
    // Inner cut
    cylinder(r =  inner_diameter/ 2, h = length +1, center = true);       

    spine_depth = 0.6;
    radial_spines(16, spine_depth, 4, length+ 10, outer_diameter - spine_depth);   
    
    // inside spines
    inside_spine_depth = 0.4;
    rotate([0, 0, 11]) radial_spines(16, inside_spine_depth, 3.1, length+ 10, inner_diameter + inside_spine_depth - 0.2);    
 
}

// Main body
translate ([0, 0, (length / 2)]) difference () 
{
    // Outer
    cylinder(r = (outer_diameter) / 2, h = length, center = true);
    // Inner cut
    cylinder(r =  inner_diameter/ 2, h = length +1, center = true);       

    spine_depth = 0.6;
    radial_spines(16, spine_depth, 4, length+ 10, outer_diameter - spine_depth);   
    
    // inside spines
    inside_spine_depth = 0.4;
    rotate([0, 0, 11]) radial_spines(16, inside_spine_depth, 3.1, length+ 10, inner_diameter + inside_spine_depth - 0.2);    
 
}


// Cut threads. 
translate ([0, 0, length]) difference () 
{
    cylinder(r = (outer_diameter) / 2, h = filter_front_lip_thickness, center = true);
    translate([0,0, -filter_front_lip_thickness/2 + -extrusionNudge]) isoThread(dInch = 1.13, h=filter_front_lip_thickness + 2*extrusionNudge, tpi=42, angle=40, internal=true, $fn=100);
}

