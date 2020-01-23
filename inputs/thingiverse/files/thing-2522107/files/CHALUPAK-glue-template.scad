image_file = "c:\\Logo\\symbol_vertix_K_neg.png";
font="Ladislav:style=BOLD";
size=6;
/* [Hidden] */
$fa = 6;
$fs = 0.5;
image_width = 40;
image_length = 40;

plate_width=49.6;
plate_heigth=16;
plate_thickness=0.6;

text_thickness = 0.8; 
$fn=250;

motif_height = 0.8;

union(){
/*color("Yellow",1){
translate([-8,0,-1]){
    $fn=50;
    minkowski(){    
        cube(size=[plate_width,plate_heigth,plate_thickness], center= true);
        cylinder(r=1,h=0.1);
    };
    };
    };
//*/
color("Yellow",1){
linear_extrude(height=text_thickness, $fn=150){
    text("CHALUPAK", font=font, size=size, halign = "center", valign="center" );
};
};
color("BLACK",1){
translate([0,0,-plate_thickness]){
    linear_extrude(height=plate_thickness, $fn=150){
    offset(r=1){
        text("CHALUPAK", font=font, size=size, halign = "center", valign="center" );
};
};
};
};
};


module bee(h) {
    linear_extrude(height=h)
      polygon([[-2.552513,20.546383],[-4.367219,19.521696],[-5.307253,18.656791],[-0.075773,18.452218],[5.155827,18.452218],[4.524557,19.124566],[3.048671,20.201265],[1.202892,20.832153],[-0.751321,20.964702],[-2.552513,20.546383]]);
    linear_extrude(height=h)
      polygon([[-4.707123,14.997484],[-7.528139,14.418558],[-7.975190,13.905100],[-8.230323,12.985054],[-8.448913,11.444014],[-6.380333,11.676160],[-2.850166,12.090453],[0.918464,12.196722],[4.512248,12.000043],[7.517877,11.505490],[8.058699,11.498281],[8.192877,11.979331],[7.774347,13.623187],[7.232761,14.452563],[6.349348,14.803210],[0.833499,15.128895],[-4.707122,14.997484]]);
    linear_extrude(height=h)
      polygon([[-18.718279,12.101017],[-18.562768,11.049462],[-17.749277,9.413143],[-15.006533,5.834962],[-13.018666,4.129910],[-10.853643,2.821264],[-8.454513,1.854829],[-9.732443,2.930350],[-11.995545,4.710156],[-14.077681,6.895982],[-15.746212,9.208798],[-16.768501,11.369575],[-17.214812,12.350490],[-17.839579,12.602218],[-18.718279,12.101017]]);
    linear_extrude(height=h)
      polygon([[17.192637,12.227218],[16.323517,10.015573],[15.211862,8.216058],[13.579787,6.216636],[11.726635,4.349412],[9.951747,2.946487],[8.640267,1.854829],[10.997397,2.800507],[13.176292,4.133569],[15.275867,6.072577],[18.039856,9.655229],[18.781853,11.141605],[18.903427,12.102607],[18.542216,12.446247],[17.964655,12.594091],[17.428783,12.527347],[17.192637,12.227218]]);
    linear_extrude(height=h)
      polygon([[-4.857123,8.518465],[-7.067903,8.058088],[-8.678683,7.744822],[-8.528083,6.408700],[-8.199452,4.894546],[-6.289272,5.077990],[-0.592431,5.624563],[5.041148,5.300365],[7.935268,5.040487],[8.331378,6.485809],[8.531627,7.719400],[7.237257,8.091265],[1.141014,8.549590],[-4.857123,8.518465]]);
    linear_extrude(height=h)
      polygon([[-3.261393,2.089585],[-5.914583,1.649851],[-6.376556,1.361398],[-5.746343,0.590966],[-5.197163,-0.162803],[-5.114183,-0.744070],[-4.754036,-1.592421],[-3.203153,-3.240732],[-1.264080,-5.535261],[-1.077071,-6.266539],[-1.399973,-6.743364],[-3.274973,-7.111138],[-5.477304,-7.837356],[-9.807122,-10.414052],[-16.869459,-14.551019],[-18.906606,-15.298603],[-20.768854,-15.550333],[-22.414726,-15.530899],[-23.390981,-15.215021],[-23.809118,-14.522029],[-23.780637,-13.371250],[-22.587131,-10.128173],[-20.668577,-7.491309],[-19.557119,-6.563478],[-20.457119,-6.753475],[-24.403509,-7.895346],[-25.658381,-8.627080],[-26.730563,-9.600426],[-28.892638,-12.773088],[-30.174994,-16.334642],[-30.283418,-17.983422],[-29.815044,-19.050802],[-28.683051,-19.625887],[-26.800619,-19.797781],[-24.316131,-19.571260],[-21.561119,-18.597977],[-17.589983,-16.437348],[-11.457123,-12.648790],[-6.009783,-9.240631],[-5.062443,-8.671154],[-3.720073,-9.617340],[-1.853069,-10.532973],[0.117301,-10.808011],[2.011064,-10.446481],[3.648247,-9.452413],[4.767817,-8.440948],[8.805347,-11.022218],[18.032715,-16.672416],[23.133147,-19.203847],[25.566980,-19.717130],[27.763046,-19.759182],[29.426213,-19.357505],[30.261347,-18.539602],[30.283418,-17.042551],[29.767869,-14.952316],[28.852241,-12.687439],[27.674077,-10.666464],[26.485587,-9.256884],[25.101842,-8.257490],[23.187676,-7.488569],[20.407917,-6.770405],[19.840869,-6.747219],[20.726277,-7.623301],[22.247755,-9.530675],[23.326271,-11.827984],[23.755676,-13.915735],[23.662539,-14.693684],[23.329817,-15.194432],[22.311816,-15.531785],[20.791841,-15.584601],[17.492877,-14.899603],[10.292877,-10.744343],[5.400691,-7.832295],[3.031797,-7.065553],[1.647961,-6.780823],[1.140177,-6.289265],[1.095723,-5.672465],[1.408642,-4.982662],[3.424847,-2.913844],[4.862812,-1.481493],[4.964697,-0.736765],[4.900737,-0.158220],[5.546487,0.543368],[6.182307,1.532785],[3.343280,2.070725],[-0.357123,2.360329],[-3.261393,2.089585]]);
    linear_extrude(height=h)
      polygon([[-17.907120,0.621679],[-20.186993,-0.409515],[-21.830545,-1.783364],[-22.605181,-3.228703],[-22.593970,-3.893443],[-22.278308,-4.474369],[-20.258060,-5.436633],[-17.779203,-5.997781],[-17.464590,-5.892602],[-17.948884,-5.412194],[-18.657120,-4.826606],[-18.016252,-3.687194],[-17.136579,-2.619280],[-15.766253,-1.698271],[-14.010463,-0.999347],[-11.607123,-0.965323],[-8.178486,-1.557573],[-4.707123,-3.316204],[-3.657123,-3.977057],[-4.557123,-3.210134],[-7.333943,-1.323586],[-10.573303,0.190373],[-14.364689,0.873406],[-17.907120,0.621679]]);
    linear_extrude(height=h)
      polygon([[10.323527,0.134612],[7.578982,-1.128220],[4.924737,-2.905879],[3.852194,-3.874399],[4.846537,-3.336256],[8.019040,-1.616963],[11.357187,-0.962134],[13.615155,-0.978044],[15.339107,-1.503265],[17.491852,-2.927047],[18.150404,-3.746984],[18.392847,-4.503788],[17.717847,-5.559995],[17.341661,-5.959093],[18.531617,-5.849062],[21.140042,-5.178229],[22.574267,-4.232496],[22.562474,-3.058475],[21.660034,-1.688912],[20.136993,-0.417807],[18.263397,0.460835],[16.370597,0.823164],[14.283045,0.884092],[12.200694,0.651837],[10.323497,0.134612]]);
    linear_extrude(height=h)
      polygon([[-5.982123,-10.221814],[-6.945680,-11.400915],[-7.406003,-12.957883],[-7.019299,-14.321487],[-6.042549,-15.399797],[-4.744043,-15.995446],[-3.392073,-15.911069],[-2.761280,-15.743742],[-2.910683,-16.204434],[-4.801098,-18.028709],[-7.252843,-19.496368],[-8.049773,-19.900159],[-8.307123,-20.421046],[-8.232600,-20.828481],[-7.963651,-20.964702],[-6.570173,-20.423946],[-4.002774,-18.547859],[-2.126583,-16.063154],[-1.221395,-14.645237],[-0.146152,-14.398469],[0.885458,-14.603321],[1.557938,-15.738629],[3.479160,-18.342121],[6.125678,-20.414488],[7.546743,-20.964164],[7.818302,-20.829051],[7.892878,-20.420988],[7.640131,-19.902681],[6.865198,-19.505088],[4.559919,-18.175193],[2.691178,-16.379331],[2.187418,-15.610496],[2.983358,-15.913114],[3.829146,-16.062607],[4.781398,-15.885014],[6.145105,-15.036672],[6.885215,-13.746054],[6.932119,-12.258849],[6.216208,-10.820745],[5.588365,-10.177449],[5.055201,-9.952640],[3.752738,-10.741815],[1.929693,-11.828122],[-0.091922,-12.296056],[-2.095695,-11.855471],[-3.929922,-10.781364],[-5.076536,-9.969260],[-5.982122,-10.221763]]);
}
//**************************************
translate([-23.8,0,0]) scale([.23, .23, 1]) rotate([0,0,180]) bee(motif_height);
color("BLACK",1){
translate([-30.5,-4,-plate_thickness]){
minkowski(){
    cube([13.5,8,0.6], center=$false);
    cylinder(r=1,h=0.1);
};
};
};
