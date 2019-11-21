/**************************************************************************************\
| Parametric Data Glove Finger Sensors
| Project codename "Grip"
| Designed by Zack Freedman of Voidstar Lab
| 
| Print as rendered with three outer layers using supports for maximum strength.
| PLA and ABS are both suitably durable.
|
| Insert a polyimide (Kapton) laminated Flexpoint flex sensor, with socket, 
| into each first segment.
|
| Don first segments, then don second segments. 
| Thread exposed sensor through second segment.
|
| Read using a voltage divider and ADC.
| Flex sensors are high impedance. Minimize lead length.
|
| Thumb was intentionally omitted. This configuration cannot measure thumb flexure
| without compromising manual dexterity.
|
| Overly snug rings and sharp edges can cut off blood flow and pinch nerves.
| Loose wires can snag on objects.
| Prioritize your biology and augment safely.
|
| Licensed Creative Commons 3.5 Attribution Noncommercial.
| Do not use for safety-critical applications.
\**************************************************************************************/

/* [Settings] */

// Which finger would you like to print?
part = "all"; // [all:All fingers,index:Index only,middle:Middle only,ring:Ring finger only,pinky:Pinky only,thumb:No Thumb]

/* [Index] */

// Millimeters from knuckle to knuckle. This segment is closest to your palm.
index_finger_first_segment_length = 30.5; // [15:0.5:50]

// Millimeters from knuckle to knuckle. This segment is between the fingertip and the first segment.
index_finger_second_segment_length = 23.5; // [15:0.5:50]

// Adjust for a snug fit. Use trial and error. Units of mm.
index_finger_first_segment_ring_diameter = 21; // [10:0.5:35]

// Adjust for a snug fit. Use trial and error. Units of mm.
index_finger_second_segment_ring_diameter = 17; // [10:0.5:35]

// Adjust to center the segment between your knuckles. Units of mm. 
index_finger_first_segment_ring_placement = 14; // [0:0.5:50]

// Adjust to center the segment between your knuckles. Units of mm. 
index_finger_second_segment_ring_placement = 2 ; // [0:0.5:50]

// Adjust to minimize the amount of exposed sensor
index_finger_sensor_inset = 13; // [0:0.5:35]

// Tune if ring is off-center or uncomfortable.
index_finger_first_segment_ring_offset = 3.5; // [0:0.1:5]

// Tune if ring is off-center or uncomfortable.
index_finger_second_segment_ring_offset = 3.2; // [0:0.1:5]


/* [Middle] */

// Millimeters from knuckle to knuckle. This segment is closest to your palm.
middle_finger_first_segment_length = 36.5; // [15:0.5:50]

// Millimeters from knuckle to knuckle. This segment is between the fingertip and the first segment.
middle_finger_second_segment_length = 25.5; // [15:0.5:50]

// Adjust for a snug fit. Use trial and error. Units of mm.
middle_finger_first_segment_ring_diameter = 20; // [10:0.5:35]

// Adjust for a snug fit. Use trial and error. Units of mm.
middle_finger_second_segment_ring_diameter = 17.5; // [10:0.5:35]

// Adjust to center the segment between your knuckles. Units of mm. 
middle_finger_first_segment_ring_placement = 17.5; // [0:0.5:50]

// Adjust to center the segment between your knuckles. Units of mm. 
middle_finger_second_segment_ring_placement = 2 ; // [0:0.5:50]

// Adjust to minimize the amount of exposed sensor
middle_finger_sensor_inset = 13; // [0:0.5:35]

// Tune if ring is off-center or uncomfortable.
middle_finger_first_segment_ring_offset = 3; // [0:0.1:5]

// Tune if ring is off-center or uncomfortable.
middle_finger_second_segment_ring_offset = 3.2; // [0:0.1:5]


/* [Ringfinger] */

// Millimeters from knuckle to knuckle. This segment is closest to your palm.
ring_finger_first_segment_length = 30.5; // [15:0.5:50]

// Millimeters from knuckle to knuckle. This segment is between the fingertip and the first segment.
ring_finger_second_segment_length = 22; // [15:0.5:50]

// Adjust for a snug fit. Use trial and error. Units of mm.
ring_finger_first_segment_ring_diameter = 19; // [10:0.5:35]

// Adjust for a snug fit. Use trial and error. Units of mm.
ring_finger_second_segment_ring_diameter = 16.5; // [10:0.5:35]

// Adjust to center the segment between your knuckles. Units of mm. 
ring_finger_first_segment_ring_placement = 14; // [0:0.5:50]

// Adjust to center the segment between your knuckles. Units of mm. 
ring_finger_second_segment_ring_placement = 2 ; // [0:0.5:50]

// Adjust to minimize the amount of exposed sensor
ring_finger_sensor_inset = 13; // [0:0.5:35]

// Tune if ring is off-center or uncomfortable.
ring_finger_first_segment_ring_offset = 2.7; // [0:0.1:5]

// Tune if ring is off-center or uncomfortable.
ring_finger_second_segment_ring_offset = 3.1; // [0:0.1:5]

/* [Pinky] */

// Millimeters from knuckle to knuckle. This segment is closest to your palm.
pinky_finger_first_segment_length = 23; // [15:0.5:50]

// Millimeters from knuckle to knuckle. This segment is between the fingertip and the first segment.
pinky_finger_second_segment_length = 16; // [15:0.5:50]

// Adjust for a snug fit. Use trial and error. Units of mm.
pinky_finger_first_segment_ring_diameter = 17; // [10:0.5:35]

// Adjust for a snug fit. Use trial and error. Units of mm.
pinky_finger_second_segment_ring_diameter = 15.5; // [10:0.5:35]

// Adjust to center the segment between your knuckles. Units of mm. 
pinky_finger_first_segment_ring_placement = 10; // [0:0.5:50]

// Adjust to center the segment between your knuckles. Units of mm. 
pinky_finger_second_segment_ring_placement = 2 ; // [0:0.5:50]

// Adjust to minimize the amount of exposed sensor
pinky_finger_sensor_inset = 0; // [0:0.5:35]

// Tune if ring is off-center or uncomfortable.
pinky_finger_first_segment_ring_offset = 2.2; // [0:0.1:5]

// Tune if ring is off-center or uncomfortable.
pinky_finger_second_segment_ring_offset = 2.6; // [0:0.1:5]

/* [Hidden] */

outerAWidth = 14;
outerBWidth = 12;

socketMaxWidth = 11;
flexCutoutWidth = 8.5;

module socket(socketSetback) {
    innerHeight = 4;
    innerOffset = -1;

    difference() {
        translate([innerOffset, 0, socketSetback]) cube([innerHeight, socketMaxWidth, 9.4 + 1.25]);
        
        translate([innerOffset, 0, socketSetback]) cube([innerHeight, 1.25, 1.55]);
        
        translate([innerOffset, socketMaxWidth - 1.25, socketSetback]) cube([innerHeight, 1.25, 1.55]);
    }
    
    translate([innerOffset, (socketMaxWidth - 7.3) / 2, socketSetback]) cube([innerHeight, 7.3, 50]);
            
    translate([0.75, (socketMaxWidth - flexCutoutWidth) / 2, socketSetback - 49]) flexSensorCutout();
}

module flexSensorCutout() {
    cube([1.5, flexCutoutWidth, 50], false);
}

module ring(diameter, reliefAngle=0) {
    scale([1, 1, 2]) {
            difference() {
            // Ring
            rotate_extrude($fn=32) translate([diameter / 2, 0, 0]) circle(r=1, $fn=16);
            
            // Relief
            // TODO: rotate_extrude() instead once I update SCAD
            rotate([0, 0, reliefAngle]) translate([diameter / 2 - 1, -3, 0]) cube([5, 5, 3], true);
        }
    }
}

module fingerA(length, ringDiameter, ringPlacement, ringOffset, sensorInset) {
    difference() {
        union() {            
            chamfer = 1.5;
            intersection() {
                translate([chamfer, chamfer,0]) minkowski() {
                    $fn=16;
                    cube([4 - chamfer * 2, outerAWidth - chamfer * 2, length - 2], false);
                    sphere(r=chamfer);
                }
                
            }   
            
            translate([-(4 + ringOffset), outerAWidth / 2, ringPlacement]) ring(ringDiameter, 50);
        }

        translate([0, (outerAWidth - socketMaxWidth) / 2, -.5])
            socket(sensorInset);
    }
}

module fingerB(length, ringDiameter, ringPlacement, ringOffset) {
    difference() {
        union() {
            chamfer = 1.5;
            translate([chamfer, chamfer, 0]) minkowski() {
                $fn=32;
                cube([4 - chamfer * 2, outerBWidth - chamfer * 2, length - 2], false);
                sphere(r=chamfer);
            }
            
            translate([-(4 + ringOffset), outerBWidth / 2, ringPlacement]) ring(ringDiameter, 50);
        }
        
        translate([.75, (outerBWidth - flexCutoutWidth) / 2, -5]) flexSensorCutout();
    }
}

module indexFinger() {
    fingerA(
        index_finger_first_segment_length, 
        index_finger_first_segment_ring_diameter,
        index_finger_first_segment_ring_placement, 
        index_finger_first_segment_ring_offset, 
        index_finger_sensor_inset);
    
    translate([30, 0, 0]) fingerB(
        index_finger_second_segment_length, 
        index_finger_second_segment_ring_diameter,
        index_finger_second_segment_ring_placement,
        index_finger_second_segment_ring_offset);
}

module middleFinger() {
    fingerA(
        middle_finger_first_segment_length, 
        middle_finger_first_segment_ring_diameter,
        middle_finger_first_segment_ring_placement, 
        middle_finger_first_segment_ring_offset, 
        middle_finger_sensor_inset);
    
    translate([30, 0, 0]) fingerB(
        middle_finger_second_segment_length, 
        middle_finger_second_segment_ring_diameter,
        middle_finger_second_segment_ring_placement,
        middle_finger_second_segment_ring_offset);
}

module ringFinger() {
    fingerA(
        ring_finger_first_segment_length, 
        ring_finger_first_segment_ring_diameter,
        ring_finger_first_segment_ring_placement, 
        ring_finger_first_segment_ring_offset, 
        ring_finger_sensor_inset);
    
    translate([30, 0, 0]) fingerB(
        ring_finger_second_segment_length, 
        ring_finger_second_segment_ring_diameter,
        ring_finger_second_segment_ring_placement,
        ring_finger_second_segment_ring_offset);
}

module pinkyFinger() {
    fingerA(
        pinky_finger_first_segment_length, 
        pinky_finger_first_segment_ring_diameter,
        pinky_finger_first_segment_ring_placement, 
        pinky_finger_first_segment_ring_offset, 
        pinky_finger_sensor_inset);
    
    translate([30, 0, 0]) fingerB(
        pinky_finger_second_segment_length, 
        pinky_finger_second_segment_ring_diameter,
        pinky_finger_second_segment_ring_placement,
        pinky_finger_second_segment_ring_offset);
}

module print_part() {
    if (part == "all") {
        indexFinger();
        translate([0, 30, 0]) middleFinger();
        translate([0, 60, 0]) ringFinger();
        translate([0, 90, 0]) pinkyFinger();
    }
    else if (part == "index") {
        indexFinger();
    }
    else if (part == "middle") {
        middleFinger();
    }
    else if (part == "ring") {
        ringFinger();
    }
    else if (part == "pinky") {
        pinkyFinger();
    }
}

print_part();