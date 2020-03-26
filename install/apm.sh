echo -e "\n\nRunning apm.sh"

apm upgrade

#install packages
packages=(
  Hydrogen
  atom-beautify
  autocomplete-python
  busy-signal
  file-icons
  git-blame
  highlight-selected
  intentions
  language-markdown
  linter
  linter-pylint
  linter-ui-default
  markdown-writer
  merge-conflicts
  minimap
  minimap-find-and-replace
  minimap-git-diff
  minimap-highlight-selected
  minimap-split-diff
  pdf-view
  split-diff
)

apm install "${packages[@]}"
