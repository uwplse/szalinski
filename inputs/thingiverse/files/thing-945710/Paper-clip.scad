/* [Main Parameters] */
Letter_or_word="Clip";
font_size=8;//[3:0.2:30]
font="Lobster";//[Alfa Slab One,Anton,Architects Daughter,Bangers,Black Ops One,Bubblegum Sans,Cherry Cream Soda,Courgette,Damion,Droid Serif,Electrolize,Exo,Fjalla One,Fredoka One,Great Vibes,Josefin Slab,Julius Sans One,Liberation Sans,Lobster,Luckiest Guy,Marck Script,Montserrat,Nunito,Orbitron,Oswald, Oxygen,Pacifico,Patua One,Passion One,Paytone One,Permanent Marker,Poiret One,Press Start 2P,Quicksand,Righteous,Rock Salt,Rokkitt,Russo One,Satisfy,Shadows Into Light,Sigmar One,Signika,Syncopate,Walter Turncoat]
place_adjustment=0;//[-5:0.5:5]
rotate=0;//[0:359]
// in millimeters
thickness=2;//[0.6:0.1:3.4]
/* [Header] */
header_text="";
header_font_size=5;//[2:0.2:20]
header_font="Lobster";//[Alfa Slab One,Anton,Architects Daughter,Bangers,Black Ops One,Bubblegum Sans,Cherry Cream Soda,Courgette,Damion,Droid Serif,Electrolize,Exo,Fjalla One,Fredoka One,Great Vibes,Josefin Slab,Julius Sans One,Liberation Sans,Lobster,Luckiest Guy,Marck Script,Montserrat,Nunito,Orbitron,Oswald, Oxygen,Pacifico,Patua One,Passion One,Paytone One,Permanent Marker,Poiret One,Press Start 2P,Quicksand,Righteous,Rock Salt,Rokkitt,Russo One,Satisfy,Shadows Into Light,Sigmar One,Signika,Syncopate,Walter Turncoat]
header_place_adjustment=0;//[-5:0.5:5]
header_rotate=0;//[0:359]
/* [Footer] */
footer_text="";
footer_font_size=5;//[2:0.2:20]
footer_font="Lobster";//[Alfa Slab One,Anton,Architects Daughter,Bangers,Black Ops One,Bubblegum Sans,Cherry Cream Soda,Courgette,Damion,Droid Serif,Electrolize,Exo,Fjalla One,Fredoka One,Great Vibes,Josefin Slab,Julius Sans One,Liberation Sans,Lobster,Luckiest Guy,Marck Script,Montserrat,Nunito,Orbitron,Oswald, Oxygen,Pacifico,Patua One,Passion One,Paytone One,Permanent Marker,Poiret One,Press Start 2P,Quicksand,Righteous,Rock Salt,Rokkitt,Russo One,Satisfy,Shadows Into Light,Sigmar One,Signika,Syncopate,Walter Turncoat]
footer_place_adjustment=0;//[-5:0.5:5]
footer_rotate=0;//[0:359]
/* [Hidden] */
// preview[view:south, tilt:top]
union(){difference(){clip();translate([0,-1.2,0])cylinder(h=5,d=28,$fn=100);}
difference(){clip();
translate([-0.25,7+header_place_adjustment,thickness-0.4])rotate([0,0,header_rotate])linear_extrude(height=thickness, center=false)
text(header_text, halign="center", valign="center", font=header_font, size=header_font_size);
translate([-0.25,-1.5+place_adjustment,thickness-0.4])rotate([0,0,rotate])linear_extrude(height=thickness, center=false)
text(Letter_or_word, halign="center", valign="center", font=font, size=font_size);
translate([-0.25,-8.5+footer_place_adjustment,thickness-0.4])rotate([0,0,footer_rotate])linear_extrude(height=thickness, center=false)
text(footer_text, halign="center", valign="center", font=footer_font, size=footer_font_size);
    }}
module blank(){
difference(){union(){
difference(){difference(){
union(){cylinder(h=thickness,d=35,$fn=100);
translate([0,-17,0])cylinder(h=thickness,d=3,$fn=100);}
difference(){cylinder(h=4,d=33,$fn=100);
translate([0,-1,0])cylinder(h=5,d=30,$fn=100);}}}
difference(){difference(){translate([-4,11,0])cube([8,6,thickness]);
translate([-4,14.75,0])cylinder(h=4,d=2.6,$fn=100);
translate([4,14.75,0])cylinder(h=4,d=2.6,$fn=100);}}}
translate([0,14.5,0])hull(){translate([-1,1,0])cube([2,2,3]);
cylinder(h=3,d=2,$fn=100);}}}
module clip(){
union(){difference(){blank();
translate([-4,14.5,0])cube([8,4,5]);}
intersection(){blank();
translate([-3.45,14.6,0])cylinder(h=4,d=5,$fn=100);}}
union(){intersection(){blank();
translate([3.45,14.6,0])cylinder(h=4,d=5,$fn=100);}}}