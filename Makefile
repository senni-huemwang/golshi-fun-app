CC = gcc
CFLAGS = -Wall -Wextra -O2

TARGET = golshi-fun-app
SOURCE = main.c
DESKTOP_FILE_SRC = golshi-fun-app.desktop
ICON_FILE_SRC = golshi-fun-app.png

BIN_DIR = /usr/local/bin
DESKTOP_DIR = /usr/share/applications
ICON_DIR = /usr/share/icons

# --- TARGETS ---

.PHONY: all
all: $(TARGET)

$(TARGET): $(SOURCE)
	@echo "Compiling $< into $@..."
	$(CC) $(CFLAGS) $< -o $@

.PHONY: install
install: all
	@if [ "$(shell id -u)" != "0" ]; then \
		echo "Installation failed! You must run this command with 'sudo'."; \
		echo "   Try: sudo make install"; \
		exit 1; \
	fi
	@echo "Installing $(TARGET) to system paths..."

	install -m 755 $(TARGET) $(BIN_DIR)/$(TARGET)
	@echo "-> Installed binary to $(BIN_DIR)/$(TARGET)"

	install -m 644 $(ICON_FILE_SRC) $(ICON_DIR)/$(TARGET).png
	@echo "-> Installed icon to $(ICON_DIR)/$(TARGET).png"

	install -m 644 $(DESKTOP_FILE_SRC) $(DESKTOP_DIR)/$(DESKTOP_FILE_SRC)
	@echo "-> Installed desktop entry to $(DESKTOP_DIR)/$(DESKTOP_FILE_SRC)"

	@echo "Radar Alert. Rader Alert. Golshi Fun App installed."

.PHONY: clean
clean:
	@echo "Cleaning up generated files..."
	rm -f $(TARGET)
	rm -f *.o

.PHONY: uninstall
uninstall:
	@if [ "$(shell id -u)" != "0" ]; then \
		echo "Uninstallation failed! You must run this command with 'sudo'."; \
		echo "   Try: sudo make uninstall"; \
		exit 1; \
	fi
	@echo "Uninstalling Golshi Fun App..."
	rm -f $(BIN_DIR)/$(TARGET)
	rm -f $(ICON_DIR)/$(TARGET).png
	rm -f $(DESKTOP_DIR)/$(DESKTOP_FILE_SRC)
	@echo "Uninstallation complete."
