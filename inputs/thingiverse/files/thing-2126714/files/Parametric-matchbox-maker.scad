//Parametric Matchbox Maker
//by Hermes Alvarado
//<hermesalvarado@gmail.com>
//www.facebook.com/MyDigitalDreamland

//Parameters:
width = 40;
length = 60;
height = 15;
thickness = 1;
bottomthickness = .5;
tolerance = 1;
resolution = 50; //20: low, 50: mid, 75: high;
useText = false; //true or false;
useDXF = false; //true or false;
customtext = "hello"; //use quotation marks;
customtextsize = 10;
customDXF = "smile.dxf"; //smile.dxf, clip.dxf, domo.dxf, heart.dxf

//Gererators:
module boxhole(){
    translate([0,0,height/2]){
        rotate([90,0,0]){
            cylinder($fn=resolution,h=length/2,r=width/6,center=false);
        }
    }
}
module matchbox(){
    difference(){
        cube([width,length,height],true);
        translate([0,0,bottomthickness]){
            cube([width-thickness, length-thickness,height-bottomthickness], true);
        }
        boxhole();
    }
}
module customtext(){
    translate([0,0,height/2+tolerance+thickness/4]){
        linear_extrude(thickness/2,center=false,convexity=10){
            $fn=resolution;
            text(customtext,customtextsize,font="Liberation:style=Bold",halign="center",valign="center");
        }
    }
}
module customDXF(){
    translate([0,0,height/2+tolerance+thickness/4]){
        linear_extrude(thickness/2,center=false,convexity=10){
            $fn=resolution;
            import(file=customDXF);
        }
    }
}
module sleeve(){
    translate([0,length,length/2-height/2]){
        rotate([90,0,0]){
            difference(){
                cube([width+thickness+tolerance*2,length,height+thickness+tolerance*2],true);
                cube([width+tolerance*2,length+thickness+tolerance,height+tolerance*2],true);
                if(useDXF==true){
                    customDXF();
                }
                if(useText==true){
                   customtext();
                } 
            }
        }
    }
}
matchbox();
sleeve();
