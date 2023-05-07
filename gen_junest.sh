# make image follow the junest image request
docker build -t junest .

# run image to export tar
docker run -d --name jun junest
docker export jun > bioarchlinux-junest.tar

# generate tar.gz
gzip bioarchlinux-junest.tar

# clean
docker rm jun --force
docker rmi junest --force
