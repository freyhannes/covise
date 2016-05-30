#! /bin/sh


#
# System Architecture finding
#

# User permanent selection in .archsuffix file
# If the user has a file .archsuffix-`uname` , we evaluate this
#
guess_archsuffix() {

   if [ "$ARCHSUFFIX" != "" ]; then
      check_readme_archsuffix
      return
   fi

   basedir="$COVISEDIR"

   ARCH=`uname`
   if [ ! -z "$basedir" ]; then
      if [ -f "$basedir"/.archsuffix-"$ARCH" ]; then
         localarch=`head -1 "$basedir"/.archsuffix-"$ARCH"`
         if [ "$localarch" != "" ]; then
            export ARCHSUFFIX="$localarch"
            check_readme_archsuffix
            return
         fi
       fi
   fi

   case "$ARCH" in
        Darwin)
            export ARCHSUFFIX=darwin
            case "`uname -r`" in
                7.*)
	            export ARCHSUFFIX=macx
                    ;;

                8.*)
	            export ARCHSUFFIX=tiger
                    ;;

                9.*|10.*)
	            export ARCHSUFFIX=leopard
                    ;;

                11.*|12.*)
	            export ARCHSUFFIX=lion
                    ;;

                13.*|14.*|15.*)
	            export ARCHSUFFIX=libc++
                    ;;
            esac
            ;;

        IRIX*)
            export ARCHSUFFIX=sgin32
            ;;
        
        HP-UX)
	    export ARCHSUFFIX=hp
            uname -a|grep ia64 && export ARCHSUFFIX=hpux_ia64
            ;;
     
        Linux)
        export ARCHSUFFIX=linux
        case "`uname -m`" in
            ia64)
              if grep -i -q -s "SUSE LINUX Enterprise Server 9 (ia64)" /etc/issue; then
                 export ARCHSUFFIX=cayman
              elif  grep -i -q -s "SUSE LINUX Enterprise Server 10 (ia64)" /etc/issue; then
                 export ARCHSUFFIX=cayenne
              else
                 export ARCHSUFFIX=ia64
              fi
              ;;
            
            x86_64)
               export ARCHSUFFIX=linux64
               if grep -i -q -s stentz /etc/issue; then
                   export ARCHSUFFIX=x64
               elif grep -i -q -s "Fedora Core release 5" /etc/fedora-release; then
                  export ARCHSUFFIX=bishorn
               elif grep -i -q -s "zod" /etc/fedora-release; then
                  export ARCHSUFFIX=fujisan
               elif grep -i -q -s "moonshine" /etc/fedora-release; then
                  export ARCHSUFFIX=monshuygens
               elif grep -i -q -s "werewolf" /etc/fedora-release; then
                  export ARCHSUFFIX=lycaeus
               elif grep -i -q -s "sulphur" /etc/fedora-release; then
                  export ARCHSUFFIX=maunaloa
               elif grep -i -q -s "cambridge" /etc/fedora-release; then
                  export ARCHSUFFIX=gorely
               elif grep -i -q -s "leonidas" /etc/fedora-release; then
                  export ARCHSUFFIX=leonidas
               elif grep -i -q -s "constantine" /etc/fedora-release; then
                  export ARCHSUFFIX=constantine
               elif grep -i -q -s "goddard" /etc/fedora-release; then
                  export ARCHSUFFIX=goddard
               elif grep -i -q -s "laughlin" /etc/fedora-release; then
                  export ARCHSUFFIX=laughlin
               elif grep -i -q -s "lovelock" /etc/fedora-release; then
                  export ARCHSUFFIX=lovelock
               elif grep -i -q -s "verne" /etc/fedora-release; then
                  export ARCHSUFFIX=verne
               elif [ -f /lib64/libc-2.3.2.so ]; then
                  export ARCHSUFFIX rhel3
               elif [ -f /lib64/libc-2.3.4.so ]; then
                   export ARCHSUFFIX=rhel4
               elif grep -i -q -s 'Scientific Linux SL release 5.0' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'Red Hat Enterprise Linux 5.0' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'Red Hat Enterprise Linux Client release 5.' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'CentOS release 5 (Final)' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'Scientific Linux SL release 5.1' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'Red Hat Enterprise Linux 5.1' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'Scientific Linux SL release 5.2' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'Scientific Linux SL release 5.3' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'Scientific Linux SL release 5.5' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'Scientific Linux SL release 5.6' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'Red Hat Enterprise Linux 5.2' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'CentOS release 5.2 (Final)' /etc/issue; then
                   export ARCHSUFFIX=rhel5
               elif grep -i -q -s 'Scientific Linux release 6..' /etc/issue; then
                   export ARCHSUFFIX=rhel6
               elif grep -i -q -s 'Red Hat Enterprise Linux Server release 6..' /etc/issue; then
                   export ARCHSUFFIX=rhel6
               elif grep -i -q -s 'CentOS release 6..' /etc/issue; then
                   export ARCHSUFFIX=rhel6
               elif grep -i -q -s 'bullx Linux Server release 6..' /etc/issue; then
                   export ARCHSUFFIX=rhel6
               elif test -f /etc/system-release; then
                  if grep -i -q -s 'Scientific Linux release 7..' /etc/system-release; then
                    export ARCHSUFFIX=rhel7
                  elif grep -i -q -s 'CentOS Linux release 7..' /etc/system-release; then
                    export ARCHSUFFIX=rhel7
                  elif grep -i -q -s 'Red Hat Enterprise Linux.*release 7..' /etc/system-release; then
                    export ARCHSUFFIX=rhel7
                  fi
               elif grep -i -q -s 'suse.*11.0' /etc/issue; then
                   export ARCHSUFFIX=mabuya
               elif grep -i -q -s 'suse.*11.1' /etc/issue; then
                   export ARCHSUFFIX=drusenkopf
               elif grep -i -q -s 'suse.*11.2' /etc/issue; then
                   export ARCHSUFFIX=lipinia
               elif grep -i -q -s 'suse.*11.3' /etc/issue; then
                   export ARCHSUFFIX=mamba
               elif grep -i -q -s 'suse.*12.1' /etc/issue; then
                   export ARCHSUFFIX=indicus
               elif grep -i -q -s 'suse.*12.2' /etc/issue; then
                   export ARCHSUFFIX=slowworm
               elif grep -i -q -s 'suse.*12.3' /etc/issue; then
                   export ARCHSUFFIX=neolamprologus
               elif grep -i -q -s 'suse.*13.1' /etc/issue; then
                   export ARCHSUFFIX=saara
               elif grep -i -q -s 'suse.*13.2' /etc/issue; then
                   export ARCHSUFFIX=julidochromis
               elif grep -i -q -s 'suse.*10.3' /etc/issue; then
                   export ARCHSUFFIX=tuatara
               elif grep -i -q -s 'suse.*10.2' /etc/issue; then
                   export ARCHSUFFIX=iguana
               elif grep -i -q -s 'suse.*10.1' /etc/issue; then
                   export ARCHSUFFIX=basilisk
               elif grep -i -q -s 'suse.*10.0' /etc/issue; then
                   export ARCHSUFFIX=waran
               elif grep -i -q -s 'SUSE Linux Enterprise Server 10' /etc/issue; then
                   export ARCHSUFFIX=waran
               elif grep -i -q -s 'suse.*9.3' /etc/issue; then
                   export ARCHSUFFIX=leguan
               elif grep -i -q -s 'ubuntu.*6\.06' /etc/issue; then
                   export ARCHSUFFIX=drake
               elif grep -i -q -s 'ubuntu.*6\.10' /etc/issue; then
                   export ARCHSUFFIX=eft
               elif grep -i -q -s 'ubuntu.*7\.04' /etc/issue; then
                   export ARCHSUFFIX=fawn
               elif grep -i -q -s 'Debian GNU/Linux 4.0' /etc/issue; then
                   export ARCHSUFFIX=etch
               elif grep -i -q -s 'debian.*5\.0' /etc/issue; then
                   export ARCHSUFFIX=lenny
               elif grep -i -q -s 'squeeze' /etc/issue; then
                   export ARCHSUFFIX=squeeze
               elif grep -i -q -s 'ubuntu.*7\.10' /etc/issue; then
                   export ARCHSUFFIX=gibbon
               elif grep -i -q -s 'ubuntu.*8\.04' /etc/issue; then
                   export ARCHSUFFIX=heron
               elif grep -i -q -s 'ubuntu.*8\.10' /etc/issue; then
                   export ARCHSUFFIX=ibex
               elif grep -i -q -s 'ubuntu.*9\.04' /etc/issue; then
                   export ARCHSUFFIX=jackalope
               elif grep -i -q -s 'ubuntu.*9\.10' /etc/issue; then
                   export ARCHSUFFIX=koala
               elif grep -i -q -s 'ubuntu.*10\.04' /etc/issue; then
                   export ARCHSUFFIX=lynx
               elif grep -i -q -s 'ubuntu.*10\.10' /etc/issue; then
                   export ARCHSUFFIX=meerkat
               elif grep -i -q -s 'ubuntu.*11\.04' /etc/issue; then
                   export ARCHSUFFIX=narwhal
               elif grep -i -q -s 'ubuntu.*11\.10' /etc/issue; then
                   export ARCHSUFFIX=ocelot
               elif grep -i -q -s 'ubuntu.*12\.04' /etc/issue; then
                   export ARCHSUFFIX=pangolin
               elif grep -i -q -s 'ubuntu.*14\.04' /etc/issue; then
                   export ARCHSUFFIX=tahr
               elif grep -i -q -s 'ubuntu.*15\.04' /etc/issue; then
                   export ARCHSUFFIX=vervet
               elif grep -i -q -s 'ubuntu.*15\.10' /etc/issue; then
                   export ARCHSUFFIX=werewolf
               fi
               ;;
            
            *)
               export ARCHSUFFIX=linux32
               if [ -f /lib/libgcc_s.so.1 ]; then
                  if grep -i -q -s stentz /etc/issue; then
                     # rename to ????
                     export ARCHSUFFIX=gcc4
                  elif grep -i -q -s 'debian.*3\.1' /etc/issue; then
                     export ARCHSUFFIX=sarge
                  elif grep -i -q -s 'debian.*4\.0' /etc/issue; then
                     export ARCHSUFFIX=etch32
                  elif grep -i -q -s 'debian.*5\.0' /etc/issue; then
                     export ARCHSUFFIX=lenny32
                  elif grep -i -q -s 'ubuntu.*8\.10' /etc/issue; then
                     export ARCHSUFFIX=intrepid
                  elif grep -i -q -s 'ubuntu.*8\.04' /etc/issue; then
                     export ARCHSUFFIX=hardy
                  elif grep -i -q -s 'ubuntu.*7\.10' /etc/issue; then
                     export ARCHSUFFIX=gutsy
                  elif grep -i -q -s 'ubuntu.*7\.04' /etc/issue; then
                     export ARCHSUFFIX=feisty
                  elif grep -i -q -s 'ubuntu.*6\.10' /etc/issue; then
                     export ARCHSUFFIX=edgy
                  elif grep -i -q -s 'ubuntu.*6\.06' /etc/issue; then
                     export ARCHSUFFIX=dapper
                  elif grep -i -q -s 'ubuntu.*9\.04' /etc/issue; then
                     export ARCHSUFFIX=jaunty
                  elif grep -i -q -s 'ubuntu.*9\.10' /etc/issue; then
                     export ARCHSUFFIX=karmic
                  elif grep -i -q -s 'ubuntu.*10\.04' /etc/issue; then
                     export ARCHSUFFIX=lucid
                  elif grep -i -q -s 'ubuntu.*10\.10' /etc/issue; then
                     export ARCHSUFFIX=maverick
                  elif grep -i -q -s 'suse.*11.0' /etc/issue; then
                     export ARCHSUFFIX=tiliqua
                  elif grep -i -q -s 'suse.*10.3' /etc/issue; then
                     export ARCHSUFFIX=agame
                  elif grep -i -q -s 'suse.*10.2' /etc/issue; then
                     export ARCHSUFFIX=dornteufel
                  elif grep -i -q -s 'suse.*10.1' /etc/issue; then
                     export ARCHSUFFIX=skink
                  elif grep -i -q -s 'suse.*10.0' /etc/issue; then
                     export ARCHSUFFIX=gecko
                  elif grep -i -q -s 'suse.*9.3' /etc/issue; then
                     export ARCHSUFFIX=lurchi
                  elif grep -i -q -s 'suse.*9.2' /etc/issue; then
                     export ARCHSUFFIX=chuckwalla
                  elif grep -i -q -s "moonshine" /etc/fedora-release; then
                      export ARCHSUFFIX=monsruemker
                  elif grep -i -q -s "werewolf" /etc/fedora-release; then
                      export ARCHSUFFIX=neuffen
                  elif grep -i -q -s "sulphur" /etc/fedora-release; then
                      export ARCHSUFFIX="stromboli"
                  elif grep -i -q -s 'centos.* 5' /etc/issue; then
                     export ARCHSUFFIX=rh5
                  elif [ -f /etc/gentoo-release ]; then
                     export ARCHSUFFIX=gentoo
                  elif grep -i -q -s 'redhat.* 5' /etc/issue; then
                     export ARCHSUFFIX=rh5
                  elif [ -f /lib/libc-2.3.6.so ]; then
                     export ARCHSUFFIX=teck
                  elif [ -f /lib/libc-2.3.5.so ]; then
                     export ARCHSUFFIX=teck
                  elif [ -f /lib/libc-2.4.so ]; then
                     export ARCHSUFFIX=heiner 
                  elif [ -f /lib/libc-2.5.so ]; then
                     export ARCHSUFFIX=belchen
                  fi
               elif [ -f /lib/i386-linux-gnu/libgcc_s.so.1 ]; then
                  if grep -i -q -s 'ubuntu.*11\.04' /etc/issue; then
                     export ARCHSUFFIX=natty
                  elif grep -i -q -s 'ubuntu.*11\.10' /etc/issue; then
                     export ARCHSUFFIX=oneiric
                  elif grep -i -q -s 'ubuntu.*12\.04' /etc/issue; then
                     export ARCHSUFFIX=precise
                  fi
               fi
               ;;

            esac
   esac

    if [ "$basedir" != "" ]; then
       if [ ! -d "$basedir"/"$ARCHSUFFIX" -a -d "$basedir"/"${ARCHSUFFIX}opt" ]; then
          export ARCHSUFFIX="${ARCHSUFFIX}opt"
       fi
    fi

    #if uname -r | grep -i -q -s xeno; then
    #  export ARCHSUFFIX="${ARCHSUFFIX}xenomai"
    #fi

    check_readme_archsuffix
}


check_readme_archsuffix() {
   local basearch=`echo $ARCHSUFFIX | sed -e 's/opt$//' -e 's/mpi$//' -e 's/xenomai$//'  `
   local readme="${COVISEDIR}/README-ARCHSUFFIX.txt"
   if [ ! -r "$readme" -o ! -f "$readme" ]; then
       readme="${COVISEDIR}/share/doc/covise/README-ARCHSUFFIX.txt"
   fi

    if ! grep $basearch "$readme" >/dev/null 2>&1; then
       echo "Unknown ARCHSUFFIX ${basearch} - please check $readme"
    fi
}
