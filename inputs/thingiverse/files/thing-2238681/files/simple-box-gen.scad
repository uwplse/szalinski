/*
A very simple box-generator for laser cutting.

Version 1.2
Tjark Nieber 2017
www.thingiverse.com/SharkNado

*/

//Preview/Render
rendering = "false"; //[false,true]

//Rendering for STL export
for_3D_print = "true"; //[false,true]

//Box/Shelf
modus = "box"; //[box,shelf]

// Width in mm
width = 50;

// Length
length= 40;

// Height
height =30;

//Material Thickness in mm
th = 3;

// Joinsize Scaling
js = 0.33; 

//Correction in mm
cor = 0.25;

//Margin
margin = 2;

if(rendering == "true")renderView();
if(rendering  == "false")preview();

    
//#################################################
/*
Example for cutting into top/bottom cover:
difference(){
    ground(true);
    translate([width/2,length/2,0])resize([width-4*th,0,0],[true,true,false])text("some text",valign="center",halign="center");
}*/
//#################################################

module preview(){
    s=0.5;   
                                                3D() ground();
    if(modus=="box")translate([0,0,height-th+s])3D() ground();
    translate([0,th,0])rotate([90,0,0])         3D() front();
    translate([0,length+s,0])rotate([90,0,0])   3D() front();
    translate([th,0,0])rotate([0,-90,0])        3D() side();
    translate([width+s,0,0])rotate([0,-90,0])   3D() side();
}

module renderView(){
    if(for_3D_print == "true"){
        3D()renderSet();
    }else{
        renderSet();
    }
    module renderSet(){
                                             ground();
        translate([-height-margin,0,0])      side();
        translate([width+margin,0,0])        side();
        translate([0,-height-margin,0])      front();
        translate([0,length+margin,0])       front();
        if(modus=="box")translate([0,length+height+2*margin])ground();
    }
}

//#################################################
module 3D(){
    c=rands(0,100,3);
    color([c[0]/100,c[1]/100,c[2]/100])linear_extrude(height=th)children();
}
//button and top
module ground(){
     plate(width,length,th,cor,[-1,-1,-1,-1]);
}

//sides left and right
module side(){
    plate(height,length,th,cor,[1,1,1,1]);
    if(modus=="shelf"){
        translate([height-th,th,0])square([th,length-2*th]);
    }
}
//front and back
module front(){
    plate(width,height,th,cor,[1,1,-1,-1]);
     if(modus=="shelf"){
        translate([0,height-th,0])square([width,th]);
    }
}

//#################################################

//raw plate
module plate(w,l,th,cor,conf){
    F=conf[0];  // Front
    B=conf[1];  // Back
    L=conf[2];  // Left
    R=conf[3];  // Right
    
    // Pseudo-Random coloring
    green = (128 + 64*F+32*B)/255;
    blue = (128 + 64*L+32*R)/255;
    
    
    
    _plate();
    
    
    module _plate(){
        difference(){
            square([w,l]);
            if(F==1){square([w,th]);}
            if(F==-1){j(w,0);}
            if(B==1){translate([0,l-th])square([w,th]);}
            if(B==-1){translate([0,l-th])j(w,0);}
            if(L==1){square([th,l]);}
            if(L==-1){translate([th,0,0])j(l,90);}
            if(R==1){translate([w-th,0,0])square([th,l]);}
            if(R==-1){translate([w,0,0])j(l,90);}
        }
           
            if(F==1){j(w,0,false);}           
            if(B==1){translate([0,l-th])j(w,0,false);}           
            if(L==1){translate([th,0,0])j(l,90,false);}            
            if(R==1){translate([w,0,0])j(l,90,false);}
    }
    
    
    
    module j(dist,rot,cut=true){
        rotate([0,0,rot]){
            if(!cut)translate([(dist-dist*js)/2-cor/2,0,0])square([dist*js+cor,th]);
            if(cut)translate([(dist-dist*js)/2+cor/2,0,0])square([dist*js-cor,th]);
        }
    }
    
    
}