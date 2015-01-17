use <Carcassonne_core.scad>;




// ====================================

//  R I V E R   E X P A N S I O N  I

// ====================================







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


plate6();
//ccrr();















