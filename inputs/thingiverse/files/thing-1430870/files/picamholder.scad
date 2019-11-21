//2020 frame block holder
tolerance = 0.4;
screwradius = 1.5; //M3
screwlength = 8;
nutheight = 2.5;
nutrad = 3+tolerance/2;
washerheight = 0;
partwidth = (screwlength-nutheight+washerheight)/2;
holeradius = screwradius+tolerance/2;
tmult= 3;
armlength=40;
module arm(){
 translate([0,0,partwidth/2])union(){
  //arm
  cube([holeradius*tmult*2,armlength-screwradius*2,partwidth],center=true);
 //armscewhole
  translate([0,armlength/2,0])rotate([0,0,0])difference(){
   union(){
    cylinder(h=partwidth,r=holeradius*tmult,$fn=90,center=true);
    translate([0,-holeradius*tmult/2,0])cube([holeradius*tmult*2,holeradius*tmult,partwidth],center=true);
   }
   cylinder(h=partwidth,r=holeradius,$fn=90,center=true);
  }
  //nutholder
  translate([0,armlength/2,nutheight])rotate([0,0,0])difference(){
    cylinder(h=nutheight,r=holeradius*tmult,$fn=90,center=true);
   cylinder(h=nutheight,r=nutrad,$fn=6,center=true);
  }
  //theotherhole
  translate([0,-armlength/2,0])rotate([0,0,180])difference(){
   union(){
    cylinder(h=partwidth,r=holeradius*tmult,$fn=90,center=true);
    translate([0,-holeradius*tmult/2,0])cube([holeradius*tmult*2,holeradius*tmult,partwidth],center=true);
   }
   cylinder(h=partwidth,r=holeradius,$fn=90,center=true);
  }
 }
}

module angle(){
 translate([0,0,partwidth/2])union(){
  //arm
  cube([holeradius*tmult*2,10-screwradius*2,partwidth],center=true);
 //armscewhole
  translate([0,10/2,0])rotate([0,0,0])difference(){
   union(){
    cylinder(h=partwidth,r=holeradius*tmult,$fn=90,center=true);
    translate([0,-holeradius*tmult/2,0])cube([holeradius*tmult*2,holeradius*tmult,partwidth],center=true);
   }
   cylinder(h=partwidth,r=holeradius,$fn=90,center=true);
  }
  //theotherhole
  translate([0,-2.15,holeradius*tmult])rotate([90,0,180])difference(){
   union(){
    cylinder(h=partwidth,r=holeradius*tmult,$fn=90,center=true);
    translate([0,-holeradius*tmult/2,0])cube([holeradius*tmult*2,holeradius*tmult,partwidth],center=true);
   }
   cylinder(h=partwidth,r=holeradius,$fn=90,center=true);
  }
 }
}

//holding block

module block(){
translate([0,0,7])difference(){
 union(){
  //block
  cube([20,20,6],center=true);
  //armscewhole
  translate([10-holeradius*tmult,10-partwidth/2,3+holeradius*tmult])rotate([90,0,0])difference(){
   union(){
    cylinder(h=partwidth,r=holeradius*tmult,$fn=90,center=true);
    translate([0,-holeradius*tmult,0])cube([holeradius*tmult*2,holeradius*tmult*2,partwidth],center=true);
   }
   cylinder(h=partwidth,r=holeradius,$fn=90,center=true);
  }
  //nutholder
  translate([10-holeradius*tmult,10-partwidth/2-nutheight,3+holeradius*tmult])rotate([90,0,0])difference(){
   union(){
    cylinder(h=nutheight,r=holeradius*tmult,$fn=90,center=true);
    translate([0,-holeradius*tmult,0])cube([holeradius*tmult*2,holeradius*tmult*2,nutheight],center=true);
   }
   cylinder(h=nutheight,r=nutrad,$fn=6,center=true);
  }
  //extruision nipples
  difference(){
   translate([0,0,-2])cube([6-tolerance,20,10],center=true);
   translate([0,0,-2])cube([6-tolerance,14,10],center=true);
  }
 }
 //centerscrewhole
 cylinder(h=30,r=holeradius,$fn=90,center=true);
}
}

module cam(){
 //color("red")cube([25,24,1],center=true);
 union(){
 difference(){
  union(){
   translate([0,24/2+4/2,0])cube([29,4,4],center=true);
   translate([25/2+4/2-1,4/2,0])cube([4,24+4,4],center=true);
   translate([-25/2-4/2+1,4/2,0])cube([4,24+4,4],center=true);
  }
  color("blue")cube([25+tolerance,24+tolerance,1+tolerance],center=true);
 }
 translate([-16,0,-0.1])rotate([180,0,-90])union(){
 //armscewhole
  translate([holeradius*tmult,partwidth/2,3+holeradius*tmult])rotate([90,0,0])difference(){
   union(){
    cylinder(h=partwidth,r=holeradius*tmult,$fn=90,center=true);
    translate([0,-holeradius*tmult,0])cube([holeradius*tmult*2,holeradius*tmult*2,partwidth],center=true);
   }
   cylinder(h=partwidth,r=holeradius,$fn=90,center=true);
  }
  //nutholder
  translate([holeradius*tmult,partwidth/2-nutheight,3+holeradius*tmult])rotate([90,0,0])difference(){
   union(){
    cylinder(h=nutheight,r=holeradius*tmult,$fn=90,center=true);
    translate([0,-holeradius*tmult,0])cube([holeradius*tmult*2,holeradius*tmult*2,nutheight],center=true);
   }
   cylinder(h=nutheight,r=nutrad,$fn=6,center=true);
  }
 }
}
}

block();
translate([10+holeradius*tmult+2,0,0])arm();
translate([10+(holeradius*tmult+1)*3,0,0])arm();

translate([-34,0,2])rotate([180,0,180])cam();
translate([0,-24,0])angle();
