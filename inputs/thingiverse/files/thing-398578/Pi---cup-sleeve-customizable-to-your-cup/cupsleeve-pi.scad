use<write/Write.scad>;

//Start with Cup Dimensions - these are for Leonardo glasses 'Ciao'
bottom_diameter=50.6;
top_diameter=80;
//Make sure the height is measured as the distance between your top and bottom radius measurements!
height=132;

//Now some basic properties of your sleeve
color="aqua"; //[black,silver,gray,white,maroon,red,purple,fuchsia,green,lime,olive,yellow,navy,blue,teal,aqua,brown,sienna]
thickness=1.6; //[1:4]
border=3; //[1:30]
sleeve_height_percent=19.5;//[10:95]
//Use this to move the sleeve up or down on the cup
sleeve_z_offset=30;

//And finally the pattern variables...

part=2;//[1:Render,2:Final]

////////////////////////////////

bottom_radius=bottom_diameter/2;
top_radius=top_diameter/2;
rb=bottom_diameter/2+thickness;
rt=top_diameter/2+thickness;
h=height;
sh=sleeve_height_percent/100*h;
szo=sleeve_z_offset;

res=30;

if(part==2)sleeve();

if(part==1){
    cup();
    sleeve();
}

radmiddle=rb+(rt-rb)*(0.5+szo/h);
pisize=5/19.6;
lettersize=sh-2*border+0.9;

module sleeve(){
    color(color)union(){
        intersection(){
            cupwall();

            translate([0,0,h/2+szo-0.4]) {
                //sphere(radmiddle,center=true);
                writesphere(".",[0,0,0],radmiddle-thickness,h=lettersize,t=5*thickness,spin=0,north=0,east=-120);
                writesphere("3141592653589",[0,0,0],radmiddle-thickness,h=lettersize,t=5*thickness,spin=0,north=0,east=0);

                translate([0,radmiddle+2*thickness,0]) rotate(90,[1,0,0])
                scale([pisize*lettersize,pisize*lettersize,sh/20.4*5]) poly_pi(4*thickness);
            }

        }


        intersection(){
            cupwall();
            translate([0,0,szo+(h-sh)/2])cylinder(r=rt*2,h=border,$fn=res);
        }

        intersection(){
            cupwall();
            translate([0,0,h-border+szo-(h-sh)/2])cylinder(r=rt*2,h=border,$fn=res);
        }
    }
}


module cup(){
    color("white")difference(){
        union(){
            translate([0,0,-.1])cylinder(r1=bottom_radius+.1,r2=top_radius+.1,h=h+.2,$fn=res);
            translate([0,0,h+.2-2.5])cylinder(r=top_radius+1.5,h=2.5,$fn=res);
        }
        translate([0,0,6])cylinder(r1=bottom_radius-1,r2=top_radius-1,h=h+.2,$fn=res);
        translate([0,0,-.2])cylinder(r=bottom_radius-1,h=5,$fn=res);
    }
}

module cupwall(){
    difference(){
        cylinder(r1=rb,r2=rt,h=h,$fn=30);
        translate([0,0,-.05])cylinder(r1=bottom_radius,r2=top_radius,h=h+.1,$fn=res);
    }
}

module poly_pi(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-0.997864,-5.116033],[2.550097,-5.116033],[1.492836,-0.098994],[1.219612,2.993592],[1.473037,5.401137],[1.983849,6.699944],[2.613453,6.953370],[3.500443,6.604909],[3.912260,5.781275],[3.722191,5.084354],[2.918356,1.964050],[2.803523,-0.110874],[3.373731,-5.116033],[6.985048,-5.116033],[7.887877,-5.250665],[8.321473,-5.570417],[8.505602,-6.193092],[8.101705,-6.858335],[7.270152,-6.953370],[-3.310374,-6.953370],[-4.692336,-6.767260],[-5.586751,-6.325250],[-6.573231,-5.464493],[-7.955193,-3.650915],[-8.505602,-2.645131],[-8.458085,-2.474861],[-8.125464,-2.328349],[-7.618612,-2.676810],[-6.429194,-4.086985],[-5.278384,-4.811130],[-3.627156,-5.116033],[-1.821498,-5.116033],[-3.726151,0.471214],[-5.844632,5.369458],[-6.098058,6.129736],[-5.797114,6.755381],[-5.211067,6.953370],[-4.616111,6.801413],[-4.205284,6.379202],[-3.627156,4.925963],[-2.771844,1.853176]]);
  }
}

// writesphere(text="text",where=[0,0,0],radius=radius of sphere);

//assuming z+ = north
//rotate(angle,[1,0,0]) // will move text north or south
//rotate(angle,[0,1,0]) // will rotate text like a clock hand
//rotate(angle,[0,0,1]) // will move text east or west

//detailed useage is in the WriteScadDoc
//rounded=true makes the face of the letters rounded, but takes longer to render

//%sphere(40);
//writesphere("3.14159265359",[0,0,0],40,spin=0,north=5,east=0);
