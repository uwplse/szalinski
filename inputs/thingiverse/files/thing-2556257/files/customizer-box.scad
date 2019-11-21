//Outside length of box in mm
length=50; 
//Outside width of box in mm
width=40; 
//Outside height of box in mm
height=30; 
//Thickness of box walls in mm.  Take this into account for desired interior dimensions.
thickness=8; 
//Tolerance affects the fit of the sliding lid.  Higher is looser.
tolerance=4;//[0:20]
//Bit is for CNC purposes.  This affects the spacing between pieces in the layout.
bit=6;
//Layout style.
layout=1;//[1:Layout1, 2:Layout2, 3:Layout3, 4:Layout4, 5:Assembled, 6:Exploded]

tlrnc=thickness*tolerance/100;

module lid() {
   translate([tlrnc,0,0]) 
      cube([width-thickness-2*tlrnc,length-thickness/2-tlrnc,thickness/2]);
   translate([thickness/2+tlrnc,thickness/2,0]) 
      cube([width-2*thickness-2*tlrnc,length-3/2*thickness-tlrnc,thickness]);
   difference() {
      translate([tlrnc,0,0]) 
         cube([width-thickness-2*tlrnc,thickness+tlrnc,thickness]); 
      translate([0,thickness+tlrnc,thickness/2]) 
         cylinder($fn=50,thickness/2+2*tlrnc,thickness/2+tlrnc,thickness/2+tlrnc); 
      translate([width-thickness,thickness+tlrnc,thickness/2-2*tlrnc]) 
         cylinder($fn=50,thickness/2+2*tlrnc,thickness/2+tlrnc,thickness/2+tlrnc); 
   } 
}

module bottom() {
   cube([width-thickness,length,thickness/2]);
   translate([thickness/2,thickness/2,0]) 
      cube([width-2*thickness,length-thickness,thickness]);
}  

module side() {
   cube([height,length,thickness/2]);
   translate([thickness+tlrnc,thickness/2,0]) 
      cube([height-3/2*thickness-tlrnc,length-thickness,thickness]);
   translate([0,thickness+tlrnc,0])
      cube([thickness/2-tlrnc,length-3/2*thickness-tlrnc,thickness]);
   translate([0,thickness+tlrnc,thickness/2]) 
      rotate([0,90,0]) 
         cylinder($fn=50,thickness/2-tlrnc,thickness/2,thickness/2); 
}  

module end() {
   cube([width-thickness,height-3/2*thickness-tlrnc,thickness/2]);
   translate([thickness/2,thickness/2,0]) cube([width-2*thickness,height-2*thickness-tlrnc,thickness]); 
}

module far_end() {
   cube([height-thickness/2,width-thickness,thickness/2]);
   translate([thickness+tlrnc,thickness/2,0]) 
      cube([height-2*thickness-tlrnc,width-2*thickness,thickness]); 
   translate([0,thickness/2,0])
      cube([thickness/2-tlrnc,width-2*thickness,thickness]);  
}


module box_layout_1 () {
// good for more cubicle boxes.    
   lid();
   translate([0,length-thickness/2+bit,0]) bottom();
   translate([width-thickness+bit,0,0]) side();
   translate([width-thickness+bit,2*length+bit,0]) mirror([0,1,0]) side();
   translate([0,2*length-thickness/2+2*bit,0]) end();
   translate([width-thickness+bit,2*length+2*bit,0]) far_end();
}  

module box_layout_2 () {
// good for longer boxes such as would hold a wine bottle on its side.   
   lid();
   translate([length+bit,height+bit,0]) bottom();
   translate([length+width-thickness+bit,0,0])rotate([0,0,90])side();
   translate([length,length+height+bit,0]) rotate([0,0,-90])mirror([0,1,0]) side();
   translate([width/2+length/2-bit/2-thickness/2,length/2-width/2+height/2+thickness,0]) rotate([0,0,90])end();
   translate([width/2+length/2+bit/2-thickness/2,length/2-width/2+height/2+thickness,0])                 far_end();
}

module box_layout_3 () {
// good for tall boxes.
   lid();
   translate([0,length-thickness/2+bit,0]) bottom();
   translate([width-thickness+bit,0,0]) side();
   translate([width-thickness+bit,2*length+bit,0]) mirror([0,1,0]) side();
   translate([width-thickness+bit,2*length+2*bit,0])far_end();
   translate([width-thickness/2+bit,2*width-2*thickness+2*length+3*bit,1])rotate([0,0,-90])end();
}  

module box_layout_4 () {
// good for pizza box shaped boxes.
   lid();
   translate([0,length-thickness/2+bit,0]) bottom();
   translate([0,height+2*length-thickness/2+2*bit,0]) rotate([0,0,-90])side();
   translate([0,height+2*length-thickness/2+3*bit,0]) rotate([0,0,90])mirror([0,1,0]) side();
   translate([0,3*height-3/2*thickness/2+2*length+4*bit,0])rotate([0,0,-90])far_end();
   translate([0,3*height-3/2*thickness/2+2*length+5*bit,0])end();
}  

module assembled_box() {
   translate([0,0,height-thickness]) lid();
   translate([0,0,0]) bottom();
   translate([-thickness/2,0,height]) rotate([0,90,0]) side();
   translate([width-thickness/2,0,height]) rotate([180,90,0])mirror([0,1,0]) side();
   translate([0,length,height]) rotate([90,0,0])rotate([0,0,-90])far_end();
   translate([width-thickness,0,thickness/2]) rotate([90,0,180])end();
}   

module exploded_box() {
   translate([0,0,height]) lid();
   translate([0,0,-thickness]) bottom();
   translate([-3/2*thickness,0,height]) rotate([0,90,0]) side();
   translate([width+thickness/2,0,height]) rotate([180,90,0])mirror([0,1,0]) side();
   translate([0,length+thickness,height]) rotate([90,0,0])rotate([0,0,-90])far_end();
   translate([width-thickness,-thickness,thickness/2]) rotate([90,0,180])end();
} 

if(layout==1) box_layout_1();
if(layout==2) box_layout_2();
if(layout==3) box_layout_3();
if(layout==4) box_layout_4();
if(layout==5) assembled_box();  
if(layout==6) exploded_box();