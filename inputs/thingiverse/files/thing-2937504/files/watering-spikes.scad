/*
 * Watering spikes
 *
 * 1/2'' tube connectors optional on left and/or right end.
 *
 * Copyright (c) 2018 Peter Mueller <peter@crycode.de> (https://crycode.de)
 */

/* [Golbal] */

// The part you want
part = "both"; // [left:Only left Connector,right:Only right connector,both:Both connectors]

/* [Size] */

// diameter of the tube (6.3 = 1/4'', 12.7 = 1/2'', 19 = 3/4'', 25.4 = 1'')
tubeD = 13;

// width of the top pipe without connectors
width = 100;

// depth of spikes without the bottom cone
depth = 100;

/* [Advanced] */

// diameter of one spike
spikeD = 10;

// additional diameter of a cone of the tube connectors
connectorCone = 1.5;

// wall thickness
wall = 2;

// space from the main pipe to the first watering hole
depthSpace = 30;

// diameter of the watering holes in the spikes
spikeOutD = 4;

/* [Hidden] */
// attach left tube connector
leftConnector = (part == "left" || part == "both");

// attach right tube connector
rightConnector = (part == "right" || part == "both");

/**
 * Module to create a tube connector.
 */
module tubeConnector () {
  cylinder(h=5, d1=tubeD-wall+1, d2=tubeD+connectorCone/2);
  for(i = [5:5:15]){
    translate([0, 0, i])
    cylinder(h=5, d1=tubeD-connectorCone/2, d2=tubeD+connectorCone/2);
  }
}

/**
 * Module to create a spike.
 */
module spike(){
  difference(){
    rotate([90, 0, 0])
    cylinder(h=depth, d=spikeD);
    
    for(i=[0:3]){
      for(y = [depthSpace+i*10:40:depth-5]){
        translate([0, -y, 0])
        rotate([0, 45 + i*90, 0])
        cylinder(h=spikeD/2+1, d=spikeOutD);
      }
    }
  }
  
  rotate([90, 0, 0])
  cylinder(h=10+tubeD/2, d1=tubeD, d2=spikeD);
  
  translate([0, -depth, 0])
  rotate([90, 0, 0])
  cylinder(h=15, d1=spikeD, d2=0);
}

/**
 * Module to create the inner hollow of a spike.
 */
module spikeInner(){
  rotate([90, 0, 0])
  cylinder(h=depth, d=spikeD-wall*2);
}


difference(){
  // create the main shape 
  union(){
    // middle pipe
    translate([-width/2, 0, 0])
    rotate([0, 90, 0])
    cylinder(h=width, d=tubeD);

    // left connector
    if(leftConnector){
      translate([-width/2 - 20, 0, 0])
      rotate([0, 90, 0])
      tubeConnector();
    }

    // right connector
    if(rightConnector){
      translate([width/2 + 20, 0, 0])
      rotate([0, -90, 0])
      tubeConnector();
    }

    // left spike
    translate([-width/2 + 15, 0, 0])
    spike();

    // right spike
    translate([width/2 - 15, 0, 0])
    mirror([1, 0, 0])
    spike();
  }

  // hollow middle pipe
  translate([-width/2-21, 0, 0])
  rotate([0, 90, 0])
  cylinder(h=width + 42, d=tubeD-wall*2);
  
  // hollow left spike
  translate([-width/2 + 15, 0, 0])
  spikeInner();
  
  // hollow right spike
  translate([width/2 - 15, 0, 0])
  spikeInner();
}

// left end plug if no left connector
if(!leftConnector){
  translate([-width/2, 0, 0])
  rotate([0, 90, 0])
  cylinder(h=wall*2, d=tubeD);
}

// right end plug if no right connector
if(!rightConnector){
  translate([width/2-wall*2, 0, 0])
  rotate([0, 90, 0])
  cylinder(h=wall*2, d=tubeD);
}