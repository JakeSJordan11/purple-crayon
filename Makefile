APP = PurpleCrayon
BUNDLE = $(APP).app

build:
	mkdir -p $(BUNDLE)/Contents/MacOS
	clang -framework AppKit -framework WebKit -framework CoreGraphics -framework CoreFoundation \
		-o $(BUNDLE)/Contents/MacOS/$(APP) main.c pc_event_tap.c pc_run_loop.c PCPanel.m
	cp Info.plist $(BUNDLE)/Contents/Info.plist

run: build
	./$(BUNDLE)/Contents/MacOS/$(APP)

clean:
	rm -rf $(BUNDLE)