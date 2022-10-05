function fish_greeting
  if test -d ~/.local/share/JetBrains/Toolbox/shortcut
    fish_add_path ~/.local/share/JetBrains/Toolbox/shortcut
  end

  if status is-interactive
    neofetch
  end
end
