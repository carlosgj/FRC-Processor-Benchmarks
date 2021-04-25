CC=gcc
INCLUDE_PATH=include
SRC_PATH=src
BIN_PATH=bin
RESULTS_PATH=results
DEPS=include
CFLAGS= -lm -lrt -lpthread -O3 -mfloat-abi=hard

all: whetmp dhrymp linpack linpack-neon

whet: dirs $(SRC_PATH)/whets.c $(SRC_PATH)/cpuidc.c
	$(CC) -o $(BIN_PATH)/whet $(SRC_PATH)/whets.c $(SRC_PATH)/cpuidc.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/whet.txt\" $(CFLAGS) -mfpu=vfp

whetmp: dirs $(SRC_PATH)/mpwhets.c $(SRC_PATH)/cpuidc.c
	$(CC) -o $(BIN_PATH)/whetmp $(SRC_PATH)/mpwhets.c $(SRC_PATH)/cpuidc.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/whet-mp.txt\" $(CFLAGS) -mfpu=vfp

dhry: dirs $(SRC_PATH)/dhry_1.c $(SRC_PATH)/dhry_2.c $(SRC_PATH)/cpuidc.c
	$(CC) -o $(BIN_PATH)/dhry $(SRC_PATH)/dhry_2.c $(SRC_PATH)/dhry_1.c $(SRC_PATH)/cpuidc.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/dhry.txt\" $(CFLAGS) -mfpu=vfp

dhrymp: dirs $(SRC_PATH)/mpdhry.c $(SRC_PATH)/cpuidc.c $(SRC_PATH)/dhry22.c
	$(CC) -o $(BIN_PATH)/dhrymp $(SRC_PATH)/mpdhry.c $(SRC_PATH)/cpuidc.c $(SRC_PATH)/dhry22.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/dhry-mp.txt\" $(CFLAGS) -mfpu=vfp

linpack: dirs $(SRC_PATH)/linpack.c $(SRC_PATH)/cpuidc.c
	$(CC) -o $(BIN_PATH)/linpack $(SRC_PATH)/linpack.c $(SRC_PATH)/cpuidc.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/linpack.txt\" $(CFLAGS) -mfpu=vfp

linpack-neon: dirs $(SRC_PATH)/linpackneon.c $(SRC_PATH)/cpuidc.c
	$(CC) -o $(BIN_PATH)/linpack-neon $(SRC_PATH)/linpackneon.c $(SRC_PATH)/cpuidc.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/linpack-neon.txt\" $(CFLAGS) -mfpu=neon -funsafe-math-optimizations

cpuidc.o: dirs
	$(CC) -I $(INCLUDE_PATH) -c $(SRC_PATH)/cpuidc.c -o $(SRC_PATH)/cpuidc.o $(CFLAGS)

run:
	bin/whetmp N
	bin/dhrymp N
	bin/linpack N
	bin/linpack-neon N

dirs:
	mkdir -p $(BIN_PATH)
	mkdir -p $(RESULTS_PATH)

clean:
	rm -rf $(BIN_PATH)
	rm -rf $(RESULTS_PATH)
