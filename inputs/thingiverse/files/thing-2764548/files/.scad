dia=0.5;
rotate_angle=60;
translate_dis=20;
stick=30;
num=360/stick;

//difference(){
//cube([120,10,120],center=true);
    union(){
        for(i = [1:stick]){
            translate([sin(i*num)*translate_dis,cos(i*num)*translate_dis,0]){
                rotate([sin(i*num)*rotate_angle,cos(i*num)*rotate_angle,0]){

                        linear_extrude(heigh =20, center= true ){
                            circle(dia,center = true);
                        }
                    }
                }
        }
        for(i = [1:stick]){
            translate([sin(i*num)*translate_dis,cos(i*num)*translate_dis,0]){
                rotate([sin(i*num)*rotate_angle*-1,cos(i*num)*rotate_angle*-1,0]){
                        linear_extrude(heigh = 20,center= true ){
                            circle(dia,center = true);
                        }
                    }
                }
        }

    }
//}