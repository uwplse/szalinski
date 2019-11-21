//Digital Design Fabrication HW2
//Hanjong Kim
//150914

//variables

/* [Cup] */
diameter_top = 90;
diameter_bottom = 60;
cup_height = 140;

/* [Sleeve] */
sleeve_type=0; // [0:Circle,1:Square]
sleeve_thinkness = 3; // [1:10]
sleeve_height = 50; // [20:100]
name = "COFFEE";
text_size=5; // [1:10]

/* [Hidden] */
cup_shell = 3;
res=50;


//modeling
//cup();


color("teal")
union(){
    union(){
        sleeve();
        ring();
    }
    intersection(){
        cup_holder();
        name();
    }
}

module name(){
    for(i=[0:len(name)]){
        temp_rad=(diameter_top-diameter_bottom)/2*((cup_height/2+sleeve_height/2)/cup_height)+diameter_bottom/2;
        rotate([0,0,i*text_size])
        translate([0,0,-text_size/2-0.5])
        translate([temp_rad-5, 0, cup_height/2+sleeve_height/2+text_size/2]) 
        rotate([90,0,90])
        linear_extrude(height = 30, center = true, convexity = 10, twist = 0)
        text(name[i], font = "Liberation Sans:style=Bold", size=text_size, halign = "center");
    }
}

module sleeve(){
    intersection(){
        intersection(){
            cup_holder();
            pattern();
        }
        translate([0,0,cup_height/2-sleeve_height/2])
        cylinder(r=diameter_top/2+30, h=sleeve_height, $fn=res);
    }
}

module ring(){
    intersection(){
        cup_holder();
        translate([0,0,cup_height/2-sleeve_height/2])
        cylinder(r=diameter_top/2+30, h=sleeve_thinkness, $fn=res);
    }
    intersection(){
        cup_holder();
        translate([0,0,cup_height/2+sleeve_height/2-sleeve_thinkness])
        cylinder(r=diameter_top/2+30, h=sleeve_thinkness, $fn=res);
    }
}


module pattern(){
    if(sleeve_type==0){
        for(j=[0:cup_height/2:cup_height]){
            for(i=[0:45:360]){
                rand_rad = rands(50,100,1)[0];
                rand_angle = rands(-20,20,1)[0];
                translate([0,0,j])
                rotate([90+rand_angle,0,i])
                difference(){
                    cylinder(r2=rand_rad, r1=15, h=60, $fn=res);
                    cylinder(r2=rand_rad-5, r1=10, h=60+0.1, $fn=res);
                }
            }
        }
    }
    else{
        for(j=[0:cup_height/5:cup_height]){
            for(i=[0:45:360]){
                rand_rad = rands(30,60,1)[0];
                rand_angle = rands(-45,45,1)[0];
                rotate([0,0,i])
                translate([diameter_bottom/2,0,j])
                rotate([rand_angle,0,0])
                difference(){
                    cube(size = rand_rad, center=true);
                    cube(size = [500,rand_rad-3,rand_rad-3], center=true);
                }
            }
        }
    }
}


module cup(){
    color("white")
    difference(){
        cylinder(r1=diameter_bottom/2, r2=diameter_top/2, h=cup_height, $fn=res);
        translate([0,0,cup_shell])
        cylinder(r1=diameter_bottom/2-cup_shell, r2=diameter_top/2-cup_shell, h=cup_height-cup_shell+0.1, $fn=res);
    }
}

module cup_holder(){
    color("lime")
    difference(){
        cylinder(r1=diameter_bottom/2+sleeve_thinkness, r2=diameter_top/2+sleeve_thinkness, h=cup_height, $fn=res);
        cylinder(r1=diameter_bottom/2-0.2, r2=diameter_top/2-0.2, h=cup_height+0.1, $fn=res);
    }
}
