$fn=90;
in2mm = 25.4;

extra = 0.01;

boxwidth = 1*in2mm;
boxlength = 1.5*in2mm;
thickness = 0.05*in2mm;
tailthickness = 0.08*in2mm;

//tail piece to attach to screw in back
translate([-0.6*in2mm,-1.33*in2mm,0]){
  difference(){
    cube([1.2*in2mm,2.65*in2mm,tailthickness]);
    translate([0.6*in2mm,2.31*in2mm,-extra]){
      cylinder(d=0.15*in2mm, h=0.25*in2mm);
    }
  }
}

//ledge in front
translate([-1.5*in2mm,-1.6*in2mm,0]){
  difference(){
    cube([3*in2mm,0.5*in2mm,thickness]);
    translate([0.43*in2mm,0.125*in2mm,-extra]){
      cylinder(d=0.15*in2mm, h=0.25*in2mm);
    }
    translate([0.91*in2mm,0.125*in2mm,-extra]){
      cylinder(d=0.15*in2mm, h=0.25*in2mm);
    }
    translate([1.38*in2mm,0.125*in2mm,-extra]){
      cylinder(d=0.15*in2mm, h=0.25*in2mm);
    }
    translate([1.61*in2mm,0.125*in2mm,-extra]){
      cylinder(d=0.15*in2mm, h=0.25*in2mm);
    }
    translate([2.085*in2mm,0.125*in2mm,-extra]){
      cylinder(d=0.15*in2mm, h=0.25*in2mm);
    }
    translate([2.56*in2mm,0.125*in2mm,-extra]){
      cylinder(d=0.15*in2mm, h=0.25*in2mm);
    }
  }
}

//front piece to attach to hole in left front
translate([-1.85*in2mm,-1.6*in2mm,0]){
  difference(){
    cube([0.5*in2mm,0.5*in2mm,thickness]);
    translate([0.12*in2mm,0.135*in2mm,-extra]){
      cylinder(d=0.15*in2mm, h=0.25*in2mm);
    }
  }
}

//front piece to attach to hole in right front
translate([1.62*in2mm,-1.6*in2mm,0]){
  difference(){
    translate([-0.25*in2mm,0,0]){
      cube([0.5*in2mm,0.5*in2mm,thickness]);
    }
    translate([0.12*in2mm,0.135*in2mm,-extra]){
      cylinder(d=0.15*in2mm, h=0.25*in2mm);
    }
  }
}


translate([(-0.97-0.85/2)*in2mm,-1.25*in2mm,0]){
  intersection(){
    rotate([0,0,180]){
      difference(){
        translate([0,0,23]){
          rotate([-90,0,0]){
            import("BRACKET_PRINTED.stl");
          }
        }
        translate([-boxlength/2,-boxwidth-6,-5]){
          cube([boxlength, boxwidth, 10]);
        }
      }  
    }
    translate([-0.94*in2mm,-0.25*in2mm,-extra]){
      cube([2.5*in2mm,5*in2mm,5*in2mm]);
    }
  }
}

translate([(1+0.85/2)*in2mm,-1.25*in2mm,0]){
  intersection(){
    rotate([0,0,180]){
      difference(){
        translate([0,0,23]){
          rotate([-90,0,0]){
            import("BRACKET_PRINTED.stl");
          }
        }
        translate([-boxlength/2,-boxwidth-6,-5]){
          cube([boxlength, boxwidth, 10]);
        }
      }  
    }
    translate([-1.05*in2mm,-0.25*in2mm,-extra]){
      cube([1.97*in2mm,5*in2mm,5*in2mm]);
    }
  }
}

//translate([0,0,-1]){
//  linear_extrude(height=0.05*in2mm){
//    import("x_carriage_v1.4.dxf");
//  }
//}