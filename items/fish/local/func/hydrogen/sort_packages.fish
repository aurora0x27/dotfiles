function sort_packages --desc 'List and sort packages'
    LC_ALL=C.UTF-8 pacman -Qeti |
      awk '
    /^Name/{
      name=$3
    }

    /^Description/ {
      for(i=3; i<NF; i++)
        dis = dis $i " "
      dis = dis $NF
    }

    /^Installed Size/ {
      print $4 substr($5,1,1), "\x1b[31m"name"\x1b[0m" "\0" "\x1b[32m"dis"\0\x1b[0m"
      dis=""
    }' |
      sort -h |
      tr "\0" "\n" |
      less -R
end
