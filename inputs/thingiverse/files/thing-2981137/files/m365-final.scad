height_base=0.4;
width_base1=50; //width on 0
width_base12=48;//width on lenght/2
width_base2=40; //width on lenght
lenght=20;
r_axis=7;
cutoff_axis=8;
offset_axis=4;
//stabiliser
width_st=35.3;
hoehe_st=15;
pos_st=5;
r_cylinder_st=5;

union(){
    translate([-lenght/2,-width_base1/2,0]){
        difference(){
            //Base polygon
            difference(){
                linear_extrude(height = height_base, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0){
                    polygon([[0,0],[0,width_base1],[lenght/2,width_base12+(width_base1-width_base12)/2],[lenght,width_base2+(width_base1-width_base2)/2],[lenght,(width_base1-width_base2)/2],[lenght/2,(width_base1-width_base12)/2]]);
                }
                translate([0,0,-0]){ //text to cut out
                    linear_extrude(height = 0.2, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0){
                        translate([pos_st+r_cylinder_st+4,lenght/2,0]){rotate([180,0,90]){text(str(height_base),size =3.5);}}
                    }
                }
            }
            //Cut out space between wings
            translate([0,width_base1/2-r_axis,-5*height_base]){
                cube([lenght,2*r_axis,10*height_base]);}
        }
    }
    
    rotate([-90,0,90]){
        difference(){
            union(){
                translate([0,0,offset_axis]) {cylinder(lenght-cutoff_axis,r_axis+1, r_axis+1,true,$fn=8);}
                rotate([0,0,-90]){
                    translate([0,-width_st/2,lenght/2-pos_st]){
                        linear_extrude(height = 0.5, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0){
                            //connector between stabilisers
                            polygon([[0,width_st],[hoehe_st,width_st],[hoehe_st,0],[0,0]]);}}}
            
                for(i=[-1:2:1]){ //stabiliser cylinders
                    translate([i*(width_st/2-r_cylinder_st),-hoehe_st/2,lenght/2-pos_st]){
                        rotate([90,0,-0]){
                            difference(){
                                cylinder(hoehe_st,r_cylinder_st,r_cylinder_st,true,$fn=80);
                                cylinder(hoehe_st,r_cylinder_st-0.5,r_cylinder_st-0.5,true,$fn=80);
                             }
                         }
                     }
                 }
            }
//            union(){ //to cut half pipe
                cylinder(lenght+10,r_axis,r_axis,true,$fn=8);
                translate([-2*r_axis,0,-2*r_axis]){cube(4*r_axis);}
            }
 
     
        }
    
    
    

    
    }