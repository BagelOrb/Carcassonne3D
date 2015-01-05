$fs=0.4;$fa=5;

//Layer heights:
//Grass     0.0-1.0mm
//Roads     1.0-1.3mm
//Shields   1.3-1.6mm
//City      1.6-2.0mm
//Buildings 2.0-100mm
//translate([-25,-25,-0.5]) color([1,0,0]) cube([50,50,1.6]);

//Helper modules

module bottom(top=0,right=0,bottom=0,left=0,shield=0) {
	//translate([0,0,-1]) scale([1,1,2]) 
		bottom_o(top,right,bottom,left,shield);
	
}
module bottom_o(top=0,right=0,bottom=0,left=0,shield=0) {
	render() difference() {
		union() {
			cube([40, 40, 1],center=true);
			translate([0,-10,0]) cube([44, 5, 1],center=true);
			translate([0, 10,0]) cube([44, 5, 1],center=true);
			translate([-10,0,0]) cube([5, 44, 1],center=true);
			translate([ 10,0,0]) cube([5, 44, 1],center=true);
			if (top == 3) translate([20,10,0]) rotate(a=45, v=[0,0,1]) cube([sqrt(2)*5, sqrt(2)*5,1],center=true);
			if (bottom == 3) translate([-20,-10,0]) rotate(a=45, v=[0,0,1]) cube([sqrt(2)*5, sqrt(2)*5,1],center=true);
			if (right == 3) translate([-10, 20,0]) rotate(a=45, v=[0,0,1]) cube([sqrt(2)*5, sqrt(2)*5,1],center=true);
			if (left == 3) translate([ 10,-20,0]) rotate(a=45, v=[0,0,1]) cube([sqrt(2)*5, sqrt(2)*5,1],center=true);

			
		}
		if (top == 0) translate([25,  0,0]) cube([10,50,10],center=true);
		if (top == 1) translate([25, 10,0]) cube([14.4, 5.4,10],center=true);
		if (top == 2) translate([25,-10,0]) cube([14.4, 5.4,10],center=true);
		if (top == 3) translate([20,-10,0]) rotate(a=45, v=[0,0,1]) cube([sqrt(2)*5, sqrt(2)*5,10],center=true);

		if (bottom == 0) translate([-25,  0,0]) cube([10,50,10],center=true);
		if (bottom == 1) translate([-25,-10,0]) cube([14.4, 5.4,10],center=true);
		if (bottom == 2) translate([-25, 10,0]) cube([14.4, 5.4,10],center=true);
		if (bottom == 3) translate([-20, 10,0]) rotate(a=45, v=[0,0,1]) cube([sqrt(2)*5, sqrt(2)*5,10],center=true);

		if (right == 0) translate([  0, 25,0]) cube([50,10,10],center=true);
		if (right == 1) translate([-10, 25,0]) cube([ 5.2,14.4,10],center=true);
		if (right == 2) translate([ 10, 25,0]) cube([ 5.2,14.4,10],center=true);
		if (right == 3) translate([ 10, 20,0]) rotate(a=45, v=[0,0,1]) cube([sqrt(2)*5, sqrt(2)*5,10],center=true);

		if (left == 0) translate([  0,-25,0]) cube([50,10,10],center=true);
		if (left == 1) translate([ 10,-25,0]) cube([ 5.2,14.4,10],center=true);
		if (left == 2) translate([-10,-25,0]) cube([ 5.2,14.4,10],center=true);
		if (left == 3) translate([-10,-20,0]) rotate(a=45, v=[0,0,1]) cube([sqrt(2)*5, sqrt(2)*5,10],center=true);
		
		if (shield) translate([13-(5*(shield-1)),13,0.5]) {
			linear_extrude(height = 0.8,center=true) difference() {
				intersection() {
					translate([0,2,0]) circle(r=5);
					translate([0,-2,0]) circle(r=5);
				}
				translate([5.5,0]) circle(r=5);
			}
		}
	}
		if (shield) translate([13-(5*(shield-1)),13,0.5]) {
			%linear_extrude(height = 10,center=true) difference() {
				intersection() {
					translate([0,2,0]) circle(r=5);
					translate([0,-2,0]) circle(r=5);
				}
				translate([5.5,0]) circle(r=5);
			}
		}
}

module singleCityWall() {
	render() intersection() {
		translate([0,0,1]) bottom(1,0,0,0);
		translate([ 40,0,0]) cylinder(r=30,h=10,$fn=22);
	}
	roundCityWall();
}

module roundCityWall() {
	render(convexity=2) intersection() {
		union() {
			difference() {
				translate([ 40,0,0]) cylinder(r=30,h=8,$fn=22);
				translate([ 40,0,0]) cylinder(r=28,h=12,$fn=22);
				for(i=[0:10])
					translate([ 40,0,8]) rotate([0,0,360/22*(0.5+i)]) cube([60,3,2],center=true);
			}
			translate([ 20, 20]) cylinder(r=3,h=9);
			translate([ 20,-20]) cylinder(r=3,h=9);
		}
		cube([40,40,40],center=true);
	}
}

module wallTower(rot=10,type=0) {
	translate([40,0,0]) rotate(rot) translate([-28,0,0]) difference() {
		union() {
			cylinder(r=3,h=10,$fn=8);
			if (type == 0) {
				translate([0,0,10]) cylinder(r1=3,r2=4,h=2,$fn=8);
				translate([0,0,12]) cylinder(r=4,h=2,$fn=8);
			}
			if (type == 1) {
				translate([0,0,10]) cylinder(r1=3.5,r2=1,h=5,$fn=8);
			}
		}
		if (type == 0) {
			translate([0,0,12]) cylinder(r=2.7,h=4,$fn=8);
			for(i=[0:3]) translate([0,0,14]) rotate(360/16+i*360/8) cube([20,0.8,2],center=true);
		}
	}
}

module cornerWall(shield=0) {
	render() difference() {
		intersection() {
			color([0.7,0.7,0.7]) translate([0,0,1]) bottom(1,1,0,0, shield);
			union() {
				rotate([0,0,90]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
				rotate([0,0, 0]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
				difference() {
					cube([20,20,10]);
					cylinder(r=11,h=10,$fn=12);
				}
			}
		}
	}
	render() difference() {
		union() {
			roundCityWall();
			rotate(90) roundCityWall();
		}
		cube([25,25,20]);
	}

	render(convexity=2) intersection() {
		union() {
			difference() {
				translate([ 0,0,0]) cylinder(r=12,h=8,$fn=12);
				translate([ 0,0,0]) cylinder(r=10,h=12,$fn=12);
				for(i=[0:2])
					translate([ 0,0,8]) rotate([0,0,360/12*(0.5+i)]) cube([60,3,2],center=true);
			}
		}
		cube([40,40,40]);
	}
}

module road(seed=0, length=40) {
	d = [[0,0],[10, 1],[length-10, 1],[length, 0]];

	off1 = rands(-10,10,3, seed)[0];
	off2 = rands(-10,10,3, seed)[1];
	off3 = rands(-30,30,3, seed)[2];
	scale3 = rands(1,3,1, seed+1)[0];

	linear_extrude(height=0.8) intersection() {
		translate([0,-20]) for(i=[0:length-1]) hull() {
			translate([sin(i*off1)*2*sign(off3)*lookup(i,d)+sin(i*off2)*2*sign(off3)*lookup(i,d)+sin(i*off3)*scale3*lookup(i,d),i]) circle(r=1);
			translate([sin((i+1)*off1)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off2)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off3)*scale3*lookup((i+1),d),(i+1)]) circle(r=1);
		}
		square([40,40],center=true);
	}
}

module roadCorner(seed=2) {
	a = [[0,0],[10,10],[20,10],[30,10]];
	b = [[0,0],[10, 0],[20,10],[30,10]];
	c = [[0,0],[10, 0],[20, 0],[30,10]];
	d = [[0,0],[10, 1],[20, 1],[30, 0]];

	off1 = rands(-30,30,3, seed)[0];
	off2 = rands(-30,30,3, seed)[1];
	off3 = rands(-50,50,3, seed)[2];
	scale3 = rands(1,10,1, seed+1)[0];

	linear_extrude(height=0.8) intersection() {
		translate([-20,-20]) for(i=[0:29]) hull() {
			translate([10,lookup(i,a)]) rotate(lookup(i,b)*9) translate([10+sin(i*off1)*2*sign(off3)*lookup(i,d)+sin(i*off2)*2*sign(off3)*lookup(i,d)+sin(i*off3)*scale3*lookup(i,d),lookup(i,c)]) circle(r=1);
			translate([10,lookup((i+1),a)]) rotate(lookup((i+1),b)*9) translate([10+sin((i+1)*off1)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off2)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off3)*scale3*lookup((i+1),d),lookup((i+1),c)]) circle(r=1);
		}
		square([40,40],center=true);
	}
}

module house() {
	render() scale(0.3) translate([0,0,4]) union() {
		difference() {
			cube([7,15,8],center=true);
			translate([4,3,0]) cube([3,5,2],center=true);
			translate([-4,-3,0]) cube([3,5,2],center=true);
			translate([-4,3,-2]) cube([3,3,5],center=true);
			translate([4,-4,0]) cube([3,3,2],center=true);
		}
		translate([0,0,5.2]) rotate([0,-90,90]) cylinder(h=16,r=5,center=true,$fn=3);
	}
}

module cloister() {
	difference() {
		union() {
			translate([0,-2,3.5]) cube([7,15,7],center=true);
			translate([-2,5,6]) cube([7,7,12],center=true);
			translate([-2,5,12]) rotate([0,0,45]) cylinder(r1=5.5,r2=1,h=5,$fn=4);
			translate([ 2,5,4.5]) cube([4,4,9],center=true);
			translate([ 2,5,9]) rotate([0,0,45]) cylinder(r1=3.5,r2=1,h=2,$fn=4);
	
			hull() {
				translate([ 0,3,7]) rotate([0,0,45]) cylinder(r1=5.5,r2=1,h=3,$fn=4);
				translate([ 0,-6,7]) rotate([0,0,45]) cylinder(r1=5.5,r2=1,h=3,$fn=4);
			}
		}
		hull() {
			translate([-2,9,0]) cube(2,center=true);
			translate([-2,9,5]) rotate([90,0,0]) cylinder(r=1,h=2,center=true);
		}
		translate([-2,9,9]) rotate([90,0,0]) cylinder(r=1,h=2,center=true);
		for(i=[0:2]) translate([-6,5,6+i*2]) cube([2,3,1],center=true);

		for(i=[0:2]) hull() {
			translate([-3.5,i*-3.5,3]) cube(2,center=true);
			translate([-3.5,i*-3.5,5]) rotate([90,0,90]) cylinder(r=1,h=2,center=true);
		}
		for(i=[0:2]) hull() {
			translate([ 3.5,i*-3.5,3]) cube(2,center=true);
			translate([ 3.5,i*-3.5,5]) rotate([90,0,90]) cylinder(r=1,h=2,center=true);
		}
		hull() {
			translate([0,-10,2.5]) cube([3,2,2],center=true);
			translate([0,-10,4.5]) rotate([90,0,0]) cylinder(r=1.5,h=2,center=true);
		}
	}
}

/* tile modules */

module cccc(seed=5) {
	color([0.3,0.7,0.3]) bottom(1,1,1,1);
	color([0.7,0.7,0.7]) translate([0,0,1]) bottom(1,1,1,1, 1);
	offX = rands(-1.5,1.5,7*7,seed);
	offY = rands(-1.5,1.5,7*7,seed+1);
	rots = rands(0,360,7*7,seed+2);
	for(x=[-3:3])
		for(y=[-3:3])
			if (x < 2 || y < 2)
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

//cccf x3 +x1 shield
module cccf(seed=0, shield=0) {
	color([0.3,0.7,0.3]) bottom(1,1,1,0);
	render() difference() {
		color([0.7,0.7,0.7]) translate([0,0,1]) bottom(1,1,1,0, shield);
		rotate([0,0,-90]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
	}
	offX = rands(-1.5,1.5,7*7,seed);
	offY = rands(-1.5,1.5,7*7,seed+1);
	rots = rands(0,360,7*7,seed+2);
	rotate([0,0,-90]) roundCityWall();
	if (seed == 1) rotate([0,0,-90]) wallTower(10,0);
	if (seed == 2) rotate([0,0,-90]) wallTower(-20,0);
	if (seed == 3) rotate([0,0,-90]) wallTower(15,1);
	for(x=[-3:3])
		for(y=[-2:3])
			if (((x < 2 || y < 2) || !shield) && (y > -2 || abs(x) == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

//cccr x1 +x2 shield
module cccr(seed=10, shield=0) {
	color([0.3,0.7,0.3]) bottom(1,1,1,2);
	render() difference() {
		color([0.7,0.7,0.7]) translate([0,0,1]) bottom(1,1,1,2, shield);
		rotate([0,0,-90]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
	}
	offX = rands(-1.5,1.5,7*7,seed);
	offY = rands(-1.5,1.5,7*7,seed+1);
	rots = rands(0,360,7*7,seed+2);
	rotate([0,0,-90]) roundCityWall();
	for(x=[-3:3])
		for(y=[-2:3])
			if (((x < 2 || y < 2) || !shield) && (y > -2 || abs(x) == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
	road(seed+3);
}

//ccff x3, +x2 shield
module ccff(seed=0,shield=0) {
	color([0.3,0.7,0.3]) bottom(1,1,0,0);
	cornerWall(shield);

	if (seed == 1) wallTower(20);
	if (seed == 2) rotate(90) wallTower(-15, 1);
	
	if (seed == 10) rotate(90) wallTower(-20);
	if (seed == 10) wallTower(5);
	if (seed == 11) rotate(90) wallTower(0, 1);

	offX = rands(-1.5,1.5,7*7,seed);
	offY = rands(-1.5,1.5,7*7,seed+1);
	rots = rands(0,360,7*7,seed+2);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((((x > -2 && (x < 2)) || (y > -2 && y < 2)) && (x == 3 || y == 3))
				|| (!shield && x > 1 && y > 1))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

//ccff_alt x2
module ccff_alt(seed=0) {
	color([0.3,0.7,0.3]) bottom(1,1,0,0);
	singleCityWall();
	rotate([0,0,90]) singleCityWall();

	if (seed == 2) wallTower(-35);

	offX = rands(-1.5,1.5,7*7,seed);
	offY = rands(-1.5,1.5,7*7,seed+1);
	rots = rands(0,360,7*7,seed+2);
	for(x=[-3:3])
		for(y=[-3:3])
			if (((x > -2 && x < 2) || (y > -2 && y < 2)) && (x == 3 || y == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

module ccrr(seed=0, shield=0) {
	color([0.3,0.7,0.3]) bottom(1,1,2,2);
	cornerWall(shield);

	if (seed == 1) wallTower(10);
	if (seed == 2) rotate(90) wallTower(-10, 1);

	if (seed == 11) wallTower(10);
	if (seed == 11) rotate(90) wallTower(-10);

	offX = rands(-1.5,1.5,7*7,seed+20);
	offY = rands(-1.5,1.5,7*7,seed+21);
	rots = rands(0,360,7*7,seed+22);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((((x > -2 && (x < 2)) || (y > -2 && y < 2)) && (x == 3 || y == 3))
				|| (!shield && x > 1 && y > 1))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
	roadCorner(seed+23);
}

module cfcf(seed=0,shield=0) {
	color([0.3,0.7,0.3]) bottom(0,1,0,1);

	rotate([0,0,  0]) roundCityWall();
	rotate([0,0,180]) roundCityWall();

	if (seed == 10) wallTower(10);
	if (seed == 10) rotate(180) wallTower(15);
	if (seed == 11) wallTower(25, 1);
	if (seed == 11) wallTower(-25, 1);

	render() difference() {
		if (shield) color([0.7,0.7,0.7]) translate([0,0,1]) bottom(0,1,0,1, 2);
		else color([0.7,0.7,0.7]) translate([0,0,1]) bottom(0,1,0,1, 0);
		rotate([0,0,  0]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
		rotate([0,0,180]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
	}

	offX = rands(-1.5,1.5,7*7,seed);
	offY = rands(-1.5,1.5,7*7,seed+1);
	rots = rands(0,360,7*7,seed+2);
	for(x=[-3:3])
		for(y=[-3:3])
			if (x>-3&&x<3 && ((x>-2&&x<2) || y>2 || y<-2) && (!shield || x<1||y<2))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

//cfcf_alt x3
module cfcf_alt(seed=0) {
	color([0.3,0.7,0.3]) bottom(1,0,1,0);

	singleCityWall();
	rotate([0,0,180]) singleCityWall();

	if (seed == 1) wallTower(15);
	if (seed == 2) wallTower(20, 1);
	if (seed == 2) rotate(180) wallTower(25);

	offX = rands(-1.5,1.5,7*7,seed+20);
	offY = rands(-1.5,1.5,7*7,seed+21);
	rots = rands(0,360,7*7,seed+22);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3 || x == -3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

//cfff x3
module cfff(seed=0) {
	color([0.3,0.7,0.3]) bottom(1,0,0,0);
	singleCityWall();

	if (seed == 1) wallTower(15);
	if (seed == 2) wallTower(-10);
	if (seed == 3) wallTower(20, 1);
	if (seed == 4) wallTower( 15);
	if (seed == 4) wallTower(-15);

	offX = rands(-1.5,1.5,7*7,seed+30);
	offY = rands(-1.5,1.5,7*7,seed+31);
	rots = rands(0,360,7*7,seed+32);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

module cfrr(seed=0) {
	color([0.3,0.7,0.3]) bottom(1,2,2,0);
	singleCityWall();
	rotate([0,0,-90]) roadCorner(seed+115);

	if (seed == 1) wallTower(15);
	if (seed == 2) wallTower(-10, 1);

	offX = rands(-1.5,1.5,7*7,seed+40);
	offY = rands(-1.5,1.5,7*7,seed+41);
	rots = rands(0,360,7*7,seed+42);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

module crfr(seed=0) {
	color([0.3,0.7,0.3]) bottom(1,2,0,2);
	singleCityWall();
	road(seed+215);

	if (seed == 1) wallTower( 20, 1);
	if (seed == 1) wallTower(-20, 1);
	if (seed == 2) wallTower(-5);
	if (seed == 3) wallTower( 5, 1);

	offX = rands(-1.5,1.5,7*7,seed+50);
	offY = rands(-1.5,1.5,7*7,seed+51);
	rots = rands(0,360,7*7,seed+52);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

module crrf(seed=0) {
	color([0.3,0.7,0.3]) bottom(1,0,2,2);
	singleCityWall();
	roadCorner(seed+145);

	if (seed == 1) wallTower( 30);
	if (seed == 1) wallTower(-10);
	if (seed == 2) wallTower( 30);
	if (seed == 2) wallTower( 10);
	if (seed == 2) wallTower(-20);

	offX = rands(-1.5,1.5,7*7,seed+60);
	offY = rands(-1.5,1.5,7*7,seed+61);
	rots = rands(0,360,7*7,seed+62);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

module crrr(seed=0) {
	color([0.3,0.7,0.3]) bottom(1,2,2,2);
	singleCityWall();

	road(seed+115, 17);
	rotate(-90) road(seed+126, 17);
	rotate(180) road(seed+137, 17);

	if (seed == 0) {
		translate([3,-1,0.5]) rotate(20) house();
		translate([-4,-5,0.5]) rotate(170) house();
		translate([-5,4,0.5]) rotate(110) house();
	}
	if (seed == 1) {
		wallTower( 15);
		wallTower(-15);

		translate([3,1,0.5]) rotate(10) house();
		translate([-5,-4,0.5]) rotate(210) house();
		translate([-4,4,0.5]) rotate(120) house();
	}
	if (seed == 2) {
		translate([-12,0,0]) wallTower(0);
	}

	offX = rands(-1.5,1.5,7*7,seed+70);
	offY = rands(-1.5,1.5,7*7,seed+71);
	rots = rands(0,360,7*7,seed+72);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

module ffff(seed=0) {
	color([0.3,0.7,0.3]) bottom(0,0,0,0);
	rot = rands(0,360,seed+1,seed+83)[seed];
	rotate(rot) translate([0,0,0.5]) cloister();
}

module fffr(seed=0) {
	color([0.3,0.7,0.3]) bottom(0,0,0,2);
	translate([-3,0,0]) rotate(180) cloister();
	intersection() {
		road(seed+312);
		translate([-20,-20]) cube([40,20,20]);
	}
}

module ffrr(seed=0) {
	color([0.3,0.7,0.3]) bottom(0,0,2,2);
	roadCorner(seed+300);
}

module frfr(seed=0) {
	color([0.3,0.7,0.3]) bottom(0,2,0,2);
	road(seed+400);
}

module frrr(seed=0) {
	color([0.3,0.7,0.3]) bottom(0,2,2,2);

	road(seed+420, 17);
	rotate(-90) road(seed+430, 17);
	rotate(180) road(seed+440, 17);
}

module rrrr(seed=0) {
	color([0.3,0.7,0.3]) bottom(2,2,2,2);

	road(seed+450, 17);
	rotate( 90) road(seed+460, 17);
	rotate(-90) road(seed+470, 17);
	rotate(180) road(seed+480, 17);
}

//Testing a single tile
//cccf(0);

module plate1() {
	translate([  0,  0]) cccc();
	translate([ 50,  0]) cccf(0,0);
	translate([100,  0]) cccf(1,0);
	translate([150,  0]) cccf(2,0);

	translate([  0, 50]) cccf(3,1);
	translate([ 50, 50]) cccr(10,0);
	translate([100, 50]) cccr(16,1);
	translate([150, 50]) cccr(4,1);

	translate([  0,100]) ccff(0,0);
	translate([ 50,100]) ccff(1,0);
	translate([100,100]) ccff(2,0);
	translate([150,100]) ccff(10,1);

	translate([  0,150]) ccff(11,1);
	translate([ 50,150]) ccff_alt(1,0);
	translate([100,150]) ccff_alt(2,0);
	translate([150,150]) ccrr(0,0);
}

module plate2() {
	translate([  0,  0]) ccrr(1,0);
	translate([ 50,  0]) ccrr(2,0);
	translate([100,  0]) ccrr(10,1);
	translate([150,  0]) ccrr(11,1);

	translate([  0, 50]) cfcf(0,0);
	translate([ 50, 50]) cfcf(10,1);
	translate([100, 50]) cfcf(11,1);
	translate([150, 50]) cfcf_alt(0);

	translate([  0,100]) cfcf_alt(1);
	translate([ 50,100]) cfcf_alt(2);
	translate([100,100]) cfff(0);
	translate([150,100]) cfff(1);

	translate([  0,150]) cfff(2);
	translate([ 50,150]) cfff(3);
	translate([100,150]) cfff(4);
	translate([150,150]) cfrr(0);
}

module plate3() {
	translate([  0,  0]) cfrr(1);
	translate([ 50,  0]) cfrr(2);
	translate([100,  0]) crfr(0);
	translate([150,  0]) crfr(1);

	translate([  0, 50]) crfr(2);
	translate([ 50, 50]) crfr(3);
	translate([100, 50]) crrf(0);
	translate([150, 50]) crrf(1);

	translate([  0,100]) crrf(2);
	translate([ 50,100]) crrr(0);
	translate([100,100]) crrr(1);
	translate([150,100]) crrr(2);

	translate([  0,150]) ffff(0);
	translate([ 50,150]) ffff(1);
	translate([100,150]) ffff(2);
	translate([150,150]) ffff(3);
}

module plate4() {
	translate([  0,  0]) fffr(0);
	translate([ 50,  0]) fffr(1);
	translate([100,  0]) ffrr(0);
	translate([150,  0]) ffrr(1);

	translate([  0, 50]) ffrr(2);
	translate([ 50, 50]) ffrr(3);
	translate([100, 50]) ffrr(4);
	translate([150, 50]) ffrr(5);

	translate([  0,100]) ffrr(6);
	translate([ 50,100]) ffrr(7);
	translate([100,100]) ffrr(8);
	translate([150,100]) frfr(0);

	translate([  0,150]) frfr(1);
	translate([ 50,150]) frfr(2);
	translate([100,150]) frfr(3);
	translate([150,150]) frfr(4);
}

module plate5() {
	translate([  0,  0]) frfr(5);
	translate([ 50,  0]) frfr(6);
	translate([100,  0]) frfr(7);
	translate([150,  0]) frrr(0);

	translate([  0, 50]) frrr(2);
	translate([ 50, 50]) frrr(3);
	translate([100, 50]) frrr(4);
	translate([150, 50]) rrrr(5);

	//translate([  0,100]) ????(0);
	//translate([ 50,100]) ????(0);
	//translate([100,100]) ????(0);
	//translate([150,100]) ????(0);

	//translate([  0,150]) ????(0);
	//translate([ 50,150]) ????(0);
	//translate([100,150]) ????(0);
	//translate([150,150]) ????(0);
}

//plate1();
//translate([220,0]) 
//plate2();
//translate([0,220])
//plate3();
//translate([220,220])
//plate4();
//translate([0,440])
//plate5();













module road_mid(seed=0, length=40) {
	d = [[0,0],[5, 1],[length/2, 0],[length-5, 1],[length, 0]];

	off1 = rands(-5,5,3, seed)[0];
	off2 = rands(-5,5,3, seed)[1];
	off3 = rands(-30,30,3, seed)[2];
	scale3 = rands(1,3,1, seed+1)[0];

	linear_extrude(height=0.8) intersection() {
		translate([0,-20]) for(i=[0:length-1]) hull() {
			translate([sin(i*off1)*2*sign(off3)*lookup(i,d)+sin(i*off2)*2*sign(off3)*lookup(i,d)+sin(i*off3)*scale3*lookup(i,d),i]) circle(r=1);
			translate([sin((i+1)*off1)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off2)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off3)*scale3*lookup((i+1),d),(i+1)]) circle(r=1);
		}
		square([40,40],center=true);
	}
}



module road_side(seed=0, length=40) {
	d = [[0,0],[10, 1],[length-10, 1],[length, 0]];

	off1 = rands(-5,5,3, seed)[0];
	off2 = rands(-5,5,3, seed)[1];
	off3 = rands(-30,30,3, seed)[2];
	scale3 = rands(1,3,1, seed+1)[0];

	linear_extrude(height=0.8) intersection() {
		translate([0,-20]) for(i=[0:length-1]) hull() {
			translate([sin(i*off1)*2*sign(off3)*lookup(i,d)+sin(i*off2)*2*sign(off3)*lookup(i,d)+sin(i*off3)*scale3*lookup(i,d),i]) circle(r=1);
			translate([sin((i+1)*off1)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off2)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off3)*scale3*lookup((i+1),d),(i+1)]) circle(r=1);
		}
		square([40,40],center=true);
	}
}





function square(in) = in*in;
function rr(seed, i, length) = (square(rands(0,1,1,seed)[0])+rands(0,1,1,seed+200)[0] -0.5) *i/length *(1 - i/length)* 4 +2;


module riverCorner(seed=2, length = 45) {
	a = [[0,0],[length/3,10],[length/3*2,10],[length,10]];
	b = [[0,0],[length/3, 0],[length/3*2,10],[length,10]];
	c = [[0,0],[length/3, 0],[length/3*2, 0],[length,10]];
	d = [[0,0],[length/3, 1],[length/3*2, 1],[length, 0]];

	off1 = rands(-30,30,3, seed)[0];
	off2 = rands(-30,30,3, seed)[1];
	off3 = rands(-50,50,3, seed)[2];
	scale3 = rands(1,10,1, seed+1)[0];

	linear_extrude(height=0.8) intersection() {
	translate([-20,-20]) 
		for(i=[0:length-1]) hull() {
			translate([10,lookup(i,a)]) rotate(lookup(i,b)*9) translate([10+sin(i*off1)*2*sign(off3)*lookup(i,d)+sin(i*off2)*2*sign(off3)*lookup(i,d)+sin(i*off3)*scale3*lookup(i,d),lookup(i,c)]) circle(r=rr(seed+i,i,length));
			translate([10,lookup((i+1),a)]) rotate(lookup((i+1),b)*9) translate([10+sin((i+1)*off1)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off2)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off3)*scale3*lookup((i+1),d),lookup((i+1),c)]) circle(r=rr(seed+i+1, i+1, length));
		}
		square([40,40],center=true);
	}
}

module riverSplit(seed, pos, angle, size, length, depth, maxdepth) {
	
	r = rands(-40,40,2,seed+875);
	r2 = rands(-5,5,1,seed+875);

	table = [[0,angle], [length/3,angle+r[0]],[length/3*2,angle+r[1]], [length,angle+r2] ];

	l = pow(rands(.3,.5,1, seed+523)[0], 1/(depth+2)) * .7 ;

	
	for(i=[0:length-1]) hull() {
		translate(pos + l*i*size*[sin(lookup(i,table)),cos(lookup(i,table))]) 
		translate(rands(-1,1,2, i)*size/5)
		circle(r=pow(.9,i)*size /2 * rands(.7,1.2,1, i)[0]);
		translate(pos + l*(i+1)*size*[sin(lookup(i+1,table)),cos(lookup(i+1,table))]) 
		translate(rands(-1,1,2, i+1)*size/5)
		circle(r=pow(.9,(i+1))*size /2 * rands(.7,1.2,1, i+1)[0]);
		//if (rands(0,1,1, seed+523)[0] < 0.5 && depth < maxdepth)
		//	extraSplit(seed,i,table,pos,l,size,length,depth,maxdepth);
		
	}

	endAngle = angle + rands(-5,5,1,seed+421)[0];
	//atan2(	
//						length*sin(fa) - (length-1)*sin(lookup(length-1,table)) 
//						,	
//						length*cos(fa) - (length-1)*cos(lookup(length-1,table))
//						 );
	endPos =  pos + l*length*size*[sin(lookup(length,table)),cos(lookup(length,table))];
	if (depth < maxdepth) {
		riverSplit(seed+521, endPos, endAngle-45, .5*size, length+depth*2, depth+1, maxdepth);
		riverSplit(seed+614, endPos, endAngle+30, .5*size, length+depth*2, depth+1, maxdepth);
	}
//rands(-25,-10,1, seed+53)[0]

}

module extraSplit(seed,i,table,pos,l,size,length,depth,maxdepth)
{
	endAngleT = atan2(	
					i*sin(lookup(i,table)) - (i-1)*sin(lookup(i-1,table)) 
					,	
					i*cos(lookup(i,table)) - (i-1)*cos(lookup(i-1,table))
					 );
	endPosT =  pos + l*i*size*[sin(lookup(i,table)),cos(lookup(i,table))];
	riverSplit(seed+51, endPosT, endAngleT+45, .3*size, length, depth+1, maxdepth);
}





function rr2(seed, i, length) = rands(-2,3,1, seed)[0]*i/length*(length-i)/length*2 + 2;

module river(seed=0, length=40) {
	d = [[0,0],[10, 1],[length-10, 1],[length, 0]];

	off1 = rands(-10,10,3, seed)[0];
	off2 = rands(-10,10,3, seed)[1];
	off3 = rands(-30,30,3, seed)[2];
	scale3 = rands(1,3,1, seed+1)[0];

//	translate([0,0,-0.4])
	linear_extrude(height=0.8) intersection() {
		translate([0,-20]) for(i=[0:length-1]) hull() {
			translate([sin(i*off1)*2*sign(off3)*lookup(i,d)+sin(i*off2)*2*sign(off3)*lookup(i,d)+sin(i*off3)*scale3*lookup(i,d),i]) circle(r=rr2(seed+i, i, length));
			translate([sin((i+1)*off1)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off2)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off3)*scale3*lookup((i+1),d),(i+1)]) circle(r=rr2(seed+i+100, i, length));
		}
		square([41,41],center=true);
	}
}

module river_half(seed=0, length=40) {
	d = [[0,0],[10, 1],[length-10, 1],[length, 0]];

	off1 = rands(-10,10,3, seed)[0];
	off2 = rands(-10,10,3, seed)[1];
	off3 = rands(-30,30,3, seed)[2];
	scale3 = rands(1,3,1, seed+1)[0];

//	translate([0,0,-0.4])
	linear_extrude(height=0.8) intersection() {
		translate([0,-20]) for(i=[0:length/2-1]) hull() {
			translate([sin(i*off1)*2*sign(off3)*lookup(i,d)+sin(i*off2)*2*sign(off3)*lookup(i,d)+sin(i*off3)*scale3*lookup(i,d),i]) circle(r=rr2(seed+i, i, length));
			translate([sin((i+1)*off1)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off2)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off3)*scale3*lookup((i+1),d),(i+1)]) circle(r=rr2(seed+i+100, i, length));
		}
		square([41,41],center=true);
	}
}


module bridge() {

	scale([1,.5,1])
	translate([0,0,-7])
	difference() {
	union(){
		rotate([90,0,0]) 
		cylinder(h=10,r=10, center = true);
		translate([0,4,0])
		rotate([90,0,0]) 
		cylinder(h=2,r=11, center = true);
		translate([0,-4,0])
		rotate([90,0,0]) 
		cylinder(h=2,r=11, center = true);

	}
	rotate([90,0,0]) 
	cylinder(h=20,r=9, center = true);
	translate([0,0,-3]) cube([40,40,20], center = true);
	}
}


function mapAngle(a, seed=561) = rands(-5,5,2, seed+53) +[rands(10,30,2, seed+a*37)[0]*sin(a), rands(15,25,2, seed+a*37)[0]*cos(a)];

module lake(seed=0, length=40) {
	points = [
		mapAngle(  0, seed),
		mapAngle( 40, seed),
		mapAngle( 80, seed),
		mapAngle(120, seed),
		mapAngle(160, seed),
		mapAngle(200, seed),
		mapAngle(240, seed),
		mapAngle(280, seed),
		mapAngle(320, seed)
		];
	tableX = [
		[  0, mapAngle( 0, seed)[0] ],
		[ 40, mapAngle(40, seed)[0] ],
		[ 80, mapAngle(80, seed)[0] ],
		[120,mapAngle(120, seed)[0] ],
		[160,mapAngle(160, seed)[0] ],
		[200,mapAngle(200, seed)[0] ],
		[240,mapAngle(240, seed)[0] ],
		[280,mapAngle(280, seed)[0] ],
		[320,mapAngle(320, seed)[0] ],
		[360, mapAngle( 0, seed)[0] ]
		];
	tableY = [
		[  0, mapAngle( 0, seed)[1] ],
		[ 40, mapAngle(40, seed)[1] ],
		[ 80, mapAngle(80, seed)[1] ],
		[120,mapAngle(120, seed)[1] ],
		[160,mapAngle(160, seed)[1] ],
		[200,mapAngle(200, seed)[1] ],
		[240,mapAngle(240, seed)[1] ],
		[280,mapAngle(280, seed)[1] ],
		[320,mapAngle(320, seed)[1] ],
		[360, mapAngle( 0, seed)[1] ]
		];
	r = 10;	

	linear_extrude(height=0.8) {
		union() {
			polygon(points);
			
			for(i=[0: length-1])  {
				assign(s = rands(3,10,1,seed+325+i)[0])
				translate([lookup(i*360/length, tableX)*(1.2-s/20),lookup(i*360/length, tableY)*(1.2-s/20)] + rands(-2,2,2,seed+541)) 
				circle(r=s);
			}
		}
	}

	
}


module fffw(seed=123)
{
	difference() {
		color([0.3,0.7,0.3]) bottom(0,0,0,3);
		
		linear_extrude(height=0.8) 
		riverSplit(seed, pos=[0,-20] , angle=0, size=5, length=8, depth=0, maxdepth=2);
	
	}

}

module fffw_alt(seed=123)
{
	difference() {
		color([0.3,0.7,0.3]) bottom(0,0,0,3);
		scale([.5,.5,1]) lake(seed);
		river_half(seed, 40);
	}

}


module ffww(seed=0) {
	difference() {
		color([0.3,0.7,0.3]) bottom(0,0,3,3);
		riverCorner(seed+300);
	}
}

module fwfw(seed=0) {
	difference() {
		color([0.3,0.7,0.3]) bottom(0,3,0,3);
		river(seed+40);
	}	
}




module rwrw(seed=0) {
	union() {
		difference() {
			
			union(){
				color([0.3,0.7,0.3]) bottom(2,3,2,3);
					rotate([0,0,90])
					road_mid(seed+477,40);
			}
			river(seed+41);
		}	
		bridge();
	}
}


module rrww(seed=127) {
		difference() {
			union(){
				color([0.3,0.7,0.3]) bottom(2,2,3,3);
					rotate([0,0,180])
					roadCorner(seed+7,40);
			}
			riverCorner(seed+41);
		}	
}


module door() {
	union() {
		intersection () {
			translate([0,-2.5,5]) rotate([0,90,0]) cylinder(h=15,r=5);
			translate([0, 2.5,5]) rotate([0,90,0]) cylinder(h=15,r=5);
		}
		translate([0,-2.5,0])	cube([15,5,5]);
	}
}
module cityEntrance(seed=0) {
	singleCityWall();

	translate([-6,0,0]) scale([1.5,1.5,1.3]) wallTower(0,1);

	offX = rands(-1.5,1.5,7*7,seed+30);
	offY = rands(-1.5,1.5,7*7,seed+31);
	rots = rands(0,360,7*7,seed+32);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();

}

module cwrw(seed=1) {

	difference() {
		cityEntrance(seed);
		translate([5,0,1.5]) door();
	}

	union() {
		difference() {
			
			union(){
				color([0.3,0.7,0.3]) bottom(1,3,2,3);
					rotate([0,0,90])
					road_mid(seed+477,40);
			}
			river(seed+41);
		}	
		bridge();
	}
}




module cwcw(seed=0) {
	difference() {
		color([0.3,0.7,0.3]) bottom(1,3,1,3);
		river(seed);
	}

	singleCityWall();
	rotate([0,0,180]) singleCityWall();

	//if (seed == 1) wallTower(15);
	//if (seed == 2) 
	wallTower(0);
	//if (seed == 2) 
	rotate(180) wallTower(0);

	offX = rands(-1.5,1.5,7*7,seed+20);
	offY = rands(-1.5,1.5,7*7,seed+21);
	rots = rands(0,360,7*7,seed+22);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3 || x == -3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}



module ccww(seed=93, shield=0) {
	difference() { 
		color([0.3,0.7,0.3]) bottom(1,1,3,3);
		riverCorner(seed+23);
	}

	cornerWall(shield);

	//if (seed == 1) wallTower(10);
	//if (seed == 2) 
	rotate(90) wallTower(-10, 1);

	//if (seed == 11) wallTower(10);
	//if (seed == 11) rotate(90) wallTower(-10);

	offX = rands(-1.5,1.5,7*7,seed+20);
	offY = rands(-1.5,1.5,7*7,seed+21);
	rots = rands(0,360,7*7,seed+22);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((((x > -2 && (x < 2)) || (y > -2 && y < 2)) && (x == 3 || y == 3))
				|| (!shield && x > 1 && y > 1))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
	

}


module wfwr(seed=0) {
	//color([0.3,0.7,0.3]) bottom(0,0,0,2);
	translate([-13,8,0]) rotate(180) cloister();

	union() {
		difference() {
			
			union(){
				color([0.3,0.7,0.3]) bottom(2,3,0,3);
				rotate([0,0,90])
				intersection() {
					road_side(seed+47,40);
					translate([-20,-20]) cube([40,20,20]);
				}

			}
			river(seed+4351);
		}	
		translate([3,-1,0]) bridge();
	}

}


module plate6() {
	translate([  0,  0]) ffww();
	translate([ 50,  0]) ffww(513);
	translate([100,  0]) fffw();
	translate([150,  0]) fffw_alt();

	translate([  0, 50]) fwfw();
	translate([ 50, 50]) fwfw(32);
	translate([100, 50]) cwcw();
	translate([150, 50]) ccww();

	translate([  0,100]) wfwr();
	translate([ 50,100]) cwrw();
	translate([100,100]) rwrw();
	translate([150,100]) rrww();

	//translate([  0,150]) ????(0);
	//translate([ 50,150]) ????(0);
	//translate([100,150]) ????(0);
	//translate([150,150]) ????(0);
}


//plate6();
fffw_alt();
//ccrr();








