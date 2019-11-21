$fn=30;

// Element to be generated
Element="Right Wall";
// [Example, Drawer1, Drawer2, Drawer4, Shelf, Shelf with Bottom, Connect, Left Wall, Right Wall]

// Nuber of Elements, when Element=Set or Drawer1,2,4 the Number of generated elements is limited to 1
Number=1; // [1:1:8]

// Width of the drawer, Width of Box = drawer_x + 2*plug_w
drawer_x=100; // [50:1:160]

// Length of the drawer
drawer_y=100; // [50:1:160]

// Height of the drawer, Minimum 4xplug_w
drawer_z=50; // [16:1:160]

// Thickness of the drawer walls
drawer_t=0.8; // [0.4:0.1:2]

// Height of the shelf
shelf_z=10; // [8:0.5:20]

// Width of the plugs
plug_w=8; // [5:0.5:10]

// Plug wall thickness
plug_t=1.2; // [0.1:0.05:1]

// Width of ledge
shelf_ledge=5; // [4:0.5:10]

// Radius of the corners on the front panel of a drawer
cornerradius=3; // [0.5:0.5:6]

// Drawers adjustment for easy fitting
adjustment=0.5; // [0.1:0.05:1]

// Adjustment value for correction when using differences in OpenSCAD
diffcorr=0.2; // [0.1:0.05:1]

// Drawing the selected Element
for (i=[0:Number-1]) {
  if (Element=="Example")      {example();}
  else if (Element=="Drawer1") {drawer(1);}
  else if (Element=="Drawer2") {drawer(2);}
  else if (Element=="Drawer4") {drawer(4);}
  else if (Element=="Shelf")   {shelf();}
  else if (Element=="Shelf with Bottom")   {shelf(true);}
  else if (Element=="Connect") {connect();}
  else if (Element=="Left Wall")    {wall("left");}
  else if (Element=="Right Wall")    {wall("right");}
}

module example() {
  shelf();
  translate([0,0,drawer_z+drawer_t])rotate([0,0,0])shelf();

  height=drawer_z+drawer_t+2*plug_w;

  translate([+1*(drawer_x/2+drawer_t+plug_w/2),-1*(drawer_y/2-plug_w/2-drawer_t),height/2])rotate([-90,0,0])connect();
  translate([-1*(drawer_x/2+drawer_t+plug_w/2),-1*(drawer_y/2-plug_w/2-drawer_t),height/2])rotate([-90,0,0])connect();
  translate([+1*(drawer_x/2+drawer_t+plug_w/2),+1*(drawer_y/2-plug_w/2-drawer_t),height/2])rotate([90,0,0])connect();
  translate([-1*(drawer_x/2+drawer_t+plug_w/2),+1*(drawer_y/2-plug_w/2-drawer_t),height/2])rotate([90,0,0])connect();

  translate([-drawer_x-plug_w-2*drawer_t,0,height/2])rotate([0,180,0])wall("Left");
  translate([-drawer_t,-30,drawer_t*7/4])drawer(1);
}

module wall(side="right") {
  height=drawer_z+drawer_t-2*plug_w;
  hull() {
    translate([-1*(drawer_x/2+drawer_t/2),-drawer_y/2+plug_w/2,-plug_w/2-diffcorr-height/2])rotate([0,90,0])cylinder(d=plug_w,h=drawer_t,center=true);
    translate([-1*(drawer_x/2+drawer_t/2),-drawer_y/2+plug_w/2,+plug_w/2+diffcorr+height/2])rotate([0,90,0])cylinder(d=plug_w,h=drawer_t,center=true);
    translate([-1*(drawer_x/2+drawer_t/2),+drawer_y/2-plug_w/2,-plug_w/2-diffcorr-height/2])rotate([0,90,0])cylinder(d=plug_w,h=drawer_t,center=true);
    translate([-1*(drawer_x/2+drawer_t/2),+drawer_y/2-plug_w/2,+plug_w/2+diffcorr+height/2])rotate([0,90,0])cylinder(d=plug_w,h=drawer_t,center=true);
  }
  if (side=="right") {
    translate([-1*(drawer_x/2+plug_w/2+drawer_t),+1*(drawer_y/2-plug_w/4-drawer_t-diffcorr),+height/2+plug_w/2])joint(depth=plug_w/2);
    translate([-1*(drawer_x/2+plug_w/2+drawer_t),-1*(drawer_y/2-plug_w/4-drawer_t-diffcorr),+height/2+plug_w/2])joint(depth=plug_w/2);
    translate([-1*(drawer_x/2+plug_w/2+drawer_t),+1*(drawer_y/2-plug_w/4-drawer_t-diffcorr),-height/2-plug_w/2])joint(depth=plug_w/2);
    translate([-1*(drawer_x/2+plug_w/2+drawer_t),-1*(drawer_y/2-plug_w/4-drawer_t-diffcorr),-height/2-plug_w/2])joint(depth=plug_w/2);
  }
  else {
    translate([-1*(drawer_x/2+plug_w/2+drawer_t),+1*(drawer_y/2-plug_w*3/4-drawer_t-diffcorr),+height/2+plug_w/2])joint(depth=plug_w/2);
    translate([-1*(drawer_x/2+plug_w/2+drawer_t),-1*(drawer_y/2-plug_w*3/4-drawer_t-diffcorr),+height/2+plug_w/2])joint(depth=plug_w/2);
    translate([-1*(drawer_x/2+plug_w/2+drawer_t),+1*(drawer_y/2-plug_w*3/4-drawer_t-diffcorr),-height/2-plug_w/2])joint(depth=plug_w/2);
    translate([-1*(drawer_x/2+plug_w/2+drawer_t),-1*(drawer_y/2-plug_w*3/4-drawer_t-diffcorr),-height/2-plug_w/2])joint(depth=plug_w/2);
  }
}

module shelf(bottom=false) {
  union() {
    difference() {
      translate([0,0,drawer_t/2]) cube([drawer_x,drawer_y,drawer_t], center=true);
      if (bottom==false) {
        translate([0,0,drawer_t/2]) cube([drawer_x-2*shelf_ledge,drawer_y-2*shelf_ledge,drawer_t+1], center=true);
      }
    }
    translate([-drawer_x/2-drawer_t/2,0,shelf_z/2]) cube([drawer_t,drawer_y,shelf_z], center=true);
    translate([+drawer_x/2+drawer_t/2,0,shelf_z/2]) cube([drawer_t,drawer_y,shelf_z], center=true);

    translate([0,drawer_y/2-drawer_t/2,shelf_z/2]) cube([drawer_x+2*drawer_t,drawer_t,shelf_z], center=true);

    translate([+1*(drawer_x/2+plug_w/2+drawer_t),-1*(drawer_y/2-plug_w/4-plug_w/2-diffcorr-drawer_t-diffcorr),plug_w/2])joint(depth=plug_w/2);
    translate([+1*(drawer_x/2+plug_w/2+drawer_t),+1*(drawer_y/2-plug_w/4-plug_w/2-diffcorr-drawer_t-diffcorr),plug_w/2])joint(depth=plug_w/2);
    translate([-1*(drawer_x/2+plug_w/2+drawer_t),+1*(drawer_y/2-plug_w/4-drawer_t-diffcorr),plug_w/2])joint(depth=plug_w/2);
    translate([-1*(drawer_x/2+plug_w/2+drawer_t),-1*(drawer_y/2-plug_w/4-drawer_t-diffcorr),plug_w/2])joint(depth=plug_w/2);

    if (bottom==false) {
      translate([+1*(drawer_x/2+plug_w/2+drawer_t),-1*(drawer_y/2-plug_w/4-plug_w/2-diffcorr-drawer_t-diffcorr),plug_w*3/2])joint(depth=plug_w/2);
      translate([+1*(drawer_x/2+plug_w/2+drawer_t),+1*(drawer_y/2-plug_w/4-plug_w/2-diffcorr-drawer_t-diffcorr),plug_w*3/2])joint(depth=plug_w/2);
      translate([-1*(drawer_x/2+plug_w/2+drawer_t),+1*(drawer_y/2-plug_w/4-drawer_t-diffcorr),plug_w*3/2])joint(depth=plug_w/2);
      translate([-1*(drawer_x/2+plug_w/2+drawer_t),-1*(drawer_y/2-plug_w/4-drawer_t-diffcorr),plug_w*3/2])joint(depth=plug_w/2);

      translate([-1*(drawer_x/2+drawer_t/2),-1*(drawer_y/2-plug_w*3/4-diffcorr),shelf_z]) rotate([0,90,0])cylinder(d=plug_w*2/3,h=drawer_t, center=true);
      translate([+1*(drawer_x/2+drawer_t/2),-1*(drawer_y/2-plug_w*3/4-diffcorr),shelf_z]) rotate([0,90,0])cylinder(d=plug_w*2/3,h=drawer_t, center=true);
    }
    else{
      translate([0,-drawer_y/2+drawer_t/2,shelf_z/2]) cube([drawer_x+2*drawer_t,drawer_t,shelf_z], center=true);
    }
  }
}

module joint(depth=plug_w) {
  difference() {
    cube([plug_w,depth,plug_w],center=true);
    rotate([90,0,0])cylinder(d=plug_w*2/3,h=depth+diffcorr,center=true);
  }
}

module connect(height=plug_w) {
  height=drawer_z+drawer_t-2*plug_w;
  hull() {
    translate([0,-plug_w/2-diffcorr-height/2,-plug_w/2-drawer_t/2])cylinder(d=plug_w,h=drawer_t,center=true);
    translate([0,+plug_w/2+diffcorr+height/2,-plug_w/2-drawer_t/2])cylinder(d=plug_w,h=drawer_t,center=true);
  }

  translate([0,0,-plug_w/4])cube([plug_w/3,height-diffcorr-plug_w,plug_w/2],center=true);

  translate([0,-height/2+diffcorr/2+plug_w/6,diffcorr/2])cube([plug_w,plug_w/3,plug_w+diffcorr],center=true);
  translate([0,+1*(-height/2+diffcorr/2+plug_w/12),plug_w*2/3+diffcorr]) {
    difference() {
      translate([0,0,plug_w/4])prism(plug_w,plug_w/2,plug_w/2);
      translate([0,0,plug_w*4/8])cube([plug_w+diffcorr,plug_w/2+diffcorr,plug_w/2],center=true);

    }
    rotate([0,180,0])translate([0,0,plug_w/4])prism(plug_w,plug_w/2,plug_w/2);
  }

  translate([0,-1*(-height/2+diffcorr/2+plug_w/6),diffcorr/2])cube([plug_w,plug_w/3,plug_w+diffcorr],center=true);
  translate([0,-1*(-height/2+diffcorr/2+plug_w/12),plug_w*2/3+diffcorr])rotate([0,0,180]) {
    difference() {
      translate([0,0,plug_w/4])prism(plug_w,plug_w/2,plug_w/2);
      translate([0,0,plug_w*4/8])cube([plug_w+diffcorr,plug_w/2+diffcorr,plug_w/2],center=true);

    }
    rotate([0,180,0])translate([0,0,plug_w/4])prism(plug_w,plug_w/2,plug_w/2);
  }

  translate([0,-plug_w/2-diffcorr/2-height/2,0])cylinder(d=plug_w*2/3-2*diffcorr,h=plug_w,center=true);
  translate([0,-plug_w/2-diffcorr/2-height/2,plug_w/2])sphere(d=plug_w*2/3-2*diffcorr,center=true);
  translate([0,+plug_w/2+diffcorr/2+height/2,0])cylinder(d=plug_w*2/3-2*diffcorr,h=plug_w,center=true);
  translate([0,+plug_w/2+diffcorr/2+height/2,plug_w/2])sphere(d=plug_w*2/3-2*diffcorr,center=true);
}

module drawer(type=1) {
  union() {
    if (type==1 || type==2 || type==4) {
      //bottom
      cube([drawer_x-adjustment,drawer_y,drawer_t], center=true);
      // left wall
      translate([-drawer_x/2+drawer_t/2+adjustment/2,0,drawer_z/2-drawer_t/2-adjustment/2])
        cube([drawer_t,drawer_y,drawer_z-adjustment], center=true);
      // right wall
      translate([+drawer_x/2-drawer_t/2-adjustment/2,0,drawer_z/2-drawer_t/2-adjustment/2])
        cube([drawer_t,drawer_y,drawer_z-adjustment], center=true);
      // back wall
      translate([0,+drawer_y/2-drawer_t/2,drawer_z/2-drawer_t/2-adjustment/2])
        cube([drawer_x-adjustment,drawer_t,drawer_z-adjustment], center=true);
      // drawer stops
      translate([+drawer_x/2-drawer_t/4,+drawer_y/2-drawer_t/2,shelf_z])
        scale([1,1,1.4])rotate([90,0,0])cylinder(r=drawer_t,h=drawer_t,center=true);
      translate([-drawer_x/2+drawer_t/4,+drawer_y/2-drawer_t/2,shelf_z])
        scale([1,1,1.4])rotate([90,0,0])cylinder(r=drawer_t,h=drawer_t,center=true);
      // front wall
      translate([0,-drawer_y/2+drawer_t/2,cornerradius-drawer_t/2])
        hull() {
          translate([-drawer_x/2+drawer_t,0,0])rotate([90,0,0]) cylinder(r=cornerradius,h=drawer_t,center=true);
          translate([+drawer_x/2-drawer_t,0,0])rotate([90,0,0]) cylinder(r=cornerradius,h=drawer_t,center=true);
          translate([-drawer_x/2+drawer_t,0,drawer_z-cornerradius*2])rotate([90,0,0]) cylinder(r=cornerradius,h=drawer_t,center=true);
          translate([+drawer_x/2-drawer_t,0,drawer_z-cornerradius*2])rotate([90,0,0]) cylinder(r=cornerradius,h=drawer_t,center=true);
        }
      // handle
      if (drawer_z>20) {
        drawer_z=20;
        translate([0,-drawer_y/2+drawer_t/2-2.5,drawer_z/2-drawer_t])cube([4,5,drawer_z-drawer_t], center=true);
        translate([0,-drawer_y/2-drawer_t-6,drawer_z/2-drawer_t])cylinder(d=6,h=drawer_z-drawer_t, center=true);
        translate([0,-drawer_y/2-drawer_t-6,drawer_z/2-drawer_t+drawer_z/2-drawer_t/2])sphere(d=6, center=true);
      }
    }
    if (type==2 || type==4) {
      translate([0,0,drawer_z/2-drawer_t/2-adjustment/2])
        cube([drawer_t,drawer_y,drawer_z-adjustment], center=true);
    }
    if (type==4) {
      translate([0,0,drawer_z/2-drawer_t/2-adjustment/2])
        cube([drawer_x-adjustment,drawer_t,drawer_z-adjustment], center=true);
    }
  }
}

module prism(l, w, h, pos){
  rotate(pos) translate([-l/2,-w/2,-h/2])polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
  );
}

