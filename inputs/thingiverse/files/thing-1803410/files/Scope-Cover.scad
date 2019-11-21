Scope_Diameter_slider=40.5;  // [20:0.1:100]
Cap_Height_slider = 18; // [10:100]
shf = Cap_Height_slider*1.6;
//dia = 56.8;

Resolution_slider = 50;	//	[20:100]
//res = 50;

dia=Scope_Diameter_slider-0.4;

translate([100,0,0]){

difference(){
    //EXTERIOR
    cylinder(h=Cap_Height_slider,r=((dia/2)+2.5),$fn=Resolution_slider);
    //INTERIOR HIDDEN - ACTUAL WIDTH
    cylinder(h=Cap_Height_slider+1,r=(dia/2),$fn=Resolution_slider);
}

rotate_extrude(convexity = 10, $fn = Resolution_slider){
    translate([((dia/2)+1.2), 0, 0]){
        circle(r=1.3, $fn = Resolution_slider);
    }
}

translate([0,0,(Cap_Height_slider-0.2)]){
    rotate_extrude(convexity = 10, $fn = Resolution_slider){
        translate([((dia/2)+1.2), 0, 0]){
            circle(r=1.3, $fn = Resolution_slider);
        }
    }
}

rotate_extrude(convexity = 10, $fn = Resolution_slider){
    translate([((dia/2)+1.2), 0, 0]){
        square(size=2);
    }
}
    
translate([0,0,(Cap_Height_slider-2)]){
    rotate_extrude(convexity = 10, $fn = Resolution_slider){
        translate([((dia/2)+1.2), 0, 0]){
            square(size=2);
        }
    }    
}

//CAP
translate([0,0,-1.3]){
        cylinder(h=2,r=((dia/2)+2),$fn=Resolution_slider);
    }
    
    
    
    text = Scope_Diameter_slider;
    font = "Liberation Sans Narrow";
    translate([0, -2.5, 0]) {
     linear_extrude(height = 2.5) {
       text(text = str(text,"mm"), font = font, size = 6, halign="center");
     }
    }
     
    
    
}

