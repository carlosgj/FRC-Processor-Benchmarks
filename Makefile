CC=gcc
INCLUDE_PATH=include
SRC_PATH=src
BIN_PATH=bin
RESULTS_PATH=results
DEPS=include
ARCH = $(shell gcc -dumpmachine)
CFLAGS= -lm -lrt -lpthread -O3
ifeq ($(ARCH), aarch64-linux-gnu)
	CFLAGS += -march=armv8-a+simd -ffast-math -flto
endif

ifeq ($(ARCH), arm-linux-gnueabihf)
        CFLAGS += -mfloat-abi=hard
endif


all: whetmp dhrymp linpack
ifeq ($(ARCH), arm-linux-gnueabihf)
	make linpack-neon
endif

whet: dirs $(SRC_PATH)/whets.c $(SRC_PATH)/cpuidc.c
	$(CC) -o $(BIN_PATH)/whet $(SRC_PATH)/whets.c $(SRC_PATH)/cpuidc.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/whet.txt\" $(CFLAGS)

whetmp: dirs $(SRC_PATH)/mpwhets.c $(SRC_PATH)/cpuidc.c
	$(CC) -o $(BIN_PATH)/whetmp $(SRC_PATH)/mpwhets.c $(SRC_PATH)/cpuidc.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/whet-mp.txt\" $(CFLAGS)

dhry: dirs $(SRC_PATH)/dhry_1.c $(SRC_PATH)/dhry_2.c $(SRC_PATH)/cpuidc.c
	$(CC) -o $(BIN_PATH)/dhry $(SRC_PATH)/dhry_2.c $(SRC_PATH)/dhry_1.c $(SRC_PATH)/cpuidc.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/dhry.txt\" $(CFLAGS)

dhrymp: dirs $(SRC_PATH)/mpdhry.c $(SRC_PATH)/cpuidc.c $(SRC_PATH)/dhry22.c
	$(CC) -o $(BIN_PATH)/dhrymp $(SRC_PATH)/mpdhry.c $(SRC_PATH)/cpuidc.c $(SRC_PATH)/dhry22.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/dhry-mp.txt\" $(CFLAGS)

linpack: dirs $(SRC_PATH)/linpack.c $(SRC_PATH)/cpuidc.c
	$(CC) -o $(BIN_PATH)/linpack $(SRC_PATH)/linpack.c $(SRC_PATH)/cpuidc.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/linpack.txt\" $(CFLAGS)

linpack-neon: dirs $(SRC_PATH)/linpackneon.c $(SRC_PATH)/cpuidc.c
	$(CC) -o $(BIN_PATH)/linpack-neon $(SRC_PATH)/linpackneon.c $(SRC_PATH)/cpuidc.c -I $(INCLUDE_PATH) -DRESULT_PATH=\"$(RESULTS_PATH)/linpack-neon.txt\" $(CFLAGS) -mfpu=neon -funsafe-math-optimizations

run:
	bin/whetmp N
	bin/dhrymp N
	bin/linpack N
ifeq ($(ARCH), arm-linux-gnueabihf)
	bin/linpack-neon N
endif

dirs:
	mkdir -p $(BIN_PATH)
	mkdir -p $(RESULTS_PATH)

clean:
	rm -rf $(BIN_PATH)
	rm -rf $(RESULTS_PATH)
