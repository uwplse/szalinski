/* [Main] */
//Stencil Thickness (in mm)
ST = 2;
//Stencil Border (in mm)
SB=10;

/* [Text] */
//Single Letter or amount of lines
p = "all";//[all,single,1,2,3]
//Text for single letter
t="A";
//Text
print1="A B C D E F";
print2="G H I J K L";
print3="M N O P Q R S";
print4="T U V W X Y Z";
//Text Size in mm
TS=50;
//https://www.google.com/fonts[eg Liberation Sans:style=Bold Italic]
Font="Times New Roman";
//Additional Vertical Spacing between text lines (if they merge for larger fonts)
VS=0;
//Maximum characters in a line
MC=7;

/* [Advanced Text] */
//Vertical
VA="center";// Eg left, right, center, or any number
//Horizontal
HA="center";//Eg top, center, bottom, baseline, or any number
// Spacing
space=1;
//Text Stretch X
TSX=1;
//Text Stretch Y
TSY=1;

TSMM=TS*3*25.4/72.0;

if(p=="all"){
difference(){
    
//STENCIL
translate([0,0,0]){
cube([(MC+2)*TSMM+2*SB,4*TSMM+5*SB+VS*3,ST]);
}

//TEXT
translate([TSMM*4.5+SB,3.5*TSMM+(SB*4)+(3*VS),0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print1,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}

translate([TSMM*4.5+SB,2.5*TSMM+(SB*3)+(2*VS),0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print2,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}

translate([TSMM*4.5+SB,1.5*TSMM+(SB*2)+VS,0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print3,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}

translate([TSMM*4.5+SB,0.5*TSMM+SB,0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print4,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}

}

}

if(p=="single"){
    difference(){
translate([0,0,0]){
    cube([TSMM+2*SB,TSMM+2*SB,ST]);
}
translate([TSMM/2+SB,TSMM/2+SB,0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(t,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}

}
}

if(p=="1"){
difference(){
    
//STENCIL
translate([0,0,0]){
cube([(MC+2)*TSMM+2*SB,TSMM+2*SB+VS*3,ST]);
}

//TEXT
translate([TSMM*4.5+SB,0.5*TSMM+SB,0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print1,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}


}
}

if(p=="2"){
difference(){
    
//STENCIL
translate([0,0,0]){
cube([(MC+2)*TSMM+2*SB,2*TSMM+3*SB+VS*3,ST]);
}

//TEXT
translate([TSMM*4.5+SB,1.5*TSMM+(SB*2)+VS,0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print1,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}

translate([TSMM*4.5+SB,0.5*TSMM+SB,0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print2,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}


}

}

if(p=="3"){
difference(){
    
//STENCIL
translate([0,0,0]){
cube([(MC+2)*TSMM+2*SB,3*TSMM+4*SB+VS*3,ST]);
}

//TEXT

translate([TSMM*4.5+SB,2.5*TSMM+(SB*3)+(2*VS),0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print1,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}

translate([TSMM*4.5+SB,1.5*TSMM+(SB*2)+VS,0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print2,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}

translate([TSMM*4.5+SB,0.5*TSMM+SB,0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print3,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}

}

}
