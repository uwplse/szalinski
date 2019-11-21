
// Total height including the base of the filter. Measure bottom of the lid to bottom of your drain
filterHeight=16; 

// Height of the base plate
floorHeight = 1.4; // Hight of the floor

// Length of the filter
filterLength=150; 

// Tickness of the walls. Do not make them to small
wallThickness = 1.6; // Wall thickness

// Circular size of the grate/holes. 
holeSize=9; // Size of each circular hole

// Hight of the rim (it´s the little edge that keeps the vortex breaker and drain filter in place)
rimHeight=1; // Hight of the inset rim

// Drain size hole as measured. We will add 1mm tolerance to it to ensure uou have a nice fit
drainSizeMeasured=42; // Drain diamateer as measures, we will add 1mm tolerance

// Hight of the insert and vortex breaker
insetHeight=15; // Hight of the insert that will fit into the drain

// Maximum width. THis is used to add a little tab to keep the drain filter from rotating.
maxWidth = 54; // Maximum width

/* [Hidden] */
$fn=100;

drainSize=drainSizeMeasured - 1; // slighty smaller so it will always fit
filterWidth = drainSize + wallThickness*2 + 0.75;
echo("Filte width : " , filterWidth);
wallHeight = filterHeight - floorHeight;


// Floor
color([0.5,0.5,1]) {
   difference() {
       cube([filterLength,filterWidth,floorHeight]);
       translate([filterLength/2,filterWidth/2,floorHeight+0.1]) {
   inset(rimHeight=rimHeight, hollow=false,diam=drainSize+0.2,height=insetHeight,rim=1.2);
       }
   }
}

// Insert
translate([filterLength/2,filterWidth/2,floorHeight+40]) {
   inset(rimHeight=rimHeight, diam=drainSize,height=insetHeight,rim=1.2);
}

// Borders
border();
translate([0,filterWidth/2-maxWidth/2,0])
cube([10,maxWidth,floorHeight]);


// Border module
module border() {
   translate([0,0,floorHeight]) {
       top(width=filterLength,height=wallHeight,holeSize=holeSize,depth=wallThickness);
       translate([0,filterWidth-wallThickness,0])
           top(width=filterLength,height=wallHeight,holeSize=holeSize,depth=wallThickness);

       translate([wallThickness,0,0])
           rotate([0,0,90])
               top(width=filterWidth,height=wallHeight,holeSize=holeSize,depth=wallThickness);

       translate([filterLength,0,0])
           rotate([0,0,90])
               top(width=filterWidth,height=wallHeight,holeSize=holeSize,depth=wallThickness);
   }
}



module inset(diam=30, height=15, rim=1, hollow=true,border=1.2,vWidth=1.2) {
   translate([0,0,-height]) {
       difference() {
           union() {
               cylinder(d=diam, h=height);
               translate([0,0,height])
                   difference() {
                       cylinder(d=diam+rim*2, h=rim);
                       translate([0,0,-0.5])
                           cylinder(d=diam-border*2, h=rim+1);            
               }
           }

           union() {
               translate([0,0,-0.5])
                   cylinder(d=diam-border*2, h=height+1);
               translate([-diam,-5-diam/2,height-0.01])
                   cube([diam*2,10,rim*2]);
               translate([-diam,-5+diam/2,height-0.01])
                   cube([diam*2,10,rim*2]);
               translate([-diam,-5,height-0.01])
                   cube([diam*2,10,rim*2]);
           }
       }

       // Vortex breaker
       vortexBrakerDiam = diam-border;
       translate([-vortexBrakerDiam/2,-vWidth/2,0])
           cube([vortexBrakerDiam,vWidth,height+rim]);
       translate([-vWidth/2,-vortexBrakerDiam/2,0])
           cube([vWidth,vortexBrakerDiam,height+rim]);

       // Make it not hollow
       if (hollow == false) {
           cylinder(d=diam, h=height);
       }
   }
}

function centerEdge(holeSize) 
    = (holeSize) * sin(30) * 2; // distance center to Edge perpendicular    

module top(width=80,depth=2,height=16, holeSize=8, border=1.6, noBottom=true) {
   dx = centerEdge(holeSize); 

   spaceW = holeSize*1.5 + border;
   spaceH = dx;

    // Honeycob structure top
   itemsW = floor(width / spaceW);
   itemsH = floor(height / spaceH );

   if (noBottom) {
       difference()
       {                
           cube([width,depth,height]); 
           translate([border,-0.25,-0.01])
               cube([width-border*2,depth+0.5,height-border*1]);             
       }
   } else {
       difference()
       {                
           cube([width,depth,height]); 
           translate([border,-0.25,border])
               cube([width-border*2,depth+0.5,height-border*2]);             
       }
   }

   difference()
   {                
       cube([width,depth,height]);             
       for (x = [0:itemsW+1]) {
           for (y = [0:itemsH+1]) {                    
               translate([
               spaceW*x ,                 
               depth*1.5,
               spaceH*y - border/2
               ])
               rotate([90,0,0])
                  cylinder(d=holeSize, h=depth*2, $fn=6);

               translate([
               spaceW*x + spaceW/2,                 
               depth*1.5,
               spaceH* y + spaceH/2 - border/2
               ])
               rotate([90,0,0])
                  cylinder(d=holeSize, h=depth*2, $fn=6);
           }
       }

   }
}