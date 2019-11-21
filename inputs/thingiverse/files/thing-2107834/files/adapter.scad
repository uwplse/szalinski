/* [Parameters] */
adapter_width=25;
adapter_lenght=84;
hand_width=30;

cutlery_width=20;
cutlery_thickness=3;

/* [Hidden] */

h=adapter_lenght;
w=adapter_width;
cw=cutlery_width+0.5;
ce=cutlery_thickness+0.5;
r=hand_width/2;

//Body
difference() {
union(){
union() {
hull(){
cylinder(h,w/sqrt(3),w/sqrt(3), $fn=6, center=true);
cube(size=[ce+2,cw+2,h+6] , center=true);
}
cube(size=[ce+2,cw+2,h+16] , center=true);
}

//handle
difference() {
    translate([w*0.8+0.1*r,0,0]){
        rotate([90,0,0]){ 
        difference() {
        union(){
            scale([1.2,h/(r*2),1]){
                    cylinder(w,r+2,r+2, center=true);
                    }
            translate([-r/2,0,0]){
            cube(size=[w+0.1*r,0.95*h,w],center=true );
            }
            
        }
        scale([1.2,h/(r*2),1]){
        cylinder(w+10,r,r, center=true);
        }
        }
    }   
    }
    union() {
       cube(size=[w+10,w+10,0.8*h] , center=true);
       cube(size=[10*w,w+40,0.5*h] , center=true);
    }
}
}

//Hole
cube(size=[ce+1,cw+1,h+30] , center=true);
}


