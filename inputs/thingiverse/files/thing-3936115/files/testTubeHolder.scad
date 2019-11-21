//print resolution
$fn = 24;

//// test tube thingy ////

/* test tube */

//diameter of tube
diameter = 8; //

//number of tubes
rowsOfTubes = 3; //[3, 5, 7]

//columns
columnsOfTubes = 1; //[1, 2, 3]

r = diameter/2;

////////////////
/////Holder/////
////////////////

module tubeHolder() {  //the main chassis of the print
    
    s = .2*r+1;    //radius of small corners
    c = diameter+r-1;  //distance to centers of corner spheres
    l = c*rowsOfTubes; //length of holder for multiple rows
    w = c*columnsOfTubes; //width for multiple rows
    hull(){
        translate([w,l,c*2]) sphere(s);
        translate([w+3,l+3,-c]) sphere(s-1);
        translate([w+3,-l-3,-c]) sphere(s-1);
        translate([w,-l,c*2]) sphere(s);
        translate([-w,l,c*2]) sphere(s);
        translate([-w-3,l+3,-c]) sphere(s-1);
        translate([-w-3,-l-3,-c]) sphere(s-1);
        translate([-w,-l,c*2]) sphere(s);
    }
    
}


////////////////
/////Cutouts////
////////////////

module tubeHoles() {  //punch test tube holes
    
    c = diameter+r-1;
    w = diameter+.3; //diameter of holes
    t = c*4; //height of punches
    s = ((rowsOfTubes*c)-1)/1.5; //spacing between tubes

    if (columnsOfTubes == 1) {
        
        if (rowsOfTubes == 3) {
            
            //punches//
            
            translate([0,s-1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,0,-c+10])cylinder(t,r1=w,r2=w);
            
            //divots//
            
            translate([0,s-1.5,-c+10])sphere(w);
            translate([0,-s+1.5,-c+10])sphere(w);
            translate([0,0,-c+10])sphere(w);
            
            //bevels//
            
            translate([0,s-1.5,c*3.4])sphere(w*2);
            translate([0,-s+1.5,c*3.4])sphere(w*2);
            translate([0,0,c*3.4])sphere(w*2);            
            
        }

        if (rowsOfTubes == 5) {
            
            //punches//
                        
            translate([0,s+3,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s-3,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,s/2+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s/2-1.5,-c+10])cylinder(t,r1=w,r2=w);
            
            //divots//
                        
            translate([0,s+3,-c+10])sphere(w);
            translate([0,-s-3,-c+10])sphere(w);
            translate([0,0,-c+10])sphere(w);
            translate([0,s/2+1.5,-c+10])sphere(w);
            translate([0,-s/2-1.5,-c+10])sphere(w); 
            
            //bevels//

            translate([0,s+3,c*3.4])sphere(w*2);
            translate([0,-s-3,c*3.4])sphere(w*2);
            translate([0,0,c*3.4])sphere(w*2);
            translate([0,s/2+1.5,c*3.4])sphere(w*2);
            translate([0,-s/2-1.5,c*3.4])sphere(w*2);
            
        }

        if (rowsOfTubes == 7) {
            
            //punches//
                        
            translate([0,s+5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s-5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,s/1.5+3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s/1.5-3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,s/2-7,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s/2+7,-c+10])cylinder(t,r1=w,r2=w);
            
            //divots//
                        
            translate([0,s+5.5,-c+10])sphere(w);
            translate([0,-s-5.5,-c+10])sphere(w);
            translate([0,0,-c+10])sphere(w);
            translate([0,s/1.5+3.5,-c+10])sphere(w);
            translate([0,-s/1.5-3.5,-c+10])sphere(w);
            translate([0,s/2-7,-c+10])sphere(w);
            translate([0,-s/2+7,-c+10])sphere(w);
            
            //bevels//
            
            translate([0,s+5.5,c*3.4])sphere(w*2);
            translate([0,-s-5.5,c*3.4])sphere(w*2);
            translate([0,0,c*3.4])sphere(w*2);
            translate([0,s/1.5+3.5,c*3.4])sphere(w*2);
            translate([0,-s/1.5-3.5,c*3.4])sphere(w*2);
            translate([0,s/2-7,c*3.4])sphere(w*2);
            translate([0,-s/2+7,c*3.4])sphere(w*2);
                        
        }
        
    }


    if (columnsOfTubes == 2) {

        if (rowsOfTubes == 3) {
            
            //punches//
            
            translate([c,s-1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,-s+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,0,-c+10])cylinder(t,r1=w,r2=w);
            
            translate([-c,s-1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,-s+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,0,-c+10])cylinder(t,r1=w,r2=w);
                        
            //divots//
            
            translate([c,s-1.5,-c+10])sphere(w);
            translate([c,-s+1.5,-c+10])sphere(w);
            translate([c,0,-c+10])sphere(w);
            
            translate([-c,s-1.5,-c+10])sphere(w);
            translate([-c,-s+1.5,-c+10])sphere(w);
            translate([-c,0,-c+10])sphere(w);
                        
            //bevels//
            
            translate([c,s-1.5,c*3.4])sphere(w*2);
            translate([c,-s+1.5,c*3.4])sphere(w*2);
            translate([c,0,c*3.4])sphere(w*2);            
            
            translate([-c,s-1.5,c*3.4])sphere(w*2);
            translate([-c,-s+1.5,c*3.4])sphere(w*2);
            translate([-c,0,c*3.4])sphere(w*2);            
                        
        }

        if (rowsOfTubes == 5) {
            
            //punches//
                        
            translate([c,s+3,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,-s-3,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,s/2+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,-s/2-1.5,-c+10])cylinder(t,r1=w,r2=w);
                        
            translate([-c,s+3,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,-s-3,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,s/2+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,-s/2-1.5,-c+10])cylinder(t,r1=w,r2=w);
                        
            //divots//
                        
            translate([c,s+3,-c+10])sphere(w);
            translate([c,-s-3,-c+10])sphere(w);
            translate([c,0,-c+10])sphere(w);
            translate([c,s/2+1.5,-c+10])sphere(w);
            translate([c,-s/2-1.5,-c+10])sphere(w); 
                        
            translate([-c,s+3,-c+10])sphere(w);
            translate([-c,-s-3,-c+10])sphere(w);
            translate([-c,0,-c+10])sphere(w);
            translate([-c,s/2+1.5,-c+10])sphere(w);
            translate([-c,-s/2-1.5,-c+10])sphere(w); 
                        
            //bevels//

            translate([c,s+3,c*3.4])sphere(w*2);
            translate([c,-s-3,c*3.4])sphere(w*2);
            translate([c,0,c*3.4])sphere(w*2);
            translate([c,s/2+1.5,c*3.4])sphere(w*2);
            translate([c,-s/2-1.5,c*3.4])sphere(w*2);

            translate([-c,s+3,c*3.4])sphere(w*2);
            translate([-c,-s-3,c*3.4])sphere(w*2);
            translate([-c,0,c*3.4])sphere(w*2);
            translate([-c,s/2+1.5,c*3.4])sphere(w*2);
            translate([-c,-s/2-1.5,c*3.4])sphere(w*2);
            
        }

        if (rowsOfTubes == 7) {
            
            //punches//
                        
            translate([c,s+5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,-s-5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,s/1.5+3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,-s/1.5-3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,s/2-7,-c+10])cylinder(t,r1=w,r2=w);
            translate([c,-s/2+7,-c+10])cylinder(t,r1=w,r2=w);
                        
            translate([-c,s+5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,-s-5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,s/1.5+3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,-s/1.5-3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,s/2-7,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c,-s/2+7,-c+10])cylinder(t,r1=w,r2=w);
                        
            //divots//
                        
            translate([c,s+5.5,-c+10])sphere(w);
            translate([c,-s-5.5,-c+10])sphere(w);
            translate([c,0,-c+10])sphere(w);
            translate([c,s/1.5+3.5,-c+10])sphere(w);
            translate([c,-s/1.5-3.5,-c+10])sphere(w);
            translate([c,s/2-7,-c+10])sphere(w);
            translate([c,-s/2+7,-c+10])sphere(w);
                        
            translate([-c,s+5.5,-c+10])sphere(w);
            translate([-c,-s-5.5,-c+10])sphere(w);
            translate([-c,0,-c+10])sphere(w);
            translate([-c,s/1.5+3.5,-c+10])sphere(w);
            translate([-c,-s/1.5-3.5,-c+10])sphere(w);
            translate([-c,s/2-7,-c+10])sphere(w);
            translate([-c,-s/2+7,-c+10])sphere(w);
                        
            //bevels//
            
            translate([c,s+5.5,c*3.4])sphere(w*2);
            translate([c,-s-5.5,c*3.4])sphere(w*2);
            translate([c,0,c*3.4])sphere(w*2);
            translate([c,s/1.5+3.5,c*3.4])sphere(w*2);
            translate([c,-s/1.5-3.5,c*3.4])sphere(w*2);
            translate([c,s/2-7,c*3.4])sphere(w*2);
            translate([c,-s/2+7,c*3.4])sphere(w*2);
            
            translate([-c,s+5.5,c*3.4])sphere(w*2);
            translate([-c,-s-5.5,c*3.4])sphere(w*2);
            translate([-c,0,c*3.4])sphere(w*2);
            translate([-c,s/1.5+3.5,c*3.4])sphere(w*2);
            translate([-c,-s/1.5-3.5,c*3.4])sphere(w*2);
            translate([-c,s/2-7,c*3.4])sphere(w*2);
            translate([-c,-s/2+7,c*3.4])sphere(w*2);
            
        }
        
    }


    if (columnsOfTubes == 3) {
              
        if (rowsOfTubes == 3) {
        
            
            //punches//
            
            translate([c+10,s-1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,-s+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,0,-c+10])cylinder(t,r1=w,r2=w);
            
            translate([0,s-1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,0,-c+10])cylinder(t,r1=w,r2=w);
            
            translate([-c-10,s-1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,-s+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,0,-c+10])cylinder(t,r1=w,r2=w);
                                    
            //divots//
            
            translate([c+10,s-1.5,-c+10])sphere(w);
            translate([c+10,-s+1.5,-c+10])sphere(w);
            translate([c+10,0,-c+10])sphere(w);
            
            translate([0,s-1.5,-c+10])sphere(w);
            translate([0,-s+1.5,-c+10])sphere(w);
            translate([0,0,-c+10])sphere(w);
            
            translate([-c-10,s-1.5,-c+10])sphere(w);
            translate([-c-10,-s+1.5,-c+10])sphere(w);
            translate([-c-10,0,-c+10])sphere(w);
                                    
            //bevels//
            
            translate([c+10,s-1.5,c*3.4])sphere(w*2);
            translate([c+10,-s+1.5,c*3.4])sphere(w*2);
            translate([c+10,0,c*3.4])sphere(w*2);            
            
            translate([0,s-1.5,c*3.4])sphere(w*2);
            translate([0,-s+1.5,c*3.4])sphere(w*2);
            translate([0,0,c*3.4])sphere(w*2);            
            
            translate([-c-10,s-1.5,c*3.4])sphere(w*2);
            translate([-c-10,-s+1.5,c*3.4])sphere(w*2);
            translate([-c-10,0,c*3.4])sphere(w*2);            
                                                          
            
        }

        if (rowsOfTubes == 5) {
            
            
            //punches//
                        
            translate([c+10,s+3,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,-s-3,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,s/2+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,-s/2-1.5,-c+10])cylinder(t,r1=w,r2=w);
                        
            translate([0,s+3,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s-3,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,s/2+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s/2-1.5,-c+10])cylinder(t,r1=w,r2=w);
                        
            translate([-c-10,s+3,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,-s-3,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,s/2+1.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,-s/2-1.5,-c+10])cylinder(t,r1=w,r2=w);
                                    
            //divots//
                        
            translate([c+10,s+3,-c+10])sphere(w);
            translate([c+10,-s-3,-c+10])sphere(w);
            translate([c+10,0,-c+10])sphere(w);
            translate([c+10,s/2+1.5,-c+10])sphere(w);
            translate([c+10,-s/2-1.5,-c+10])sphere(w); 
                        
            translate([0,s+3,-c+10])sphere(w);
            translate([0,-s-3,-c+10])sphere(w);
            translate([0,0,-c+10])sphere(w);
            translate([0,s/2+1.5,-c+10])sphere(w);
            translate([0,-s/2-1.5,-c+10])sphere(w); 
                        
            translate([-c-10,s+3,-c+10])sphere(w);
            translate([-c-10,-s-3,-c+10])sphere(w);
            translate([-c-10,0,-c+10])sphere(w);
            translate([-c-10,s/2+1.5,-c+10])sphere(w);
            translate([-c-10,-s/2-1.5,-c+10])sphere(w); 
                                    
            //bevels//

            translate([c+10,s+3,c*3.4])sphere(w*2);
            translate([c+10,-s-3,c*3.4])sphere(w*2);
            translate([c+10,0,c*3.4])sphere(w*2);
            translate([c+10,s/2+1.5,c*3.4])sphere(w*2);
            translate([c+10,-s/2-1.5,c*3.4])sphere(w*2);

            translate([0,s+3,c*3.4])sphere(w*2);
            translate([0,-s-3,c*3.4])sphere(w*2);
            translate([0,0,c*3.4])sphere(w*2);
            translate([0,s/2+1.5,c*3.4])sphere(w*2);
            translate([0,-s/2-1.5,c*3.4])sphere(w*2);

            translate([-c-10,s+3,c*3.4])sphere(w*2);
            translate([-c-10,-s-3,c*3.4])sphere(w*2);
            translate([-c-10,0,c*3.4])sphere(w*2);
            translate([-c-10,s/2+1.5,c*3.4])sphere(w*2);
            translate([-c-10,-s/2-1.5,c*3.4])sphere(w*2);
                                                        
            
        }

        if (rowsOfTubes == 7) {
            
            
            //punches//
                        
            translate([c+10,s+5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,-s-5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,s/1.5+3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,-s/1.5-3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,s/2-7,-c+10])cylinder(t,r1=w,r2=w);
            translate([c+10,-s/2+7,-c+10])cylinder(t,r1=w,r2=w);
                        
            translate([0,s+5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s-5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,s/1.5+3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s/1.5-3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,s/2-7,-c+10])cylinder(t,r1=w,r2=w);
            translate([0,-s/2+7,-c+10])cylinder(t,r1=w,r2=w);
                        
            translate([-c-10,s+5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,-s-5.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,0,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,s/1.5+3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,-s/1.5-3.5,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,s/2-7,-c+10])cylinder(t,r1=w,r2=w);
            translate([-c-10,-s/2+7,-c+10])cylinder(t,r1=w,r2=w);
                                    
            //divots//
                        
            translate([c+10,s+5.5,-c+10])sphere(w);
            translate([c+10,-s-5.5,-c+10])sphere(w);
            translate([c+10,0,-c+10])sphere(w);
            translate([c+10,s/1.5+3.5,-c+10])sphere(w);
            translate([c+10,-s/1.5-3.5,-c+10])sphere(w);
            translate([c+10,s/2-7,-c+10])sphere(w);
            translate([c+10,-s/2+7,-c+10])sphere(w);
                        
            translate([0,s+5.5,-c+10])sphere(w);
            translate([0,-s-5.5,-c+10])sphere(w);
            translate([0,0,-c+10])sphere(w);
            translate([0,s/1.5+3.5,-c+10])sphere(w);
            translate([0,-s/1.5-3.5,-c+10])sphere(w);
            translate([0,s/2-7,-c+10])sphere(w);
            translate([0,-s/2+7,-c+10])sphere(w);
                        
            translate([-c-10,s+5.5,-c+10])sphere(w);
            translate([-c-10,-s-5.5,-c+10])sphere(w);
            translate([-c-10,0,-c+10])sphere(w);
            translate([-c-10,s/1.5+3.5,-c+10])sphere(w);
            translate([-c-10,-s/1.5-3.5,-c+10])sphere(w);
            translate([-c-10,s/2-7,-c+10])sphere(w);
            translate([-c-10,-s/2+7,-c+10])sphere(w);
                                    
            //bevels//
            
            translate([c+10,s+5.5,c*3.4])sphere(w*2);
            translate([c+10,-s-5.5,c*3.4])sphere(w*2);
            translate([c+10,0,c*3.4])sphere(w*2);
            translate([c+10,s/1.5+3.5,c*3.4])sphere(w*2);
            translate([c+10,-s/1.5-3.5,c*3.4])sphere(w*2);
            translate([c+10,s/2-7,c*3.4])sphere(w*2);
            translate([c+10,-s/2+7,c*3.4])sphere(w*2);
            
            translate([0,s+5.5,c*3.4])sphere(w*2);
            translate([0,-s-5.5,c*3.4])sphere(w*2);
            translate([0,0,c*3.4])sphere(w*2);
            translate([0,s/1.5+3.5,c*3.4])sphere(w*2);
            translate([0,-s/1.5-3.5,c*3.4])sphere(w*2);
            translate([0,s/2-7,c*3.4])sphere(w*2);
            translate([0,-s/2+7,c*3.4])sphere(w*2);
            
            translate([-c-10,s+5.5,c*3.4])sphere(w*2);
            translate([-c-10,-s-5.5,c*3.4])sphere(w*2);
            translate([-c-10,0,c*3.4])sphere(w*2);
            translate([-c-10,s/1.5+3.5,c*3.4])sphere(w*2);
            translate([-c-10,-s/1.5-3.5,c*3.4])sphere(w*2);
            translate([-c-10,s/2-7,c*3.4])sphere(w*2);
            translate([-c-10,-s/2+7,c*3.4])sphere(w*2);
            
        }
        
    }
    
}

module cutout() {
    
        s = .2*r+3;    //radius of small corners
    c = diameter+r-1;  //distance to centers of corner spheres
    l = (c*rowsOfTubes)*.8; //length of cutout in relation to print
    w = c*columnsOfTubes*2; //cutout needs to be wider than the print
    h = c*.4; //shortens the hieght to maintaint cutout
    hull(){
        translate([w,l,h*3.5]) sphere(s);
        translate([w,l,-h*.5]) sphere(s);
        translate([w,-l,-h*.5]) sphere(s);
        translate([w,-l,h*3.5]) sphere(s);
        translate([-w,l,h*3.5]) sphere(s);
        translate([-w,l,-h*.5]) sphere(s);
        translate([-w,-l,-h*.5]) sphere(s);
        translate([-w,-l,h*3.5]) sphere(s);
    }
    
}


////////////////
/////Final//////
////////////////

difference() {

tubeHolder();
    cutout();
    tubeHoles();
}

//tubeHoles();