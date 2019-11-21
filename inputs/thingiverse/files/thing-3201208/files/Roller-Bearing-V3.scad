//Variables

//preview[view:north east, tilt:top diagonal]

/*[Basic parameters]*/

//A cutaway view of the bearing (be sure to set to "no" if generating an STL)
cutaway="yes";//[yes,no]

//For multi material printing you can generate just the raceways, cage or rollers to print in different materials. Select all for the whole bearing.
parts="all";//[all,raceways,cage,rollers]

inner_diameter=10;

outer_diameter=40;

bearing_width=12;

roller_shape="cylindrical";//[curved,cylindrical]

//A slot included into the base of the rollers for flathead screwdrivers to twist and free up stuck rollers after printing. The 'Base Slots' cut right through the base of the roller, reducing contact area with the print bed slightly. The 'Inset Slots' are set into the roller slightly and do not cut into the first printing layer of the roller. This makes printing and sticking the first layer of the rollers to the print bed easier, while still making the loosening slots available by breaking through the thin first layer to access it. The default inset distance is 0.2mm .
roller_loosening_slot="inset slots";//[no,base slots,inset slots]

//Make sure the tolerance settings are suitable for your printer. A general rule of thumb for the tolerances is 'Roller Raceway Tolerance'<'Cage Roller Tolerance'<'Cage Raceway Tolerance'. 'Roller Raceway Tolerance' is the tolerance between the rollers and raceway. You can use a relatively low tolerance value here since the rollers and raceway only come close at a point on the roller circumference.
roller_raceway_tolerance=0.2;

//This is the tolerance between the rollers and cage. Set this to a value that just allows the rollers to turn easily in the cage.
cage_roller_tolerance=0.4;

//This is the tolerance between the cage and raceway. This should be a fair bit larger than the 'roller raceway tolerance', to prevent the bearing riding on the cage (causing sliding friction) and not on the rollers.
cage_raceway_tolerance=0.5;

//The tolerance gap above the rollers for the cage to bridge over them 
bridge_tolerance=0.6;

//This is a bit of a hack to make the first cage bridging layer over the rollers consist of just concentric circles, which makes the bridging clean, without having to set the number of shells very high. It slices the bridging part of the cage into rings with a very small gap between them so that the slicer produces extra shells on the bridging section.
cage_bridge_slice="yes";//[yes,no]

//Width of the gaps sliced into the cage bridging section. If the gaps are too small sometimes the slicer will ignore them
cage_bridge_slice_gap=0.01;

//Raceway mesh quality multiplier (higher is more, default is 200 segments around). Important to increase if making very large bearings.
raceway_mesh_refinement=1;

//Roller mesh quality multiplier (higher is more, default is 60 segments around)
roller_mesh_refinement=1;

/*[Advanced Parameters]*/

//Diameter of the cylindrical part of the rollers, the actual diameter will extend out further if curved rollers are selected. Also avoid making the footprint of the roller too small, otherwise it may break away from the print bed.
roller_diameter_override=0;

//The radius of curvature on the curved part of the rollers (if selected) If the radius is less than half the raceway contact thickness,(Bearing Width - 6.4*Cage Geometry Scale), the model won't generate properly
R_override=0;

number_of_rollers_override=0;

//The length of the loosening slot cut into the roller
roller_slot_length_override=0;

//The width of the loosening slot cut into the roller
roller_slot_width_override=0;

//The depth of the loosening slot cut into the roller
roller_slot_depth_override=0;

//The the distance the loosening slot is inset into the roller.
roller_slot_inset_override=0;

//The cage tapers down to this minimum width in the centre of the bearing. 0.6*roller_diameter is a good value to start with.
cage_width_override=0;

//The minimum thickness of the cage pillars between the rollers.
cage_pillar_thickness_override=0;

//Scales the rest of the geometry defining the cage. A general rule of thumb is to increace this if you are using wider rollers or decrease it if you are using thinner rollers than the default bearing (on the defualt bearing, the default setting for this parameter is 1).
cage_geometry_scale_override=0;

//A chamfer that helps prevent the cage and rollers fusing together on the first few layers
cage_roller_chamfer_override=0;

//A chamfer that helps prevent the cage and raceway fusing together on the first few layers
cage_raceway_chamfer_override=0;

//Chamfer on the outer and inner diameter of the bearing
outside_chamfer_override=0;

/*[Hidden]*/

//Variable calculations

half_raceway_thickness=(outer_diameter-inner_diameter)/4;
middle_radius=(inner_diameter+outer_diameter)/4;

roller_diameter= roller_diameter_override==0 ? 1.2*half_raceway_thickness:roller_diameter_override;
roller_radius=roller_diameter/2;
 
cage_geometry_scale= cage_geometry_scale_override==0 ? roller_diameter/9:cage_geometry_scale_override;

cage_width= cage_width_override==0 ? 5*roller_diameter/9:cage_width_override;
half_cage_width=cage_width/2;

cage_pillar_thickness= cage_pillar_thickness_override==0 ? 0.09*roller_diameter:cage_pillar_thickness_override;

cage_roller_chamfer= cage_roller_chamfer_override==0 ? cage_geometry_scale/2:cage_roller_chamfer_override;

cage_raceway_chamfer= cage_raceway_chamfer_override==0 ? cage_geometry_scale/2:cage_raceway_chamfer_override;

outside_chamfer= outside_chamfer_override==0 ? 0.3*cage_geometry_scale:outside_chamfer_override;

half_rolling_contact=(bearing_width-6.4*cage_geometry_scale)/2;
curved_profile_width= (0.10*roller_diameter)/half_rolling_contact>0.414 ? 0.414*half_rolling_contact:0.10*roller_diameter;

scaleA= half_rolling_contact<0 ? bearing_width/6.4:cage_geometry_scale;

roller_type= half_rolling_contact<0 ? "cylindrical":roller_shape;

R= R_override==0 ? (half_rolling_contact*half_rolling_contact+curved_profile_width*curved_profile_width)/(2*curved_profile_width):R_override;

number_of_rollers= number_of_rollers_override==0 ? round(360/(2*asin((roller_radius+(roller_type=="curved" ? R-sqrt(R*R-half_rolling_contact*half_rolling_contact):0)+cage_roller_tolerance+cage_pillar_thickness/2)/middle_radius))-0.5):number_of_rollers_override;

roller_slot_length= roller_slot_length_override==0 ? roller_diameter:roller_slot_length_override;

roller_slot_width= roller_slot_width_override==0 ? 0.12*roller_diameter:roller_slot_width_override;

roller_slot_depth= roller_slot_depth_override==0 ? 0.1*roller_diameter:roller_slot_depth_override;

roller_slot_inset= roller_slot_inset_override==0 ? 0.2:roller_slot_inset_override;

//Curved roller profile generator
x1=roller_radius;
y1=3.2*scaleA;
y2=bearing_width-3.2*scaleA;
nP=round(roller_mesh_refinement*12);
xc=x1-sqrt(R*R-half_rolling_contact*half_rolling_contact);
yc=(y1+y2)/2;
al=asin(half_rolling_contact/R);
th=2*al/nP;
pol=[for(i=[1:nP-1]) [R*cos(al-i*th)+xc,R*sin(al-i*th)+yc]];
curved_profile=concat([[x1,y2]],pol,[[x1,y1]]);


//Bearing half-profiles
raceway_profile=[[0,0],[half_raceway_thickness-outside_chamfer,0],[half_raceway_thickness,outside_chamfer],[half_raceway_thickness,bearing_width-outside_chamfer],[half_raceway_thickness-outside_chamfer,bearing_width],[0,bearing_width]];

cage_profile=[[0,0],[roller_radius-cage_raceway_chamfer+scaleA,0],[roller_radius-cage_raceway_chamfer+scaleA,cage_raceway_chamfer],[half_cage_width,roller_radius+scaleA-half_cage_width],[half_cage_width,bearing_width-roller_radius-scaleA+half_cage_width],[roller_radius-cage_raceway_chamfer+scaleA,bearing_width-cage_raceway_chamfer],[roller_radius-cage_raceway_chamfer+scaleA,bearing_width],[0,bearing_width]];

cage_cut_profile=[[0,0],[roller_radius+scaleA,0],[half_cage_width,roller_radius+scaleA-half_cage_width],[half_cage_width,bearing_width-roller_radius-scaleA+half_cage_width],[roller_radius+scaleA,bearing_width],[0,bearing_width]];

cylindrical_roller_profile=[[0,0],[roller_radius-1.2*scaleA,0],[roller_radius-1.2*scaleA,2*scaleA],[roller_radius,3.2*scaleA],[roller_radius,bearing_width-3.2*scaleA],[roller_radius-1.2*scaleA,bearing_width-2*scaleA],[0,bearing_width-2*scaleA]];

cylindrical_roller_raceway_cut_profile=[[0,0],[roller_radius-1.2*scaleA,0],[roller_radius-1.2*scaleA,2*scaleA],[roller_radius,3.2*scaleA],[roller_radius,bearing_width-3.2*scaleA],[roller_radius-1.2*scaleA,bearing_width-2*scaleA],[roller_radius-1.2*scaleA,bearing_width],[0,bearing_width]];

cylindrical_roller_cage_cut_profile=[[cage_roller_tolerance,0],[roller_radius-1.2*scaleA+cage_roller_chamfer,0],[roller_radius-1.2*scaleA,cage_roller_chamfer],[roller_radius-1.2*scaleA,2*scaleA],[roller_radius,3.2*scaleA],[roller_radius,bearing_width-2*scaleA-cage_roller_tolerance+bridge_tolerance],[cage_roller_tolerance,bearing_width-2*scaleA-cage_roller_tolerance+bridge_tolerance]];


//Bearing generator

//Raceways generator
if(parts=="raceways"||parts=="all"){ 
color("silver"){
    //Cut out inner profile from raceway
difference(){               
        //Raceways
    rotate_extrude($fn=200*raceway_mesh_refinement,convexity=10){   
        translate([middle_radius,0,0]){            
                //Raceway profile
            union(){    
                polygon(raceway_profile);
                mirror([1,0,0]){
                    polygon(raceway_profile);
    }}}}    
        //Inner shape to cut into raceway
    rotate_extrude($fn=200*raceway_mesh_refinement,convexity=10){  
        translate([middle_radius,0,0]){
                //Total inner cut profile
            union(){
                    //Total cage profile to cut raceways
                offset(delta=cage_raceway_tolerance){
                    polygon(cage_cut_profile);
                    mirror([1,0,0]){
                        polygon(cage_cut_profile);
                }}
                    //Total roller profile to cut raceways
                offset(delta=roller_raceway_tolerance){
                    union(){                   
                        polygon(cylindrical_roller_raceway_cut_profile);
                        if(roller_type=="curved"){
                            polygon(curved_profile);
                        }
                        mirror([1,0,0]){
                            polygon(cylindrical_roller_raceway_cut_profile);
                            if(roller_type=="curved"){
                                polygon(curved_profile);
    }}}}}}}
if(cutaway=="yes"){
    translate([0,0,-0.1]){
        cube(outer_diameter);
}}}}}

    //Cage generator
if(parts=="all"||parts=="cage"){
color("deepskyblue"){
    //Cut holes for rollers into the cage
difference(){
        //Cage body
    rotate_extrude($fn=200*raceway_mesh_refinement,convexity=10){
        translate([middle_radius,0,0]){
                //Cage profile
            union(){
                polygon(cage_profile);
                mirror([1,0,0]){
                    polygon(cage_profile);
    }}}}
        //Roller holes
    for(i=[1:number_of_rollers]){
      rotate(i*360/number_of_rollers){
          translate([middle_radius,0,0]){
              rotate_extrude($fn=60*roller_mesh_refinement){
                  offset(delta=cage_roller_tolerance){
                          //Roller hole cutting profile
                      union(){
                          polygon(cylindrical_roller_cage_cut_profile);
                          if(roller_type=="curved"){
                              polygon(curved_profile);
    }}}}}}}
        //Cage bridge slice
    if(cage_bridge_slice=="yes"){
        bridge_thickness=2*scaleA-bridge_tolerance;
        half_bridge_width=roller_radius+scaleA-bridge_thickness;
        rotate_extrude($fn=200*raceway_mesh_refinement,convexity=10){
            for(i=[1,-1]){
                translate([middle_radius+i*half_bridge_width/3,bearing_width-0.001-3*bridge_thickness/4,0]){
                    square(size=[cage_bridge_slice_gap,bridge_thickness/2],center=true); 
    }}}}
if(cutaway=="yes"){
    translate([0.001,0.001,bearing_width/2]){
    cube(outer_diameter);
}}}}}

    //Rollers generator
if(parts=="all"||parts=="rollers"){
color("yellow"){
for(i=[1:number_of_rollers]){
      rotate(i*360/number_of_rollers){
          translate([middle_radius,0,0]){
                  //Cut loosening slots from rollers
              difference(){
                      //Rollers
                  rotate_extrude($fn=60*roller_mesh_refinement){
                          //Roller profile
                      union(){
                          polygon(cylindrical_roller_profile);
                          if(roller_type=="curved"){
                              polygon(curved_profile);
                  }}}
                      //Loosening slots
                  if(roller_loosening_slot!="no"){
                      rotate(i*(-360/number_of_rollers)){
                          translate([0,0,roller_slot_depth/2-0.001+(roller_loosening_slot=="inset slots" ? roller_slot_inset:0)]){
                          cube(size=[roller_slot_length,roller_slot_width,roller_slot_depth],center=true);
}}}}}}}}}