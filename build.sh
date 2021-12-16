#!/bin/bash

rm -r build 

mkdir build
rm -r lib

mkdir lib
cd build

make clean

INSTALL_PATH="-DCMAKE_INSTALL_PREFIX="/${UTBLOCK_DIR}/FortInterface/lib/""
MGRID_LIB="-DMGRIDGEN_LIB="/datapart1/UTBLOCK-OP2/ParMGridGen/libmgrid.a"" 
if [[ $OP2_F_COMPILER == 'gnu' ]]; then
	FC=gfortran cmake .. -DMETIS_LIB="/datapart1/spack/opt/spack/linux-centos7-cascadelake/gcc-11.2.0/metis-5.1.0-rir5wcja2uqvsvbmdcfra76syfpvkvkf/lib/libmetis.a" -DCMAKE_INSTALL_PREFIX="/datapart1/UTBLOCK-OP2/fmetis/lib/" -DINT=32 -DREAL=64
elif [[ $OP2_F_COMPILER == 'intel'  ]]; then
	FC=ifort cmake .. -DMETIS_LIB=$(METIS_INSTALL_PATH)"/lib/libmetis.a" -DCMAKE_INSTALL_PREFIX="/datapart1/UTBLOCK-OP2/fmetis/lib/" -DINT=32 -DREAL=64
elif [[ $OP2_F_COMPILER == 'nvhpc'  ]]; then
	FC=nvfortran cmake .. -DMETIS_LIB=$(METIS_INSTALL_PATH)"/lib/libmetis.a" -DCMAKE_INSTALL_PREFIX="/datapart1/UTBLOCK-OP2/fmetis/lib/" -DINT=32 -DREAL=64
fi

make install
cd ..


rm -r build/