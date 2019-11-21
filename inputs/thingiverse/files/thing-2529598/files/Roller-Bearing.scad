//Variables

//preview[view:north east, tilt:top diagonal]

//A cutaway view of the bearing (be sure to set to "no" if generating an STL)
cutaway="yes";//[yes,no]

inner_diameter=10;

outer_diameter=40;

bearing_width=12;

roller_type="cylindrical";//[curved,cylindrical]

//Diameter of the cylindrical part of the rollers, the actual diameter will extend out further if curved rollers are selected. Also avoid making the footprint of the roller too small, otherwise it may break away from the print bed.
roller_diameter=9;

//The radius of curvature on the curved part of the rollers (if selected) If the radius is less than half the raceway contact thickness,(Bearing Width - 6.4*Cage Geometry Scale), the model won't generate properly
R=4;

//The cage tapers down to this minimum width in the centre of the bearing. 0.5*roller_diameter is a good value to start with.
cage_width=6;

//Scales the rest of the geometry defining the cage. A general rule of thumb is to increace this if you are using wider rollers or decrease it if you are using thinner rollers.
cage_geometry_scale=1;

number_of_rollers=7;

//To loosen the rollers, a hex socket is incorporated into them. This alters the distance AF 'Across Flats' of the hex socket, add a tolerance to make sure the key fits.
key_socket_AF=3.3;

//Depth of the hex socket 
key_socket_depth=3;

//Tolerance between the rollers and raceway. You can use a relatively low tolerance value since the rollers and raceway only come close at a point on roller circumference.
roller_raceway_tolerance=0.25;

//Tolerance between the rollers and cage. Set this to a value that will allow the roller to move loosely in the cage.
cage_roller_tolerance=0.4;

//Tolerance between the cage and raceway. This should be a fair bit larger than the 'roller raceway tolerance', to prevent the bearing riding on the cage (causing sliding friction) and not the rollers.
cage_raceway_tolerance=0.5;

//Chamfer on the outer and inner diameter of the bearing
outside_chamfer=0.3;

//A chamfer that helps prevent the cage and rollers fusing together on the first few layers
cage_roller_chamfer=0.4;

//A chamfer that helps prevent the cage and raceway fusing together on the first few layers
cage_raceway_chamfer=0.5;

//Raceway mesh quality multiplier (higher is more, default is 200 segments around)
raceway_mesh_refinement=1;

//Roller mesh quality multiplier (higher is more, default is 60 segments around)
roller_mesh_refinement=1;


//Variable calculations
scaleA=cage_geometry_scale;
middle_radius=(inner_diameter+outer_diameter)/4;
half_raceway_thickness=(outer_diameter-inner_diameter)/4;
roller_radius=roller_diameter/2;
x1=roller_radius;
y1=3.2*scaleA;
y2=bearing_width-3.2*scaleA;
half_cage_width=cage_width/2;
key_radius=key_socket_AF/(2*cos(30));
circle_size_refinement=45/asin((bearing_width-6.4*scaleA)/(2*R)); //Keeps the number of segments on the curved part of the roller profile constant

//Flip bearing over
rotate(a=[180,0,0]){
translate([0,0,-bearing_width]){
//Cut out inner profile from raceway
color("silver"){
difference(){               
    //Raceway
    rotate_extrude($fn=200*raceway_mesh_refinement,convexity=10){   
        translate([middle_radius,0,0]){            
            //Raceway profile
            union(){    
                polygon([[0,0],[half_raceway_thickness-outside_chamfer,0],[half_raceway_thickness,outside_chamfer],[half_raceway_thickness,bearing_width-outside_chamfer],[half_raceway_thickness-outside_chamfer,bearing_width],[0,bearing_width]]);
                mirror([1,0,0]){
                    polygon([[0,0],[half_raceway_thickness-outside_chamfer,0],[half_raceway_thickness,outside_chamfer],[half_raceway_thickness,bearing_width-outside_chamfer],[half_raceway_thickness-outside_chamfer,bearing_width],[0,bearing_width]]);
    }}}}    
    //Inner profile cut into raceway
    rotate_extrude($fn=200*raceway_mesh_refinement,convexity=10){  
        translate([middle_radius,0,0]){
            //Total inner profile
            union(){
                offset(delta=cage_raceway_tolerance){
                    //Cage profile to cut outer raceway
                    polygon([[0,0],[roller_radius+scaleA,0],[half_cage_width,roller_radius+scaleA-half_cage_width],[half_cage_width,bearing_width-roller_radius-scaleA+half_cage_width],[roller_radius+scaleA,bearing_width],[0,bearing_width]]);
                    //Cage profile to cut inner raceway
                    mirror([1,0,0]){
                        polygon([[0,0],[roller_radius+scaleA,0],[half_cage_width,roller_radius+scaleA-half_cage_width],[half_cage_width,bearing_width-roller_radius-scaleA+half_cage_width],[roller_radius+scaleA,bearing_width],[0,bearing_width]]);
                 }}
                offset(delta=roller_raceway_tolerance){    
                    //Roller profile to cut outer raceway
                    //Straight part of roller profile
                    polygon([[0,0],[roller_radius-1.2*scaleA,0],[roller_radius-1.2*scaleA,2*scaleA],[roller_radius,3.2*scaleA],[roller_radius,bearing_width-3.2*scaleA],[roller_radius-1.2*scaleA,bearing_width-2*scaleA],[roller_radius-1.2*scaleA,bearing_width],[0,bearing_width]]);
                    //Curved part of roller profile
                    if(roller_type=="curved"){
                    intersection(){
                        polygon([[x1,y1],[x1,y2],[half_raceway_thickness,y2],[half_raceway_thickness,y1]]);
                        translate([x1-sqrt(R*R-((y2-y1)/2)*((y2-y1)/2)),(y1+y2)/2,0]){
                            circle(R,$fn=60*roller_mesh_refinement*circle_size_refinement);
                    }}}
                    //Roller profile to cut inner raceway
                    mirror([1,0,0]){
                        //Straight part of roller profile
                        polygon([[0,0],[roller_radius-1.2*scaleA,0],[roller_radius-1.2*scaleA,2*scaleA],[roller_radius,3.2*scaleA],[roller_radius,bearing_width-3.2*scaleA],[roller_radius-1.2*scaleA,bearing_width-2*scaleA],[roller_radius-1.2*scaleA,bearing_width],[0,bearing_width]]);
                        //Curved part of roller profile
                        if(roller_type=="curved"){
                        intersection(){
                            polygon([[x1,y1],[x1,y2],[half_raceway_thickness,y2],[half_raceway_thickness,y1]]);
                            translate([x1-sqrt(R*R-((y2-y1)/2)*((y2-y1)/2)),(y1+y2)/2,0]){
                                circle(R,$fn=60*roller_mesh_refinement*circle_size_refinement);
}}}}}}}}
if(cutaway=="yes"){
    translate([0,-outer_diameter,-0.1]){
    cube(outer_diameter);
}}}}


//Cut holes for rollers into the cage
color("deepskyblue"){
difference(){
    //Cage body
    rotate_extrude($fn=200*raceway_mesh_refinement,convexity=10){
        translate([middle_radius,0,0]){
            //Cage profile
            union(){
                polygon([[0,0],[roller_radius-cage_raceway_chamfer+scaleA,0],[roller_radius-cage_raceway_chamfer+scaleA,cage_raceway_chamfer],[half_cage_width,roller_radius+scaleA-half_cage_width],[half_cage_width,bearing_width-roller_radius-scaleA+half_cage_width],[roller_radius-cage_raceway_chamfer+scaleA,bearing_width-cage_raceway_chamfer],[roller_radius-cage_raceway_chamfer+scaleA,bearing_width],[0,bearing_width]]);
            mirror([1,0,0]){
                polygon([[0,0],[roller_radius-cage_raceway_chamfer+scaleA,0],[roller_radius-cage_raceway_chamfer+scaleA,cage_raceway_chamfer],[half_cage_width,roller_radius+scaleA-half_cage_width],[half_cage_width,bearing_width-roller_radius-scaleA+half_cage_width],[roller_radius-cage_raceway_chamfer+scaleA,bearing_width-cage_raceway_chamfer],[roller_radius-cage_raceway_chamfer+scaleA,bearing_width],[0,bearing_width]]);
    }}}}
    //Roller holes
    for(i=[1:number_of_rollers]){
      rotate(i*360/number_of_rollers){
          translate([middle_radius,0,0]){
              rotate_extrude($fn=60*roller_mesh_refinement){
                  //Trim roller profile (all x values must be +ve for rotate extrude to work)
                  intersection(){
                      //Polygon to trim profile
                      polygon([[0,-cage_roller_tolerance],[half_raceway_thickness,-cage_roller_tolerance],[half_raceway_thickness,bearing_width+cage_roller_tolerance],[0,bearing_width+cage_roller_tolerance]]);
                      //Offset roller profile
                      offset(delta=cage_roller_tolerance){
                          union(){
                              //Straight part of roller profile
                              polygon([[0,0],[roller_radius-1.2*scaleA+cage_roller_chamfer,0],[roller_radius-1.2*scaleA,cage_roller_chamfer],[roller_radius-1.2*scaleA,2*scaleA],[roller_radius,3.2*scaleA],[roller_radius,bearing_width-3.2*scaleA],[roller_radius-1.2*scaleA,bearing_width-2*scaleA],[roller_radius-1.2*scaleA,bearing_width-cage_roller_chamfer],[roller_radius-1.2*scaleA+cage_roller_chamfer,bearing_width],[0,bearing_width]]);
                              //Curved part of roller profile
                              if(roller_type=="curved"){
                              intersection(){
                                  polygon([[x1,y1],[x1,y2],[half_raceway_thickness,y2],[half_raceway_thickness,y1]]);
                                  translate([x1-sqrt(R*R-((y2-y1)/2)*((y2-y1)/2)),(y1+y2)/2,0]){
                                      circle(R,$fn=60*roller_mesh_refinement*circle_size_refinement);
}}}}}}}}}}
if(cutaway=="yes"){
    translate([0.001,-outer_diameter-0.001,bearing_width/2-outer_diameter]){
    cube(outer_diameter);
}}}}


//Add rollers to bearing
color("yellow"){
for(i=[1:number_of_rollers]){
      rotate(i*360/number_of_rollers){
          translate([middle_radius,0,-0.0001]){
              //Cut hex keys from rollers
              difference(){
                  //Roller
                  //Fudge factor to make the hex keys look nice
                  translate([0,0,0.0001]){
                  rotate_extrude($fn=60*roller_mesh_refinement){
                      //Roller profile
                      union(){
                          //Straight part of profile
                          polygon([[0,0],[roller_radius-1.2*scaleA,0],[roller_radius-1.2*scaleA,2*scaleA],[roller_radius,3.2*scaleA],[roller_radius,bearing_width-3.2*scaleA],[roller_radius-1.2*scaleA,bearing_width-2*scaleA],[roller_radius-1.2*scaleA,bearing_width],[0,bearing_width]]);
                          //Curved part of profile
                          if(roller_type=="curved"){
                          intersection(){
                              polygon([[x1,y1],[x1,y2],[half_raceway_thickness,y2],[half_raceway_thickness,y1]]);
                              translate([x1-sqrt(R*R-((y2-y1)/2)*((y2-y1)/2)),(y1+y2)/2,0]){
                                  circle(R,$fn=60*roller_mesh_refinement*circle_size_refinement);
                    }}}}}}
                    //Hex key socket to cut from roller
                    linear_extrude(height=key_socket_depth){
                    circle(r=key_radius,$fn=6);
}}}}}}}}