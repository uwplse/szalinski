// preview[view:south east, tilt:top diagonal]

Width = 80; // [25:200]
Length = 190; // [50:500]
Height = 6; // [4:10]
/* [Misc Settings] */
Corner_Radius = 10; // [0:12]
Border_Thickness = 2; // [3:10]
Mesh_Width = 4; // [3:10]
Mesh_Thickness = 2; // [2:4]
Weep_Holes = 8; // [0:20]
//*********Declaration of customization variables************
/* [Hidden] */

// Takes much longer to generate with this enabled.
// Comment out until final rendering.
$fn=120;

union(){
  difference(){
    union(){
      // Generate the outer perimeter
      difference() {
        base(0);
        translate([0,0,-1]) 
          resize([Width-Border_Thickness*2,Length-Border_Thickness*2,Height+2]) base(0);
      }
      // Add the center support
      translate([-Border_Thickness/2,-Length/2,0])cube([Border_Thickness,Length,Height]);
    }
    // Add the weep holes across the bottom
    for ( j = [1 : 1 : Weep_Holes] )	{
        weep_len = Length-Corner_Radius*2-Mesh_Width*2;
        weep_max = weep_len/2;
        weep_step = weep_len/(Weep_Holes-1);
        weep_shift = weep_max-weep_step*(j-1);
        //echo(j,weep_len,weep_max,weep_step,weep_shift);
        translate([-Width/2-0.01,weep_shift,Height])rotate(90,[0,1,0])cylinder(h=Width+1,r=Mesh_Width/2);
    }
  }
  // And finally add the slots in the top
  intersection() {
    mesh_raw(h=Mesh_Thickness,mesh_w=Mesh_Width,mesh_space=Mesh_Width,width=max(Width,Length)+10,layer_height=0.3);
    base();
  }
}

module mesh_raw(h=2,mesh_w=1,mesh_space=2,width=50,layer_h=0.3){
	for ( j = [0 :(mesh_w+mesh_space): width] )	{
	   //	translate([0,0,0.01])translate([-width/2+j, 0, h/4])cube([mesh_w,width,h/2-layer_h/10],center=true);
		translate([0,0,0.01])translate([0, -mesh_w-j, h/4])cube([width,mesh_w,h/2],center=true);
        translate([0,0,0.01])translate([0, mesh_w+j, h/4])cube([width,mesh_w,h/2],center=true);
	}
}

module base(adj=0,h=Height) {

    w = Width - adj;
    l = Length - adj;
    r = Corner_Radius - adj;

  union(){
    translate ([-(w-(r*2))/2,-l/2,0])cube([w-(r*2),l, h]);
    translate ([-w/2,-(l-(r*2))/2,0])cube([w,l-(r*2), h]);
    translate ([(w/2)-r,(l/2)-r,0])cylinder(h=h,r=r);
    translate ([-((w/2)-r),(l/2)-r,0])cylinder(h=h,r=r);
    translate ([(w/2)-r,-((l/2)-r),0])cylinder(h=h,r=r);
    translate ([-((w/2)-r),-((l/2)-r),0])cylinder(h=h,r=r);
  }
}