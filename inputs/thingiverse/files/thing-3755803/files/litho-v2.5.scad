// Params
//Litho-v2.5
//By T. Vogl  (trv)
//2.3: First published.
//2.4: Added alignment pins on base and top.  
//   : Changed valid base sizes (min 5).
//   : Added option to fill text - generates text object.  
//   : Reduced emboss text depth to 0.6.
//   : Rotated text on top to align with "front" panel (cosmetic only)

// Using the library:
//      Pin Connectors V2
//      BY: Tony Buser <tbuser@gmail.com>


//Select part to generate
part = "both"; // [first:Base Only,second:Top Only,text:Fill Text (use with 'Top Only'),both:All]

//Lithopane Width
lithw = 100;    //[65:1:200]

//Lithopane Heigth
lithh = 72;   //[65:1:200]

//Lithopane Depth (thickness)
lithd = 4;      //[0:.1:10]

//Lithopane Border size (determines inset depth)
lithb = 2;      //[1:.1:8]

//Heigth of base
baseh = 10;     //[5:1:20] 

//thickness of 'floor'
floorh = 5;     //[1:.1:10]

//Cable Diameter
cablediameter = 4.2;    //[2:.1:6]

//width of jack cutout 
jackw = 5.6;  //[0:.1:10]

//length of jackcutout  
jackl = 13.1;  //[0:.1:20]

//diameter of LED cylinder
cylr=18;   //[0:1:80]

//thickness of LED cylinder
cylrthick=2;    //[0.2:.1:40]

//Emboss or fill Text?
textmode = "emboss"; //[emboss,fill]

//Text for Area A
texta = "John & Jane";

//Text for Area B
textb = "Married";

//Text for Area C
textc = "July 17, 2019";

//Font for text on lid.  Use any OpenSCAD or Google Font.  (fonts.google.com)
fontname = "Liberation Sans";


//Real constants
buffer=0+1.4;
smidge = 0+.01;
lipsize = 0+2;
textdepth = 0+ 0.6;
pinh = 0+5;
pinr = 0+2.5;
pint = 0+0.3;


//use <lib_pins.scad>
//-----------------------------------
//-----------------------------------
// Pin Connectors V2
// Tony Buser <tbuser@gmail.com>
module pinhole(h=10, r=4, lh=3, lt=1, t=0.3, tight=true) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // t = tolerance
  // tight = set to false if you want a joint that spins easily
  
  union() {
    pin_solid(h, r+(t/2), lh, lt);
    cylinder(h=h+0.2, r=r);
    // widen the cylinder slightly
    // cylinder(h=h+0.2, r=r+(t-0.2/2));
    if (tight == false) {
      cylinder(h=h+0.2, r=r+(t/2)+0.25);
    }
    // widen the entrance hole to make insertion easier
    translate([0, 0, -0.1]) cylinder(h=lh/3, r2=r, r1=r+(t/2)+(lt/2));
  }
}

module pin(h=10, r=4, lh=3, lt=1, side=false) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // side = set to true if you want it printed horizontally

  if (side) {
    pin_horizontal(h, r, lh, lt);
  } else {
    pin_vertical(h, r, lh, lt);
  }
}

module pintack(h=10, r=4, lh=3, lt=1, bh=3, br=8.75) {
  // bh = base_height
  // br = base_radius
  
  union() {
    cylinder(h=bh, r=br);
    translate([0, 0, bh]) pin(h, r, lh, lt);
  }
}

module pinpeg(h=20, r=4, lh=3, lt=1) {
  union() {
    translate([0, -h/4+0.05, 0]) pin(h/2+0.1, r, lh, lt, side=true);
    translate([0, h/4-0.05, 0]) rotate([0, 0, 180]) pin(h/2+0.1, r, lh, lt, side=true);
  }
}

// just call pin instead, I made this module because it was easier to do the rotation option this way
// since openscad complains of recursion if I did it all in one module
module pin_vertical(h=10, r=4, lh=3, lt=1) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness

  difference() {
    pin_solid(h, r, lh, lt);
    
    // center cut
    translate([-r*0.5/2, -(r*2+lt*2)/2, h/4]) cube([r*0.5, r*2+lt*2, h]);
    translate([0, 0, h/4]) cylinder(h=h+lh, r=r/2.5, $fn=20);
    // center curve
    // translate([0, 0, h/4]) rotate([90, 0, 0]) cylinder(h=r*2, r=r*0.5/2, center=true, $fn=20);
  
    // side cuts
    translate([-r*2, -lt-r*1.125, -1]) cube([r*4, lt*2, h+2]);
    translate([-r*2, -lt+r*1.125, -1]) cube([r*4, lt*2, h+2]);
  }
}

// call pin with side=true instead of this
module pin_horizontal(h=10, r=4, lh=3, lt=1) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  translate([0, h/2, r*1.125-lt]) rotate([90, 0, 0]) pin_vertical(h, r, lh, lt);
}

// this is mainly to make the pinhole module easier
module pin_solid(h=10, r=4, lh=3, lt=1) {
  union() {
    // shaft
    cylinder(h=h-lh, r=r, $fn=30);
    // lip
    // translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r2=r, r1=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r, r2=r-(lt/2), $fn=30);

    // translate([0, 0, h-lh]) cylinder(h=lh*0.50, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/3), $fn=30);    

    translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r=r+(lt/2), $fn=30);    
    translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/2), $fn=30);    

    // translate([0, 0, h-lh]) cylinder(h=lh, r1=r+(lt/2), r2=1, $fn=30);
    // translate([0, 0, h-lh-lt/2]) cylinder(h=lt/2, r1=r, r2=r+(lt/2), $fn=30);
  }
}

//-----------------------------------
//   END OF THIRD PARTY LIBRARY
//-----------------------------------

cubeadj = ((lithd*2)+(4*lipsize));
adj=((lipsize)*4)+(2*lithd);

module cone(){
    //color("red") cylinder(h = 4, r1 = (lipsize+adj/2)/3, r2 = 1, center = true/false);
    color("red") pin(h=pinh,r=pinr);
}


module pillers(){
  //pwidth = lipsize+((lithw+adj)-lithw)/2;
  pwidth = lipsize+adj/2;
  trans = ((lithw+adj)/2)-(pwidth/2);
  pillerh = baseh+lithh-(lithb*2);
  translate([trans,trans,pillerh/2]) color("cyan") cube([pwidth,pwidth,pillerh],true);  
  translate([-trans,trans,pillerh/2]) color("cyan") cube([pwidth,pwidth,pillerh],true);    
  translate([trans,-trans,pillerh/2]) color("cyan") cube([pwidth,pwidth,pillerh],true);   
  translate([-trans,-trans,pillerh/2]) color("cyan") cube([pwidth,pwidth,pillerh],true);  
  
  ts = (lithw)/2 + (.5*sin(45)*(lipsize+(adj/2)));
  translate([ts,ts,pillerh])   rotate(a=45, v=[0,0,1]) cone();
  translate([-ts,ts,pillerh])  rotate(a=-45,v=[0,0,1]) cone();
  translate([ts,-ts,pillerh])  rotate(a=-45,v=[0,0,1]) cone();
  translate([-ts,-ts,pillerh]) rotate(a=45, v=[0,0,1]) cone();  
}

module base2(bw,bl,bh){
    difference(){
        translate([-bw/2,-bl/2,0]) cube([bw,bl,bh],false);
        translate([-(bw-cubeadj)/2,-(bl-cubeadj)/2,floorh
        +0.1]) cube([bw-cubeadj,bl-cubeadj,bh-floorh], false);
    }
}


module panels(pw,ph,pd,factor,fortop) {
    translate([0,(lithw/2)+(pd/2)+factor,baseh+(ph/2)-lithb]) color("red") rotate ([90,0,0]) cube([pw,ph,pd],true);
    
    translate([0,-((lithw/2)+(pd/2)+factor),baseh+(ph/2)-lithb]) color("green") rotate ([90,0,0]) cube([pw,ph,pd],true);
    // switch panel location for accurate color representation only (no impact on real model)
    if (fortop) {
        translate([0,(lithw/2)+(pd/2)+factor,baseh+(ph/2)-(lithb+.5)]) color("yellow") rotate ([90,0,0]) cube([pw,ph,pd],true);
    
        translate([0,-((lithw/2)+(pd/2)+factor),baseh+(ph/2)-(lithb+.5)]) color("green") rotate ([90,0,0]) cube([pw,ph,pd],true);
        translate([((lithw/2)+(pd/2)+factor),0,baseh+(ph/2)-(lithb+.5)]) color("blue") rotate ([90,0,90]) cube([pw,ph,pd],true);
    
        translate([-((lithw/2)+(pd/2)+factor),0,baseh+(ph/2)-(lithb+.5)]) color("black") rotate ([90,0,90]) cube([pw,ph,pd],true);
    } else {
        translate([0,(lithw/2)+(pd/2)+factor,baseh+(ph/2)-lithb]) color("yellow") rotate ([90,0,0]) cube([pw,ph,pd],true);
        translate([0,-((lithw/2)+(pd/2)+factor),baseh+(ph/2)-lithb]) color("green") rotate ([90,0,0]) cube([pw,ph,pd],true);

        // switch panel location for accurate color representation only (no impact on real model)
        translate([-((lithw/2)+(pd/2)+factor),0,baseh+(ph/2)-lithb]) color("blue") rotate ([90,0,90]) cube([pw,ph,pd],true);
    
        translate([((lithw/2)+(pd/2)+factor),0,baseh+(ph/2)-lithb]) color("black") rotate ([90,0,90]) cube([pw,ph,pd],true);
    }
}


module tube(fortop){
    ch = lithh+baseh-lithb;
    cradius = min(cylr,(lithw/2));
    if (fortop) {
        translate([0,0,(ch/2)]) cylinder(h=ch,r=cradius+0.2,center=true);
    } else {
    difference(){
        translate([0,0,(ch/2)]) cylinder(h=ch,r=cradius,center=true);
        translate([0,0,(ch/2)]) cylinder(h=ch+.1,r=max(0,cradius-cylrthick),center=true);
        
    }
}
}


module jack(){
   // translate([lithw/2+(lipsize*2),0,(cablediameter/2)+((baseh-cablediameter)/2)]) rotate([0,90,0]) color("red") cylinder(h=(lithw/2+adj+.2),r=cablediameter/2,center=true);
    
    hull(){
    translate([((lithw/2+adj+.2)/2)+cylr,0,cablediameter/2]) rotate([0,90,0]) color("red") cylinder(h=(lithw/2+adj+.2),r=cablediameter/2,center=true);
    
    translate([((lithw/2+adj+.2)/2)+cylr,0,-cablediameter/2]) rotate([0,90,0]) color("red") cylinder(h=(lithw/2+adj+.2),r=cablediameter/2,center=true);
    };
    
    //translate([(lithw/2+adj+.2)/2,0,cablediameter/2])     rotate([0,90,0]) cube([cablediameter/2,cablediameter,(lithw/2+adj+.2)],true);
    
    translate([cylr+jackw/2,0,0])  cube([jackw,jackl,lithh],true);
    
    //cylinder(h=lithh,r=jacksize,center=true);
    
}



//Main
module bottom(){        
        adj=((lipsize)*4)+(2*lithd);
        
        difference(){
            union(){
                // base & pillars
                base2(lithw+adj,lithw+adj,max(baseh,floorh));
                translate([0,0,0]) pillers();
                tube(false);
            };
            // subtract out the panels
            panels(lithw+0.4,lithh,lithd+0.4,buffer,false);
            //subtract out the cable channel and plug path
            jack();
            //translate([0,0,0]) rotate(a=90,v=[0,0,1])  
            rotate(a=90,v=[0,0,1]) rotate(a=180,v=[0,1,0]) translate([lithw/2,-lithw/2,-0.59]) color("red") linear_extrude(height=0.6) signature();
        };
        
        //test lithopane
        //translate([0,0,0]) panels(lithw+0.4,lithh,lithd+0.4,buffer, false);
        
        // subtract out the jack space
    }



module top(){
     //slicers seem to work better if top has holes either way
   
    trans2 = (lithw)/2 + (.5*sin(45)*(lipsize+(adj/2)));
    
     difference(){

                base2(lithw+adj,lithw+adj,max(baseh,floorh));
                translate([trans2,trans2,max(baseh,floorh)-pinh]) color("red") pinhole(h=pinh, r=pinr, t=pint, tight=false);
    
                translate([-trans2,trans2,max(baseh,floorh)-pinh]) color("red") pinhole(h=pinh, r=pinr, t=pint, tight=false);
         
                translate([trans2,-trans2,max(baseh,floorh)-pinh]) color("red") pinhole(h=pinh, r=pinr, t=pint, tight=false);
    
                translate([-trans2,-trans2,max(baseh,floorh)-pinh]) color("red") pinhole(h=pinh, r=pinr, t=pint, tight=false);
    
         
         //translate([0,0,(2*baseh)+lithh-(lithb*2)+0.1]) rotate(a=180,v=[0,1,0]) pillers();
                //translate([0,0,lithb]) tube(true);
                panels(lithw+0.4,lithh,lithd+0.4,buffer,true);
                placetext();
        };
           
     //test lithopane
     //translate([lithw*1.5,0,0]) panels(lithw+0.4,lithh,lithd+0.4,buffer, true);
}


module placetext(){
    translate([0,0,(textdepth-0.03)]) rotate(a=90,v=[0,0,1]) rotate(a=180,v=[0,1,0]) color("red") linear_extrude(height=textdepth) mtext();
}


module mtext(){
 translate([0,20,0]) text(texta, halign="center", font=fontname);
 translate([0,0,0])  text(textb, halign="center", font=fontname);
 translate([0,-20,0]) text(textc, halign="center", font=fontname);
}


module signature(){
   translate([0,0,0]) text("trv", halign="center", font="Liberation Sans:style=italic", size=6);
}

module print_part(){
    	if (part == "first") {
		bottom();
	} else if (part == "second") {
		top();
	} else if (part == "both") {
		bottom();
        translate([lithw*1.5,0,0]) top();
        if (textmode=="fill") {translate([lithw*3,0,0]) placetext();}
    } else if (part=="text"){
        placetext();
	} else {
		bottom();
        translate([lithw*1.5,0,0]) top();
        if (textmode=="fill") {translate([lithw*3,0,0]) placetext();}
	}
}


print_part();




