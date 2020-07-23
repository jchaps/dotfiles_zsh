echo -e "\n\nRunning apm.sh"

export NODE_EXTRA_CA_CERTS=$HOME/ssl/SystemCertificates.cer

apm upgrade

#install packages
packages=(
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
  Hydrogen
)

apm install "${packages[@]}"
