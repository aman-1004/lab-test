
function runc(){
  filename="$1"
  if [[ $filename == *.cpp ]] || [[ $filename == *.c ]]; 
  then :
  else filename=${filename}.cpp
  fi
  # echo Running $filename >&2
  withoutext="$(echo ${filename} | sed 's/\..*//')"
  g++ -g ${filename} -o ${withoutext} 
  ./${withoutext}
}

function pc(){
  filename="$1"
  if [[ $filename == *.cpp ]] || [[ $filename == *.c ]]; 
  then :
  else filename=${filename}.cpp
  fi
  # echo Running $filename >&2
  withoutext="$(echo ${filename} | sed 's/\..*//')"
  g++ -g ${filename} -o ${withoutext} 
  if [[ -e "input.txt" ]] && [[  -e "output.txt" ]];
  then ./${withoutext} < input.txt > output.txt
  else 
    echo "input.txt or output.txt missing. running runc instead" >&2
    ./${withoutext}
  fi
}

function runi(){
  filename="$1"
  if [[ $filename == *.cpp ]] || [[ $filename == *.c ]]; 
  then :
  else filename=${filename}.cpp
  fi
  # echo Running $filename >&2
  withoutext="$(echo ${filename} | sed 's/\..*//')"
  g++ -DINPUT_TXT -g ${filename} -o ${withoutext} 
  ./${withoutext} < input.txt
}

function dated(){
  date +%d%b%y
}

function q(){
  var="$@"
  incog "https://www.google.com/search?q=${var// /%20}"
}

function wbot(){
  python3 -i '/home/aman/Projects/projects/wbot/wbot.py'
}


function gitclone(){
  git clone "https://github.com/${1}.git"
}

function drgn(){
  dragon --and-exit --on-top $@
}

function directTorrent(){
  directlink "$(sort=time site='https://1337x.to' getMagnet $1)"
}

function yplay(){
  yt-dlp -f bestaudio+bestvideo --get-url "$1" > /tmp/yplay.txt 
  mpv --audio-file="$(sed -n 1p < /tmp/yplay.txt)" "$(sed -n 2p < /tmp/yplay.txt)"
}


function copath(){
  echo "$(pwd)/$1"
}


function testc(){
  ls | grep -v 'a$' | while read line ; do diff <( $1 < ${line}) ${line}.a ; done ;
}


function walred() (
  echo "Moved all files to reddit-saved" 
  cd ${HOME}/Pictures/Wallpapers/reddit/
  curl -H 'User-Agent: Firefox' 'https://www.reddit.com/r/wallpapers.json?limit=1000'  | jq  -r '.data.children|.[].data |  select(.post_hint == "image") | select( .preview.images[0].source | .width*9 == .height  *16) | "\(.url), \(.title)"'  | awk --field-separator "," '{print $1}' | grep -v '.gif' | while read line ; do wget -c -q ${line}; echo downloaded ${line} to $(pwd) ; done
  cd -
)


function potd() (
  ff3 'https://practice.geeksforgeeks.org/problem-of-the-day'
  cd ~/temp/gfg-potd
  git pull >/dev/null 2>/dev/null
  cat "$(find . -name $(date +%d-%m-%Y).cpp)" | awk -f ~/.dat/scripts/gfg.awk \
      | sed -e 's/\r//g'
)
