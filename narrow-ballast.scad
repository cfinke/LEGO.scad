use <LEGO.scad>

color([108/255, 110/255, 104/255]) {
    stack(0,0,0) {
        place(0,0,0) uncenter(1,8) block(width=1, length=8, height=1/3);
        place(7,0,0) uncenter(1,8) block(width=1, length=8, height=1/3);
        place(0,3,0) rotate([0, 0, 90]) uncenter(2,8)  block(width=2, length=8, height=1/3, type="tile");
        place(0,7,0) rotate([0, 0, 90]) uncenter(2,8)  block(width=2, length=8, height=1/3, type="tile");
        place(1,1,1/3) uncenter(1,2) block(width=1,length=2,height=1/3, block_bottom_type="closed");
        place(1,5,1/3) uncenter(1,2) block(width=1,length=2,height=1/3, block_bottom_type="closed");
        place(6,1,1/3) uncenter(1,2) block(width=1,length=2,height=1/3, block_bottom_type="closed");
        place(6,5,1/3) uncenter(1,2) block(width=1,length=2,height=1/3, block_bottom_type="closed");
        place(3,1,1/3) uncenter(2,2) block(width=2,length=2,height=1/3, block_bottom_type="closed");
        place(3,5,1/3) uncenter(2,2) block(width=2,length=2,height=1/3, block_bottom_type="closed");
    }
}
