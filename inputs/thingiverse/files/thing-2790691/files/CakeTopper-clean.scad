scale([0.1,0.1,0.03]){

translate([700,-120,0]){
  linear_extrude(100){
    scale([0.9,0.8,1]){
      text(">", 340, "Ubuntu");
    }
  }
}  

translate([-950,-120,0]){
  linear_extrude(100){
    scale([0.9,0.8,1]){
      text(">", 340, "Ubuntu");
    }
  }
}  

translate([-1070,-120,0]){
  linear_extrude(100){
    scale([0.9,0.8,1]){
      text(">", 340, "Ubuntu");
    }
  }
}  

translate([330,-25,0]){
  cube([570,40,100]);
}

translate([600,300,-10]){
  rotate([0,0,45]){
    import("hartvorm.stl");
  }
}
    
translate([-900,-25,0]){
  cube([570,40,100]);
}

translate([50,-870,0]){
  rotate([0,0,90]){
    cube([570,40,100]);
  }
}
// 360,-130
translate([360,-130,0]){
  linear_extrude(100){
    text("S", 400, "TeXGyreChorus");
  }
}  

    translate([-760,-180,0]){
      linear_extrude(100){
        text("T", 400, "TeXGyreChorus");
      }
    }
}