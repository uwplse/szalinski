/*
   Origami Duck
   kit wallace

*/
//thickness of 'paper'
thickness=1.2;

body_angle=30;
wing_angle=60;
head_angle=25;

//quality of curves
steps=5;
scale=2;

//  functions for creating the matrices for transforming a single point

function m_translate(v) = [ [1, 0, 0, 0],
                            [0, 1, 0, 0],
                            [0, 0, 1, 0],
                            [v.x, v.y, v.z, 1  ] ];

function m_scale(v) =    [ [v.x, 0, 0, 0],
                            [0, v.y, 0, 0],
                            [0, 0, v.z, 0],
                            [0, 0, 0, 1  ] ];
                            
                            
function m_rotate(v) =  [ [1,  0,         0,        0],
                          [0,  cos(v.x),  sin(v.x), 0],
                          [0, -sin(v.x),  cos(v.x), 0],
                          [0,  0,         0,        1] ]
                      * [ [ cos(v.y), 0,  -sin(v.y), 0],
                          [0,         1,  0,        0],
                          [ sin(v.y), 0,  cos(v.y), 0],
                          [0,         0,  0,        1] ]
                      * [ [ cos(v.z),  sin(v.z), 0, 0],
                          [-sin(v.z),  cos(v.z), 0, 0],
                          [ 0,         0,        1, 0],
                          [ 0,         0,        0, 1] ];
                            
function m_to(centre,normal) = 
      m_rotate([0, atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]) 
    * m_rotate([0, 0, atan2(normal.y, normal.x)]) 
    * m_translate(centre);   
   
function m_from(centre,normal) = 
      m_translate(-centre)
    * m_rotate([0, 0, -atan2(normal.y, normal.x)]) 
    * m_rotate([0, -atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]); 

function m_rotate_about_line(a,v1,v2) =
      m_from(v1,v2-v1)*m_rotate([0,0,a])*m_to(v1,v2-v1);

function vec3(v) = [v.x, v.y, v.z];
function m_transform(v, m)  = vec3([v.x, v.y, v.z, 1] * m);
 
function face_transform(face,m) =
     [ for (v = face) m_transform(v,m) ];
            
module double(axis) { 
      union() {
          children();
          mirror(axis) children();
      }
  }
module face(s,t=thickness) {
    hull()
    for (i=[0:len(s) -1])
       translate(s[i]) sphere(t/2);     
    } 

module ground(size=50) {
   translate([0,0,-size]) cube(2*size,center=true);
}

  
// vertices
p1=[0,0,0];
p2=[4,0,7.5];
p3=[13.8,0,9.8];
p4=[18.2,0,0];
p5=[26,0,11.5];
p6=[7,0,17];
p7=[10.4,0,10.6];
p8=[7,0,0];
p9=[-5,0,13];
p10=[0,0,12.8];
p11=[-0.5,0,16];
p12=[-3.8,0,6];

$fn=steps;
// faces
body =[p12,p5,p1,p4];
wing=[p1,p2,p3,p4];
neck=[p1,p12,p6,p7,p8];
head=[p7,p6,p11,p10];
beak=[p9,p6,p7];

mbody= m_rotate_about_line(body_angle,p12,p5);
rbody= face_transform(body,mbody);
rwing=face_transform(wing,mbody) ; 
mwing = m_rotate_about_line(-wing_angle,rwing[0],rwing[3]);
rrwing = face_transform(rwing,mwing);

mneck = m_rotate_about_line(head_angle,p12,p6);
rp7= m_transform(p7,mneck);  // has to have a kink

mhead = m_rotate_about_line(head_angle,p6,p11);
rhead=face_transform(head,mhead);
mbeak = m_rotate_about_line(head_angle,p6,p9);
rbeak=face_transform(beak,mbeak);

scale(scale)
difference() {
translate([0,0,-0.5])  // to form a better base
rotate([0,2,0])   // in attempt to get it level - gludgy
  double([0,1,0]) {
    color("blue")
        face(rrwing);

    color("green") 
        face(rbody); 

    color("yellow") {
        face([p12,rp7,p6]);
        face([m_transform(p1,mbody),rp7,p12,m_transform(p8,mbody)]);
    }
    color("red") {
       face(rhead);
       face(rbeak);
   }
  }
  ground();  // clip the base
}