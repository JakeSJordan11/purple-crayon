APP = PurpleCrayon
BUNDLE = $(APP).app

build:
	mkdir -p $(BUNDLE)/Contents/MacOS
	clang -framework AppKit -o $(BUNDLE)/Contents/MacOS/$(APP) main.m AppDelegate.m
	cp Info.plist $(BUNDLE)/Contents/Info.plist

run: build
	open $(BUNDLE)

clean:
	rm -rf $(BUNDLE)
	p