// Use for command line option '-Dgen=n', overrides 'part'
// 0-18 - generate parts individually in assembled positions. Combine with MeshLab.
// 20 - generate core only
// 21 - generate core with holes
// 22 - generate core half
// 23 - generate gear0
// 24 - generate gear5
// 25 - generate gear9
// 26 - generate gear17
// 28 - cross section
// 29 - test gear triplet
// 30 - Core half hole
// 31 - shaft
// 32 - flat base
// 99 - generate all parts assembled (very slow implicit union)
gen=undef;

// Which part to generate
part="gear_fix"; // [core:Whole Core,core_holes:Core with Holes,core_half:Half Core,gear_top:Top Gear,gear_free:Free Gear,gear_fix:Pivot Gear,gear_base:Base Gear,core_halfhole:Half Core with Holes,shaft:Shaft,flat_base:Flat Base]

// Emboss logo
logo = 0; // [0:false, 1:true]
// Logo z-scale (maximum - 1 for customizer, 100 for local png)
logo_zscale = 1;
// Logo file
logo_file = "logo.png"; // [image_surface:150x150]
// Use 608 bearings?
use_bearing=1; // [0:false, 1:true]
// Replace gears with cones. Useful for tweaking dimensions
simplify_gears=0; // [0:false, 1:true]
// Use slotted shafts. Alternative is straight press-fit or cut post-print (less fuss).
slotted=0; // [0:false, 1:true]
// Speed holes. A bad idea to speed up print time.
speedholes=0; // [0:false, 1:true]
// flat bottom of gears for easier printing
trim_gears=1; // [0:false, 1:true]
// gear base/flange height (for free gears)
gear_b=1.65;
// Be stingy with the bearings (only half the gears)
stingy=1; // [0:false, 1:true]
// Only hollow out some vertexes to avoid overhang (if stingy=false)
simp_holl=1;// [0:false, 1:true]
// Outer radius of the assembled gear sphere
sphere_R = 50;
// Core shell thickness
shell = 2;
// Gear scale relative to sphere_R. Tweak for fit and gear meshing.
scl = 1.063; // 17,20

// height of gears (sans cap)
gear_h = 10;
// distance from top of gear to bottom of bearing
bearing_h = 11.5;
// bearing shaft length
bearing_s = 7;
// gear bearing recess depth (from bottom of bearing)
bearing_d = 8.5;
// bearing radius
bearing_r = 11;
// bearing bore radius
bearing_b = 4;
// target gear module, actual module will be adjusted by scl
gear_module=2;
// helix twist angle of gears
gear_twist = 10;
// Mark tooth 0 for debugging
mark_tooth = 0; // [0:false, 1:true]
g_module=gear_module*scl;
// curve segments
$fn=48;
// Geometry overlap
AT=0.01;
// Number of segments in gear tooth
t_segs=4;
// Vertical gear segments
g_segs=4;
// Number of gear teeth
gt = [17, 20,20,20,20, 20,20,20,20, 20,20,20,20, 20,20,20,20, 17];
// Number of gears in each row (TODO)
gr = [1,4,4,4,4,1];
// Angular offsets for first gear layer
of=[0,90,180,270];

/* [Hidden] */

//P0=[0,0,1];
P0=polar(180,0.01); // Avoid singularity

//function cat(L1, L2) = [for(L=[L1, L2], a=L) a];
//P1=[for(L=[polar(of[0],arc(n1=gt[0],n2=gt[1])), [180+2*of[0]+180/gt[1]]], a=L) a];
P1=polar(of[0],arc(n1=gt[0],n2=gt[1]));
P2=polar(of[1],arc(n1=gt[0],n2=gt[2]));
P3=polar(of[2],arc(n1=gt[0],n2=gt[3]));
P4=polar(of[3],arc(n1=gt[0],n2=gt[4]));

P5=trilat(P1,arc(gt[1],gt[5]),P2,arc(gt[2],gt[5]));
P6=trilat(P2,arc(gt[2],gt[6]),P3,arc(gt[3],gt[6]));
P7=trilat(P3,arc(gt[3],gt[7]),P4,arc(gt[4],gt[7]));
P8=trilat(P4,arc(gt[4],gt[8]),P1,arc(gt[1],gt[8]));

P9=trilat(P5,arc(gt[5],gt[9]),P6,arc(gt[6],gt[9]));
P10=trilat(P6,arc(gt[6],gt[10]),P7,arc(gt[7],gt[10]));
P11=trilat(P7,arc(gt[7],gt[11]),P8,arc(gt[8],gt[11]));
P12=trilat(P8,arc(gt[8],gt[12]),P5,arc(gt[5],gt[12]));

P13=trilat(P9,arc(gt[9],gt[13]),P10,arc(gt[10],gt[13]));
P14=trilat(P10,arc(gt[10],gt[14]),P11,arc(gt[11],gt[14]));
P15=trilat(P11,arc(gt[11],gt[15]),P12,arc(gt[12],gt[15]));
P16=trilat(P12,arc(gt[12],gt[16]),P9,arc(gt[9],gt[16]));

P17c=trilat(P13,arc(gt[13],gt[17]),P14,arc(gt[14],gt[17]));
P17=polar(180,179.99); // Avoid singularity
echo("P17 error: ",norm(P17c-P17));

G0=[gt[0],P0,0];
G1=[gt[1],P1,180+gt[0]/gt[1]*of[0],true];
G2=[gt[2],P2,180+gt[0]/gt[2]*of[1],true];
G3=[gt[3],P3,180+gt[0]/gt[3]*of[2],true];
G4=[gt[4],P4,180+gt[0]/gt[4]*of[3],true];

// rotate gear to mesh with another given gear, coordinate and teeth
function grot(G,P,t) = 180+acos(cross(P,[0,0,1])*cross(P,G[1])/norm(cross(P,[0,0,1]))/norm(cross(P,G[1])))-G[0]/t*(acos(cross(G[1],[0,0,1])*cross(G[1],P)/norm(cross(G[1],[0,0,1]))/norm(cross(G[1],P)))+G[2]);

G5=[gt[5],P5,grot(G1,P5,gt[5])];
G6=[gt[6],P6,grot(G2,P6,gt[6])];
G7=[gt[7],P7,grot(G3,P7,gt[7])];
G8=[gt[8],P8,grot(G4,P8,gt[8])];

G9=[gt[9],P9,grot(G5,P9,gt[9]),true];
G10=[gt[10],P10,grot(G6,P10,gt[10]),true];
G11=[gt[11],P11,grot(G7,P11,gt[11]),true];
G12=[gt[12],P12,grot(G8,P12,gt[12]),true];

G13=[gt[13],P13,grot(G9,P13,gt[13])];
G14=[gt[14],P14,grot(G10,P14,gt[14])];
G15=[gt[15],P15,grot(G11,P15,gt[15])];
G16=[gt[16],P16,grot(G12,P16,gt[16])];

G17=[gt[17],P17,grot(G13,P17,gt[17]),true];

if (gen==99) {
    trg(G0);
    trg(G1);trg(G2);trg(G3);trg(G4);
    trg(G5);trg(G6);trg(G7);trg(G8);
    trg(G9);trg(G10);trg(G11);trg(G12);
    trg(G13);trg(G14);trg(G15);trg(G16);
    trg(G17);
    core();
} else if (gen==0) { // TODO: Array of gears...
    core();
} else if (gen==1) {
    trg(G0);
} else if (gen==2) {
    trg(G1);
} else if (gen==3) {
    trg(G2);
} else if (gen==4) {
    trg(G3);
} else if (gen==5) {
    trg(G4);
} else if (gen==6) {
    trg(G5);
} else if (gen==7) {
    trg(G6);
} else if (gen==8) {
    trg(G7);
} else if (gen==9) {
    trg(G8);
} else if (gen==10) {
    trg(G9);
} else if (gen==11) {
    trg(G10);
} else if (gen==12) {
    trg(G11);
} else if (gen==13) {
    trg(G12);
} else if (gen==14) {
    trg(G13);
} else if (gen==15) {
    trg(G14);
} else if (gen==16) {
    trg(G15);
} else if (gen==17) {
    trg(G16);
} else if (gen==18) {
    trg(G17);
} else if (gen==20 || (gen==undef && part=="core")) {
    mirror([0,0,1]) core();
} else if (gen==21 || (gen==undef && part=="core_holes")) {
    mirror([0,0,1]) difference(){
        hull(){
            skel(P1,gt[1]);
            skel(P2,gt[2]);
            skel(P3,gt[3]);
            skel(P4,gt[4]);
            skel(P9,gt[9]);
            skel(P10,gt[10]);
            skel(P11,gt[11]);
            skel(P12,gt[12]);
            skel(P17,gt[17]);
            if(!stingy){
                skel(P5,gt[5]);
                skel(P6,gt[6]);
                skel(P7,gt[7]);
                skel(P8,gt[8]);
                skel(P13,gt[13]);
                skel(P14,gt[14]);
                skel(P15,gt[15]);
                skel(P16,gt[16]);
                skel(P0,gt[0]);
            }
        }
        shaft(P1,gt[1]);
        shaft(P2,gt[2]);
        shaft(P3,gt[3]);
        shaft(P4,gt[4]);
        shaft(P9,gt[9]);
        shaft(P10,gt[10]);
        shaft(P11,gt[11]);
        shaft(P12,gt[12]);
        shaft(P17,gt[17]);
        if(!stingy){
            shaft(P5,gt[5]);
            shaft(P6,gt[6]);
            shaft(P7,gt[7]);
            shaft(P8,gt[8]);
            shaft(P13,gt[13]);
            shaft(P14,gt[14]);
            shaft(P15,gt[15]);
            shaft(P16,gt[16]);
            shaft(P0,gt[0]);
        }
    }
} else if (gen==22 || (gen==undef && part=="core_half")) {
    intersection(){
        translate([-sphere_R,-sphere_R,0])cube([sphere_R*2,sphere_R*2,sphere_R]);
        rotate([90,0,0]) core();
    }
} else if (gen==23 || (gen==undef && part=="gear_top")) {
    translate([0,0,vo(gt[0])]) gear2(n=gt[0],a=gear_twist);
} else if (gen==24 || (gen==undef && part=="gear_free")) {
    translate([0,0,vo(gt[5])]) gear2(n=gt[5],a=gear_twist);
} else if (gen==25 || (gen==undef && part=="gear_fix")) {
    translate([0,0,vo(gt[9])]) gear2(n=gt[9],a=-gear_twist);
} else if (gen==26 || (gen==undef && part=="gear_base")) {
    translate([0,0,vo(gt[17])]) gear2(n=gt[17],a=-gear_twist);
} else if (gen==32 || (gen==undef && part=="flat_base")) {
    r = g_module*gt[17]/2; // Pitch radius
    d=sphere_R-sqrt(pow(sphere_R,2)-pow(r-g_module,2)); // vertical offset
    translate([0,0,2*gear_h-d])rotate([180,0,0]){
        translate([0,0,vo(gt[17])]) gear2(n=gt[17],a=-gear_twist);
        translate([0,0,gear_h])cylinder(r=r-g_module,h=d);
        difference(){
            translate([0,0,gear_h-d])cylinder(r1=r+g_module,r2=sphere_R/1.618,h=gear_h/2);
            translate([0,0,d+gear_h-sphere_R]) sphere(r=sphere_R);
        }
        translate([0,0,1.5*gear_h-d])cylinder(r=sphere_R/1.618,h=gear_h/2);
    }
} else if (gen==27) {
    union(){
        translate([0,0,vo(gt[0])]) mirror([1,0,0]) gear2(n=gt[0]);
        bearing();
    }
} else if (gen==28) { // cross section assembled
    intersection(){
        translate([-sphere_R,-sphere_R,0])cube([sphere_R*2,sphere_R*2,sphere_R]);
        
        rotate([90,0,0]) union(){
            trg(G0);
            trg(G1); trg(G2); trg(G3); trg(G4);
            trg(G5); trg(G6); trg(G7); trg(G8);
            trg(G9); trg(G10); trg(G11); trg(G12);
            trg(G13); trg(G14); trg(G15); trg(G16);
            trg(G17);
        }
    }

    //core();
} else if (gen==29) { // gear pair
    trg(G0);
    trg(G1);
    trg(G5);
} else if (gen==30 || (gen==undef && part=="core_halfhole")) {
    intersection(){
        translate([-sphere_R,-sphere_R,0])cube([sphere_R*2,sphere_R*2,sphere_R]);
        rotate([90,0,0]) core(true);
    }
} else if (gen==31 || (gen==undef && part=="shaft")) {
    intersection(){
        translate([-sphere_R,-sphere_R,0])cube([sphere_R*2,sphere_R*2,sphere_R]);
        rotate([90,0,0]) difference(){
            cylinder(r=bearing_b,h=2*bearing_s);
            translate([0,0,-AT])cylinder(d=3,h=2*bearing_s+2*AT);
        }
    }
}

module core(holes=false) {
    difference(){
        union(){ //TODO: use some loops, ffs
            spoke(P1,gt[1]);
            if(!holes)spoke(P2,gt[2]);
            spoke(P3,gt[3]);
            spoke(P4,gt[4]);
            if(!holes)spoke(P9,gt[9]);
            spoke(P10,gt[10]);
            spoke(P11,gt[11]);
            spoke(P12,gt[12]);
            spoke(P17,gt[17]);
            
            if(!stingy){
                if(!holes)spoke(P5,gt[5]);
                if(!holes)spoke(P6,gt[6]);
                spoke(P7,gt[7]);
                spoke(P8,gt[8]);
                if(!holes)spoke(P13,gt[13]);
                spoke(P14,gt[14]);
                spoke(P15,gt[15]);
                if(!holes)spoke(P16,gt[16]);
                spoke(P0,gt[0]);
            }
    
            hull(){
                skel(P1,gt[1]);
                skel(P2,gt[2]);
                skel(P3,gt[3]);
                skel(P4,gt[4]);
                skel(P9,gt[9]);
                skel(P10,gt[10]);
                skel(P11,gt[11]);
                skel(P12,gt[12]);
                skel(P17,gt[17]);

                if(!stingy){
                    skel(P5,gt[5]);
                    skel(P6,gt[6]);
                    skel(P7,gt[7]);
                    skel(P8,gt[8]);
                    skel(P13,gt[13]);
                    skel(P14,gt[14]);
                    skel(P15,gt[15]);
                    skel(P16,gt[16]);
                    skel(P0,gt[0]);
                }
            }
        }
        hull(){
            holl(P1,gt[1]);
            holl(P2,gt[2]);
            holl(P3,gt[3]);
            holl(P4,gt[4]);
            holl(P9,gt[9]);
            holl(P10,gt[10]);
            holl(P11,gt[11]);
            holl(P12,gt[12]);
            holl(P17,gt[17]);
            if(!stingy){
                holl(P0,gt[0]);
                if (!simp_holl) {
                    holl(P5,gt[5]);
                    holl(P6,gt[6]);
                    holl(P7,gt[7]);
                    holl(P8,gt[8]);
                    holl(P13,gt[13]);
                    holl(P14,gt[14]);
                    holl(P15,gt[15]);
                    holl(P16,gt[16]);
                }
            }
        }
        if (speedholes) { // TODO: store gear_n in P, along with rot
            speedhole([P1,P2,P3,P4],[gt[1],gt[2],gt[3],gt[4]]);
            speedhole([P1,P2,P12,P9],[gt[1],gt[2],gt[12],gt[9]]);
            speedhole([P2,P3,P9,P10],[gt[2],gt[3],gt[9],gt[10]]);
            speedhole([P3,P4,P10,P11],[gt[3],gt[4],gt[10],gt[11]]);
            speedhole([P4,P1,P11,P12],[gt[4],gt[1],gt[11],gt[12]]);
            speedhole([P17,P9,P10],[gt[17],gt[9],gt[10]]);
            speedhole([P17,P10,P11],[gt[17],gt[10],gt[11]]);
            speedhole([P17,P11,P12],[gt[17],gt[11],gt[12]]);
            speedhole([P17,P12,P9],[gt[17],gt[12],gt[9]]);
        }
        if (!slotted) { // holes for re-inforcing skewers
            if(holes){
                r(P2) cylinder(r=bearing_b,h=sphere_R);
                r(P9) cylinder(r=bearing_b,h=sphere_R);
                if(!stingy){
                    r(P5) cylinder(r=bearing_b,h=sphere_R);
                    r(P6) cylinder(r=bearing_b,h=sphere_R);
                    r(P13) cylinder(r=bearing_b,h=sphere_R);
                    r(P16) cylinder(r=bearing_b,h=sphere_R);
                }
            } else {
                r(P2) cylinder(d=3,h=sphere_R,$fn=24);
                r(P9) cylinder(d=3,h=sphere_R,$fn=24);
                if(!stingy){
                    r(P5) cylinder(d=3,h=sphere_R,$fn=24);
                    r(P6) cylinder(d=3,h=sphere_R,$fn=24);
                    r(P13) cylinder(d=3,h=sphere_R,$fn=24);
                    r(P16) cylinder(d=3,h=sphere_R,$fn=24);
                }
            }
            r(P1) cylinder(d=3,h=sphere_R,$fn=24);
            r(P3) cylinder(d=3,h=sphere_R,$fn=24);
            r(P4) cylinder(d=3,h=sphere_R,$fn=24);
            r(P10) cylinder(d=3,h=sphere_R,$fn=24);
            r(P11) cylinder(d=3,h=sphere_R,$fn=24);
            r(P12) cylinder(d=3,h=sphere_R,$fn=24);
            r(P17) cylinder(d=3,h=sphere_R,$fn=24);
            if(!stingy){
                r(P0) cylinder(d=3,h=sphere_R,$fn=24);
                r(P7) cylinder(d=3,h=sphere_R,$fn=24);
                r(P8) cylinder(d=3,h=sphere_R,$fn=24);
                r(P14) cylinder(d=3,h=sphere_R,$fn=24);
                r(P15) cylinder(d=3,h=sphere_R,$fn=24);
            }
        }
    }
}

// Various experimental cut-outs on core faces. Didn't pan out.
module speedhole(P,G){
    l=len(P);
    m=[for(i=[0:l-1])(sphere_R+gear_h-vo(G[i])-bearing_h-shell)/sphere_R]*P/l;
    //hull()for(i=P)r(2*l*i+m)cylinder(r=AT,h=sphere_R,$fn=4);
    //r(P1+P2+P12+P9) cylinder(d=30,h=sphere_R);
    //on second thought, why not just hull between adjacent spokes?
    //translate(m*sphere_R)sphere(r=norm(m)*sphere_R);
    //translate(m*sphere_R)r(m)sphere(r=norm(m)*sphere_R);
    //r(m)sphere(r=2*norm(m)*sphere_R-2);
    //tr(m*sphere_R)sphere(r=norm(m)*sphere_R);
    //translate([0,0,gear_h-vo(n)-bearing_h])
    tr(2*m)sphere(r=norm(m)*sphere_R-1.2);
    
        //tr(P) translate([0,0,gear_h-vo(n)-bearing_h-shell])
        //sphere(r=0.01,$fn=4);
}

module skel(P=[0,0,1],n=20){
    tr(P) translate([0,0,-sphere_R])
        cylinder(r=bearing_b+2,h=sphere_R-vo(n)+gear_h-bearing_h);
}

module holl(P=[0,0,1],n=20){
    tr(P) translate([0,0,gear_h-vo(n)-bearing_h-shell])
        sphere(r=0.01,$fn=4);
}

module shaft(P=[0,0,1],n=20){
    tr(P) translate([0,0,gear_h-vo(n)-21.99])
        cylinder(r=4,h=15.01);
}

module spoke(P=[0,0,1],n=20){
    tr(P)rotate([0,0,P.y>0.1?90:0]) { //TODO: Rotate others to be vertical
        difference(){
            union(){
                translate([0,0,-sphere_R]) {
                    cylinder(r=bearing_b,h=sphere_R-vo(n)+gear_h-bearing_h+bearing_s);
                    cylinder(r=bearing_b+2,h=sphere_R-vo(n)+gear_h-bearing_h);
                }
                if (slotted) translate([0,0,gear_h-vo(n)-0.01-bearing_h+bearing_s]) intersection(){
                    translate([-bearing_b,-bearing_b-0.5,-0.01]) cube([2*bearing_b,2*bearing_b+1,1.52]);
                    cylinder(r=bearing_b+0.5,h=1.5);
                }
            }
            if (slotted)
                translate([-bearing_b-0.01,-0.5,gear_h-vo(n)+2.5-bearing_h]) cube([2*bearing_b+0.02,1,bearing_s-0.99]);
        }
    }
}



function arc(n1,n2,m=g_module,R=sphere_R)=asin(m*n1/2/R)+asin(m*n2/2/R);

function polar(t,p) = [sin(p)*cos(t),sin(p)*sin(t),cos(p)];

function trilat(P1,a1,P2,a2) = 
[(2-pow(2*sin(a1/2),2))/2,
 (2-pow(2*sin(a2/2),2))/(2*norm(cross(P1,P2)))-(2-pow(2*sin(a1/2),2))/2*(P1*P2)/norm(cross(P1,P2)),
 sqrt(1-pow((2-pow(2*sin(a1/2),2))/2,2)-pow((2-pow(2*sin(a2/2),2))/(2*norm(cross(P1,P2)))-(2-pow(2*sin(a1/2),2))/2*(P1*P2)/norm(cross(P1,P2)),2))
]*[P1,(P2-(P1*P2)*P1)/norm(P2-(P1*P2)*P1),cross(P2,P1)/norm(cross(P2,P1))];


module tr(P=[0,0,1], sphere_R=sphere_R) {
  translate(sphere_R*P)
    rotate([-atan2(sqrt(pow(P.x,2)+pow(P.y,2)),P.z),0,-atan2(P.x,P.y)])
        children();
}

module trg(G=[11,[0,0,1],0,false], sphere_R=sphere_R) {
  n=G[0];
  P=G[1];
  turn=90+G[2]+(G[3]?0:180-180/n);
  //turn=270+G[2]+(G[3]?0:-180/n);
  a=G[3]?-gear_twist:gear_twist;
    
  tr(P) rotate([0,0,turn]) gear2(n=n,a=a);
}

module r(P=[0,0,1]) {
    rotate([-atan2(sqrt(pow(P.x,2)+pow(P.y,2)),P.z),0,-atan2(P.x,P.y)])
        rotate([0,0,len(P)==3?0:P[4]]) children();
}

function vo(n=20, m=g_module, h=gear_h, R=sphere_R) = R-sqrt(pow(R,2)-pow(m*(n/2-1),2))+h;

// n2 is number of teeth in optimal mating gear which determines contact angle
module gear2(n=20, a=10, m=g_module, h=gear_h, R=sphere_R) {
    // Pitch radius
    r = m*n/2;
    
    // Angle between axes
    ax=asin(r/R);

    // vertical offset
    d=R-sqrt(pow(R,2)-pow(r-m,2));
    
    rotate([180,0,180]) difference() {
        union() {
            // Tooth 0 marker
            if (mark_tooth) translate([-r,-0.5,0]) cube([r,1,d]);
        
            intersection(){
                union(){
                    translate([0,0,R]) sphere(r=R-(logo?1:0));
                    if(logo)intersection(){
                        translate([0,0,R]) sphere(r=R);
                        translate([0,0,d]) scale([(m-r)/75,(r-m)/75,-d/logo_zscale])surface(file=logo_file, center=true, convexity=5);
                    }
                }
                translate([0,0,-d])cylinder(r=r-m,h=2*d+0.01);
            }
            translate([0,0,d]) {
                if(simplify_gears){
                    difference(){
                        cylinder(r1=(sphere_R-d)*tan(ax),r2=(sphere_R-d-h)*tan(ax),h=h);
                        translate([0,0,-0.01]) cylinder(r=bearing_r,h=h+0.02);
                    }
                } else intersection(){
                    pfeilkegelrad(modul=m, zahnzahl=n, teilkegelwinkel=ax, zahnbreite=h/cos(ax), bohrung=0, eingriffswinkel=20, schraegungswinkel=a);                    
                    if (trim_gears&&a<0) translate([-r-m,-r-m,-d]) cube([2*(r+m),2*(r+m),d+h]);
                }
                if(a>0){
                    if(trim_gears)intersection(){
                        translate([0,0,h])cylinder(r1=(sphere_R-d-h)*tan(ax),r2=(sphere_R-d-h)*tan(ax)+gear_b*cos(ax),h=gear_b);
                        translate([0,0,(h-gear_b)/2])cylinder(r1=(sphere_R-d)*tan(ax),r2=(sphere_R-d-h)*tan(ax),h=h); // Fudge - TODO: calculate gear envelope properly
                    }
                } else if (!use_bearing) bearing();
            }
        }
        if(a<0){
            if (use_bearing) translate([0,0,bearing_h-bearing_d+d])
                cylinder(r=bearing_r,h=bearing_d+AT);
            translate([0,0,bearing_h-bearing_d-1+d])
                cylinder(r=bearing_b+1.5,h=1+AT);
            translate([0,0,bearing_h-bearing_s+d])
                cylinder(r=bearing_b,h=bearing_s+AT);
        }
    }
}

// 608 bearing: 8mm core, a 22mm outer diameter and a 7mm width
module bearing() {
    difference(){
        cylinder(r=bearing_r,h=bearing_h);
        translate([0,0,-0.01]) cylinder(r=bearing_b,h=bearing_h+0.02);
    }
    //union(){
    //    cylinder(r=11,h=6.99);
    //    cylinder(r=6,h=8);
    //}
}


// Taken from thing:1604369, slightly fudged. Will probably unpack and generate herringbone poly directly. Some trig bugs.

// Allgemeine Variablen
//pi = 3.14159;
//rad = 57.29578;
spiel = 0.05;	// Spiel zwischen Zahnen (Backlash)

/*  Kugelevolventen function
    Returns the azimuth angle of a bulb
    theta0 = polar angle of the cone at the cutting edge of which the involute rolls
    theta = polar angle for which the azimuth angle of the involute is to be calculated */
function kugelev(theta0,theta) = 1/sin(theta0)*acos(cos(theta)/cos(theta0))-acos(tan(theta0)/tan(theta));

/*  Wandelt Kugelkoordinaten in kartesische um
    Format: radius, theta, phi; theta = Winkel zu z-Achse, phi = Winkel zur x-Achse auf xy-Ebene */
function kugel_zu_kart(vect) = [
	vect[0]*sin(vect[1])*cos(vect[2]),  
	vect[0]*sin(vect[1])*sin(vect[2]),
	vect[0]*cos(vect[1])
];

/*  Pfeil-Kegelrad; verwendet das Modul "kegelrad"
    modul = Hohe des Zahnkopfes uber dem Teilkreis
    zahnzahl = Anzahl der Radzahne
    teilkegelwinkel, zahnbreite
    bohrung = Durchmesser der Mittelbohrung
    eingriffswinkel = Eingriffswinkel, Standardwert = 20deg gemaB DIN 867. Sollte nicht groBer als 45deg sein.
    schraegungswinkel = Schragungswinkel, Standardwert = 0deg */
module pfeilkegelrad(modul, zahnzahl, teilkegelwinkel, zahnbreite, bohrung, eingriffswinkel = 20, schraegungswinkel=0){

	// Dimensions-Berechnungen
	d_aussen = modul * zahnzahl;								// Teilkegeldurchmesser auf der Kegelgrundflache,
																// entspricht der Sehne im Kugelschnitt
	r_aussen = d_aussen / 2;									// Teilkegelradius auf der Kegelgrundflache 
	rg_aussen = r_aussen/sin(teilkegelwinkel);					// GroBkegelradius, entspricht der Lange der Kegelflanke;
	c = modul / 6;												// Kopfspiel
	df_aussen = d_aussen - (modul +c) * 2 * cos(teilkegelwinkel);
	rf_aussen = df_aussen / 2;
	delta_f = asin(rf_aussen/rg_aussen);
	hoehe_f = rg_aussen*cos(delta_f);							// Hohe des Kegels vom FuBkegel

	// Torsionswinkel gamma aus Schragungswinkel
	//gamma_g = 2*atan(zahnbreite*tan(schraegungswinkel)/(2*rg_aussen-zahnbreite));
	//gamma = 2*asin(rg_aussen/r_aussen*sin(gamma_g/2));
	//gamma = -10*g_segs; // test fixed rotation angle
	
	// GroBen fur Komplementar-Kegelstumpf
	hoehe_k = (rg_aussen-zahnbreite)/cos(teilkegelwinkel);		// Hohe des Komplementarkegels fur richtige Zahnlange
	rk = (rg_aussen-zahnbreite)/sin(teilkegelwinkel);			// FuBradius des Komplementarkegels
	rfk = rk*hoehe_k*tan(delta_f)/(rk+hoehe_k*tan(delta_f));	// Kopfradius des Zylinders fur 
																// Komplementar-Kegelstumpf
	hoehe_fk = rk*hoehe_k/(hoehe_k*tan(delta_f)+rk);			// Hoehe des Komplementar-Kegelstumpfs
	
	modul_innen = modul*(1-zahnbreite/rg_aussen);
	union(){
        for (i = [0:g_segs-1]){  //TODO: Let's unwrap this whole stack into a single polyhedron
            translate([0,0,(hoehe_f-hoehe_fk)*i/g_segs])
                rotate(a=(i%2)*schraegungswinkel,v=[0,0,1]) // TODO: misalignment, gamma is a function of modul
                    kegelrad(modul*(1-zahnbreite/rg_aussen*i/g_segs), zahnzahl, teilkegelwinkel, zahnbreite/g_segs, bohrung, eingriffswinkel, schraegungswinkel*(i%2?1:-1));
        }
            
	}
}

/*  Kegelrad
    modul = Hohe des Zahnkopfes uber dem Teilkegel; Angabe fur die Aussenseite des Kegels
    zahnzahl = Anzahl der Radzahne
    teilkegelwinkel = (Halb)winkel des Kegels, auf dem das jeweils andere Hohlrad abrollt
    zahnbreite = Breite der Zahne von der AuBenseite in Richtung Kegelspitze
    bohrung = Durchmesser der Mittelbohrung
    eingriffswinkel = Eingriffswinkel, Standardwert = 20deg gemaB DIN 867. Sollte nicht groBer als 45deg sein.
	schraegungswinkel = Schragungswinkel, Standardwert = 0deg */
module kegelrad(modul, zahnzahl, teilkegelwinkel, zahnbreite, bohrung, eingriffswinkel = 20, schraegungswinkel=0) {

	// Dimensions-Berechnungen
	d_aussen = modul * zahnzahl;									// Teilkegeldurchmesser auf der Kegelgrundflache,
																	// entspricht der Sehne im Kugelschnitt
	r_aussen = d_aussen / 2;										// Teilkegelradius auf der Kegelgrundflache 
	rg_aussen = r_aussen/sin(teilkegelwinkel);						// GroBkegelradius fur Zahn-AuBenseite, entspricht der Lange der Kegelflanke;
	rg_innen = rg_aussen - zahnbreite;								// GroBkegelradius fur Zahn-Innenseite	
	r_innen = r_aussen*rg_innen/rg_aussen;
	alpha_stirn = atan(tan(eingriffswinkel)/cos(schraegungswinkel));// Schragungswinkel im Stirnschnitt
	delta_b = asin(cos(alpha_stirn)*sin(teilkegelwinkel));			// Grundkegelwinkel		
	da_aussen = (modul <1)? d_aussen + (modul * 2.2) * cos(teilkegelwinkel): d_aussen + modul * 2 * cos(teilkegelwinkel);
	ra_aussen = da_aussen / 2;
	delta_a = asin(ra_aussen/rg_aussen);
	c = modul / 6;													// Kopfspiel
	df_aussen = d_aussen - (modul +c) * 2 * cos(teilkegelwinkel);
	rf_aussen = df_aussen / 2;
	delta_f = asin(rf_aussen/rg_aussen);
	rkf = rg_aussen*sin(delta_f);									// Radius des KegelfuBes
	hoehe_f = rg_aussen*cos(delta_f);								// Hohe des Kegels vom FuBkegel
	
	//echo("Teilkegeldurchmesser auf der Kegelgrundflache = ", d_aussen);
	
	// GroBen fur Komplementar-Kegelstumpf
	hoehe_k = (rg_aussen-zahnbreite)/cos(teilkegelwinkel);			// Hohe des Komplementarkegels fur richtige Zahnlange
	rk = (rg_aussen-zahnbreite)/sin(teilkegelwinkel);				// FuBradius des Komplementarkegels
	rfk = rk*hoehe_k*tan(delta_f)/(rk+hoehe_k*tan(delta_f));		// Kopfradius des Zylinders fur 
																	// Komplementar-Kegelstumpf
	hoehe_fk = rk*hoehe_k/(hoehe_k*tan(delta_f)+rk);				// Hoehe des Komplementar-Kegelstumpfs

	//echo("Hohe Kegelrad = ", hoehe_f-hoehe_fk);
	
	phi_r = kugelev(delta_b, teilkegelwinkel);						// Winkel zum Punkt der Evolvente auf Teilkegel
		
	// Torsionswinkel gamma aus Schragungswinkel
	//gamma_g = 2*atan(zahnbreite*tan(schraegungswinkel)/(2*rg_aussen-zahnbreite));
	//gamma = 2*asin(rg_aussen/r_aussen*sin(gamma_g/2));
    gamma = schraegungswinkel;
    
	schritt = (delta_a - delta_b)/t_segs;
	tau = 360/zahnzahl;												// Teilungswinkel
	start = (delta_b > delta_f) ? delta_b : delta_f;
	spiegelpunkt = (180*(1-spiel))/zahnzahl+2*phi_r;

	// Zeichnung
	rotate([0,0,phi_r+90*(1-spiel)/zahnzahl]){						// Zahn auf x-Achse zentrieren;
																	// macht Ausrichtung mit anderen Radern einfacher
		translate([0,0,hoehe_f]) rotate(a=[0,180,0]){
			union(){
				translate([0,0,hoehe_f]) rotate(a=[0,180,0]){								// Kegelstumpf							
					difference(){ // twist and align verticies with teeth
						linear_extrude(height=hoehe_f-hoehe_fk, scale=rfk/rkf, twist=gamma) circle(rkf, $fn=zahnzahl*2);
						translate([0,0,-1]){
							cylinder(h = hoehe_f-hoehe_fk+2, r = bohrung/2);				// Bohrung
						}
					}	
				}
				for (rot = [0:tau:360]){
					rotate (rot) {															// "Zahnzahl-mal" kopieren und drehen
						hull(){ // hull helps to round out jagged baseline cut
                            bp=[ // overlap inner segment mit Kegelstumpf
								kugel_zu_kart([rg_aussen, start*0.95, 1*spiegelpunkt]),
								kugel_zu_kart([rg_innen, start*0.95, 1*spiegelpunkt+gamma]),
								kugel_zu_kart([rg_innen, start*0.95, spiegelpunkt-1*spiegelpunkt+gamma]),
								kugel_zu_kart([rg_aussen, start*0.95, spiegelpunkt-1*spiegelpunkt]),
								kugel_zu_kart([rg_aussen, delta_f, 1*spiegelpunkt]),
								kugel_zu_kart([rg_innen, delta_f, 1*spiegelpunkt+gamma]),
								kugel_zu_kart([rg_innen, delta_f, spiegelpunkt-1*spiegelpunkt+gamma]),
								kugel_zu_kart([rg_aussen, delta_f, spiegelpunkt-1*spiegelpunkt])
							];
                            tp=[for(delta=[start:schritt:delta_a-schritt/2])[
								kugel_zu_kart([rg_aussen, delta, kugelev(delta_b, delta)]),
								kugel_zu_kart([rg_innen, delta, kugelev(delta_b, delta)+gamma]),
								kugel_zu_kart([rg_innen, delta, spiegelpunkt-kugelev(delta_b, delta)+gamma]),
								kugel_zu_kart([rg_aussen, delta, spiegelpunkt-kugelev(delta_b, delta)]),
								kugel_zu_kart([rg_aussen, delta+schritt, kugelev(delta_b, delta+schritt)]),
								kugel_zu_kart([rg_innen, delta+schritt, kugelev(delta_b, delta+schritt)+gamma]),
								kugel_zu_kart([rg_innen, delta+schritt, spiegelpunkt-kugelev(delta_b, delta+schritt)+gamma]),
								kugel_zu_kart([rg_aussen, delta+schritt, spiegelpunkt-kugelev(delta_b, delta+schritt)])
							]];
                            tf=[for(i=[0:t_segs])[//-1
                                [i*8+0,i*8+4,i*8+1],[i*8+1,i*8+4,i*8+5],[i*8+1,i*8+5,i*8+2],[i*8+2,i*8+5,i*8+6],[i*8+2,i*8+6,i*8+3],[i*8+3,i*8+6,i*8+7],[i*8+0,i*8+3,i*8+7],[i*8+0,i*8+7,i*8+4]
							]];
                            polyhedron(
                                points=concat([for(a=tp)for(b=a)b],bp),
                                faces=concat([[0,1,2],[0,2,3]],
                                    [for(a=tf)for(b=a)b],[[(t_segs-1)*8+4,(t_segs-1)*8+6,(t_segs-1)*8+5],
                                    [(t_segs-1)*8+4,(t_segs-1)*8+7,(t_segs-1)*8+6]]),
                                convexity=2
                            );
    					}
					}
				}	
			}
		}
	}
}
