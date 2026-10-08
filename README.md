# ask-claude

Ask Claude Code a question from anywhere on the desktop, by voice or by typing.
Opens a kitty window running `claude "<your question>"`, so the answer starts
streaming right away and you can keep the conversation going.

Speech-to-text runs locally with [whisper.cpp](https://github.com/ggml-org/whisper.cpp);
no audio leaves the machine.

## Keys (Openbox, `~/.config/openbox/rc.xml`)

| Key             | Does                                                        |
|-----------------|-------------------------------------------------------------|
| `Alt+A`         | Start listening; press again to stop and send               |
| `Alt+Shift+A`   | Type the question in a rofi box                             |

While listening, a red-bordered "Listening…" notification stays up. Recording
stops on its own after 2 minutes if you forget.

## Usage

```sh
ask-claude voice          # toggle recording (what Alt+A runs)
ask-claude type           # rofi prompt (what Alt+Shift+A runs)
ask-claude "some question"
```

## Settings (environment variables)

| Variable                 | Default                            |
|--------------------------|------------------------------------|
| `ASK_CLAUDE_MODEL`       | `~/Downloads/ggml-base.en.bin`     |
| `ASK_CLAUDE_DIR`         | `~/claude-chat` (sessions start here) |
| `ASK_CLAUDE_MAX_SECONDS` | `120`                              |

## Setup

1. `./install.sh` — links `ask-claude` into `~/.local/bin`.
2. Build `whisper-cli` (Fedora's `whisper-cpp` package ships only the library):

   ```sh
   sudo dnf install -y cmake gcc-c++
   cd ~/Downloads/whisper.cpp-src
   cmake -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DWHISPER_BUILD_TESTS=OFF
   cmake --build build -j"$(nproc)" --target whisper-cli
   install -m755 build/bin/whisper-cli ~/.local/bin/whisper-cli
   ```

3. Speech model: `ggml-base.en.bin` from
   <https://huggingface.co/ggerganov/whisper.cpp>, saved to `~/Downloads/`
   (sha1 `137c40403d78fd54d454da0f9bd998f78703390c`). For other languages use
   `ggml-base.bin` and change `-l en` to `-l auto` in the script.

## Depends on

`pw-record` (PipeWire), `whisper-cli`, `kitty`, `claude`, `rofi`, `notify-send` (dunst).
