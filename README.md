# ask-claude

Ask Claude Code a question from anywhere on the desktop, by voice or by typing.
Opens a kitty window running `claude "<your question>"`, so the answer starts
streaming right away and you can keep the conversation going.

Speech-to-text runs locally with [whisper.cpp](https://github.com/ggml-org/whisper.cpp);
no audio leaves the machine.

## Usage

```sh
ask-claude voice          # toggle recording: run once to start, again to stop and send
ask-claude type           # rofi prompt
ask-claude "some question"
```

Bind `ask-claude voice` and `ask-claude type` to hotkeys in your window manager or
desktop environment.

While listening, a red-bordered "Listening…" notification stays up. Recording
stops on its own after 2 minutes if you forget.

## Settings (environment variables)

| Variable                 | Default                            |
|--------------------------|------------------------------------|
| `ASK_CLAUDE_MODEL`       | `~/Downloads/ggml-base.en.bin`     |
| `ASK_CLAUDE_DIR`         | `~/claude-chat` (sessions start here) |
| `ASK_CLAUDE_MAX_SECONDS` | `120`                              |

## Setup

1. Install dependencies and build tools:

   **Fedora**
   ```sh
   sudo dnf install -y pipewire-utils kitty rofi dunst libnotify cmake gcc-c++ git
   ```

   **Ubuntu / Debian**
   ```sh
   sudo apt install -y pipewire-bin kitty rofi dunst libnotify-bin cmake build-essential git
   ```

   **Arch**
   ```sh
   sudo pacman -S --needed pipewire kitty rofi dunst libnotify cmake base-devel git
   ```

   Also install [Claude Code](https://docs.claude.com/en/docs/claude-code) so `claude` is on your `PATH`.

2. `./install.sh` — links `ask-claude` into `~/.local/bin` (make sure that is on your `PATH`).

3. Build `whisper-cli` (distro packages usually ship only the library):

   ```sh
   git clone https://github.com/ggml-org/whisper.cpp ~/Downloads/whisper.cpp-src
   cd ~/Downloads/whisper.cpp-src
   cmake -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DWHISPER_BUILD_TESTS=OFF
   cmake --build build -j"$(nproc)" --target whisper-cli
   install -Dm755 build/bin/whisper-cli ~/.local/bin/whisper-cli
   ```

4. Speech model: `ggml-base.en.bin` from
   <https://huggingface.co/ggerganov/whisper.cpp>, saved to `~/Downloads/`
   (sha1 `137c40403d78fd54d454da0f9bd998f78703390c`). For other languages use
   `ggml-base.bin` and change `-l en` to `-l auto` in the script.

## Depends on

`pw-record` (PipeWire), `whisper-cli`, `kitty`, `claude`, `rofi`, `notify-send` (dunst).
