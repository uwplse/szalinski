//this is a Delta hard drive Bearring Mount for the top of the printer arm piece
make_arm();

module make_arm(pvc_inner_radius=10.5, arm_length=30){
  //find the distance between sides to properly size clamp
  angle = 67.5; //angle of octogon
  side =  (2*pvc_inner_radius)*cos(angle);//each side of the octogon is equal to "c*cos(t)" where "c" is the diameter of the octogon
  x = side/(sqrt(2));
  distance_from_sides = 2*x+side;
  //lay octogon on its side and position next to clamp
  union(){
    rotate([22.5,0,0]){
      rotate([0,90,0]){
        translate([0,0,18]){
          cylinder(h = arm_length, r1=pvc_inner_radius, r2 = pvc_inner_radius, $fn=8);
    };};};
    difference(){
      translate([-(36/2),-(40/2), -(distance_from_sides/2)]){
        roundedcube(36, 40,distance_from_sides,5);
        //rounded2(36, 40,distance_from_sides,5);
      };
      translate([0,-3,0]){
        cube([22, 35, 22], center=true);};
    };
  };
};

module roundedcube(xdim ,ydim ,zdim,rdim){
  hull(){
    translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
    translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);
    translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
    translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
   };
};
