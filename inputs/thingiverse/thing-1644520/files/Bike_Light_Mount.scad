//Mount for a bicycle back light
//Ari M Diacou
//June 2016

/////////////////////// Parameters //////////////////////
base_width=90;
base_height=20;
base_thickness=5;
coupler_width=26;
coupler_height=base_height;
coupler_thickness=5;
stem_width=13;
coupler_head=17;
tolerance=2.4;
ep=0+0.05;
ziptie_width=5;

///////////////////////// Main() /////////////////////////
echo(str("Suggested Filename: Bike Light Mount-B",base_width,"x",base_height,"x",base_thickness,"-C",coupler_width,"x",coupler_thickness,"-S",stem_width,"x",coupler_head,"x",tolerance,"-Z",ziptie_width));
difference(){
    base();
    light_coupler();
    ziptie_cutouts();
    }
//////////////////////// Functions //////////////////////////
module base(){
    translate([-base_width/2,0,0]) 
        cube([base_width,base_thickness,base_height]);
    translate([-coupler_width/2,-base_thickness+ep,0]) 
        cube([coupler_width,coupler_thickness,coupler_height]);
    }

module light_coupler(){    
    //cutout
    //stem
    //color("red") 
        translate([-stem_width/2,-base_thickness-ep,tolerance]) 
            cube([stem_width,base_thickness,coupler_height]);
    //coupler
    translate([-coupler_head/2,-base_thickness+tolerance,tolerance]) 
        //color("blue") 
            cube([coupler_head,coupler_thickness-1*tolerance,coupler_height]);
    }
module ziptie_cutouts(){
    //color("red")
        {
        translate([base_width/2-ziptie_width,0,base_height]) rotate([45,0,0])
            cube([ziptie_width,base_thickness,base_thickness], center=true );
        translate([base_width/2-ziptie_width,0,0]) rotate([45,0,0])
            cube([ziptie_width,base_thickness,base_thickness], center=true );
        translate([-base_width/2+ziptie_width,0,base_height]) rotate([45,0,0])
            cube([ziptie_width,base_thickness,base_thickness], center=true );
        translate([-base_width/2+ziptie_width,0,0]) rotate([45,0,0])
            cube([ziptie_width,base_thickness,base_thickness], center=true );
        }
    }