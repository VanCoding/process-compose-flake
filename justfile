# List all the just commands
default:
    @just --list

# Auto-format the project tree
fmt:
    treefmt

# Run doc server with hot-reload
doc:
    cd ./doc && nix run

# Build docs static website (this runs linkcheck automatically)
doc-static:
    nix build ./doc

# Run example, using current process-compose
ex:
  cd ./example && nix run --override-input process-compose-flake ..
