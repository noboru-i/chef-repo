name 'web'
run_list([
         "dev-tools",
         "nginx",
         "mysql-prepare",
         "imagemagick",
         "rbenv"
])
default_attributes()
