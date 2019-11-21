/**
 * list of boxes to print.
 * Each box is represented by vertor consisting of [BOX_LABEL, WIDTH_OF_STRIP, HEIGHT_OF_STRIP, SIZE_OF_CASE, TEXT_SIZE ]
 * Inside component there is extra space added to WIDTH_OF_STRIP to allow free movement of strip.
 */
boxes=[
    ["2K2",8,6,50,5],
    ["10K",8,6,50,5],
    ["200K",8,6,50,5],
    ["49K9",8,6,50,5],
    ["100K",8,6,50,5],
    ["diode",8,6,50,5],
    ["NFET",8,6,50,5],
    ["10µF",8,6,50,5],
    ["4K7",8,6,50,5],
    ["NPN",8,6,50,5],
    ["1117",12,6,50,5],
    ["470µF",12,6,50,4],
    ["150µF",12,6,50,4],
    ["µUSB",16,6,50,5]];

/**
* width of rails leading the strip
*/
border=1;

/**
* Thiskness of strip in the rails
*/
thickness=1.5;

/**
* Width of box perimeters
*/
wall=1;

/**
* length of with text
*/
textplace=15;

/**
* length of hole for extracting SMD parts
*/
parthole=15;

/**
* Radius of arc leading strip to dispenser
*/
dispenserradius=10;

/**
*
*/
stripehole=4;

module body(width, diameter) {
    difference() {
        cube([diameter+2*wall,diameter+2*wall,width+2*wall]);
        union() {
            translate([diameter/2+wall,diameter/2+wall,wall]) cylinder(d=diameter,h=width);
            translate([diameter/2+wall,diameter/2+wall,wall]) cylinder(d=diameter-5,h=width+2*wall);
            translate([diameter/2+wall,wall,wall]) cube([diameter/2+2*wall,diameter/2,width]);
        }
    }
}

module dispenser(text, width, height, diameter, textsize) {
    function inner() = width-2*border;
    length1 = sqrt((thickness+2*wall)*(thickness+2*wall) + stripehole*stripehole);
    length = sqrt(length1*length1 - wall*wall);
    angle = -atan((thickness+2*wall)/stripehole) + asin(wall/length1);
    union() {
        difference() {
            cube([height+wall,diameter+2*wall,width+2*wall]);
            translate([-1,0,0]) difference() {
                translate([0,0,wall])
                    cube([height+1,diameter+wall-textplace-parthole+4+inner(),width]);
                translate([0,diameter+wall-textplace-parthole+4+inner(),wall])
                    cylinder(r=height,h=width);
            }
            translate([-1,0,wall+border])
                cube([height+1,diameter+2*wall+.1,inner()]);
            translate([height-thickness,0,wall])
                cube([thickness,diameter+2*wall+.1,width]);
            translate([height-.1,diameter+wall-textplace-wall/2,wall])
                cube([thickness+wall+.2,textplace,width]);
            translate([height-.1,diameter+wall-textplace-parthole,wall]) 
                cube([thickness+wall+.2,stripehole,width]);
        }
        translate([height+wall/2,diameter+wall-textplace-wall/2,wall]) 
          cylinder(d=wall, h=width);

        difference() {
            translate([-dispenserradius+height-thickness,0,wall])
                cube([dispenserradius,diameter+wall-textplace-parthole,width]);
            translate([-dispenserradius+height-thickness-wall,dispenserradius+wall,0])
                cylinder(r=dispenserradius, h=width+2*wall);
            translate([-dispenserradius+height-thickness-wall-1,dispenserradius+wall,0])
                cube([dispenserradius+1,diameter,width+2*wall]);
        }
        translate([height-thickness-wall,diameter+wall-textplace-parthole,wall]) rotate([0,0,angle])
            cube([wall,length,width]);
        translate([height+wall,(diameter+wall-textplace-parthole)/2,width/2+wall]) rotate([90,0,90])
            linear_extrude(1) text(text,valign="center", halign="center", size=textsize);
    }
}

module hull(text, width, height, diameter,textsize) {
    body(width,diameter);
    translate([diameter+2*wall,0,0]) dispenser(text, width, height, diameter, textsize);
}

module tower(width,height,count) {
  translate([3*width,0,width]) rotate([-90,0,180]) {
    for (i=[0:count-1]) {
      translate([width/2,width/2,2*wall+i*(height+wall)]) difference() {
          cube([width+2*wall+.4,width,height+2*wall]);
          translate([wall,wall,wall]) cube([width+.4,width-2*wall,height]);
          translate([wall+.2,-wall,wall]) cube([width,width,height]);
      }
    }
    cube([2*width+2*wall+.4, 2*width,3*wall]);
  }
}

module multiple_boxes() {
    function displace(i) = ( i > 0 ? boxes[i-1][1] + 2*wall + 1 + displace(i-1) : 0 );

    rotate([-90,0,180]) {
        for (i=[0:len(boxes)-1]){
            box=boxes[i];
            width=box[1]+.5;
            diameter=box[3]-2*wall;
            translate([0,0,displace(i)]) hull(box[0], width, box[2], diameter, box[4]);
        }
}
}

multiple_boxes();
tower(50,50,4);