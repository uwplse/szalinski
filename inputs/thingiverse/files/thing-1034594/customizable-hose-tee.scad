// Customizable Hose Tee

//Height of Tee
total_t_length=62;
//Diameter of main part of Tee
main_t_diameter=25.11;
//Height of barbs on Tee
main_t_barb_height=2;
//Wall thickness of main part of Tee
main_t_wall_thickness=3;

//Diameter of Tee portion of Tee
secondary_diameter=15.5;
//Height of barbs on Tee portion of Tee
secondary_barb_height=1.75;
//Wall thickness of Tee portion of Tee
secondary_wall_thickness=2.25;

difference() {
  union() {
    translate([0,0,total_t_length/2]){
      rotate(a=[0,180,0]){
        hose_barb(total_t_length/2, main_t_diameter, main_t_barb_height, main_t_wall_thickness);
      }
    }

    translate([0,0,-total_t_length/2]){
      rotate(a=[0,0,0]){
        hose_barb(total_t_length/2, main_t_diameter, main_t_barb_height, main_t_wall_thickness);
      }
    }
    translate([-(total_t_length/2 + main_t_diameter/2 - main_t_wall_thickness),0,0]){
      rotate(a=[0,90,0]){
        hose_barb(total_t_length/2, secondary_diameter, secondary_barb_height, secondary_wall_thickness);
      }
    }
  }
  rotate(a=[0,90,0]){
    translate([0,0,-total_t_length]){
      cylinder(h=total_t_length, d=secondary_diameter- (secondary_wall_thickness*2), $fn=48);
    }
  }
}



module hose_barb(height, diameter, barb_height, wall_thickness)
{ 
  end_barb_height = height - (height * 0.45);
  difference(){
    union(){
      cylinder(h=height,d=diameter,$fn=48);//pipe
      cylinder(h=end_barb_height/2,d1=diameter,d2=diameter+barb_height,$fn=48);//barb
      translate([0,0,end_barb_height/2]){
        cylinder(h=end_barb_height/2,d1=diameter,d2=diameter+barb_height,$fn=48);//barb
      }
    }
    cylinder(h=height,d=diameter - (wall_thickness*2),$fn=48);//hole
  }
}
