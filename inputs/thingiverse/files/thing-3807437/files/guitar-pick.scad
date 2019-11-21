width=28;
height=32;
thickness=0.36;
tip=3;
edge=1;
emboss=0.24;
font_size=4;
top_scale=0.45;
side_scale=0.25;
fineness=60;

//if (tip<edge*2){echo("Warning: tip is larger than edge.");}

adj_top_scale=top_scale*(((width*top_scale)-(edge/top_scale))/(width*top_scale));

side=sqrt(pow(height-(width/2*adj_top_scale)-(tip/2)-edge,2)+pow(width/2-edge-tip/2,2));

//adj_side_scale=side_scale*(((

//echo (width/2-edge-(tip-edge)/2);

angle=atan((width/2-edge-(tip-edge*2)/2)/(height-edge*2-(width/2*adj_top_scale)-(tip-edge*2)/2));
//echo(angle);


offset=height-width/2*adj_top_scale-edge;

module guitarpick(){

//translate([sin(60)*10,-cos(60)*10,0])
minkowski(){
    
hull(){
translate([0,offset,0])
scale([(width-edge*2)/width,adj_top_scale,1])
cylinder(thickness/2,width/2,width/2,$fn=fineness);


translate([tip/2>edge?tip/2-edge:0,tip/2,0])
rotate([0,0,-angle])
translate([0,side/2,0])
scale([side_scale,1,1])
cylinder(thickness/2,side/2,side/2,$fn=fineness);

translate([tip/2>edge?-tip/2+edge:0,tip/2,0])
rotate([0,0,angle])
translate([0,side/2,0])
scale([side_scale,1,1])
cylinder(thickness/2,side/2,side/2,$fn=fineness);

translate([0,tip/2,0])
cylinder(thickness/2,tip/2>edge?tip/2-edge:tip/2,tip/2>edge?tip/2-edge:tip/2,$fn=fineness);
}

cylinder(thickness/2,edge,edge,$fn=fineness);

}


translate([0,height*3/4-font_size/2,thickness-0.001])
linear_extrude(emboss+0.001,convexity=10)
                        text("BalinTech", font="Liberation Sans:style=Bold",size=font_size,halign="center",$fn=fineness);


translate([0,height*3/4-font_size*2,thickness-0.001])
linear_extrude(emboss+0.001,convexity=10)
                        text(str(thickness*1000,"μm"), font="Liberation Sans:style=Bold",size=font_size,halign="center",$fn=fineness);


}

guitarpick();