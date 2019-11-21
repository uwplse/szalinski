length=50;
width_top=20;
height_front=16;
text_line1="Work hard!";
text_line2="Dream big!";
font_size=5;
                
difference() {
translate ([0,0,-24.081]){
  rotate([0,90,0]){
      difference() {
        difference() {
          difference(){
              //THE HOOK OUTER
                cylinder(h=width_top, r=25.92, center=false);
                    // CUTOFF internal of hook
                translate([-24.081,0,-0.5]){  
                    cube([50,25.92,width_top+1]);
                }
        }
        // the cutoff of hole of hook 
        translate([0,-13,-0.5]){
            cylinder(h=width_top+1, r=13, center=false);
        }
        }
        //remove top arc
            translate([-40,-13*2,-0.5]){
            cube([40,13*2,width_top+1]);
        }
      }  
   }
}
                //cut off top part of circle      
                translate([-0.5,-0.5,1]) { 
                      cube ([width_top+1,10,10]);
                      }  
                  }


///front board
difference() {
union(){
    intersection(){             
translate ([0,0,-height_front]){
    cube([1,length,height_front]);
}
translate ([-0.5,length-10,-height_front+10]){
    rotate([0,90,0]){
        cylinder(h=5, r=10, center=false);
    }
    }
}
//up of circle
translate ([0,0,-height_front+10]){
    cube([1,length,height_front-10]);
}
//below circle
translate ([0,0,-height_front]){
    cube([1,length-10,height_front]);
}
}
// text on the board
 rotate([90,0,0]){
 rotate([0,-90,0]){
 
     //text line 1
 translate ([0,0,-1.5]){
     translate([-2, -font_size-2]) {
 
     linear_extrude(height = 2) {
     text(text_line1, font = "Liberation Sans",size=font_size,halign="right");
 }
 }
     //text line 2
 translate([-2, -font_size*2-2*2]) {
 linear_extrude(height = 2) {
     text(text_line2, font = "Liberation Sans",size=font_size,halign="right");
 }
 }
 }
 }
}
}//---end of front board

//top board
translate ([0,0,0]){
    cube([width_top,length,1]);
}

//hook straight part
translate ([0,0,-50]){
    cube([width_top,1,50]);
}
