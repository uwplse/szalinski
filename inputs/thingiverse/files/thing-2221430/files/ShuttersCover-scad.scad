// Width of the cover 
width=54;

// Length of the cover
length=199;

// Height of the cover
height=5;

// The top of the cover is a little bit smaller than the bottom. This results in a slight ramp. This value will be substracted on each side for the top. So: if you set this to 3: the top-width will be width-3-3 and the top-length length-3-3
topFaceInset=3;

// Width of the cutout
cutoutWidth=32;

// Length of the cutout
cutoutLength=20;

// Offset (measured from the width-value)
cutoutOffset=40;

// Diameter for the holes
holeDiameter=5;

// Diameter for the top of the holes (for countersunk screws)
holeTopDiameter=6;

// Offset for the holes from the bottom (from y=0)
holesOffset=20;

// The length from one hole to the other hole. Measured from the center of the holes.
holeToHoleLength=159;

// Width of the border
borderWidth=0.8;

// Width of the top
topWidth=1;

// rotate by 180 degree for better print without supports
rotateForPrint=true;

$fn=60+0;

bottomHoleOffset=holesOffset;
topHoleOffset=bottomHoleOffset+holeToHoleLength;

if (rotateForPrint) {
    translate([width, 0, height])
        rotate([0,180,0])
            cover();
} else {
    cover();
}

module cover() {
    difference() {
            cutPyramid(width,length,height, topFaceInset);
            
            translate([borderWidth, borderWidth, -0.01])
                difference() {
                    cutPyramid(width-2*borderWidth,length-2*borderWidth,height+0.02, topFaceInset);
                    translate([0,0,height-topWidth])
                    cube([width-2*borderWidth,length-2*borderWidth,topWidth]);
                }
        
            translate([width/2-cutoutWidth/2, cutoutOffset, height-topWidth-1])
                cutPyramid(cutoutWidth, cutoutLength, topWidth+2, -1);
            
            hole(width/2, bottomHoleOffset);
            hole(width/2, topHoleOffset);
                
            
        }
}

module hole(x, y) {
    translate([x, y, 0]) {
        cylinder(d=holeDiameter, h=height+2);
        translate([0,0,height-topWidth/2-0.001])
            cylinder(d1=holeDiameter, d2=holeTopDiameter, h=topWidth/2+0.002);
    }
}

module cutPyramid(w, l, h, topInset) {
	polyhedron(points = [
      [  0,  0,  0 ],  //0
      [ w,  0,  0 ],  //1
      [ w,  l,  0 ],  //2
      [  0,  l,  0 ],  //3
      [  0+topInset,  0+topInset,  h ],  //4
      [ w-topInset,  0+topInset,  h ],  //5
      [ w-topInset,  l-topInset,  h ],  //6
      [  0+topInset,  l-topInset,  h ]   //7
	], faces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]
	]);
}