//Mount for WLANThermo Nano, Mini, MiniV2
//Fully configurable
//(c)Armin Thinnes, Juni 2018
//Find more about the fine BBQ-thermometre at https://www.wlanthermo/de and visit the forum: https://forum.wlanthermo.de


// customizing starts here
bodenstaerke=6; //bottom thickness, 4mm minimum to allow hexnut to sit flat below thermometer
wandstaerke=3; //wall thicknes
haltenase=1.5; //retension size
breite=105; // width of thermometer (flat side to flat side, NOT diagonal!) 105 for mini and mini V2, 60 for Nano
hoehe=36.5; //height of thermometer (thickness), 36.5 for Mini and Mini V2, 18 for Nano
toleranz=0.5; //tolerance allows play inside mount. 0.5 is a good start
name="WLANThermo";//Enter any Text to show up on surface
// customizing ends here

/* [Hidden] */
$fn=100;
basisradius=25; //base radius do not change!
basisbreite=105; //base width do not change!


radius=basisradius*breite/basisbreite;
ausschnitt=breite-2*radius;
breite_klammer=breite+2*wandstaerke+2*toleranz;
hoehe_klammer=hoehe+toleranz+bodenstaerke+haltenase;
breite_einlass=breite_klammer-2*(wandstaerke+haltenase);

radius_klammer=radius*breite_klammer/breite; 
radius_einlass=radius*breite_einlass/breite;

thermo=[breite+2*toleranz,hoehe+toleranz,radius];
klammer=[breite_klammer,hoehe_klammer,radius_klammer];
einlass=[breite_einlass, 2*haltenase, radius_einlass];



module hexnut() {
cube([3.1,7.5,3],center=true);
rotate(45,0,0) cube([3.1,7.5,3], center=true);
rotate(90,0,0) cube([3.1,7.5,3], center=true);
rotate(135,0,0) cube([3.1,7.5,3], center=true);
}


module rundeEcken(size)
{
x = size[0];
y = size[0];
z = size[1];
radius= size[2];    

linear_extrude(height=z)
hull()
{
    // place 4 circles in the corners, with the given radius
    translate([(-x/2)+(radius), (-y/2)+(radius), 0])
    circle(r=radius);

    translate([(x/2)-(radius), (-y/2)+(radius), 0])
    circle(r=radius);

    translate([(-x/2)+(radius), (y/2)-(radius), 0])
    circle(r=radius);

    translate([(x/2)-(radius), (y/2)-(radius), 0])
    circle(r=radius);
}

}
difference(){

rundeEcken(klammer);
translate([0,0,bodenstaerke])rundeEcken(thermo);
translate([0,0,bodenstaerke+hoehe])rundeEcken(einlass); 
translate( [0,0,(hoehe+toleranz+haltenase)/2+bodenstaerke]) cube([breite_klammer,ausschnitt,hoehe+toleranz+haltenase], center=true);    
translate( [0,0,(hoehe+toleranz+haltenase)/2+bodenstaerke]) cube([ausschnitt,breite_klammer,hoehe+toleranz+haltenase], center=true);   
translate([0,0,bodenstaerke-1.5]) hexnut();
 cylinder(d=4.5, h=bodenstaerke);
    translate ([0,-breite/3,bodenstaerke-2]) linear_extrude(height=2)
text(name, font = "Comic Sans MS:style=Bold Italic", halign="center", size=breite/10);     
};


