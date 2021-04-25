CC=gcc
INCLUDE_PATH=include
BUILD_PATH=build
SRC_PATH=src
BIN_PATH=bin
RESULTS_PATH=results
DEPS=include
CFLAGS=-Wall -lm

all: whet dhry linpack

whet: $(BUILD_PATH)/whets.o $(BUILD_PATH)/cpuidc.o
	$(CC) -o $(BIN_PATH)/whet $(BUILD_PATH)/whets.o $(BUILD_PATH)/cpuidc.o $(CFLAGS)

dhry: $(BUILD_PATH)/dhry_1.o $(BUILD_PATH)/dhry_2.o $(BUILD_PATH)/cpuidc.o
	$(CC) -o $(BIN_PATH)/dhry $(BUILD_PATH)/dhry_2.o $(BUILD_PATH)/dhry_1.o $(BUILD_PATH)/cpuidc.o $(CFLAGS)

linpack: $(BUILD_PATH)/linpack.o $(BUILD_PATH)/cpuidc.o
	$(CC) -o $(BIN_PATH)/linpack $(BUILD_PATH)/linpack.o $(BUILD_PATH)/cpuidc.o $(CFLAGS)

#whet.o: dirs cpuidc.o
#	$(CC) -Drespath=\"$(RESULTS_PATH)\" -I $(INCLUDE_PATH) -c $(SRC_PATH)/whets.c -o $(BUILD_PATH)/whet.o $(CFLAGS)

#whet.o: dirs cpuidc.o
#        $(CC) -Drespath=\"$(RESULTS_PATH)\" -I $(INCLUDE_PATH) -c $(SRC_PATH)/whets.c -o $(BUILD_PATH)/whet.o $(CFLAGS)

#%.o: $(SRC_PATH)/%.c
#	$(CC) -c -o $@ $< $(CFLAGS)

cpuidc.o: dirs
	$(CC) -I $(INCLUDE_PATH) -c $(SRC_PATH)/cpuidc.c -o $(BUILD_PATH)/cpuidc.o $(CFLAGS)

run:
	bin/whet N
	bin/dhry N
	bin/linpack N

dirs:
	mkdir -p $(BUILD_PATH)
	mkdir -p $(BIN_PATH)
	mkdir -p $(RESULTS_PATH)

clean:
	rm -rf $(BUILD_PATH)
	rm -rf $(BIN_PATH)
	rm -rf $(RESULTS_PATH)

$(BUILD_PATH)/%.o: $(SRC_PATH)/%.c dirs
	$(CC) -Drespath=\"$(RESULTS_PATH)\" -I $(INCLUDE_PATH) -c $< -o $@ $(CFLAGS)

