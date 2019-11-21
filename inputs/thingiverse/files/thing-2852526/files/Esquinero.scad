ladoX=178;
ladoY=178;
ladoZ=25;
grosor=30;
redondeadorMink=30;
espaciamientoEntreTornillos=100;
ajusteTornillosX=120;
ajusteTornillosOrillaX=20;
ajusteTornillosOrillaY=20;

difference(){

    cube([ladoX,ladoY,ladoZ],center=true);

    //Recortador (forma "L")
    translate([grosor,-grosor,-ladoZ])
    linear_extrude(height=ladoZ*2)    
    minkowski(){
    square([ladoX-2*(redondeadorMink),ladoY-2*(redondeadorMink)],center=true);
    circle(r=redondeadorMink,$fn=100);
    }//fin minkowski
    
    //###Tornillos en eje "X"###
    translate([ladoX/2-ajusteTornillosX,(ladoY/2)-(grosor)])
    for(i=[0:1]){
        translate([i*espaciamientoEntreTornillos,0])
        rotate([90,90,0])
        cylinder(r=2,$fn=100,h=ladoZ*4,center=true);
        
       translate([i*espaciamientoEntreTornillos,-ladoZ*4+2*grosor])
        rotate([90,90,0])
        cylinder(r=4,$fn=100,h=ladoZ*4,center=true);
    }
    
    //###Tornillos en eje "Y"###
   translate([-ladoX/2,-(ladoY/2)+ajusteTornillosOrillaY])
    for(i=[0:1]){
        translate([0,i*espaciamientoEntreTornillos])
        rotate([90,0,90])
        cylinder(r=2,$fn=100,h=ladoZ*4,center=true);
        
        translate([grosor*2,i*espaciamientoEntreTornillos])
        rotate([90,0,90])
        cylinder(r=4,$fn=100,h=ladoZ*4,center=true);
    }
}