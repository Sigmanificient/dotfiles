export GTK_THEME=Catppuccin-Mocha-Standard-Sapphire-Dark

# Global scripts
export PATH="$PATH:/home/sigmanificient/Scripts"

# Added by Toolbox App
export PATH="$PATH:/home/sigmanificient/.local/share/JetBrains/Toolbox/scripts"

function cs() {
    start_time=$(date +%s%3N)
    norm_dir="$HOME/scripts/banana-coding-style-checker/vera"

    echo "Running norm in $(pwd)"
    files=$(find $(pwd)        \
        -type f                \
        -not -path "*/.git/*"  \
        -not -path "*/.idea/*" \
        -not -path "bonus/*"   \
        -not -path "tests/*"   \
        -not -path "/*build/*" \
    )

    echo "Checking $(echo $files | wc -w) files"
    output=$(vera++                           \
        --profile epitech                     \
        --root $norm_dir                      \
        -d $(echo $files | tr '\n' ' ')       \
    )

    if [ -z "$output" ]; then
        echo "No issue found :D"
    else
        escaped_path=$(echo $(pwd) | sed 's/\//\\\//g')
        echo "$output" | sed "s/$escaped_path\///g"
        echo "Found $(echo "$output" | grep -c "$") issues"
    fi
    end_time=$(date +%s%3N)
    echo "Ran in $(expr $end_time - $start_time)ms"
}
