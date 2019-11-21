//
//
//  Old style steet lamp cap
//
//   R. Lazure  Oct 31, 2018
//
//
height= 160;
cut_ht= 100;
base= 140;
lip=15;
lip_thick=2;
//
inner_height=cut_ht-2;
plate_width=base+2*lip;
echo("plate width= ",plate_width);

difference(){
      union(){ 
//
// bottom plate
color("red")
cube(size = [plate_width,plate_width,lip_thick], center = false);
// rising pyramid
translate([lip+base/2,lip+base/2,lip_thick])
scale([base/20,base/20,height/10])
polyhedron(
  points=[ [10,10,0],[10,-10,0],[-10,-10,0],[-10,10,0], // the four points at base
           [0,0,10]  ],                                 // the apex point 
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );
}
//
//   cut top point
//
color("green")
translate([0,0,cut_ht+lip_thick])
cube(size = [300,300,300], center = false);
//
//  hollow out the inside, no need for support
//
color("yellow")
translate([lip+base/2,lip+base/2,-lip_thick-4])
scale([base/20,base/20,inner_height/10])
polyhedron(
  points=[ [10,10,0],[10,-10,0],[-10,-10,0],[-10,10,0], // the four points at base
           [0,0,10]  ],                                 // the apex point 
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );

//
//  screw holes
//
//  model specific, not general values
$fn=20;
color("blue")
translate([8,8,0])
cylinder(h=10, r=2.6, center=true);
color("blue")
translate([162,8,0])
cylinder(h=10, r=2.6, center=true);
color("blue")
translate([8,162,0])
cylinder(h=10, r=2.6, center=true);
color("blue")
translate([162,162,0])
cylinder(h=10, r=2.6, center=true);
}

 