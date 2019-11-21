include <write/Write.scad>

//CUSTOMIZER VARIABLES

//(Advise less than 5 characters, 3 looks best)
cufflink_text="BMS";
//(Relative size)
letters_size_scale = 10; //[5:15]
stock_length = 17; // [14:25]
//(Futuristic has best support)
font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic]
end_connector = "rounded" ; //[rounded,straight,upright]

//CUSTOMIZER VARIABLES END

letters_size = letters_size_scale/10;



module supportedLetters(text="ABC", theight=6)
{
    // Need to extrude at 45 degrees.
    // 1 - We strink (inv cos 45)
    // 2 - extrude at 90
    // 3 - Rotate 45 degrees
    // 4 - Chop off at 45 degrees
    // Then add normal extruded letters to the scaffolding
    invCos45 = 0.7071068;
    $fn=60;
    translate([0,-2,-1])  rotate([-90,0,0]) difference()
    {
        union() {
            rotate([45,0,0]) scale([1,invCos45,1]) write(text,h=theight,t=10,font=font, center=true);
        }
        translate([0,-7,0]) cube([len(text)*10,10,20], center=true);
        translate([0,5,0]) cube([len(text)*10,10,20], center=true);
        translate([0,0,-6]) cube([len(text)*10,20,10], center=true);
    }
    write(text,h=6,t=2.,font=font, center=true);
}

module supportedLettersAndBack(text="ABC", theight=6)
{
    translate([0,0,-0])  supportedLetters(text);
    translate([0,theight*0.025/2,-1])  cube([len(text)*(theight*2/3)*1.1,theight*1.025,1], center=true);
}


module stork(length, width, cheight, cradius, end="rounded")
{
    $fn=60;
	translate([0,width/2,-length/2])  union() {

      if(end=="rounded") 
      {
        support_stork(width=width, length=length);
        // End part - holding shirt together
        translate([0,-width/2,-(length-cheight)/2]) scale([1.25,1,1])  difference()
        {
	       cylinder(h=cheight, r1=cradius/2, r2=width/4, center=true);
          translate([0,-cheight,0]) cube([cradius*2,cheight*2,cradius], center=true);
		  }
      }
      if(end=="straight") 
      {
        support_stork(width=width, length=length);
        // Main stork
	     cube([width,width,length], center=true);
        // End part - holding shirt together
        translate([0,0,-(length)/2+cheight/5]) scale([1.25,1,1])  difference()
        {
	       cube([cheight*1.5,width,width], center=true);
		  }
        translate([0,-width/2,-(length-cheight)/2]) scale([1.25,1,1])  difference()
        {
	       cylinder(h=cheight, r1=cradius/2, r2=width/4, center=true);
          translate([0,-cheight,0]) cube([cradius*2,cheight*2,cradius], center=true);
          translate([0,width*2,0]) cube([cradius*2,width*2,cradius], center=true);
		  }
      }
      if(end=="upright") 
      {
        translate([0,(cheight-1)/2,1])  cylinder(h=length,r=1.5,center=true);
      translate([0,(cheight-1)/2,-1/2+length/2]) cylinder(h=1,r1=1.5, r2=3,center=true);
      translate([0,(cheight-1)/2,-length/2+1.25]) cylinder(h=0.5,r1=2, r2=1.5,center=true);
      translate([0,3,-length/2]) cube([4,9,2],center=true);
      }

	}
}


module support_stork(width=width, length=length)
{
// Strengthening stork to main link
		translate([0,-width/2,length/2]) scale([1.25,0.9,0.66]) difference() {
			sphere(r=width*1.25);
			translate([0,0,width*2]) cube([width*4, width*4, width*4], center=true);
			translate([0,-width*2,0]) cube([width*4, width*4, width*4], center=true);
    }
    // Main stork
    cube([width,width,length], center=true);
}

module bottom_()
{
  // base is "squeezed" by brim 
  scale([1, 1.,1])  difference()
  {
    union()
    {
      // scale as bottom is not rotated
      cube([12,24,0.8], center=true);
      translate([0,0,(15+0.8)/2]) cylinder(h=15,r=1.5,center=true);
      translate([0,0,0.8]) cylinder(h=1,r1=3, r2=1.5,center=true);
      translate([0,0,15-0.8]) cylinder(h=1,r1=1.2, r2=2.5,center=true);
      difference()
      {
          rotate([0,0,0]) translate([0,0,(15+0.8)])  cube([25,5,2.5	], center=true);
          translate([12,0,(15+1)])  cube([12,5*5,3*2], center=true);
          translate([-12,0,(15+1)])  cube([12,5*5,3*2], center=true);
      }
    }
  translate([0,0,0]) screw_holes(radius=1);
  }
}


module cufflink()
{
    rotate([90,0,0])
    {
        scale([1.5*letters_size,1.5*letters_size,1.5*letters_size]) translate([0,3,1.5]) supportedLettersAndBack(text=cufflink_text);
	     stork(stock_length,3, 7, 10, end=end_connector);
    }
}

cufflink();