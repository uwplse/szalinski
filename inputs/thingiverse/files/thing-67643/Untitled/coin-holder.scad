coin_d	=	26.4 + 1;
coin_r	=	coin_d / 2;
coin_h	=	2;

buffer	=	0.75;

card_w	=	(3 * coin_d) + (5 * buffer);	//86
card_l	=	(2 * coin_d) + (3 * buffer);	//56
card_h	=	coin_h;	//2

difference() {
	cube([card_w, card_l, card_h]);

	translate([coin_r+buffer, coin_r+buffer, -1]){
		cylinder(r1=coin_r-0.1, r2=coin_r+0.05, h=4);
	}
	translate([coin_r+buffer, card_l-coin_r-buffer, -1]){
		cylinder(r1=coin_r-0.1, r2=coin_r+0.05, h=4);
	}

	translate([card_w/2, coin_r+buffer, -1]){
		cylinder(r1=coin_r-0.1, r2=coin_r+0.05, h=4);
	}
	translate([card_w/2, card_l-coin_r-buffer, -1]){
		cylinder(r1=coin_r-0.1, r2=coin_r+0.05, h=4);
	}

	translate([card_w-coin_r-buffer, coin_r+buffer, -1]){
		cylinder(r1=coin_r-0.1, r2=coin_r+0.05, h=4);
	}
	translate([card_w-coin_r-buffer, card_l-coin_r-buffer, -1]){
		cylinder(r1=coin_r-0.1, r2=coin_r+0.05, h=4);
	}
}