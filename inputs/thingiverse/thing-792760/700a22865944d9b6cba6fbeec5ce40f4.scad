// SDE big cards sleeved : 66*90.7 tol 1.5

// Width of a card
card_width = 66;
// Length of a card
card_length = 90.7;
// Total height of the stack of cards you need a box for
stack_height = 36.3;
// The size of the support that will go beneath the card box
support_size = 28;
// This value will be added to the width, length and height. It should probably never be 0 if your values are precise.
tolerance = 1.5;
// The thickness of the printed parts, 1.6 is good for a 0.4 nozzle with a shell thikness of 0.8
thickness = 1.6;
// Which parts do you want to print ?
wut2print = "boxncover"; // [box:Bottom part,lid:Lid,boxncover:Bottom and lid,support:Support,every:Everything]


print_part();

cardwidth = card_width;
cardlength = card_length;
cardheight = stack_height;
support = support_size;

tol = tolerance;
thick1 = thickness;

cardw1 = cardwidth+tol;
cardl1 = cardlength+tol;
cardh1 = cardheight+tol;
cardldiv1 = cardl1/6;
cardwdiv1 = cardw1/5;

module print_part(){

if (wut2print == "box") {
bottom(cardw1, cardl1, cardh1, thick1, cardldiv1, cardwdiv1);
}
else if (wut2print == "lid") {
    translate([cardw1*2.3,0,cardh1]) rotate([0,180,0]) top(cardw1, cardl1, cardh1, thick1, cardldiv1, cardwdiv1);
}
else if (wut2print == "boxncover") {
    translate([cardw1*2.3,0,cardh1]) rotate([0,180,0]) top(cardw1, cardl1, cardh1, thick1, cardldiv1, cardwdiv1);
    bottom(cardw1, cardl1, cardh1, thick1, cardldiv1, cardwdiv1);
}
else if (wut2print == "support") {
support(cardw1, cardl1, cardh1, thick1, cardldiv1, cardwdiv1, support);
}
else if (wut2print == "every") {
    bottom(cardw1, cardl1, cardh1, thick1, cardldiv1, cardwdiv1);
    translate([cardw1*2.3,0,cardh1]) rotate([0,180,0]) top(cardw1, cardl1, cardh1, thick1, cardldiv1, cardwdiv1);
    translate([0,-cardldiv1*5,support]) support(cardw1, cardl1, cardh1, thick1, cardldiv1, cardwdiv1, support);
}

}


module bottom(cardw, cardl, cardh, thick, cardldiv, cardwdiv)
{
    difference(){
    union(){
        translate([-thick,cardldiv,-thick]) cube([cardw+thick*2,cardldiv,cardh+thick]);
        translate([-thick,cardldiv*4,-thick]) cube([cardw+thick*2,cardldiv,cardh+thick]);
        translate([cardwdiv*2,cardldiv,-thick]) cube([cardwdiv,cardl-cardldiv+thick,cardh+thick*2]);
    }
    translate([0,-5,0]) cube([cardw,cardl+5,cardh+5]);
    translate([cardw+thick*1.4,cardldiv*5-cardldiv/5,cardh-thick*1.5]) rotate([90,0,0]) cylinder($fn = 100, r = thick, h = cardldiv*4-2*(cardldiv/5));
    translate([-thick*1.4,cardldiv*5-cardldiv/5,cardh-thick*1.5]) rotate([90,0,0]) cylinder($fn = 100, r = thick, h = cardldiv*4-2*(cardldiv/5));
    }
}

module top(cardw, cardl, cardh, thick, cardldiv, cardwdiv)
{
difference(){
union(){
    difference(){
        union(){
            translate([-thick*2,cardldiv1-thick-tol/10,cardh-thick]) cube([cardw+thick*4,cardldiv1/1.7,thick*2]);
            translate([-thick*2,cardldiv1*5-cardldiv1/1.7+thick+tol/10,cardh-thick]) cube([cardw+thick*4,cardldiv1/1.7,thick*2]);
            translate([-thick*2,cardldiv1-thick-tol/10,cardh-thick*2]) cube([cardldiv1/1.7,cardldiv1*4+thick*2+tol/5,thick*3]);
            translate([cardw+thick*2-cardldiv1/1.7,cardldiv1-thick-tol/10,cardh-thick*2]) cube([cardldiv1/1.7,cardldiv1*4+thick*2+tol/5,thick*3]);
            translate([cardwdiv*2,cardldiv1*5-cardldiv1/1.7+thick+tol/10,-thick]) cube([cardwdiv,cardl1-(cardldiv1*5-cardldiv1/1.7+thick+tol/10)+thick,cardh+thick*2]);
        }
        translate([-thick,0,-thick*2]) cube([cardw+thick*2,cardl,cardh+thick*2]);
        //#translate([cardldiv1/1.7-thick*2,cardldiv1+cardldiv1/1.7-thick-tol/10,thick*2]) cube([cardw1+thick*4-cardldiv1/1.7*2,cardldiv1*4-cardldiv1/1.7-thick+tol/2,cardh+thick*2]);
    }
    translate([cardw+thick*1.4,cardldiv*2+cardldiv/5+1,cardh-thick*1.7]) rotate([90,0,0]) cylinder($fn = 100, r = thick, h = cardldiv);
    translate([cardw+thick*1.4,cardldiv*5-cardldiv/5-1,cardh-thick*1.7]) rotate([90,0,0]) cylinder($fn = 100, r = thick, h = cardldiv);
    translate([-thick*1.4,cardldiv*5-cardldiv/5-1,cardh-thick*1.7]) rotate([90,0,0]) cylinder($fn = 100, r = thick, h = cardldiv);
    translate([-thick*1.4,cardldiv*2+cardldiv/5+1,cardh-thick*1.7]) rotate([90,0,0]) cylinder($fn = 100, r = thick, h = cardldiv);

translate([-thick*2,cardldiv*5+tol/10,cardh-thick*2]) cube([thick*2,thick,thick*3]);
    translate([cardw,cardldiv*5+tol/10,cardh-thick*2]) cube([thick*2,thick,thick*3]);
    translate([cardw,cardldiv-tol+tol/10,cardh-thick*2]) cube([thick*2,thick,thick*3]);
    translate([-thick*2,cardldiv-tol+tol/10,cardh-thick*2]) cube([thick*2,thick,thick*3]);
}
translate([cardw+thick*2,0,0]) cube([10,cardl,cardh*1.1]);
translate([-thick*3,cardldiv*2+thick,0]) cube([cardw*1.2,cardldiv*2-thick*2,cardh]);

translate([-10-thick*2,0,0]) cube([10,cardl,cardh*1.1]);
}
}

module support(cardw, cardl, cardh, thick, cardldiv, cardwdiv, sup)
{
    difference(){
        union(){
            translate([0,cardldiv-2,-sup-thick]) cube([cardwdiv/2, cardldiv+4, sup+thick-0.1]);
            translate([cardwdiv*4.5,cardldiv-2,-sup-thick]) cube([cardwdiv/2, cardldiv+4, sup+thick-0.1]);
            translate([cardwdiv*4.5,cardldiv*4-2,-sup-thick]) cube([cardwdiv/2, cardldiv+4, sup+thick-0.1]);
            translate([0,cardldiv*4-2,-sup-thick]) cube([cardwdiv/2, cardldiv+4, sup+thick-0.1]);
            hull(){
            translate([0,cardldiv*4-2,-sup-thick]) cube([cardwdiv/2, cardldiv+4, 1]);
            translate([cardwdiv*4.5,cardldiv-2,-sup-thick]) cube([cardwdiv/2, cardldiv+4, 1]);}
            hull(){
                translate([0,cardldiv-2,-sup-thick]) cube([cardwdiv/2, cardldiv+4, 1]);
                translate([cardwdiv*4.5,cardldiv*4-2,-sup-thick]) cube([cardwdiv/2, cardldiv+4, 1]);}
            translate([cardwdiv*2-2,cardldiv*2.65,-sup-thick]) cube([cardwdiv+4, cardldiv/1.5, sup+thick-0.1]);
        }
        
    difference(){
    union(){
        translate([-thick,cardldiv-0.7,-thick]) cube([cardw+thick*2,cardldiv+1.4,cardh+thick]);
        translate([-thick,cardldiv*4-0.7,-thick]) cube([cardw+thick*2,cardldiv+1.4,cardh+thick]);
        translate([cardwdiv*2-0.7,cardldiv,-thick]) cube([cardwdiv+1.4,cardl-cardldiv+thick,cardh+thick*2]);
    }
    translate([0,-5,0]) cube([cardw,cardl+5,cardh+5]);
    translate([cardw+thick*1.4,cardldiv*5-cardldiv/5,cardh-thick*1.5]) rotate([90,0,0]) cylinder($fn = 100, r = thick, h = cardldiv*4-2*(cardldiv/5));
    translate([-thick*1.4,cardldiv*5-cardldiv/5,cardh-thick*1.5]) rotate([90,0,0]) cylinder($fn = 100, r = thick, h = cardldiv*4-2*(cardldiv/5));
    }
}}
