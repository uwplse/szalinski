length = 75;

//Bearing
bearingOD = 13;
bearingID = 4;
bearingDepth = 5;

wallThickness = 2.4;

//Advanced
fudgeAllowance = 0.2; //looseness of bearing fit

//Hidden
$fn=120;
yTotal = bearingDepth+(2*wallThickness)+fudgeAllowance;
zCube = bearingOD/2+wallThickness+fudgeAllowance;
bearingCover = bearingOD/2+1;

union(){
  difference(){
    union(){
      cube([length,yTotal,zCube]);
      rotate([90,0,0]){ translate([bearingCover,zCube,-yTotal]){ cylinder(yTotal,r=bearingCover);}}  
      rotate([90,0,0]){ translate([length-bearingCover,zCube,-yTotal]){ cylinder(yTotal,r=bearingCover);}}  
    }
    translate([0,wallThickness,wallThickness]){ cube([length,bearingDepth+fudgeAllowance,zCube+bearingCover]);}
    translate([(bearingCover*2),0,wallThickness]){ cube([length-(bearingCover*4),yTotal,zCube+bearingCover]);}
    translate([bearingCover*2.25,bearingDepth/2+wallThickness+fudgeAllowance,0]){
      hull() {
        translate([length-(bearingCover*4.5),0,0]) cylinder(wallThickness,d=bearingDepth);
        cylinder(wallThickness,d=bearingDepth);
      }
    }
  }
  difference(){
    union(){
      translate([bearingCover,wallThickness-fudgeAllowance,zCube]){ sphere(d=bearingID);}
      translate([bearingCover,yTotal-wallThickness-fudgeAllowance,zCube]){ sphere(d=bearingID);}
      translate([length-bearingCover,wallThickness-fudgeAllowance,zCube]){ sphere(d=bearingID);}
      translate([length-bearingCover,yTotal-wallThickness-fudgeAllowance,zCube]){ sphere(d=bearingID);}
    }
    translate([0,wallThickness+(4*fudgeAllowance),wallThickness]){ cube([length,yTotal-(8*fudgeAllowance)-(2*wallThickness),zCube+bearingCover]);}
  }    
}
