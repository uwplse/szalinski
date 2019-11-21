// eye radius if size_factor = 1
eye_r = 9;  // [0:20]
eye_distance = 2*eye_r+4;
// move wing position up or down
wing_offset = 5;   //[-10:10]
// width for the plug hole in the wing if size_factor = 1
plug_width = 5;   //[0:20]
// height for the plug hole in the wing if size_factor = 1
plug_height = 22; //[0:50]
// horizontal offset position for the plug hole in the wing
plug_offset = 13;  //[0:20]
// size factor of the owl, if 1 body owl is 100mm x 60 mm
size_factor = 1;
// thickness (height) of the owl, if 1 ears are 2 mm, body 3mm
height_size_factor = 1.;

difference() {
     union () {
          // ears & body
          intersection() {
               union() {
                    // corpus limits
                    cube(size=[100*size_factor, 60*size_factor, 3*height_size_factor], center=true);
                    // blocks forming ears
                    for ( a=[-1,1] ) {
                         translate([a*17.5*size_factor,-35*size_factor,-1*height_size_factor])
                              cube(size=[7.5*size_factor,15*size_factor,2*height_size_factor], center=true);
                    }
                    // nose
                    linear_extrude(height=6*height_size_factor,center=true)
                         polygon(points=[[-5*size_factor,-5*size_factor],[5*size_factor,-5*size_factor],[0*size_factor,5*size_factor]],
                                 paths=[[0,1,2]]
                              );
                    // wings
                    translate([0,wing_offset,0])
                    for ( a=[-1,1] ) {
                         intersection () {
                              translate([a*32*size_factor,15*size_factor,0])
                                   cylinder(h=15*height_size_factor, r=25*size_factor, center=true, $fn=80);
                              translate([0,17.5*size_factor,0])
                                   cube(size=[100*size_factor,45*size_factor,7.5*height_size_factor], center=true);
                         }
                    }
               }

               // rounded sides
               translate([0,0,1*height_size_factor])
                    intersection_for ( a=[-1,1] ) {
                    translate([a*75*size_factor,0,0])
                         cylinder(h=5*height_size_factor, r=100*size_factor, center=true, $fn=80);
                    }
          }
          // feet
          * for ( a=[-1,1] ) {
               translate([a*12.5*size_factor, (27.5)*size_factor, 0])
                    cylinder(h=3*height_size_factor, r=8*size_factor, center=true, $fn=80);
          }
     }
     // eyes
     for ( a=[-1,1] ) {
          translate([a*(eye_distance/2)*size_factor,-17.5*size_factor,0])
               cylinder(h=10*height_size_factor, r=eye_r*size_factor, center=true, $fn=80);
     }
     // slot for plug
     translate([(plug_offset+plug_width)*size_factor,0,-12.5*height_size_factor])
          cube(size=[plug_width*size_factor,plug_height*size_factor,25*height_size_factor]);
}
