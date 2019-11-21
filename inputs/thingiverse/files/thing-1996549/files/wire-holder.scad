//$fn=32;
width = 138;
height = 30;
// clip 4 mm thick
// 9mm high
$fn=132;
module wire_holder(){
 linear_extrude(2){
  difference(){
  // Wire Board    
  square([width,height]);
  for(i=[2:4:width]){
    translate([i,0,0]){
        translate([1,height-5,0]){circle(1);}   
        difference(){
        // blank spacers    
        square([2,height-5]);
          
        // End tits    
        translate([-.2,.6,0]){circle(.7);}
        translate([2.2,.6,0]){circle(.7);}    
        }    
        
        }
    }

  }
 }
 translate([0,height,-6]){cube([width,2,14]);}
}
// Back Plate
module bracket(){
difference(){
translate([.75,0,0]){cube([6,10,18]);}
union(){
translate([0,0,5.75]){cube([2.75,10,6.75]);}
translate([2.75,0,1.5]){cube([2.25,11.5,15]);}
}


    }
}

module clip_on(){
    translate([0,height+2,16-4]){cube([10,4,2]);}    
    translate([0,height+2+4,14-10]){cube([10,2,10]);}
}
module secure(){
   translate([width/2,height,7]){
       rotate([0,90,90]){
       cylinder(2,3,2);
       }
       }
     
}
module show_all(){    
difference(){    
    
wire_holder();
    //secure();
    
}  
translate([width/2-5,height+7,0]){rotate([0,0,-90]){bracket();}}
translate([0+5,height+7,0]){rotate([0,0,-90]){bracket();}}
translate([width-15,height+7,0]){rotate([0,0,-90]){bracket();}}
}
show_all();
