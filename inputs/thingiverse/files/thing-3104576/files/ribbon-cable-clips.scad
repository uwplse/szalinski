//
//***Holder for Rainbow Ribbon Flat Cable***
//Designed upside to how you print it. That's why it can look like too much plastic is above the cable.
//Coded for Thingyverse / Customizer
//
// Alan Percy Childs - Mostly
// B.Norcutt - Added countersink for screw heads

//User Settings
    
    //Render it sweetly
    $fa=1; $fs=0.5;    
    
    /* [Global] */

    
    /* [Cable] */
    //No of wires in the cable
    cable_qty = 6; // [1:100]
    //In mm, unless you use milstomm func in code.
    cable_pitch = 1.27; 
    
    /* [Screw] */
    //Screw thread diameter
    screw_threadWidth = 4; 
    //Screw head width, controls overall width of holder
    screw_headWidth = 7; 
    //0 if flat, use for countersinking
    screw_headDepth = 3; 
    
    /* [3D Printer] */
    //The mm nozzle on the 3D printer (assumes wall)
    print_nozzle = 0.4; 
    //The mm layer height on the 3D printer
    print_height = 0.15; 
 

/* [Hidden] */

//Render it sweetly
    $fa=1; $fs=0.5;    
 
//Hard Calculations (lazy functions)
    
    //Cable
    cable_width = (cable_qty+1)*cable_pitch;
    cable_height = cable_pitch+print_height;
    
    //Box
    box_width = screw_headWidth+(print_nozzle*4); 
    box_edge = ceil(cable_pitch) > 2 ? ceil(cable_pitch) : 2; 
    box_height = screw_headDepth+box_edge > cable_height+box_edge ? screw_headDepth+box_edge : cable_height+box_edge;

  
//Make Parts (Modules)
      
    module cable(cable_length=0) {
        cube([ cable_width , cable_length , cable_height ]);
    }
    
    module screw() {
        cylinder( h=box_height , d=screw_threadWidth );
        //Countersink
        if (screw_headDepth > 0) {
            translate([ 0 , 0 , box_height-(screw_headDepth) ]) 
                    cylinder( d2=screw_headWidth , d1=screw_threadWidth , h=screw_headDepth );
        }
    }


//Put it together (Rendering)

    difference(){
        cube([ box_width+cable_width+box_edge , box_width , box_height ]);
        translate([ box_width , 0 , 0 ])
            cable(box_width);
        translate([ (box_width/2) , (box_width/2) , 0 ])
            screw();
    }
        

    
            
//Mathical functions (some added just in case)

//    function milstomm(mils) = (mils*2.54) / 100;
//    function awgtomm(awg) = 0.127 * pow( 92 , ((36-awg)/39) ); //this isn't pitch :-(