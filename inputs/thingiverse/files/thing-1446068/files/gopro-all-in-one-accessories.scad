/****************customizable values****************/

number_of_batteries=6;
walls_thickness=3;

/* [Hidden] */
battery_depth=36;
battery_width=13;
battery_height=28;

tolerance=0.4;
/****************init values to ease the code****************/
bat_d=battery_depth+tolerance*4;
bat_w=battery_width+tolerance*4;
bat_h=battery_height+tolerance*2;
bat_nbr=number_of_batteries;
walls=walls_thickness;
/****************MODULES****************/
$fn=100;
module battery(depth,width,height){
    cube([width,depth,height]);
    };
//------------------------------------------------------------------------
module makebox(bat_nbr,bat_w,bat_h,bat_d,walls){
    depth=(bat_nbr*(bat_w+walls))+walls;
    width=bat_d+(walls*4)+15;
    height=bat_h+(walls*2);
    cube([depth,width,height]);
    }
//------------------------------------------------------------------------    
module makeBatteriesHoles(bat_nbr,bat_w,bat_h,bat_d,walls){
    for(n=[1:bat_nbr]){        
        translate([n*(walls+bat_w)-bat_w,walls,walls])
            color("red") 
                battery(bat_d,bat_w,bat_h);
    }
    color("pink")
    rotate([0,90,0]) 
        translate([-(bat_h+walls),(walls+(bat_d/2)) , walls]){   //(walls+(bat_d/2))
            cylinder(  bat_nbr*(bat_w+walls)-walls, d1=bat_d/1.5,  d2=bat_d/1.5,center=false);
    }        
}
//------------------------------------------------------------------------
module makeBatteriesTopOpening(bat_nbr,bat_w,bat_h,bat_d,walls,marge){
    demi_marge=marge/2;
    color("green") 
      cube([bat_nbr*(bat_w+walls),bat_d-marge,walls]);  
        bord=walls/2;
    color("blue");
    translate([-bord,-bord,0]) 
        cube([bat_nbr*(bat_w+walls)+bord,bat_d+walls,bord-marge]);    
}
//------------------------------------------------------------------------
module makeCardsTopOpening(bat_nbr,bat_w,bat_h,bat_d,walls,marge){
    color("blue") 
      cube([bat_nbr*(bat_w+walls),15,walls]);  
    bord=walls/2;
    color("blue")
        translate([-bord,-bord,0]) 
            cube([bat_nbr*(bat_w+walls)+bord,15+walls,bord-marge]);    
}       
//------------------------------------------------------------------------
module makeCardsSlots(width,depth){
    cube([width,depth,6]);
    nbr_cards=width/4;
    for (n=[1:nbr_cards]){        
        translate([4*n,1.2,-10]) cube([1,12.6,10]);
    }
}
/*****************************************************************************************************/    
/*****************************************************************************************************/
/*****************************************************************************************************/
/**---**/translate([n*(walls+bat_w)-bat_w,walls,walls])                                       /**---**/
/**---**/    translate([0,-(bat_d*1.5),0]){                                                   /**---**/
/**---**/        makeBatteriesTopOpening(bat_nbr,bat_w,bat_h,bat_d,walls,tolerance);          /**---**/
/**---**/    }                                                                                /**---**/
/**---**/translate([0,-(bat_d*2.5),0]){                                                       /**---**/
/**---**/      makeCardsTopOpening(bat_nbr,bat_w,bat_h,bat_d,walls,tolerance);                /**---**/
/**---**/    }                                                                                /**---**/
/**---**///bloc                                                                               /**---**/
/**---**/difference(){                                                                        /**---**/
/**---**/    color("Teal") makebox(bat_nbr,bat_w,bat_h,bat_d,walls);                          /**---**/
/**---**/                                                                                     /**---**/
/**---**/    makeBatteriesHoles(bat_nbr,bat_w,bat_h,bat_d,walls);                             /**---**/
/**---**/    translate([walls,walls,walls+bat_h])                                             /**---**/
/**---**/        makeBatteriesTopOpening(bat_nbr,bat_w,bat_h,bat_d,walls,0);                  /**---**/
/**---**/    translate([walls,(walls*3)+bat_d,walls+bat_h])                                   /**---**/
/**---**/        makeCardsTopOpening(bat_nbr,bat_w,bat_h,bat_d,walls,0);                      /**---**/
/**---**/                                                                                     /**---**/
/**---**/    width=bat_nbr*(bat_w+walls)-walls;                                               /**---**/
/**---**/    depth=15;                                                                        /**---**/
/**---**/                                                                                     /**---**/
/**---**/    translate([walls,(walls*3)+bat_d,walls+bat_h-6])                                 /**---**/ 
/**---**/       makeCardsSlots(width,depth);                                                  /**---**/
/**---**/}                                                                                    /**---**/
/*****************************************************************************************************/
/*****************************************************************************************************/
/*****************************************************************************************************/   