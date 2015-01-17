//Layer heights:
//Grass     0.0-1.0mm
//Roads     1.0-1.3mm
//Shields   1.3-1.6mm
//City      1.6-2.0mm
//Buildings 2.0-100mm
//translate([-25,-25,-0.5]) color([1,0,0]) cube([50,50,1.6]);



	function rr(seed, i, length) = rands(-2,3,1, seed)[0]*i/length*(length-i)/length*2 + 2;

module river(seed=0, length=40) {
	d = [[0,0],[10, 1],[length-10, 1],[length, 0]];

	off1 = rands(-10,10,3, seed)[0];
	off2 = rands(-10,10,3, seed)[1];
	off3 = rands(-30,30,3, seed)[2];
	scale3 = rands(1,3,1, seed+1)[0];

//	translate([0,0,-0.4])
	linear_extrude(height=0.8) intersection() {
		translate([0,-20]) for(i=[0:length-1]) hull() {
			translate([sin(i*off1)*2*sign(off3)*lookup(i,d)+sin(i*off2)*2*sign(off3)*lookup(i,d)+sin(i*off3)*scale3*lookup(i,d),i]) circle(r=rr(seed+i, i, length));
			translate([sin((i+1)*off1)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off2)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off3)*scale3*lookup((i+1),d),(i+1)]) circle(r=rr(seed+i+100, i, length));
		}
		square([41,41],center=true);
	}
}


module bridge() {

	scale([1.4,.7,.7])
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
	cylinder(h=20,r=8, center = true);
	translate([0,0,-3]) cube([40,40,20], center = true);
	}
}

module lake(seed=0, length=40) {

	r = 10;	

	translate([0,0,-0.4])
	linear_extrude(height=0.4) {
//		union() {
//			translate([10,10]) hull() for(i=[0:length-1])  {
//				translate([rands(-10,10,1,seed*(i+1)+i)[0],rands(-10,10,1,seed+i+length)[0],0]) 
//				circle(r=1);
//			}
//			translate([10,10]) for(i=[0:length-1])  {
//				translate([rands(-10,10,1,seed*(i+1)+i)[0],rands(-10,10,1,seed+i+length)[0],0]) 
//				circle(r=rr(seed, i, length));
//			}
//		}

		union() {
			for(i=[0:length-1])  {
				translate([rands(-10,10,1,seed*(i+1)+i)[0],rands(-10,10,1,seed+i+length)[0],0]) 
				circle(r=rr(seed, i, length));
			}
			circle(r=10);
		}
	}
		
}






module bottom(top=0,right=0,bottom=0,left=0,shield=0) {
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


//lake(3, 60);
//bridge();
//river(14);

module fwfw(seed=0) {
	difference() {
		color([0.3,0.7,0.3]) bottom(0,3,0,3);
		river(seed+40);
	}	
}



module cwcw_alt(seed=0) {
	difference() {
		color([0.3,0.7,0.3]) bottom(1,3,1,3);
		river(seed);
	}

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


module plate1() {
	translate([  0,  0]) fwfw(253);
	translate([ 50,  0]) fwfw(); //435
	translate([100,  0]) cwcw_alt(25);
/*	translate([150,  0]) cwcw_alt(253);

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
*/
}

plate1();



























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

