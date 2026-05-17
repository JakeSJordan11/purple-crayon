APP = PurpleCrayon
BUNDLE = $(APP).app

build:
	mkdir -p $(BUNDLE)/Contents/MacOS
	clang -framework CoreGraphics -framework CoreFoundation -o $(BUNDLE)/Contents/MacOS/$(APP) main.c
	cp Info.plist $(BUNDLE)/Contents/Info.plist

run: build
	./$(BUNDLE)/Contents/MacOS/$(APP)

clean:
	rm -rf $(BUNDLE)