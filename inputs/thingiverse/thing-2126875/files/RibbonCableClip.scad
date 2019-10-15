//CUSTOMIZER VARIABLES

// Number of wires of the ribbon cable
wire_count = 10; //  [0:100]

// Width of the ribbon cable
wire_width = 12.7; //  [0:200]

// Depth of the clip
clip_depth = 10; //  [0:30]

//CUSTOMIZER VARIABLES END


module ribbonCableClip(wireCount, cableWidth, depth)
{
  wireDiameter = cableWidth / wireCount;
  
  difference()
  {
    union()
    {
      cube([cableWidth, wireDiameter+4, depth], center=true);
      translate([(-cableWidth)/2,0,0]) cylinder(d=wireDiameter+4, h=depth, center=true, $fn=50);
      translate([(cableWidth)/2,(wireDiameter+5)/4,0]) cylinder(d=(wireDiameter+3)/2, h=depth, center=true, $fn=50);
      
      translate([(cableWidth)/2,-(wireDiameter+5)/4,0]) cylinder(d=(wireDiameter+3)/2, h=depth, center=true, $fn=50);
    }
    for(i=[0:1:wireCount-1])
    {
      translate([(wireDiameter-cableWidth)/2+i*wireDiameter,0,0]) cylinder(d=wireDiameter*1.1, h=depth+2, center=true, $fn=25);
    }
  }
}

// Ribbon cable with 18 wires a width of 22.7mm
//ribbonCableClip(18, 22.7, 10);



ribbonCableClip(wire_count, wire_width, clip_depth);
