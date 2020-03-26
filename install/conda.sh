# install default packages
packages=(
  jupyter
  notebook
  matplotlib
  numpy
  scipy
  pandas
  pylint
  scikit-learn
  scikit-image
  pillow
  seaborn
  line_profiler
  memory_profiler
  numexpr
  pandas-datareader
  netcdf4
  )

conda install -y "${packages[@]}"
