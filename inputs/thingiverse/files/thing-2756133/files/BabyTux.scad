/* 
 * This is an OpenSCAD version of the creation of Nicolas Rougier, originaly 
 * designed for POV-RAY (available at
 * https://www.labri.fr/perso/nrougier/artwork/index.html#baby-gnu-and-baby-tux).
 * I had to modify the wing, tongue and feet to be able to draw it in openSCAD, 
 * I hope it doesn't change the spirit.
 *
 * You can choose the position of the baby tux (seated or standing), and if the 
 * beak is open or closed (easier to print without the tongue). Choose the
 * configuration using the coarse mode, and then refine the mesh before exporting.
 * In fine mode, it can take a very long time (more than 1 hour!). It can be a 
 * multi-part model (one of each color or member), or mono-block (in yellow 
 * you get a nice chick :).
 * 
 * Janvier 2018, Champystile-Corp
 * licensed under the 
 * Creative Commons - Attribution - Non-Commercial - Share Alike license.
 * http://creativecommons.org/licenses/by-nc-sa/3.0/
 * 
 */

// Quality of the mesh
quality=0; //[0:Coarse, 1:Medium, 2:Fine]

// Position of the tux
position=0; //[0:Standing, 1:Seated]

// Type of beak
beak_opening=1; //[1:Open, 0:Closed]

// Part to print
part=0; //[0:All (monoblock), 1:Body (black), 2:Body (white), 3:Foot, 4:Wing, 5:Beak, 6:Tongue, 7:Eye ]


/* [Hidden] */

quality_values = [[10,0.05,2],[5,0.02,3],[2,0.01,4]];
fa=quality_values[quality][0];;
fs=quality_values[quality][1];;
nb_raf=quality_values[quality][2];

black = [0.1,0.1,0.1];
white = [1,1,1];
rouge = [1,0,0];
yellow = [1,.55,0];

usph = icos_sphere(1,nb_raf);

module rep_beak() {
    children();
}

module beak() {
    difference() {
        union() {
            color(yellow) translate([0,.8,1.1]) rotate([5,0,0]) difference() {
                // beak up
                rotate([0,0,-90]) scale(0.6) difference() {
                    multmatrix([[1,0,1,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]) 
                    rotate([0,0,45]) scale([sqrt(2),sqrt(2),1]/2)
                    translate([0,0,1]) difference() {
                        superellipsoid(R=1,e=.25,n=.25);
                        translate([0,0,-1]) scale(.9) superellipsoid(R=1,e=.25,n=.25);
                    }
                    translate([2.2,0,0]) cube(4*[1,1,1],center = true);
                }
                // holes
                copy_sym() translate([0.1,0.3,0.2]) sphere(r=0.025,$fa=fa,$fs=fs);
            }
            // beak down
            br=(beak_opening==1)?-15:2;
            color(yellow) translate([0,.75,1.16]) rotate([br,0,0]) rotate([0,0,-90])
            scale(0.57) difference() {
                multmatrix([[1,0,-1,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]) 
                rotate([0,0,-45]) scale([sqrt(2),sqrt(2),.1]/2)
                translate([0,0,-1]) superellipsoid(R=1,e=.25,n=.25);
                
                translate([1,0,0]) cube([2,2,2],center = true);
            }
            // Interior
            /*color(black) intersection() {
                translate([0,0,1.5]) sphere(r=1.001,$fa=fa,$fs=fs);
                translate([0,.8,1.1]) rotate([0,0,-90]) 
                scale(0.57) multmatrix([[1,0,1,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]) 
                rotate([0,0,45]) scale([sqrt(2),sqrt(2),1]/2) translate([0,0,1])
                superellipsoid(R=1,e=.25,n=.25);
            }*/
        }
        if (part!=0) {
            rep_body() translate([0,0,1.5]) sphere(r=.98, $fa=fa, $fs=fs);
            if (beak_opening==1) {
                rep_tongue() tongue();
            }
        }
    }
}

module rep_eyes() {
    translate([0,0,1.5]) rotate([-180*(1/64),0,0]) rotate([0,0,180*(1/2+1/12)])
        translate([.99,0,0])children();
}

module eyes() {
    eye_size = .1;
    color(black) union() {
        scale([0.6435,1,1]) sphere(r=eye_size, $fa=fa, $fs=fs);
    }
}

module rep_tongue() {
    children();
}

module tongue() {
    difference() {
        pts = [[0,0,0],[0,1.5,0]];
        tgts = [[0,1,.25],[0,1.,-.7]];
        color(rouge) translate([0,.78,1.1]) scale(0.25)
            bs(pts,tgts,radius=[.3,0.2,0.4],threshold=[0.2,0.5]);
        if (part!=0) {
            rep_body() translate([0,0,1.5]) sphere(r=.97, $fa=fa, $fs=fs);
            //rep_beak() beak();
        }
    }
}

module rep_aisles() {
    translate([1,0,.75]) rotate([0,-10,0]) rotate([30,0,00]) rotate([0,0,-90]) children();
}

module aisles() {
    pts = [[0,0,0],[2,0,0]];
    tgts = [[1,0,0],[0,0,3]];
    nb_t = 50;
    scalep = [for (i=[0:1:nb_t-1]) cos(i/(nb_t-1)*180/2.3) ];
    color(black) union() {
        scale(0.25)
            bs(pts,tgts,radius=[.5,.85,.38],nb_t=nb_t,threshold=[0.2,0.05],scalep=scalep);
    }
}

module rep_body(c=0) {
    children();
}

module body(c=0) {
    if (c==0) {
        union() {
            body_white();
            body_black();
        }
    } else if (c==1) {
        body_black();
    } else if (c==2) {
        difference() {
            body_white();
            body_black();
        }
    }
}

module body_black() {
    difference() {
        color(black) difference() {
            union() {
                // Body
                translate([0,0,0.75]) scale([1,1,0.75]) sphere(r=1, $fa=fa, $fs=fs);
                // Head
                translate([0,0,1.5]) sphere(r=1, $fa=fa, $fs=fs);
            }
            union() {
                // Belly
                translate([0,.5,.5]) scale(0.88) sphere(r=1, $fa=fa, $fs=fs);
                // Eyes
                translate([-.5,1,1.5]) scale(0.6) sphere(r=1, $fa=fa, $fs=fs);
                translate([.5,1,1.5]) scale(0.6) sphere(r=1, $fa=fa, $fs=fs);
            }
        }
        if (part==1) {
            copy_sym() rep_foot() foot();
            copy_sym() rep_aisles() aisles();
        }
    }
}

module body_white() {
    difference() {
        color(white) union() {
            // Body
            translate([0,0,0.75]) scale([1,1,0.75]) sphere(r=.99, $fa=fa, $fs=fs);
            // Head
            translate([0,0,1.5]) sphere(r=.99, $fa=fa, $fs=fs);
        }
        if (part==2) {
            copy_sym() rep_foot() foot();
            copy_sym() rep_eyes() eyes();
            if (beak_opening==1) {
                rep_tongue() tongue();
            }
            rep_beak() beak();
        }
    }
}

module rep_foot() {
    if (position==0) {
        translate([-.3,0,0]) rotate([0,0,15]) children();
    } else if (position==1) {
        alpha=45;
        translate([-.3,sin(alpha),0.75*(1-cos(alpha))])
            rotate([alpha,0,0]) rotate([0,0,15]) children();
    }
}

module foot() {
    R = 0.7*3.5;
    kx=0.4*R;
    ky=0.8*R;
    kz=0.2*R;
    rot=-0;
    rsph=[for (i=[0:1:len(usph[0])-1])
        [usph[0][i][0],usph[0][i][1]*cos(rot)+usph[0][i][2]*sin(rot),
            usph[0][i][2]*cos(rot)-usph[0][i][1]*sin(rot)] ];
    ssph=[for (i=[0:1:len(rsph)-1])
        [kx*rsph[i][0],ky*rsph[i][1],kz*rsph[i][2]] ];
    points=[for (i=[0:1:len(ssph)-1]) let(
        r=sqrt(pow(ssph[i][0],2)+pow(ssph[i][1],2)),
        r3=sqrt(pow(ssph[i][0],2)+pow(ssph[i][1],2)+pow(ssph[i][2],2)),
        theta=atan2(ssph[i][0],ssph[i][1]),
        phi=abs(asin(ssph[i][2]/r3)),
        kt1=2.5,
        t1=abs(theta/kt1),
        kt1b=1.3,
        t1b=abs(theta/kt1b),
        kt2=0.14,
        t2=abs(theta/kt2),
        kphi1=1,
        kphi2=.5,
        kzz=0.8,
        dr=0.3*(1-pow(1-pow(cos((t1<90)?t1:90),15),5))
            *(1-pow(1-pow(cos(phi/kphi1<90?phi/kphi1:90),15),10))
            +1*(1-pow(1-pow(cos((t1b<90)?t1b:90),15),10))
            *(1-pow(1-pow(cos(phi/kphi1<90?phi/kphi1:90),8),2))
            -.4*(1-pow(1-pow(abs(sin((t2<180)?t2:0)),2.5),0.7))*
            (1-pow(1-cos(phi/kphi2<90?phi/kphi2:90),1))
        )
        [ssph[i][0]+dr*sin(theta),
        ssph[i][1]+dr*cos(theta),
        sign(ssph[i][2])*pow(abs(ssph[i][2]),kzz)*pow(kz*R,1-kzz)]];
    color(yellow) scale(0.23*[1,.9,1]) 
        polyhedron(points=points,faces=usph[1]);
}

module foot2() {
    R = 0.7*3.5;
    kx=0.4*R;
    ky=0.8*R;
    kz=0.18*R;
    kzz=.8;
    ssph=[for (i=[0:1:len(usph[0])-1])
        [kx*usph[0][i][0],ky*usph[0][i][1]+.5,
        kz*sign(usph[0][i][2])*pow(abs(usph[0][i][2]),kzz)*pow(R,1-kzz) ] ];
    
    pts = [[0,1,0],[0.26,0.7,0],[1,0,0]];
    tgts = [[.2,0,0],[.4,-3,0],[1,0,0]];
    theta=[for (i=[0:1:len(ssph)-1]) atan2(ssph[i][0],ssph[i][1]) ];
    atheta=[for (i=[0:1:len(ssph)-1]) abs(theta[i]) ];
    phi=[for (i=[0:1:len(ssph)-1]) let(
        r3=sqrt(pow(ssph[i][0],2)+pow(ssph[i][1],2)+pow(ssph[i][2],2)))
        abs(asin(ssph[i][2]/r3)) ];
    kt1=1.5;
    t1=atheta/kt1/90;
    kt2=0.09;
    t2=atheta/kt2;
    
    t=[0:0.01:1];
    spl=spline(pts,tgts,t);
    dr0=interp1(spl,t1);
    
    points=[for (i=[0:1:len(ssph)-1]) let(
        k=(t1[i]<90)?1:0,
        t2i=t2[i],
        dr1=0.3*(1-pow(1-pow(sin((t2i<180)?t2i:0),2),.6))
        ) [ 
        ssph[i][0]+k*(dr0[i]-dr1)*sin(theta[i])*cos(phi[i]),
        ssph[i][1]+k*(dr0[i]-dr1)*cos(theta[i])*cos(phi[i]),
        ssph[i][2]] ];
        polyhedron(points=points,faces=usph[1]);
} 


rotate([0,0,180]) scale(20) {
    if (part==0) {
        //all
        union() {
            rep_beak() beak();
            copy_sym() rep_eyes() eyes();
            if (beak_opening==1) {
                rep_tongue() tongue();
            }
            rep_body() body(0);
            copy_sym() rep_aisles() aisles();
            copy_sym() rep_foot() foot();
        }
    } else if (part==1) {
        // Body (black)
        body(1);
    } else if (part==2) {
        // Body (white)
        body(2);
    } else if (part==3) {
        // Foot
        foot();
    } else if (part==4) {
        // Wing
        aisles();
    } else if (part==5) {
        // Beak
        beak();
    } else if (part==6) {
        // Tongue
        tongue();
    } else if (part==7) {
        // Eye
        eyes();
    }
        
}

module copy_sym() {
    children();
    mirror([1,0,0]) children();
}

module bs(points,tangents,radius=[1,1,1],nb_t=50,threshold=[0.5,0.5],scalep=[]) {
    t = [for (i=[0:1:nb_t-1]) i/(nb_t-1)];
    pt_spline = spline(points,tangents,t);
    dl_spline = dl(pt_spline);
    l_spline = sum(dl_spline);
    pt_spline_d = spline_d(points,tangents,t);
    pt_spline_d2 = spline_d2(points,tangents,t);
    pt_spline_dtds = dtds(pt_spline_d);
    pt_spline_dtds2 = dtds2(pt_spline_d,pt_spline_d2,pt_spline_dtds);
    
    pt_spline_t = kv(pt_spline_dtds,pt_spline_d);
    pt_spline_n1_test = kv(puissance(pt_spline_dtds,2),pt_spline_d2) -
        kv(pt_spline_dtds2,pt_spline_d);
    pt_spline_n1 = [for (i=[0:1:len(pt_spline_n1_test)-1])
        ((pt_spline_n1_test[i][0]==0)&&(pt_spline_n1_test[i][1]==0)&&(pt_spline_n1_test[i][2]==0)) ? 
        ((pt_spline_t[i][0]==0&&pt_spline_t[i][1]==0&&pt_spline_t[i][2]==1) ? 
        normalizes(pvs(pt_spline_t[i],[0,1,0])) : 
        normalizes(pvs(pt_spline_t[i],[0,0,1]))) : normalizes(pt_spline_n1_test[i]) ];
    pt_spline_n2 = pv(pt_spline_t,pt_spline_n1);
    
    r = br(t,threshold[0],1,threshold[1],l_spline);
    sr = (len(scalep)==len(t)) ? [for (i=[0:1:nb_t-1]) r[i]*scalep[i] ] : r;
    
    union() {
        for (i=[1:1:nb_t-1]) {
            hull() {
                base1 =[[pt_spline_t[i-1][0],pt_spline_n1[i-1][0],pt_spline_n2[i-1][0],0],
                    [pt_spline_t[i-1][1],pt_spline_n1[i-1][1],pt_spline_n2[i-1][1],0],
                    [pt_spline_t[i-1][2],pt_spline_n1[i-1][2],pt_spline_n2[i-1][2],0],
                    [0,0,0,1]];
                translate(pt_spline[i-1]) multmatrix(base1) scale(sr[i-1]) 
                scale([1,radius[1]/radius[0],radius[2]/radius[0]])
                sphere(r=radius[0], $fa=fa*3, $fs=fs);
                base2 =[[pt_spline_t[i][0],pt_spline_n1[i][0],pt_spline_n2[i][0],0],
                    [pt_spline_t[i][1],pt_spline_n1[i][1],pt_spline_n2[i][1],0],
                    [pt_spline_t[i][2],pt_spline_n1[i][2],pt_spline_n2[i][2],0],
                    [0,0,0,1]];
                translate(pt_spline[i]) multmatrix(base2) scale(sr[i])
                scale([1,radius[1]/radius[0],radius[2]/radius[0]])
                sphere(r=radius[0], $fa=fa*3, $fs=fs);
            }
        }
    }
}

module geode(n=3,init="icosa") {
    if (init=="icosa") {
        sph = icos_sphere(1,n);
        polyhedron(points=sph[0],faces=sph[1]);
    } else if (init=="pyra") {
        sph = pyra_sphere(1,n);
        polyhedron(points=sph[0],faces=sph[1]);
    } else if (init=="dpyra") {
        sph = dpy_sphere(1,n);
        polyhedron(points=sph[0],faces=sph[1]);
    }
}

module superellipsoid(R=1,e=1,n=1) {
    ssph=[for (i=[0:1:len(usph[0])-1]) R*usph[0][i]];
    points=superellipsoid_points(ssph,e,n);
    polyhedron(points=points,faces=usph[1]);
}

function interp1(x,xi) = [for (i=[0:1:len(xi)-1]) sum(
    [for (j=[0:1:len(x)-1]) (j==0) ? ((xi[i]==x[0][0]) ? x[0][1] : 0) : 
        (xi[i]>x[j-1][0]&&xi[i]<=x[j][0]) ? 
        x[j-1][1]+(xi[i]-x[j-1][0])*(x[j][1]-x[j-1][1])/(x[j][0]-x[j-1][0]) : 0]) ];

function spline(points,tangents,t) = let(n=len(points)-1) [ for (ti=t) 
    let(ip=(ti>=1)?n-1:floor(ti*n),tt=(ti>=1)?1:(ti*n)%1)
    [for (ix=[0:1:2]) 
    points[ip][ix]*(1+tt*tt*(-3+2*tt)) + 
    tangents[ip][ix]*tt*(1+tt*(-2+tt)) + 
    points[ip+1][ix]*tt*tt*(3-2*tt) + 
    tangents[ip+1][ix]*tt*tt*(-1+tt) 
] ];

function spline_d(points,tangents,t) = let(n=len(points)-1) [ for (ti=t) 
    let(ip=(ti>=1)?n-1:floor(ti*n),tt=(ti>=1)?1:(ti*n)%1)
    [for (ix=[0:1:2]) 
    points[ip][ix]*tt*(-6+tt*6) + 
    tangents[ip][ix]*(1+tt*(-4+3*tt)) + 
    points[ip+1][ix]*tt*(6-6*tt) + 
    tangents[ip+1][ix]*tt*(-2+3*tt) 
] ];

function spline_d2(points,tangents,t) = let(n=len(points)-1) [ for (ti=t) 
    let(ip=(ti>=1)?n-1:floor(ti*n),tt=(ti>=1)?1:(ti*n)%1)
    [for (ix=[0:1:2]) 
    points[ip][ix]*(-6+12*tt) + 
    tangents[ip][ix]*(-4+6*tt) + 
    points[ip+1][ix]*(6-12*tt) + 
    tangents[ip+1][ix]*(-2+6*tt) 
] ];

function dtds(d) = [ for(i=[0:1:len(d)-1]) 1/norm(d[i]) ];
    
function dtds2(d,d2,dtds) = [ for(i=[0:1:len(d)-1]) 
    (d[i][0]*d2[i][0]+d[i][1]*d2[i][1]+d[i][2]*d2[i][2])*pow(dtds[i],4) ];

function dl(points) = [ for(i=[1:1:len(points)-1]) 
    norm([
        points[i][0]-points[i-1][0],
        points[i][1]-points[i-1][1],
        points[i][2]-points[i-1][2]])];

function s(points,i=0) = let(
        j=len(points)-i-1,
        dsi=(j>0)?norm([
        points[j][0]-points[j-1][0],
        points[j][1]-points[j-1][1],
        points[j][2]-points[j-1][2]]) : 0, 
        sm1 = (j>0)?s(points,i+1):0)
    (j>0) ? concat(sm1,sm1[len(sm1)-1]+dsi) : [0];
        
function sum(v,s=0,i=0) = (i>len(v)-1) ? s : v[i]+sum(v,s,i+1);

function normalizes(v) = let(n=norm(v))[ for (j=[0:1:len(v)-1]) v[j]/n ];

function normalize(v) = [ for (i=[0:1:len(v)-1]) normalizes(v[i]) ];
        
function kv(k,v) = [ for(i=[0:1:len(v)-1]) [ for(j=[0:1:len(v[i])-1]) k[i]*v[i][j] ]];
    
function prod(v1,v2) = [ for(i=[0:1:len(v1)-1]) v1[i]*v2[i] ];
    
function pvs(v1,v2) = [ v1[1]*v2[2] - v1[2]*v2[1], 
    v1[2]*v2[0] - v1[0]*v2[2], 
    v1[0]*v2[1] - v1[1]*v2[0] ];
        
function pv(v1,v2) = [ for (i=[0:1:len(v1)-1]) pvs(v1[i],v2[i]) ];
    
function pss(v1,v2) = v1[0]*v2[0]+v1[1]*v2[1]+v1[2]*v2[2];
        
function ps(v1,v2) = [ for (i=[0:1:len(v1)-1]) pss(v1[i],v2[i]) ];
    
function puissance(v,p) = [ for(i=[0:1:len(v)-1]) pow(v[i],p) ];
    

function br(t,R0,R1,t1,L) = let(t0=R0/L,t1f=min(t1,0.5)) [for (i=[0:1:len(t)-1])
    (t[i]<t1f) ? R1*sqrt(1-pow((t[i]-t1f)/(t1f+t0),2)) :
    (t[i]>1-t1f) ? R1*sqrt(1-pow((t[i]-1+t1f)/(t1f+t0),2)) : R1 ];


function icos_sphere(R,nb=0) = let(
    pts = icos_sphere_points(R),
    seg = icos_sphere_segments(),
    faces = icos_sphere_faces(),
    faces_seg = icos_sphere_faces_seg()
    )
    discretize_sphere(pts,seg,faces,faces_seg,nb);

function icos_sphere_points(R) = let(phi=(1+sqrt(5))/2,a=R*2/(sqrt(phi*sqrt(5))))
    [[a/2,a*phi/2,0],[a/2,-a*phi/2,0],[-a/2,-a*phi/2,0],[-a/2,a*phi/2,0],
     [0,a/2,a*phi/2],[0,a/2,-a*phi/2],[0,-a/2,-a*phi/2],[0,-a/2,a*phi/2],
     [a*phi/2,0,a/2],[-a*phi/2,0,a/2],[-a*phi/2,0,-a/2],[a*phi/2,0,-a/2]];

function icos_sphere_faces() = [
    [4,8,7],[4,7,9],[4,0,8],[7,8,1],[4,9,3],
    [7,2,9],[4,3,0],[7,1,2],[8,11,1],[8,0,11],
    [9,2,10],[9,10,3],[5,0,3],[2,1,6],[0,5,11],
    [3,10,5],[2,6,10],[1,11,6],[10,6,5],[11,5,6]];

function icos_sphere_segments() = [
    [0,3],[0,4],[0,5],[0,8],[0,11], //0-4
    [1,2],[1,6],[1,7],[1,8],[1,11], //5-9
    [2,6],[2,7],[2,9],[2,10],[3,4], //10-14
    [3,5],[3,9],[3,10],[4,7],[4,8], //15-19
    [4,9],[5,6],[5,10],[5,11],[6,10], //20-24
    [6,11],[7,8],[7,9],[8,11],[9,10]]; //25-29
    
function icos_sphere_faces_seg() = [[
    [19,26,18],[18,27,20],[ 1, 3,19],[26, 8, 7],[20,16,14],
    [11,12,27],[14, 0, 1],[ 7, 5,11],[28, 9, 8],[ 3, 4,28],
    [12,13,29],[29,17,16],[ 2, 0,15],[ 5, 6,10],[ 2,23, 4],
    [17,22,15],[10,24,13],[ 9,25, 6],[24,21,22],[23,21,25]],
    [[0,1,1],[0,0,1],[1,0,1],[0,1,0],[0,1,0],
    [1,0,1],[1,1,0],[1,0,0],[0,1,0],[1,0,1],
    [1,0,1],[0,1,0],[1,0,0],[1,0,1],[0,0,1],
    [0,1,1],[0,0,1],[0,1,1],[1,1,0],[1,0,0]]];

function pyra_sphere(R,nb=0) = let(
    pts = pyra_sphere_points(1),
    seg = pyra_sphere_segments(),
    faces = pyra_sphere_faces(),
    faces_seg = pyra_sphere_faces_seg()
    )
    discretize_sphere(pts,seg,faces,faces_seg,nb);

function pyra_sphere_points(R) = let(a=2*sqrt(2/3),b=a/(2*sqrt(2)))
    [[b,-b,-b],[-b,-b,b],[-b,b,-b],[b,b,b]];

function pyra_sphere_segments() = [[2,1],[1,0],[0,2],[1,3],[2,3],[0,3]];

function pyra_sphere_faces() = [[2,1,0],[1,2,3],[0,3,2],[1,3,0]];

function pyra_sphere_faces_seg() = [[[0,1,2],[0,4,3],[5,4,2],[3,5,1]],
    [[0,0,0],[1,0,1],[0,1,1],[0,1,1]]];

function dpy_sphere(R,nb=0) = let(
    pts = dpy_sphere_points(1),
    seg = dpy_sphere_segments(),
    faces = dpy_sphere_faces(),
    faces_seg = dpy_sphere_faces_seg()
    )
    discretize_sphere(pts,seg,faces,faces_seg,nb);

function dpy_sphere_points(R) = [[1,0,0],[0,1,0],[-1,0,0],[0,-1,0],[0,0,1],[0,0,-1]];

function dpy_sphere_faces() = [[0,1,4],[1,2,4],[2,3,4],[3,0,4],
    [1,0,5],[2,1,5],[3,2,5],[0,3,5]];

function dpy_sphere_segments() = [[0,1],[1,2],[2,3],[3,0],
    [0,4],[1,4],[2,4],[3,4],[0,5],[1,5],[2,5],[3,5]];

function dpy_sphere_faces_seg() = [[[0,5,4],[1,6,5],[2,7,6],[3,4,7],
    [0,8,9],[1,9,10],[2,10,11],[3,11,8]],
    [[0,0,1],[0,0,1],[0,0,1],[0,0,1],[1,0,1],[1,0,1],[1,0,1],[1,0,1]]];


function discretize_sphere(points,segments,faces,faces_seg,nb=0,i=0) = let(
    dseg=(i<nb)?discretize_seg(points,segments):[],
    dtri=(i<nb)?discretize_tri(dseg[0],dseg[1],faces,faces_seg,len(points)):[]
    )
    (i<nb)?discretize_sphere(dtri[0],dtri[1],dtri[2],dtri[3],nb,i+1):[points,faces];
    
function discretize_seg(points,seg,i=0) = let(
    j=len(seg)-1-i,
    p0=normalizes(points[seg[j][0]]),
    p1=normalizes(points[seg[j][1]]),
    alpha=asin(norm(pvs(p0,p1))),
    n=norm(points[seg[j][0]]),
    pj=[n*normalizes([(p0[0]+p1[0]),(p0[1]+p1[1]),(p0[2]+p1[2])])],
    ds=(j>0)?discretize_seg(points,seg,i+1):[points,[]],
    k=len(ds[0]),
    new_seg=[[seg[j][0],k],[k,seg[j][1]]]
    )
    [concat(ds[0],pj),concat(ds[1],new_seg)];
    
function discretize_tri(points,segments,tri,tri_seg,nb_pts,i=0) = let(
    j=len(tri)-1-i,
    ds=(j>0)?discretize_tri(points,segments,tri,tri_seg,nb_pts,i+1):
        [points,segments,[],[[],[]]],
    nb_seg=len(ds[1]),
    ipt0=nb_pts+tri_seg[0][j][0],
    ipt1=nb_pts+tri_seg[0][j][1],
    ipt2=nb_pts+tri_seg[0][j][2],
    ori0=tri_seg[1][j][0],
    ori1=tri_seg[1][j][1],
    ori2=tri_seg[1][j][2],
    new_seg=[[ipt0,ipt1],[ipt1,ipt2],[ipt2,ipt0]],
    new_face=[[tri[j][0],ipt0,ipt2],[tri[j][1],ipt1,ipt0],[tri[j][2],ipt2,ipt1],
        [ipt0,ipt1,ipt2]],
    seg_tri = [2*tri_seg[0][j][0]+ori0,2*tri_seg[0][j][0]+1-ori0,
        2*tri_seg[0][j][1]+ori1,2*tri_seg[0][j][1]+1-ori1,
        2*tri_seg[0][j][2]+ori2,2*tri_seg[0][j][2]+1-ori2,
        nb_seg+0,nb_seg+1,nb_seg+2],
    new_face_seg=[[[seg_tri[0],seg_tri[8],seg_tri[5]],[seg_tri[2],seg_tri[6],seg_tri[1]],
        [seg_tri[4],seg_tri[7],seg_tri[3]],[seg_tri[6],seg_tri[7],seg_tri[8]]],
        [[ori0,1,ori2],[ori1,1,ori0],[ori2,1,ori1],[0,0,0]]]
    )
    [points,concat(ds[1],new_seg),concat(ds[2],new_face),
        [concat(ds[3][0],new_face_seg[0]),concat(ds[3][1],new_face_seg[1])]];
      
function push_sphere(points,axis,t,r) = let(
    r0=norm(points[0]),
    r2=r*r,
    alpha0=asin(r/r0),
    alpha02=alpha0*alpha0,
    naxis=normalizes(axis),
    ps=[for (i=[0:1:len(points)-1]) pss(naxis,points[i])],
    //npoints=normalize(points),
    d=[for (i=[0:1:len(points)-1]) norm(pvs(naxis,points[i]))],
    alpha=[for (i=[0:1:len(points)-1]) asin(d[i]/norm(points[i]))],
    k=[for (i=[0:1:len(points)-1]) (alpha[i]<alpha0&&ps[i]>0) ? 
        0.5*t*(1+sqrt(1-alpha[i]*alpha[i]/alpha02)) : 
        (alpha[i]<2*alpha0&&ps[i]>0) ? 
        0.5*t*(1-sqrt(1- (alpha[i]-2*alpha0)*(alpha[i]-2*alpha0)/alpha02)) : 0]
    )
    [for (i=[0:1:len(points)-1]) k[i]*naxis];
    

function superellipsoid_points(points,e,n) = [for (i=[0:1:len(points)-1]) let(
    r=norm(points[i]),
    theta=atan2(points[i][1],points[i][0]),
    phi=asin(points[i][2]/r),
    x=cos(phi)*cos(theta),
    y=cos(phi)*sin(theta),
    z=sin(phi),
    xp=pow(abs(cos(phi)),n)*pow(abs(cos(theta)),e),
    yp=pow(abs(cos(phi)),n)*pow(abs(sin(theta)),e),
    zp=pow(abs(sin(phi)),n)
    )
    [r*sign(x)*xp,
     r*sign(y)*yp,
     r*sign(z)*zp]];




















