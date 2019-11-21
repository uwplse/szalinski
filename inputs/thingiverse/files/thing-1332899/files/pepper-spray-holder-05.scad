$fn=16;

H = 50;
D_base = 42;
wall = 3;
H_scale = 1.2;
R_mount = 5; // rounding of mount plate
H_base = 4;
D_hole_mount = 4;

spiral_qty = 12;

//echo(atan((D_base/2*H_scale-D_base/2)/H));

union(){
 // base
 cylinder(h=H_base, d=D_base, center=true, $fn=60);

 // wall mounter {
 difference(){
  translate([0, D_base/2, 0]){
   rotate([90-atan((D_base/2*H_scale-D_base/2)/H), 0 ,0]){
     difference(){
      linear_extrude(height = 3, center = true, twist = 0, convexity = 10, scale=[1,1,1])
       offset(r = R_mount) 
        polygon(points=[[-D_base/2, R_mount/2],[D_base/2, R_mount/2],[D_base*H_scale/2,H - R_mount],[-D_base*H_scale/2,H-R_mount]]);
        
        // mount holes
        k = 2;
        translate([-D_base/2 +k,R_mount/2 +k ])
         cylinder(h=H_base, d=D_hole_mount, center=true, $fn=20); 

        translate([D_base/2 -k, R_mount/2 +k])
         cylinder(h=H_base, d=D_hole_mount, center=true, $fn=20); 

        translate([D_base*H_scale/2 -k,H-R_mount-k])
         cylinder(h=H_base, d=D_hole_mount, center=true, $fn=20); 

        translate([-D_base*H_scale/2 +k,H-R_mount-k])
         cylinder(h=H_base, d=D_hole_mount, center=true, $fn=20); 
     }
   } // rotate
  } // traslate

  translate([0, 0, -H_base])
   cylinder(h=H_base, d=D_base*2, center=true, $fn=10);
 } // difference
 // } wall mounter

 // main body {
 for ( tt = [-180 : 90: 180]) {
  linear_extrude(height = H, twist = tt, slices = 70, scale=[H_scale,H_scale]) {

                for ( i = [0 : 360/spiral_qty : 360] )
                {
                    rotate( i , [0, 0, 1])
                     translate([(D_base - wall)/2, 0, 0])
                       circle(d = wall);
                }
  } // extrude
  
 } // for tt
 // } main body


 // top balls
 translate([0, 0, H])
 for ( i = [0 : 360/spiral_qty : 360] )
 {
    rotate( i , [0, 0, 1])
     translate([(D_base - wall)/2 * H_scale, 0, 0])
      //scale([1.5,1,1])
       sphere(d = wall*H_scale*H_scale, $fn=24);
 }

} // union