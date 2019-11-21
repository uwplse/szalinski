use <write/Write.scad>

text="Your Name";

kamm(text=text);

module langloch(B=150,T=40,H=3)
{
  translate(v=[0,0,H/2]) {
    cube(size=[B-T,T,H],center=true);
  }
  translate(v=[-B/2+T/2,0,0]) {
    cylinder(h=H,r=T/2);
  }
  translate(v=[B/2-T/2,0,0]) {
    cylinder(h=H,r=T/2);
  }
}



module kamm(B=150,T=40,H=1.5,text="Andreas Urben")
{
  rotate(a=[-90,0,180]) {
    difference() {
      translate(v=[0,0,-H/2]) {
        langloch(B=B,T=T,H=H);
      }
      for (n=[-21:21]) {
        translate(v=[(n*2.5)-0.75,-5,-H/2]) {
          cube(size=[1.5,70,H+0.2]);
        }
      }
    }
    translate([0,-12,H/2]) {
      rotate(a=[0,0,180]) {
        write(text,t=0.9,h=7,center=true);
      }
    }
  }
}

// -- (c) 2013 Abdreas Urben (urbenan) 
// -- GPL licens