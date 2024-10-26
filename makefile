dungeon_game: dungeon_game.o
	ld -m elf_i386 -o dungeon_game ./out/dungeon_game.o ./out/random_int.o ./out/int_to_string.o
dungeon_game.o: ./src/dungeon_game.s
	as -32 -o ./out/dungeon_game.o ./src/dungeon_game.s 
	as -32 -o ./out/random_int.o ./src/random_int.s
	as -32 -o ./out/int_to_string.o ./src/int_to_string.s
