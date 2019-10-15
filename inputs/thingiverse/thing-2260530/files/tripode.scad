// *** Configuration variables ***
wheel_d = 25;    // Outer Diameter of the thumb wheel
wheel_h = 20;     // Height of the thumb wheel

male_female_h=30;

hole_d = 8.1;    // Diameter of screw hole
hex_sz = 11;      // Size of the hex (nut trap)           
rod_d = 13.3;   //Rod diameter (structure´s rod)
             
hex_d = 4;       // Depth of the hex (set this < or = to wheel_h)

wall=10;

//main(diameter=wheel_d,height=wheel_h,center_hole=1, nut=false);
male();
translate([1*(rod_d+wall),0,0])female();
translate([2*(rod_d+wall),0,0])camera_mic_screw();
translate([4*(rod_d+wall),0,0])rotate([0,0,30])base();





module main(diameter=1,height=1,center_hole=1, nut=false){
    rotate([0,0,360/16])difference() {
        cylinder(h=height, d=diameter, $fn=8, center=true);
        
        if(center_hole>1){
            cylinder(h=height+2, d=center_hole, $fn=50, center=true);
        }
        if(nut==true){
            translate([0,0,(height/2)-(hex_d/2)-3])hexagon_hole();
        }
        
        translate([0,0,(-height/2)+(height/2-hex_d-3)])cylinder(h=height, d=rod_d, $fn=50, center=true);
  
    }
}

module hexagon_hole() {

    cylinder(h=hex_d, r=(hex_sz/2)/cos(30), $fn=6, center=true);
    
}



module male(){
   
    difference(){
        union(){
            translate([0,0,-male_female_h/2])main(diameter=rod_d+wall,height=male_female_h,center_hole=1, nut=false);
            translate([0,0,((rod_d+wall)*cos(22.5))/4])rotate([0,0,360/16])cylinder(h=((rod_d+wall)*cos(22.5))/2, d=rod_d+wall, $fn=8, center=true);
            translate([0,0,((rod_d+wall)*cos(22.5))/2])intersection(){
                rotate([0,0,360/16])cylinder(h=(rod_d+wall)*cos(22.5), d=rod_d+wall, $fn=8, center=true);
                translate([0,0,0])rotate([0,90,0])cylinder(h=(rod_d+wall)*2, d=(rod_d+wall)*cos(22.5), $fn=30, center=true);
}
                
              
        }
          
        translate([(rod_d+wall)*cos(22.5)/3,0,(rod_d+wall)/2])cube([(rod_d+wall)*cos(22.5)/3,(rod_d+wall)*cos(22.5),rod_d+wall],center=true);
        translate([-(rod_d+wall)*cos(22.5)/3,0,(rod_d+wall)/2])cube([(rod_d+wall)*cos(22.5)/3,(rod_d+wall)*cos(22.5),rod_d+wall],center=true);
        
        translate([0,0,((rod_d+wall)*cos(22.5))/2])rotate([0,90,0])cylinder(h=(rod_d+wall), d=hole_d, $fn=30, center=true);
        
    }
 
}

module female(){
   
    difference(){
        union(){
            translate([0,0,-male_female_h/2])main(diameter=rod_d+wall,height=male_female_h,center_hole=1, nut=false);
            translate([0,0,((rod_d+wall)*cos(22.5))/4])rotate([0,0,360/16])cylinder(h=((rod_d+wall)*cos(22.5))/2, d=rod_d+wall, $fn=8, center=true);
            translate([0,0,((rod_d+wall)*cos(22.5))/2])intersection(){
                rotate([0,0,360/16])cylinder(h=(rod_d+wall)*cos(22.5), d=rod_d+wall, $fn=8, center=true);
                translate([0,0,0])rotate([0,90,0])cylinder(h=(rod_d+wall)*2, d=(rod_d+wall)*cos(22.5), $fn=30, center=true);
}
                
              
        }
          
        translate([0,0,(rod_d+wall)/2])cube([(rod_d+wall)*cos(22.5)/3,(rod_d+wall)*cos(22.5),rod_d+wall],center=true);
      
        
        translate([0,0,((rod_d+wall)*cos(22.5))/2])rotate([0,90,0])cylinder(h=(rod_d+wall), d=hole_d, $fn=30, center=true);
        
    }
 
}
module camera_mic_screw(){
        translate([0,0,-male_female_h/2])main(diameter=rod_d+wall,height=male_female_h,center_hole=7, nut=true);
 
}

module base_part(){
    
        union(){
            translate([0,0,-male_female_h/2])main(diameter=rod_d+wall,height=male_female_h,center_hole=1, nut=false);
            translate([0,0,((rod_d+wall)*cos(22.5))/4])rotate([0,0,360/16])cylinder(h=((rod_d+wall)*cos(22.5))/2, d=rod_d+wall, $fn=8, center=true);
            translate([0,0,((rod_d+wall)*cos(22.5))/2])intersection(){
                rotate([0,0,360/16])cylinder(h=(rod_d+wall)*cos(22.5), d=rod_d+wall, $fn=8, center=true);
                translate([0,0,0])rotate([0,90,0])cylinder(h=(rod_d+wall)*2, d=(rod_d+wall)*cos(22.5), $fn=30, center=true);
            }
                
              
        }
          
       
   
 
}

module base(){
    //rotate([180,0,0])translate([0,0,-male_female_h])main(diameter=rod_d+wall,height=male_female_h*2,center_hole=1, nut=false);
    difference(){
        hull(){
            for(i = [0:120:360]) {
                rotate([0,0,i])translate([0,((rod_d+wall)*cos(22.5))*sin(30),((rod_d+wall)*cos(22.5))*cos(30)])rotate([-90-30,0,0])translate([0,((rod_d+wall)*cos(22.5))/2,male_female_h])base_part();
                
                        
            }

        }
        for(i = [0:120:360]) {
            rotate([0,0,i])translate([0,((rod_d+wall)*cos(22.5))*sin(30),((rod_d+wall)*cos(22.5))*cos(30)])rotate([-90-30,0,0])translate([0,((rod_d+wall)*cos(22.5))/2,male_female_h])cylinder(h=male_female_h*2, d=rod_d, $fn=30, center=true);
        }
        
        for(i = [0:120:360]) {
            rotate([0,0,i+60])translate([0,(male_female_h/2+rod_d+wall)/cos(30),0])cylinder(h=male_female_h*2, d=((rod_d+wall)*cos(22.5))*3, $fn=8, center=true);
        }
        translate([0,0,0])cylinder(h=wheel_h*10, d=rod_d, $fn=30, center=true);
    }
    
}
