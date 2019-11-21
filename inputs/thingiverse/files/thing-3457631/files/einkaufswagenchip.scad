myname="mein Name";
laenge=20;
what_to_print="frame";//[text,frame]

/* [Hidden] */
//================================
ad=23.25;
di=2.33;
texthight=0.15;
factor=0.65;
fonttitel="Arial";// [Arial,Oxygen Mono]
txtsize=4;
stielbreite=7;
cutr=7;
$fn=60;

if (what_to_print == "frame"){
  difference(){
    body();
    mirror(v=[0,1,0])translate([ad/2+laenge-3,0,-0.01])mktext(myname);
  }
}

if (what_to_print == "text"){
  mirror(v=[0,1,0])translate([ad/2+laenge-3,0,-0.01])mktext(myname);
}
  
module body(){
  difference(){
    union(){
      cylinder(r=ad/2, h=di);
      hull(){
        cylinder(r=stielbreite/2,h=di);
        translate([ad/2+laenge,0,0])cylinder(r=stielbreite/2, h=di);
      }
    }
    translate([ad/2,cutr+stielbreite/2,-0.01])cylinder(r=cutr,h=di+0.1);
    translate([ad/2,-cutr-stielbreite/2,-0.01])cylinder(r=cutr,h=di+0.1);
    translate([ad/2+laenge,0,-0.01])cylinder(r=2, h=di+0.1);
  }
}
  
module mktext(name){
  color("red")linear_extrude(height = texthight) {
    text(name, font=fonttitel, size=txtsize, direction="ltr", valign = "center", halign = "right");
  }
}