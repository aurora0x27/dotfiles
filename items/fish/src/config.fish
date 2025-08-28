if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x STARSHIP_CONFIG "$HOME/.config/starship/tokyo_night.toml"
    starship init fish | source
end
