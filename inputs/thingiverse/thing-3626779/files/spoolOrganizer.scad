// bits and bobs for a spool-based tool organizer
// 2019 Troseph
// https://www.thingiverse.com/thing:3626779

$fn=50;
//  spool info
mainDia=200;
innerDia=87;
wallthickness=1.2;
middleDia=140;
// set to 60 for type 1
wallheight=60;

//  variables for type 5
//  the tool holder diameter (must be slightly larger than the tool)
toolHandleDia=15;
//  hole for tool to go through
toolDia=6;
//  depth of the cup to hold a tool
toolHolderHeight=15;

//  type 1 is for 1/4th swinging drawers
//  type 2 is half a bottom tray
//  type 3 is the whole bottom tray, but I don't know how you'll get it on a typical spool
//  type 4 is 1/6th tray with center dividers
//  type 5 is for screw driver holders
type=1;

// magic
spokeLen=(mainDia/2)-(innerDia/2);
spokeOffset=(innerDia/2)+(spokeLen/2);

module do_it(){
  if (type==1) {
    bottom_cup_1_4th();
  }
  if (type==2) {
    bottom_cup_half();
  }
  if (type==3) {
    bottom_cup();
  }
  if (type==4) {
    bottom_cup_1_6th();
  }
  if (type==5) {
    tool_holder();
  }
}


module bottom_cup_half(){
  difference(){
    bottom_cup();
    chop_block();
  }
}
module chop_block(){
  translate([0,(mainDia/2)+(wallthickness/2),0])cube([mainDia,mainDia,(wallheight+4)],true);
}
module bottom_cup_1_4th(){
  rotate([0,0,-87]) translate([spokeOffset,0,0])cube([spokeLen,wallthickness,wallheight],true);
  translate([spokeOffset,0,0])cube([spokeLen,wallthickness,wallheight],true);
  difference(){
    union(){
      translate([spokeOffset+((spokeLen/2)-3),-1.85,0])cylinder(h=wallheight,d=5,center=true);
      difference(){
        bottom_cup();
        chop_block();
        rotate([0,0,93]) chop_block();
      }
    }
    translate([spokeOffset+((spokeLen/2)-3),-1.85,0])cylinder(h=wallheight+2,d=3,center=true);
  }
}
module bottom_cup_1_6th(){
  difference(){
    bottom_cup();
    rotate([0,0,60]) chop_block();
    rotate([0,0,-60]) chop_block();
  }
}

module bottom_cup(){
  //mainbody
  difference(){
    cylinder(h=wallheight,d=mainDia,center=true);
    translate([0,0,0])cylinder(h=(wallheight+4),d=innerDia,center=true);
    translate([0,0,1])cylinder(h=wallheight,d=mainDia-(wallthickness*2),center=true);
  };
 //inner ring
  difference(){
    cylinder(h=wallheight,d=innerDia+(wallthickness*2),center=true);
    translate([0,0,1])cylinder(h=(wallheight+4),d=innerDia,center=true); 
  }
  if (type!=1) {
    //middle ring
    difference(){
      cylinder(h=wallheight,d=middleDia,center=true);
      translate([0,0,1])cylinder(h=(wallheight+4),d=middleDia-(wallthickness*2),center=true); 
    }
    //spokes
    for (i = [0 : 5]){
    rotate([0,0,i*60]) translate([spokeOffset,0,0])cube([spokeLen,wallthickness,wallheight],true);
    }
 }
}

module tool_holder(){
  difference(){
    cylinder(h=toolHolderHeight,d=toolHandleDia+wallthickness,center=true);
    translate([0,0,wallthickness])cylinder(h=toolHolderHeight,d=toolHandleDia,center=true);
    translate([0,0,-(toolHolderHeight/2)])cylinder(h=toolHolderHeight,d=toolDia,center=true);
  }
};

do_it();