width=35;
length=200;
height=10;
corner_radius=4;
thickness=10;
peg_radius=3;
peg_height=20;
num_columns=16;

module square_knit_loom() {
  $fn=60;
  
  module rounded_rect(rr_width, rr_length, rr_height) {
    translate([corner_radius, corner_radius, 0])  
    minkowski()
    {    
      cylinder(r=corner_radius,h=rr_height/2);   
      linear_extrude(rr_height/2)
      square([rr_width-corner_radius*2,rr_length-corner_radius*2]);
    }  
  }

  module peg_body() {
    translate([0,0,height-1])
      cylinder(r=peg_radius,h=peg_height+1);  
  }

  module peg_top() {
    peg_top_height=peg_height*.5;
    translate([0,0,height+peg_height-peg_top_height])
      cylinder(r=peg_radius*1.25,r1=0,h=peg_top_height);
  }

  module peg_groove() {
    translate([peg_radius,0,height-1])
      cylinder(r=peg_radius/2,h=peg_height+1);
  }
  
  module peg_flat_back() {
    square([peg_radius*2,peg_radius*4]);
  }

  module peg() {  
    difference() {
      union() {
        difference() {      
          peg_body();         
          peg_groove();          
        }
        peg_top();
      }
      translate([-peg_radius*2.5,-peg_radius*2,0])
        linear_extrude(height+peg_height*2)
          peg_flat_back();
    }
  }

  module peg_row() {
    startx=thickness*2;
    endx=length-thickness;
    step=(endx-startx) / (num_columns - 1);
    for (x = [startx:step:endx]) {
      translate([thickness/2,x,0])
        peg();
    }  
  }

  module pegs() {
    // end peg 1
    translate([width/2,thickness/2,0])
      rotate([0,0,270])
        peg();
    // end peg 2
    translate([width/2,length-thickness/2,0])
      rotate([0,0,90])
        peg();
    
    translate([thickness,0,0])
      mirror([1,0,0])
        peg_row();  
    translate([width-thickness,0,0])      
      peg_row();
  }

  module board() {
    difference() {
      inner_width = width - thickness*2;
      inner_length = length - thickness*2;
    
      rounded_rect(width, length, height);  
      translate([thickness, thickness, -1])
        rounded_rect(inner_width, inner_length, height+2);
    }
  }

  translate([-width/2,-length/2,0]) {
    board();
    pegs();
  }  
}

square_knit_loom();
