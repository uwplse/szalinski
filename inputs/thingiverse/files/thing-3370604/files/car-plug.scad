//uncoment this for smoother end design
//$fn=90;
length_of_plug=23.3;
plug_dia= 8.2;
plug_rad=plug_dia/2;
head_dia= 24.1;
head_rad= head_dia/2;
dist_start_sml_rings=3; //ditance between large ring and small rings
j=dist_start_sml_rings+2; // add thinkness of head to get spacing
k= 2; // axial distance between small rings on plug
small_ring_thickness=1.1 ;  // max thickness of ring(though pointed
small_ring_diameter=11.2; // max diameter of small rings
small_ring_radius = small_ring_diameter/2;

last_ring_height = length_of_plug-5.2;

union(){
translate([0,0,23.3-5.2])cylinder(r1=plug_rad,r2=(plug_dia-5.2)/2,h=5.2, center = false);
cylinder(r1=plug_rad,r2=plug_rad,h=length_of_plug-5.2, center = false);
cylinder(r1=(head_dia-4)/2 ,r2=head_rad,h=2 ,center = false);

color ("red") {
    for (i=[j:k:last_ring_height]){
        translate([0,0,i])cylinder(r1=plug_rad,r2=small_ring_radius,h=small_ring_thickness/2, center = false);
        translate([0,0,i+small_ring_thickness/2])cylinder(r1=small_ring_radius,r2=plug_rad,h=small_ring_thickness/2, center = false);
    }
}
}