/**
 * (C) 2019 by Indy73c
 *
 * You can use it for whatever you want, but please keep this comment
 *
 * This Killflash Protector was
 * developed for the ATN XSight 4k. but he can
 * for any other riflescopes with internal thread can be adjusted.
 *
 */
use <threads.scad>              // Download it from thingiverse.com or
                                // https://dkprojects.net/openscad-threads/

hoehe               = 15;
d_in                = 61.6;     // inside diameter
d_out               = 64;       // outside diameter
threat_d            = 61.2;     // Thread size for the riflescope
threat_ring_hole    = 58.1;
threat_ring_h       = 6;
threat_connector_h  = 5;
comp_h              = 10;       // Height of the honeycomb, attention 
                                // of this value must be adapted to the 
                                // imported STL file.
//=======================================================================
$fn                 = 300;      // Fineness of the tube, 300 is great

killFlash();


/*
 * Create the Killflash protector with a tube.
 */
module killFlash()
{
    translate([0,0,hoehe]) threatRing();
    translate([0,0,hoehe-threat_connector_h]) threatConnector();
    honnyWedding();
}


/*
 * Creates the honeycomb insert for the scope
 */
module compInlay()
{
    difference()
    {
        /**
         * Here you can change the honeycomb structure.
         * just choose another base file.
         * Either one supplied by me, or create your own.
         * The base honeycomb should be at least 80x80 mm 
         * with a scope inside diameter of 60mm
         */
        import("honeycomb_base_16mm.stl");
        roundCut();
    }
}

/*
 * Cuts a round segment from the base honeycomb.
 */ 
module roundCut()
{
    difference()
    {
        cylinder(d=150, h=comp_h);
        cylinder(d=d_in+0.4, h=comp_h);
    }
}

/*
 * Creates the threaded ring that is screwed into the riflescope.
 */
module threatRing()
{
    difference()
    {
        metric_thread(threat_d, 1, threat_ring_h);
        cylinder(d=threat_ring_hole, h=threat_ring_h); 
    }
    
}

/**
 * Connects the honeycomb to the tube
 */
module honnyWedding()
{
    union()
    {
        baseTube();
        compInlay();
    }
}

/*
 * Creates the tube
 */
module baseTube()
{
    difference()
    {
        cylinder(d=d_out, h=hoehe-threat_connector_h); 
        cylinder(d=d_in, h=hoehe-threat_connector_h); 
    }
}

/*
 * Creates a ring that narrows the diameter of the tube 
 * so that the thread sits stably on the tube.
 */
module threatConnector()
{
    difference()
    {
        cylinder(d=d_out, h=threat_connector_h); 
        cylinder(d1=d_in, d2=threat_ring_hole, h=threat_connector_h);
        
    }
}