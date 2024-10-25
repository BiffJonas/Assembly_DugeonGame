dungeon_game: dungeon_game.o
	ld -m elf_i386 -o dungeon_game ./out/dungeon_game.o
dungeon_game.o: ./src/dungeon_game.s
	as -32 -o ./out/dungeon_game.o ./src/dungeon_game.s
