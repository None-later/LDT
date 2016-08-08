#!/bin/sh
# Flags:
# -2   compile with GTK2.
# -g   compile with debug flags.
#
# Assumption:
# your SWT & SWT binary repos should be checked out under ~/git/ . If not, edit path below:

# to run: 
# swtjnibuild
# swtjnibuild -2   #build for GTK2.
# swtjnibuild -g   #build for debugging with gdb and GTK3.
# swtjnibuild -2 -g  #build for debugging with gdb and GTK2.

#Define the global variable for the Java location. (prevent the missing jni.h header error).
#NOTE: Ubuntu stores Java elsewhere:
#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export JAVA_HOME=/usr/lib/jvm/java/

#------ Read input flags.

#Default values:
myGtk2=false
myDebug=false

while getopts ":2gh" optname
  do
    case "$optname" in
      "2")
          echo "2 specified"
	  myGtk2=true
        ;;
      "g")
	  myDebug=true
          ;;
      "h")
	  echo "HELP: Flags: -g == debug, -2 == build with gtk2. Read this script for more info."
	  exit 0;
	  ;;
      "?")
          echo "ERROR: Unknown option $OPTARG, type -h for help."
	  exit 1
        ;;
      ":")
          echo "ERROR: No argument value for option $OPTARG"
	  exit 1
        ;;
      *)
      # Should not occur
          echo "ERROR: Unknown error while processing options"
	  exit 1
        ;;
    esac
  done



#### These don't seeem to be needed. Alex.K said these are only used when Eclipse is doing a complete maven build. I should remove them.
#Try & fail the ant builds:
# cd ~/git/eclipse.platform.swt.binaries/bundles/org.eclipse.swt.gtk.linux.x86_64
#echo "NOTE: THE BELOW WILL PROBABLY FAIL:"
#ant -f build.xml build.jars
#ant -f build.xml build_libraries
# these should generate the library path below:

#Navigate to our generated C code:
cd ~/git/eclipse.platform.swt/bundles/org.eclipse.swt/bin/library/

if [ $? -ne 0 ]
then
    echo "ERROR: ~/git/eclipse.platform.swt/bundles/org.eclipse.swt/bin/library/ did not exist"
    exit 1
fi 


#Determine if GTK2 or GTK3 should be used.
if [ "$myGtk2" == true ]; then
    echo "BUILD: GTK2 enabled"
    export GTK_VERSION=2.0
else
    echo "BUILD: GTK3 enabled"
    export GTK_VERSION=3.0
fi


# Debug build.
if [ "$myDebug" == true ]; then
    echo "BUILD: Compiling with debug support (-O0 -g3)"
    #export SWT_PTR_CFLAGS="-O0 -g3" 
    export SWT_PTR_CFLAGS="-O0 -g3 -ggdb3" 
    export NO_STRIP=1

    #Need to make manually for debug flags:
    make -f make_linux.mak all  make_cairo
else
    #Build the thing as intended:
    sh ./build.sh
fi

# Copy generated SO files if build went well:
# This could be replaced with setting OUTPUT_DIR var & running make .. install, but I like the -v verbose option.
if [ $? -eq 0 ]
then
    cp -v ~/git/eclipse.platform.swt/bundles/org.eclipse.swt/bin/library/*.so ~/git/eclipse.platform.swt.binaries/bundles/org.eclipse.swt.gtk.linux.x86_64/
fi

if [ $? -eq 0 ]
then
    echo "-------------------"
    echo "It looks like things went well. If you compiled for debug (-g), then check that"
    echo "there are flags like '-O0 -g3' somewhere in the build commands (near the end somewhere)."
    echo "You may see many deprecation messages in the above, we should strive to get rid of them."
fi
