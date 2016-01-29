#!/bin/bash
site="" #url do painel sem http:// e a / do final
log="/home/[user]/[dir]/desligar.txt" #caminho para do arquivo log
data="$(date +%d/%m/%y-%H:%M)" 
hora="$(date +%H%M)" # o mesmo caso acima
dia="$(date +%w)" # o mesmo caso acima
if ! ping -c 1 $site ; then
  echo $data >> $log
else
  webdata=`curl http://$site/r/data.php` # pega data no nosso servidor yyyymmdd
  webhora=`curl http://$site/r/hora.php` # pegar hora no nosso servidor hh:mm:ss
  date -s '$webdata' #atualiza data no sistema
  date -s '$webhora' #atualiza hora no sistema

  data="$(date +%d/%m/%y-%H:%M)" 
  hora="$(date +%H%M)" 
  dia="$(date +%w)"

  if [ $hora -ge "1800" ]; then
    if [ $dia -eq "1" -o $dia -eq "2" -o $dia -eq "3" -o $dia -eq "4" -o $dia -eq "5" ]; then
      killall -9 mplayer;
      shutdown -h now;
    fi
  fi
  if [ $hora -ge "1200" ]; then
    if [ $dia -eq "0" -o $dia -eq "6" ]; then
      killall -9 mplayer;
      shutdown -h now;
    fi
  fi
fi
