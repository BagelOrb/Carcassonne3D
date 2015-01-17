




module farmhouse() {

    translate([-2,-2])

    difference() 

    {

        union(){

            cube([4,4,2]);

            translate([2,4,2])

            rotate([90,0])

            linear_extrude(height=4)

            polygon([[-2,0],[2,0],[0,1]]);

        }

        translate([1,-1,0])

        cube([1,2,1.5]);

        translate([1,3,0])

        cube([1,2,1.5]);

    }

}



module gate() {
    difference() {
        union() {
            translate([0,0,4]) cube([2,8,8],center=true);
        }
        translate([0,0,4]) 
        rotate([0,90])
        hull() {
            intersection() { 
                translate([0,1]) cylinder(h=6,r=3,center=true); 
                translate([0,-1]) cylinder(h=6,r=3,center=true); }
            translate([4,0]) cube([4,4,6],center=true);
        }
    }
    

    translate([0,4]) { cylinder(h=12, r=2); translate([0,0,12]) cylinder(h=2, r1=2, r2=1); }
    translate([0,-4]) { cylinder(h=12, r=2); translate([0,0,12]) cylinder(h=2, r1=2, r2=1); }
    
    hull() {
        translate([0,-4,8]) cylinder(h=1,r1=1,r2=0,$fn=4);
        translate([0,4,8]) cylinder(h=1,r1=1,r2=0,$fn=4);
    }

}








