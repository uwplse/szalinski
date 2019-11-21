//CUSTOMIZER VARIABLES

// Number of wires of the ribbon cable
wire_count = 16; //  [0:100]

// Width of the ribbon cable
wire_width = 20.45; //  [0:200]

// Depth of the clip
clip_depth = 15; //  [0:30]

// With of the clip (over wires)
clip_w = 10; //  [0:30]

//CUSTOMIZER VARIABLES END

module ribbonCableClip(wireCount, cableWidth, depth)
{
  wireDiameter = cableWidth / wireCount;
  
  difference()
  {
    union()
    {
      cube([cableWidth+clip_w, wireDiameter+4, depth], center=true);
      translate([(-cableWidth)/2-clip_w/2,0,0])
        cylinder(d=wireDiameter+4, h=depth, center=true, $fn=50);
      translate([(cableWidth)/2+clip_w/2,(wireDiameter+5)/4,0])
        cylinder(d=(wireDiameter+3)/2, h=depth, center=true, $fn=50);
      translate([(cableWidth)/2+clip_w/2,-(wireDiameter+5)/4,0])
        cylinder(d=(wireDiameter+3)/2, h=depth, center=true, $fn=50);
   
    }
    translate([(wireDiameter-cableWidth)/2+wireCount*wireDiameter,0,0])
      cylinder(d=wireDiameter*1.1, h=depth+2, center=true, $fn=25);
    translate([(wireDiameter-cableWidth)/2+wireCount*wireDiameter,-wireDiameter*0.55, -depth/2])
      cube([clip_w/2, wireDiameter*1.1, depth], center=false);
    for(i=[0:1:wireCount-1])
    {
      translate([(wireDiameter-cableWidth)/2+i*wireDiameter,0,0])
        cylinder(d=wireDiameter*1.1, h=depth+2, center=true, $fn=25);
    }
    translate([(wireDiameter-cableWidth)/2-0.5,0,0]) 
      cylinder(d=wireDiameter*1.1, h=depth+2, center=true, $fn=25);
    translate([(wireDiameter-cableWidth)/2-0.5,-wireDiameter*0.55, -depth/2])
      cube([0.5, wireDiameter*1.1, depth], center=false);
  }
}

// Ribbon cable with 18 wires a width of 22.7mm and 10mm(2x5mm) +width
//ribbonCableClip(18, 22.7, 10, 10);

ribbonCableClip(wire_count, wire_width, clip_depth);
