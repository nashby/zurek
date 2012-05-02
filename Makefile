zurekmake: zurek.y
	bison zurek.y && cc zurek.tab.c -lm -o zurek
